meta = {
    name = "Spelunky 2 Archipelago",
    description = "Adds Archipelago Multiworld Randomizer support!",
    author = "DDRKhat\nOriginal: Eszenn",
    version = "0.3.0",
    unsafe = true
}

register_option_float('popup_time', 'Popup Timer', 'How long the "You received" or "You sent"! popup lingers.\n(Note: Higher values makes receiving items take longer)\nTime in seconds', 3.5, 0.5, 10)

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

safe_require("data")
safe_require("save")
safe_require("client")
safe_require("lib/Spel2ItemCodes")

ENT_MORE_FLAG.FINISHED_SPAWNING = 7 -- Manually define this missing flag. So we don't have a "Magic number" in code.
ENT_FLAG.CLOVER_FLAG = 23 -- Add level flag not in ent_flag list. So we don't have a "Magic number" in code.
generalItem = makeTexture("assets/item.png", 128, 128)
trapItem = makeTexture("assets/trap.png", 128, 128)
progressionItem = makeTexture("assets/progression.png", 128, 128)

debugging = false
givingItem = false
waddlerClover = false
local bombOrRope = false
function getBombOrRope()
    bombOrRope = not bombOrRope
    if bombOrRope then
        return ENT_TYPE.ITEM_PICKUP_BOMBBAG
    else
        return ENT_TYPE.ITEM_PICKUP_ROPEPILE
    end
end

local shortcut_save_values = {
    [0] = 1,
    [1] = 4,
    [2] = 7,
    [3] = 10
}

local function get_shortcut_level()
    if player_options.progressive_worlds then
        return math.min(ap_save.max_world - 1, 3)
    else
        local unlocks = ap_save.shortcut_unlocks
        if unlocks[Spel2AP.shortcuts.Ice_Caves] then
            return 3
        end
        if unlocks[Spel2AP.shortcuts.Olmecs_Lair] then
            return 2
        end
        if unlocks[Spel2AP.shortcuts.Jungle] or unlocks[Spel2AP.shortcuts.Volcana] then
            return 1
        end
        return 0
    end
end

local function set_shortcut_progress(level)
    savegame.shortcuts = shortcut_save_values[level] or 1
end

set_callback(function()
    debug_print("LOADING")

    if state.screen_next == SCREEN.CHARACTER_SELECT then
        update_characters()
    end

    if state.screen_next == SCREEN.CAMP then
        ap_save.last_character = savegame.players[1]
        lock_characters()
        set_shortcut_progress(get_shortcut_level())
    end
end, ON.LOADING)

function get_filtered_dice_prizes()
    local prizes = {}
    for _, ent_type in ipairs(default_dice_prizes) do
        local locked = false
        for _, data in pairs(Journal_to_ItemEnt) do
            if data.type == ent_type and ap_save.item_unlocks[data.lock] ~= true then
                locked = true
                break
            end
        end
        if not locked then
            table.insert(prizes, ent_type)
        end
    end
    return prizes
end

function remove_from_shop(entity)
    if not entity or not entity.uid then return end
    if not state.room_owners or not state.room_owners.owned_items then return end

    local owner_uid = entity.last_owner_uid
    if not owner_uid or owner_uid == -1 then return end

    for uid, entry in pairs(state.room_owners.owned_items) do
        if uid == entity.uid and entry.owner_uid == owner_uid then
            debug_print(f"Removed entity UID {uid} from shop owned by UID {owner_uid}")
            state.room_owners.owned_items:erase(uid)
            entity:liberate_from_shop()
            entity.last_owner_uid = -1
            return owner_uid
        end
    end

    debug_print(f"Entity UID {entity.uid} not found in owned_items for owner UID {owner_uid}")
    return -1
end

-- This handles all of the permanent upgrades to give the player at the start of every run
set_callback(function()
    debug_print("START")
    
    savegame.shortcuts = ap_save.shortcut_progress

    local player = get_player(1, false)
    player.health = player_options.starting_health + ap_save.stat_upgrades[Spel2AP.permanent_upgrades.Health]
    player.inventory.bombs = player_options.starting_bombs + ap_save.stat_upgrades[Spel2AP.permanent_upgrades.Bomb]
    player.inventory.ropes = player_options.starting_ropes + ap_save.stat_upgrades[Spel2AP.permanent_upgrades.Rope]
    if player_options.increase_wallet then
        add_money_slot(ap_save.starting_wallet, 1, 0)
    end

    for item_code, value in pairs(ap_save.permanent_item_upgrades) do
        if (type(value) == "boolean" and value ~= true)
                or item_code == Spel2AP.upgrades.Four_Leaf_Clover then
            goto continue -- Not something we care about, stop doing stuff with it.
        end
        local journal_index = -1
        if item_code == Spel2AP.upgrades.Compass then
            journal_index = (value == 1) and 10 or 11
        else
            journal_index = ItemCode_to_Index[item_code]
        end
        if journal_index and savegame.items[journal_index] ~= true then
            goto continue -- Not something we care about, stop doing stuff with it.
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
        waddlerClover = false
        local compassCount = 0
        for item_code, is_unlocked in pairs(ap_save.waddler_item_unlocks) do
            if is_unlocked ~= true then
                goto continue -- Not something we care about, stop doing stuff with it.
            end
            if item_code == Spel2AP.waddler_upgrades.Alien_Compass
                    or item_code == Spel2AP.waddler_upgrades.Compass then
                compassCount = compassCount + 1
                goto continue -- Not something we care about, stop doing stuff with it.
            end
            local journal_index = ItemCode_to_Index[item_code]
            if journal_index and savegame.items[journal_index] ~= true then
                goto continue -- Not something we care about, stop doing stuff with it.
            end
            local ent, _ = SpawnJournalIndex(journal_index, false)
            local itemSlot = waddler_store_entity(ent)
            if item_code == Spel2AP.waddler_upgrades.Four_Leaf_Clover then
                waddler_set_entity_meta(itemSlot, Spel2AP.waddler_upgrades.Four_Leaf_Clover)
            end
            ::continue::
        end
        if compassCount ~= 0 then
            local journal_index = (compassCount == 1) and 10 or 11
            local ent, _ = SpawnJournalIndex(journal_index, false)
            waddler_store_entity(ent)
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
        if ap_save.permanent_item_upgrades[Spel2AP.upgrades.Four_Leaf_Clover] or waddlerClover then
            local level_flags = get_level_flags()
            level_flags = set_flag(level_flags, ENT_FLAG.CLOVER_FLAG)
            set_level_flags(level_flags)
        end
    end, ON.PRE_UPDATE)
end, ON.LEVEL)

set_callback(function()
    debug_print("POST_LEVEL_GENERATION")

    local coffin_uids = get_entities_by(ENT_TYPE.ITEM_COFFIN, MASK.ITEM, LAYER.BOTH)
    for _, uid in ipairs(coffin_uids) do
        local coffin = get_entity(uid)

        for _, data in pairs(character_data) do
            local is_unlocked = ap_save.people[data.index] and savegame.people[data.index]
            if is_unlocked and coffin.inside == data.ent then
                set_contents(coffin.uid, ENT_TYPE.CHAR_HIREDHAND)
                break
            end
        end
    end
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
            if entry.type ~= storedItem then
                goto continue -- Not something we care about, stop doing stuff with it.
            end
            if ap_save.item_unlocks[entry.lock] then
                return
            else
                break
            end
            ::continue::
        end
        local replaceItem = getBombOrRope()
        crate.inside = replaceItem
    end)
end, SPAWN_TYPE.ANY, MASK.ANY, {ENT_TYPE.ITEM_CRATE, ENT_TYPE.ITEM_PRESENT, ENT_TYPE.ITEM_GHIST_PRESENT})

set_post_entity_spawn(function(clover)
    if ap_save.waddler_item_unlocks[Spel2AP.waddler_upgrades.Four_Leaf_Clover] ~= true or waddlerClover then
        return
    end
    clover:set_pre_apply_metadata(function(_, meta)
        if meta ~= Spel2AP.waddler_upgrades.Four_Leaf_Clover then
            return
        end
        clover:set_pre_virtual(94, function()
            waddlerClover = true
        end)
    end)
end, SPAWN_TYPE.ANY, MASK.ITEM, ENT_TYPE.ITEM_PICKUP_CLOVER)

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

    local shouldReset
    if player_options.progressive_worlds then
        shouldReset = state.world_next > ap_save.max_world
    else
        local unlock_id = theme_to_world_unlock_id[state.theme_next]
        shouldReset = unlock_id and not ap_save.world_unlocks[unlock_id]
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
        state.kali_altars_destroyed = 0
        state.kali_gifts = 0

        state.quest_flags = QUEST_FLAG.RESET
    end

    change_diceshop_prizes(get_filtered_dice_prizes())
end, ON.TRANSITION)

for _, data in pairs(Journal_to_ItemEnt) do
    set_post_entity_spawn(function(entity, _)
        entity:set_pre_update_state_machine(function (_)
            if not test_flag(entity.more_flags, ENT_MORE_FLAG.FINISHED_SPAWNING) then
                return
            end
            if ap_save.item_unlocks[data.lock] then
                clear_callback()
                return
            end
            local shopOwner = remove_from_shop(entity)
            if shopOwner ~= -1 then
                local spawnItem = getBombOrRope()
                local newItem = spawn_entity_snapped_to_floor(spawnItem, entity.x, entity.y, entity.layer)
                get_entity(newItem).last_owner_uid = shopOwner
                add_item_to_shop(newItem, shopOwner)
            end
            local heldEnt = entity:get_held_entity()
            if heldEnt ~= nil then
                heldEnt:destroy()
            end
            entity:destroy()
            clear_callback()
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

local item_definitions = {
    [Spel2AP.filler_items.Rope_Pile]     = { journal = 1,  ent = ENT_TYPE.ITEM_PICKUP_ROPEPILE },
    [Spel2AP.filler_items.Bomb_Bag]      = { journal = 2,  ent = ENT_TYPE.ITEM_PICKUP_BOMBBAG },
    [Spel2AP.filler_items.Bomb_Box]      = { journal = 3,  ent = ENT_TYPE.ITEM_PICKUP_BOMBBOX },
    [Spel2AP.filler_items.Cooked_Turkey] = { journal = 52, ent = ENT_TYPE.ITEM_PICKUP_COOKEDTURKEY },
    [Spel2AP.filler_items.Royal_Jelly]   = { journal = 22, ent = ENT_TYPE.ITEM_PICKUP_ROYALJELLY },
    [Spel2AP.filler_items.Gold_Bar]      = { ent = ENT_TYPE.ITEM_GOLDBAR,    value = 500 },
    [Spel2AP.filler_items.Emerald_Gem]   = { ent = ENT_TYPE.ITEM_EMERALD,    value = 800 },
    [Spel2AP.filler_items.Sapphire_Gem]  = { ent = ENT_TYPE.ITEM_SAPPHIRE,   value = 1200 },
    [Spel2AP.filler_items.Ruby_Gem]      = { ent = ENT_TYPE.ITEM_RUBY,       value = 1600 },
    [Spel2AP.filler_items.Diamond_Gem]   = { ent = ENT_TYPE.ITEM_DIAMOND,    value = 5000 },
}

function give_item(itemID)
    local player = get_player(1, false)
    if player ~= nil then
        local def = item_definitions[itemID] or item_definitions[Spel2AP.filler_items.Diamond_Gem]
        local journalEntry = def.journal or -1
        local entID = def.ent or ENT_TYPE.ITEM_DIAMOND
        local goldValue = def.value or -1
        give_entity(player, entID, journalEntry, goldValue)
    end
end

function give_entity(player, ent, journalEntry, goldValue)
    local hideJournal = journalEntry ~= -1 and savegame.items[journalEntry] == false
    local playerX, playerY, playerLayer = get_position(player.uid)
    local newItem = get_entity(spawn_entity(ent, playerX, playerY, playerLayer, 0, 0))
    if goldValue ~= -1 and player_options.increase_wallet then
        ap_save.starting_wallet = ap_save.starting_wallet + goldValue
    end
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

local trap_effects = {
    [Spel2AP.traps.Ghost] = function(player)
        set_ghost_spawn_times(0, 0)
        set_interval(function()
            set_ghost_spawn_times(10800, 9000)
            clear_callback()
        end, 1)
    end,

    [Spel2AP.traps.Poison] = function(player)
        poison_entity(player.uid)
    end,

    [Spel2AP.traps.Curse] = function(player)
        player:set_cursed(true, true)
    end,

    [Spel2AP.traps.Stun] = function(player)
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
    end,

    [Spel2AP.traps.Loose_Bombs] = function(player)
        local count = 0
        set_interval(function()
            count = count + 1
            local x, y, layer = get_position(player.uid)
            spawn(ENT_TYPE.ITEM_BOMB, x, y, layer, 0, 0)
            if count >= 5 then clear_callback() end
        end, 60)
    end,

    [Spel2AP.traps.Blindness] = function(player)
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
    end,

    [Spel2AP.traps.Amnesia] = function(player)
        player:set_position(state.level_gen.spawn_x, state.level_gen.spawn_y)
    end,

    [Spel2AP.traps.Angry_Shopkeepers] = function(_)
        for _, door in ipairs(state.level_gen.exit_doors) do
            local shoppie = get_entity(spawn(ENT_TYPE.MONS_SHOPKEEPER, door.x, door.y, LAYER.FRONT, 0, 0))
            shoppie.aggro_trigger = true
        end
        state.shoppie_aggro = 3
    end,

    [Spel2AP.traps.Punish_Ball] = function(player)
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
    end,
}

function give_trap(type)
    local player = get_player(1, false)
    if player ~= nil and trap_effects[type] then
        trap_effects[type](player)
    end
end