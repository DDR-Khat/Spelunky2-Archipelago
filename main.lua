_G.safe_require = function(name)
    local info = debug.getinfo(2, "Sln")
    local caller = info and (info.short_src or info.source or "unknown source") or "unknown source"
    local line = info and info.currentline or "?"
    local ok, result = xpcall(function() return require(name) end, debug.traceback)
    if not ok then
        print(string.format("Failed to require '%s' (called from %s:%s):\n%s",name, caller, tostring(line), result))
        return nil
    end
    return result
end

_G.safe_loadlib = function(lib, func)
    local info = debug.getinfo(2, "Sln")
    local caller = info and (info.short_src or info.source or "unknown source") or "unknown source"
    local line = info and info.currentline or "?"
    local script = info.source:sub(1, 1) == '@' and info.source:sub(2) or info.source
    local folder = script:match("(.*[\\/])")
    if not folder then
        folder = "./"
    end
    local full_lib_path = folder .. lib

    local ok, result = xpcall(function() return package.loadlib(full_lib_path, func) end, debug.traceback)
    if not ok then
        print(string.format("Failed to load library '%s' (called from %s:%s):\n%s",lib, caller, tostring(line), result))
        return nil
    end
    return result
end

local Data = safe_require("data")
local APSave = safe_require("save")
local APClient = safe_require("client")

meta = {
    name = "Spelunky 2 Archipelago",
    description = "Adds Archipelago Multiworld Randomizer support!",
    author = "Eszenn\nDDRKhat",
    version = "0.2.1",
    unsafe = true
}

register_option_float('popup_time', 'Popup Timer', 'How long the "You received" or "You sent"! popup lingers.\n(Note: Higher values makes receiving items take longer)\nTime in seconds', 3.5, 0.5, 10)

debugging = false

set_callback(function()
    if debugging then
        print("LOADING")
    end

    if state.screen_next == SCREEN.CHARACTER_SELECT then
        update_characters()
    end

    -- Prevents unlocking journal entries for characters you have been sent
    if state.screen_next == SCREEN.CAMP then
        ap_save.last_character = savegame.players[1]
        lock_characters()
    end

    
    if state.screen_next == SCREEN.CAMP then
        if player_options.progressive_worlds then
            if ap_save.max_world > 4 then
                set_shortcut_progress(3)
            elseif ap_save.max_world >= 3 then
                set_shortcut_progress(2)
            elseif ap_save.max_world == 2 then
                set_shortcut_progress(1)
            else
                set_shortcut_progress(0)
            end
        else
            if ap_save.unlocked_worlds[THEME.ICE_CAVES] then
                set_shortcut_progress(3)
            elseif ap_save.unlocked_worlds[THEME.OLMEC] then
                set_shortcut_progress(2)
            elseif ap_save.unlocked_worlds[THEME.JUNGLE] or ap_save.unlocked_worlds[THEME.VOLCANA] then
                set_shortcut_progress(1)
            else
                set_shortcut_progress(0)
            end
        end
    end
end, ON.LOADING)

function set_shortcut_progress(shortcut_number)
    if shortcut_number == 0 then
        savegame.shortcuts = 1
    elseif shortcut_number == 1 then
        savegame.shortcuts = 4
    elseif shortcut_number == 2 then
        savegame.shortcuts = 7
    else
        savegame.shortcuts = 10
    end
end

set_callback(function()
    local shortcut_uids = get_entities_by(ENT_TYPE.FLOOR_DOOR_STARTING_EXIT, MASK.FLOOR, LAYER.FRONT)

    for _, uid in ipairs(shortcut_uids) do
        local shortcut = get_entity(uid)
        local x, y, layer = get_position(uid)

        unlock_door_at(x,y)

        --[[
        if shortcut.theme == THEME.DWELLING and (ap_save.unlocked_shortcuts.progressive >= 1 or ap_save.unlocked_shortcuts.dwelling == 1) then
            unlock_door_at(x, y)
            
        elseif shortcut.theme == THEME.OLMEC and (ap_save.unlocked_shortcuts.progressive >= 2 or ap_save.unlocked_shortcuts.olmec == 1) then
            unlock_door_at(x, y)

        elseif shortcut.theme == THEME.ICE_CAVES and (ap_save.unlocked_shortcuts.progressive == 3 or ap_save.unlocked_shortcuts.ice_caves == 1) then
            unlock_door_at(x, y)
        
        else
            lock_door_at(x, y)

        end
        ]]
    end

end, ON.CAMP)


-- This handles all of the permanent upgrades to give the player at the start of every run
set_callback(function()
    if debugging then
        prinspect("START")
    end
    
    savegame.shortcuts = ap_save.shortcut_progress

    local player = get_player(1, false)
    player.health = player_options.starting_health + ap_save.permanent_upgrades.health
    player.inventory.bombs = player_options.starting_bombs + ap_save.permanent_upgrades.bombs
    player.inventory.ropes = player_options.starting_ropes + ap_save.permanent_upgrades.ropes

    if ap_save.permanent_upgrades.paste ~= 0 then
        player:give_powerup(ENT_TYPE.ITEM_POWERUP_PASTE)
    end

    if ap_save.permanent_upgrades.compass == 1 then
        player:give_powerup(ENT_TYPE.ITEM_POWERUP_COMPASS)
    elseif ap_save.permanent_upgrades.compass == 2 then
        player:give_powerup(ENT_TYPE.ITEM_POWERUP_SPECIALCOMPASS)
    end
end, ON.START)

set_callback(function()
    set_callback(function()
        clear_callback()
        if ap_save.unlocked_key_items[8] then
        waddler_store_entity(ENT_TYPE.ITEM_HOUYIBOW)
        end

        if ap_save.permanent_upgrades.eggplant ~= 0 then
            waddler_store_entity(ENT_TYPE.ITEM_EGGPLANT)
        end
    end, ON.PRE_LEVEL_GENERATION)
end, ON.RESET)


set_callback(function()
    if debugging then
        print("LEVEL")
    end

    if state.level >= 10 and state.level <= ap_save.permanent_upgrades.checkpoints * 10 then
        state.world_start = 7
        state.theme_start = THEME.COSMIC_OCEAN
        state.level_start = math.floor(state.level / 10) * 10
    end


    
    if savegame.shortcuts > ap_save.shortcut_progress then
        ap_save.shortcut_progress = savegame.shortcuts
    end
end, ON.LEVEL)


set_callback(function()
    if debugging then
        print("POST_LEVEL_GENERATION")
    end

    local coffin_uids = get_entities_by(ENT_TYPE.ITEM_COFFIN, MASK.ITEM, LAYER.BOTH)
    for _, uid in ipairs(coffin_uids) do
        local coffin = get_entity(uid)
        --[[
        if coffin.inside == ENT_TYPE.CHAR_HIREDHAND and #ap_save.default_character_queue ~= 0 then
            set_contents(coffin.uid, ap_save.default_character_queue[1])
            table.remove(ap_save.default_character_queue, 1)
            break
        end]]

        for character, is_unlocked in ipairs(ap_save.people) do
            if coffin.inside == character_data.types[character] and is_unlocked then
                set_contents(coffin.uid, ENT_TYPE.CHAR_HIREDHAND)
                break
            end
        end
    end
end, ON.POST_LEVEL_GENERATION)


set_callback(function()
    -- Iterates over all 5 Journal chapters
    for _, chapter in ipairs(journal.chapters) do

        -- Iterates over every entry in the given Journal chapter
        for index, entry_obtained in ipairs(savegame[chapter]) do

            -- Verifies that the entry has been unlocked in the game save, but not the AP save
            if not ap_save[chapter][index] and entry_obtained then
                update_journal(chapter, index)
            end
        end
    end
end, ON.GAMEFRAME)


set_callback(function()
    if debugging then
        print("TRANSITION")
    end

    if player_options.progressive_worlds then
        if state.world_next > ap_save.max_world then
            toast("This world is not unlocked yet!")
            state.world_next = state.world_start
            state.level_next = state.level_start
            state.theme_next = state.theme_start

            for _, quest in ipairs(state.quests) do
                state.quests[quest] = 0
            end

            state.quest_flags = QUEST_FLAG.RESET
        end
    else
        if not ap_save.unlocked_worlds[theme_to_index[state.theme_next]] then
            toast("This world is not unlocked yet!")
            state.world_next = state.world_start
            state.level_next = state.level_start
            state.theme_next = state.theme_start

            for _, quest in ipairs(state.quests) do
                state.quests[quest] = 0
            end

            state.quest_flags = QUEST_FLAG.RESET
        end
    end
end, ON.TRANSITION)


set_post_entity_spawn(function(entity, spawn_flags)
    local entity_type = get_entity_type(entity.uid)
    if not ap_save.unlocked_key_items[key_item_to_index[entity_type]] then
        entity:destroy_recursive(MASK.ITEM, {ENT_TYPE.ITEM_METAL_ARROW}, RECURSIVE_MODE.INCLUSIVE)
    end
end, SPAWN_TYPE.ANY, MASK.ITEM, ENT_TYPE.ITEM_PICKUP_UDJATEYE, ENT_TYPE.ITEM_PICKUP_HEDJET, ENT_TYPE.ITEM_PICKUP_CROWN, ENT_TYPE.ITEM_PICKUP_ANKH, ENT_TYPE.ITEM_EXCALIBUR, ENT_TYPE.ITEM_SCEPTER, ENT_TYPE.ITEM_PICKUP_TABLETOFDESTINY, ENT_TYPE.ITEM_USHABTI, ENT_TYPE.ITEM_LIGHT_ARROW, ENT_TYPE.ITEM_HOUYIBOW)


function give_item(type)
    local player = get_player(1, false)
    if player ~= nil then
        if type == ENT_TYPE.ITEM_PICKUP_ROPEPILE then
            if savegame[journal.chapters.items][1] then
                give_entity(player, type)
            else
                if player.inventory.ropes + 3 > 99 then
                    player.inventory.ropes = 99
                else
                    player.inventory.ropes = player.inventory.ropes + 3
                end
            end

        elseif type == ENT_TYPE.ITEM_PICKUP_BOMBBAG then
            if savegame[journal.chapters.items][2] then
                give_entity(player, type)
            else
                if player.inventory.bombs + 3 > 99 then
                    player.inventory.bombs = 99
                else
                    player.inventory.bombs = player.inventory.bombs + 3
                end
            end

        elseif type == ENT_TYPE.ITEM_PICKUP_BOMBBOX then
            if savegame[journal.chapters.items][3] then
                give_entity(player, type)
            else
                if player.inventory.bombs + 12 > 99 then
                    player.inventory.bombs = 99
                else
                    player.inventory.bombs = player.inventory.bombs + 12
                end
            end

        elseif type == ENT_TYPE.ITEM_PICKUP_COOKEDTURKEY and not player:is_cursed() then
            if savegame[journal.chapters.items][52] then
                give_entity(player, type)
            else
                player.health = player.health + 1
            end

        elseif type == ENT_TYPE.ITEM_PICKUP_ROYALJELLY and not player:is_cursed() then
            if savegame[journal.chapters.items][22] then
                give_entity(player, type)
            else
                player.health = player.health + 6
            end

        elseif type == ENT_TYPE.ITEM_GOLDBAR then
            give_entity(player, type)
        end
    end
end

function give_entity(player, ent)
    local newItem = get_entity(spawn_entity(ent, player.x, player.y, player.layer, 0, 0))
    newItem.stand_counter = 25
end


function give_trap(type)
    local player = get_player(1, false)
    if player ~= nil then
        if type == "ghost" then
            set_ghost_spawn_times(0, 0)
            
            set_interval(function()
                set_ghost_spawn_times(10800, 9000)
                clear_callback()
            end, 1)

        elseif type == "poison" then
            poison_entity(player.uid)

        elseif type == "curse" then
            player:set_cursed(true, true)

        elseif type == "stun" then
            for _, uid in ipairs(get_entities_by(0, MASK.MOUNT, LAYER.PLAYER)) do
                local mount = get_entity(uid)
                if mount.rider_uid == player.uid then
                    mount:remove_rider()
                    break
                end
            end

            if player:get_behavior() == 19 or player:get_behavior() == 21 then
                set_callback(function()
                    if player:get_behavior() ~= 19 and player:get_behavior() ~= 21 then
                        player:stun(60)
                        clear_callback()
                    end
                end, ON.GAMEFRAME)
            else
                player:stun(60)
            end

        elseif type == "loose bombs" then
            local count = 0
            set_interval(function()
                count = count + 1

                local x, y, layer = get_position(player.uid)
                spawn(ENT_TYPE.ITEM_BOMB, x, y, layer, 0, 0)
                
                if count >= 5 then
                    clear_callback()
                end
                
            end, 60)

        elseif type == "blind" then
            if state.illumination ~= nil then
                set_interval(function()
                    player.emitted_light.enabled = true
                    state.illumination.enabled = false
                end, 1)
            else
                set_callback(function()
                    state.level_flags = set_flag(state.level_flags, 18)
                end, ON.POST_ROOM_GENERATION)
            end

        elseif type == "amnesia" then
            player:set_position(state.level_gen.spawn_x, state.level_gen.spawn_y)

        elseif type == "angry" then
            for _, door in ipairs(state.level_gen.exit_doors) do
                local shoppie = get_entity(spawn(ENT_TYPE.MONS_SHOPKEEPER, door.x, door.y, LAYER.FRONT, 0, 0))
                shoppie.aggro_trigger = true
            end
            state.shoppie_aggro = 3

        elseif type == "punish" then
            local altars_destroyed_backup = state.kali_altars_destroyed
            attach_ball_and_chain(player.uid, 0, 0)
            local count = 0
            state.kali_altars_destroyed = 2

            set_callback(function()
                count = count + 1

                if count >= 2 then
                    state.kali_altars_destroyed = altars_destroyed_backup
                    clear_callback()
                end
            end, ON.LEVEL)
        end
    end
end