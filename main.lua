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

_G.debug_print = function(msg)
    if debugging then
        print(msg)
    end
end

safe_require("data")
safe_require("save")
safe_require("client")
safe_require("lib/Spel2ItemCodes")

function makeTexture(path, width, height)
    local definition = TextureDefinition.new()
    definition.texture_path = path
    definition.width = width
    definition.height = height
    definition.tile_width = width
    definition.tile_height = height
    local define = define_texture(definition)
    if define == nil then
        print("Failed to define texture: " .. path)
    else
        return define
    end
end
ENT_MORE_FLAG.FINISHED_SPAWNING = 7
ENT_FLAG.CLOVER_FLAG = 23
generalItem = makeTexture("assets/item.png", 128, 128)
trapItem = makeTexture("assets/trap.png", 128, 128)
progressionItem = makeTexture("assets/progression.png", 128, 128)

meta = {
    name = "Spelunky 2 Archipelago",
    description = "Adds Archipelago Multiworld Randomizer support!",
    author = "DDRKhat\nOriginal: Eszenn",
    version = "0.3.0",
    unsafe = true
}

register_option_float('popup_time', 'Popup Timer', 'How long the "You received" or "You sent"! popup lingers.\n(Note: Higher values makes receiving items take longer)\nTime in seconds', 3.5, 0.5, 10)

debugging = false
givingItem = false
waddlerGlover = false
local bombOrRope = false

set_callback(function()
    debug_print("LOADING")

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
            if ap_save.shortcut_unlocks[Spel2AP.shortcuts.Ice_Caves] then
                set_shortcut_progress(3)
            elseif ap_save.shortcut_unlocks[Spel2AP.shortcuts.Olmecs_Lair] then
                set_shortcut_progress(2)
            elseif ap_save.shortcut_unlocks[Spel2AP.shortcuts.Jungle] or ap_save.shortcut_unlocks[Spel2AP.shortcuts.Volcana] then
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

-- This handles all of the permanent upgrades to give the player at the start of every run
set_callback(function()
    debug_print("START")
    
    savegame.shortcuts = ap_save.shortcut_progress

    local player = get_player(1, false)
    player.health = player_options.starting_health + ap_save.stat_upgrades[Spel2AP.permanent_upgrades.Health]
    player.inventory.bombs = player_options.starting_bombs + ap_save.stat_upgrades[Spel2AP.permanent_upgrades.Bomb]
    player.inventory.ropes = player_options.starting_ropes + ap_save.stat_upgrades[Spel2AP.permanent_upgrades.Rope]

    for item_code, is_unlocked in pairs(ap_save.permanent_item_upgrades) do
        if is_unlocked ~= true or item_code == Spel2AP.upgrades.Four_Leaf_Clover then
            goto continue
        end
        local journal_index = ItemCode_to_Index[item_code]
        if journal_index and savegame.items[journal_index] ~= true then
            goto continue
        end
        local ent, isPowerup = SpawnJournalIndex(journal_index, true)
        if isPowerup then
            player:give_powerup(ent)
        else
            local playerX, playerY, playerLayer = get_position(player.uid)
            spawn_entity_snapped_to_floor(ent, playerX, playerY, playerLayer)
        end
        ::continue::
    end
end, ON.START)

set_callback(function()
    set_callback(function()
        clear_callback()
        waddlerGlover = false
        for item_code, is_unlocked in pairs(ap_save.waddler_item_unlocks) do
            if is_unlocked ~= true then
                goto continue
            end
            local journal_index = ItemCode_to_Index[item_code]
            if journal_index and savegame.items[journal_index] ~= true then
                goto continue
            end
            local ent, _ = SpawnJournalIndex(journal_index, false)
            waddler_store_entity(ent)
            ::continue::
        end
    end, ON.PRE_LEVEL_GENERATION)
end, ON.RESET)


set_callback(function()
    debug_print("LEVEL")
    if state.level >= 10 and state.level <= ap_save.stat_upgrades[Spel2AP.permanent_upgrades.Cosmic_Ocean_Checkpoint] * 10 then
        state.world_start = 7
        state.theme_start = THEME.COSMIC_OCEAN
        state.level_start = math.floor(state.level / 10) * 10
    end

    if savegame.shortcuts > ap_save.shortcut_progress then
        ap_save.shortcut_progress = savegame.shortcuts
    end

    set_callback(function()
        clear_callback()
        if ap_save.permanent_item_upgrades[Spel2AP.upgrades.Four_Leaf_Clover] then
            local level_flags = get_level_flags()
            level_flags = set_flag(level_flags, ENT_FLAG.CLOVER_FLAG)
            set_level_flags(level_flags)
        end
    end, ON.PRE_UPDATE)
end, ON.LEVEL)

local shop_item_uids = {}
set_callback(function()
    debug_print("POST_LEVEL_GENERATION")

    local coffin_uids = get_entities_by(ENT_TYPE.ITEM_COFFIN, MASK.ITEM, LAYER.BOTH)
    for _, uid in ipairs(coffin_uids) do
        local coffin = get_entity(uid)

        for _, data in pairs(character_data) do
            local is_unlocked = ap_save.people[data.index]
            if is_unlocked and coffin.inside == data.ent then
                set_contents(coffin.uid, ENT_TYPE.CHAR_HIREDHAND)
                break
            end
        end
    end
    shop_item_uids = {}
    set_callback(function()
        clear_callback()
        local owned_items = state.room_owners and state.room_owners.owned_items
        if owned_items then
            for uid, owner in pairs(state.room_owners.owned_items) do
                table.insert(shop_item_uids, {itemID = uid, ownerID = owner.owner_uid, shop_pool = owner, itemPool = owned_items})
            end
        end
    end, ON.PRE_UPDATE)
end, ON.POST_LEVEL_GENERATION)

set_post_entity_spawn(function(crate)
    if get_local_state().screen ~= SCREEN.LEVEL then
        return
    end
    crate:set_pre_update_state_machine(function()
        if not test_flag(crate.more_flags, ENT_MORE_FLAG.FINISHED_SPAWNING) then
            return
        end
        clear_callback()
        local storedItem = crate.inside
        if storedItem == ENT_TYPE.ITEM_PICKUP_BOMBBAG or storedItem == ENT_TYPE.ITEM_PICKUP_ROPEPILE then
            return
        end
        for _, entry in pairs(Journal_to_ItemEnt) do
            if entry.type == storedItem then
                if ap_save.item_unlocks[entry.lock] then
                    return
                else
                    break
                end
            end
        end
        local replaceItem = ENT_TYPE.ITEM_PICKUP_BOMBBAG
        if bombOrRope then
            replaceItem = ENT_TYPE.ITEM_PICKUP_ROPEPILE
            bombOrRope = false
        else
            bombOrRope = true
        end
        crate.inside = replaceItem
    end)
end, SPAWN_TYPE.ANY, 0, {ENT_TYPE.ITEM_CRATE, ENT_TYPE.ITEM_PRESENT, ENT_TYPE.ITEM_GHIST_PRESENT})

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
    debug_print("TRANSITION")

    local shouldReset = false
    if player_options.progressive_worlds then
        shouldReset = (state.world_next > ap_save.max_world)
    else
        local required_unlock_id = theme_to_world_unlock_id[state.theme_next]
        if required_unlock_id and not ap_save.world_unlocks[required_unlock_id] then
            shouldReset = true
        end
    end

    if shouldReset then
        toast("This world is not unlocked yet!")
        state.world_next = state.world_start
        state.level_next = state.level_start
        state.theme_next = state.theme_start

        state.quests.yang_state = 0
        state.quests.jungle_sisters_flags = 0
        state.quests.van_horsing_state = 0
        state.quests.sparrow_state = 0
        state.quests.madame_tusk_state = 0
        state.quests.beg_state = 0

        state.quest_flags = QUEST_FLAG.RESET
    end
end, ON.TRANSITION)

for _, data in pairs(Journal_to_ItemEnt) do
    set_post_entity_spawn(function(entity, _)
        entity:set_pre_update_state_machine(function (_)
            if not test_flag(entity.more_flags, ENT_MORE_FLAG.FINISHED_SPAWNING) then
                return
            end
            if not ap_save.item_unlocks[data.lock] then
                for _, shop_entry in ipairs(shop_item_uids) do
                    if shop_entry.itemID  == entity.uid then
                        debug_print(("Entity UID %d (%s) is in owned_items. Replacing."):format(entity.uid,enum_get_name(ENT_TYPE,entity.type.id)))
                        local spawnItem = ENT_TYPE.ITEM_PICKUP_BOMBBAG
                        if bombOrRope then
                            spawnItem = ENT_TYPE.ITEM_PICKUP_ROPEPILE
                            bombOrRope = false
                        else
                            bombOrRope = true
                        end
                        local newItem = spawn_entity_snapped_to_floor(spawnItem, entity.x, entity.y, entity.layer)
                        if shop_entry.ownerID and shop_entry.ownerID ~= -1 and newItem ~= nil then
                            add_item_to_shop(newItem, shop_entry.ownerID)
                        end
                        shop_entry.itemPool[entity.uid] = nil
                    end
                    local heldEnt = entity:get_held_entity()
                    if heldEnt ~= nil then
                        heldEnt:destroy()
                    end
                    entity:destroy()
                    clear_callback()
                end
            else
                clear_callback()
            end
        end)
    end, SPAWN_TYPE.ANY, MASK.ITEM, data.type)
end

function SpawnJournalIndex(journalIndex, asPowerup)
    if asPowerup then
        local ent = Journal_to_PowerupEnt[journalIndex]
        if ent ~= nil then
            return ent, true
        end
    end

    local ent = Journal_to_ItemEnt[journalIndex].type
    if ent ~= nil then
        return ent, false
    end

    debug_print("No entry found for: " .. tostring(journalIndex))
    return nil, false
end

function give_item(itemID)
    local player = get_player(1, false)
    if player ~= nil then
        local journalEntry = -1
        local entID = -1
        if itemID == Spel2AP.filler_items.Rope_Pile then
            journalEntry = 1
            entID = ENT_TYPE.ITEM_PICKUP_ROPEPILE
        elseif itemID == Spel2AP.filler_items.Bomb_Bag then
            journalEntry = 2
            entID = ENT_TYPE.ITEM_PICKUP_BOMBBAG
        elseif itemID == Spel2AP.filler_items.Bomb_Box then
            journalEntry = 3
            entID = ENT_TYPE.ITEM_PICKUP_BOMBBOX
        elseif itemID == Spel2AP.filler_items.Cooked_Turkey then
            journalEntry = 52
            entID = ENT_TYPE.ITEM_PICKUP_COOKEDTURKEY
        elseif itemID == Spel2AP.filler_items.Royal_Jelly then
            journalEntry = 22
            entID = ENT_TYPE.ITEM_PICKUP_ROYALJELLY
        elseif itemID == Spel2AP.filler_items.Gold_Bar then
            entID = ENT_TYPE.ITEM_GOLDBAR
        elseif itemID == Spel2AP.filler_items.Emerald_Gem then
            entID = ENT_TYPE.ITEM_EMERALD
        elseif itemID == Spel2AP.filler_items.Sapphire_Gem then
            entID = ENT_TYPE.ITEM_SAPPHIRE
        elseif itemID == Spel2AP.filler_items.Ruby_Gem then
            entID = ENT_TYPE.ITEM_RUBY
        else
            entID = ENT_TYPE.ITEM_DIAMOND
        end
        give_entity(player, entID, journalEntry)
    end
end

function give_entity(player, ent, journalEntry)
    local hideJournal = journalEntry ~= -1 and savegame.items[journalEntry] == false
    local playerX, playerY, playerLayer = get_position(player.uid)
    local newItem = get_entity(spawn_entity(ent, playerX, playerY, playerLayer, 0, 0))
    newItem.stand_counter = 25
    local firstRun = false
    set_callback(function()
        if firstRun then
            if hideJournal then
                game_manager.save_related.journal_popup_ui.timer = 0
                savegame.items[journalEntry] = false
                ap_save.items[journalEntry] = false
            end
            givingItem = false
            clear_callback()
        else
            firstRun = true
            givingItem = true
        end
    end, ON.PRE_UPDATE)
end


function give_trap(type)
    local player = get_player(1, false)
    if player ~= nil then
        if type == Spel2AP.traps.Ghost then
            set_ghost_spawn_times(0, 0)
            
            set_interval(function()
                set_ghost_spawn_times(10800, 9000)
                clear_callback()
            end, 1)

        elseif type == Spel2AP.traps.Poison then
            poison_entity(player.uid)

        elseif type == Spel2AP.traps.Curse then
            player:set_cursed(true, true)

        elseif type == Spel2AP.traps.Stun then
            for _, uid in ipairs(get_entities_by(0, MASK.MOUNT, LAYER.PLAYER)) do
                local mount = get_entity(uid)
                if mount.rider_uid == player.uid then
                    mount:remove_rider()
                    break
                end
            end

            if player:get_behavior() == CHAR_STATE.ENTERING or player:get_behavior() == CHAR_STATE.EXITING then
                set_callback(function()
                    if player:get_behavior() ~= CHAR_STATE.ENTERING and player:get_behavior() ~= CHAR_STATE.EXITING then
                        player:stun(60)
                        clear_callback()
                    end
                end, ON.GAMEFRAME)
            else
                player:stun(60)
            end

        elseif type == Spel2AP.traps.Loose_Bombs then
            local count = 0
            set_interval(function()
                count = count + 1

                local x, y, layer = get_position(player.uid)
                spawn(ENT_TYPE.ITEM_BOMB, x, y, layer, 0, 0)
                
                if count >= 5 then
                    clear_callback()
                end
                
            end, 60)

        elseif type == Spel2AP.traps.Blindness then
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

        elseif type == Spel2AP.traps.Amnesia then
            player:set_position(state.level_gen.spawn_x, state.level_gen.spawn_y)

        elseif type == Spel2AP.traps.Angry_Shopkeepers then
            for _, door in ipairs(state.level_gen.exit_doors) do
                local shoppie = get_entity(spawn(ENT_TYPE.MONS_SHOPKEEPER, door.x, door.y, LAYER.FRONT, 0, 0))
                shoppie.aggro_trigger = true
            end
            state.shoppie_aggro = 3

        elseif type == Spel2AP.traps.Punish_Ball then
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