meta = {
    name = "Spelunky 2 Archipelago",
    description = "Adds Archipelago Multiworld Randomizer support!",
    author = "DDRKhat\nOriginal: Eszenn",
    version = "0.3.3",
    unsafe = true
}
register_option_float('popup_time', 'Popup Timer', 'How long the "You received" or "You sent"! popup lingers.\n(Note: Higher values makes receiving items take longer)\nTime in seconds', 3.5, 0.5, 10)

local function normalizeData(container, key, max)
    local data = container[key]
    if type(data) ~= "number"
       or data < -1 -- Some things use -1 as a valid state on C's side.
       or data >= 0xFFFF0000
       or (max and data > max) then
        container[key] = 0
    end
end

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

safe_require("lib/Spel2ItemCodes")
safe_require("data")
safe_require("save")
safe_require("client")

normalizeData(game_manager.save_related.journal_popup_ui,"chapter_to_show",10)
normalizeData(game_manager.save_related.journal_popup_ui,"timer", 300)
ENT_MORE_FLAG.FINISHED_SPAWNING = 7 -- Manually define this missing flag. So we don't have a "Magic number" in code.
ENT_FLAG.CLOVER_FLAG = 23 -- Add level flag not in ent_flag list. So we don't have a "Magic number" in code.
generalItem = makeTexture("assets/item.png", 128, 128)
trapItem = makeTexture("assets/trap.png", 128, 128)
progressionItem = makeTexture("assets/progression.png", 128, 128)

apPlayer = nil
debugging = false
givingItem = nil
waddlerClover = false
usedBossDoor = false
done8Favour = false
done16Favour = false
nextWorldUnlocked = false
hudLevelIcon = nil
local hudXOffset    = -0.02
local hudYOffset    = 0.55
local bombOrRope = false
function getBombOrRope()
    bombOrRope = not bombOrRope
    if bombOrRope then
        return ENT_TYPE.ITEM_PICKUP_BOMBBAG
    else
        return ENT_TYPE.ITEM_PICKUP_ROPEPILE
    end
end

KALI_REWARDS = {
    ['8FAVOUR'] = become_lookup_table({
        ENT_TYPE.ITEM_PICKUP_COMPASS,
        ENT_TYPE.ITEM_PICKUP_SPECTACLES,
        ENT_TYPE.ITEM_PICKUP_SPRINGSHOES,
        ENT_TYPE.ITEM_PICKUP_SPIKESHOES,
        ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES,
        ENT_TYPE.ITEM_PICKUP_PITCHERSMITT,
        ENT_TYPE.ITEM_CAPE,
        ENT_TYPE.ITEM_PICKUP_SKELETON_KEY,
        ENT_TYPE.ITEM_PICKUP_BOMBBAG,
    }),

    ['16FAVOR'] = become_lookup_table({
        ENT_TYPE.ITEM_PICKUP_KAPALA,
    }),

    ['16PLUS'] = become_lookup_table({
        ENT_TYPE.ITEM_PICKUP_ROYALJELLY,
    }),

    ['USHABTI'] = become_lookup_table({
        ENT_TYPE.MONS_VAMPIRE,
        ENT_TYPE.MONS_CAVEMAN,
        ENT_TYPE.MOUNT_TURKEY,
        ENT_TYPE.CHAR_HIREDHAND,
    }),

    ['DICE'] = become_lookup_table({
        ENT_TYPE.MONS_SNAKE,
        ENT_TYPE.ITEM_DIAMOND,
        ENT_TYPE.ITEM_TELEPORTER_BACKPACK,
        ENT_TYPE.ITEM_PICKUP_SPECTACLES,
        ENT_TYPE.ITEM_PICKUP_ROPEPILE,
        ENT_TYPE.ITEM_MACHETE,
        ENT_TYPE.ITEM_WEBGUN,
        ENT_TYPE.ITEM_PICKUP_COOKEDTURKEY,
        ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES,
        ENT_TYPE.MONS_VAMPIRE,
        ENT_TYPE.CHAR_HIREDHAND,
    }),
    ['JOURNALID'] = {
        [ENT_TYPE.ITEM_PICKUP_SPECTACLES]     = 5,
        [ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES] = 6,
        [ENT_TYPE.ITEM_PICKUP_PITCHERSMITT]   = 7,
        [ENT_TYPE.ITEM_PICKUP_SPRINGSHOES]    = 8,
        [ENT_TYPE.ITEM_PICKUP_SPIKESHOES]     = 9,
        [ENT_TYPE.ITEM_PICKUP_COMPASS]        = 10,
        [ENT_TYPE.ITEM_PICKUP_KAPALA]         = 14,
        [ENT_TYPE.ITEM_PICKUP_SKELETON_KEY]   = 21,
        [ENT_TYPE.ITEM_CAPE]                  = 23,
        [ENT_TYPE.ITEM_TELEPORTER_BACKPACK]   = 26,
        [ENT_TYPE.ITEM_MACHETE]               = 38,
        [ENT_TYPE.ITEM_WEBGUN]                = 29,
    }
}

local function buildKaliLookup()
    local all = {}
    for key, category in pairs(KALI_REWARDS) do
        if key == "ALL" or key == "JOURNALID" then
            goto continue
        end
        for ent_type, _ in pairs(category) do
            all[#all+1] = ent_type
        end
        ::continue::
    end
    KALI_REWARDS.ALL = become_lookup_table(all)
end

buildKaliLookup()

local shortcut_save_values = {
    [0] = 1,
    [1] = 4,
    [2] = 7,
    [3] = 10
}

function IsInGame()
    return state.screen >= SCREEN.CAMP and
           state.screen <= SCREEN.RECAP
end

function IsTiamatLevel()
    return state.theme_info:get_theme_id() == THEME.TIAMAT
end

function IsHundunLevel()
    return state.theme_info:get_theme_id() == THEME.HUNDUN
end

function IsWaddlerLevel()
    return state.world == 3 or state.world == 5 or state.world == 7
end

local shortcut_levels = {
    [2] = 1, -- Jungle/Volcana
    [3] = 2, -- Olmec
    [4] = 2, -- ignore Tidepool/Temple, same level as Olmec
    [5] = 3, -- Ice Caves
    [6] = 3, -- Neo Babylon
    [7] = 3, -- Sunken City
    [8] = 3, -- Cosmic Ocean
}

function get_shortcut_level()
    local currentMax
    if player_options.progressive_worlds then
        currentMax = ap_save.max_world
    else
        currentMax = get_unlock_world_number()
    end

    return shortcut_levels[currentMax] or 0
end

function set_shortcut_progress(level)
    savegame.shortcuts = shortcut_save_values[level] or 1
end

set_callback(function()
    debug_print("LOADING")

    local goingIntoTransition = (state.screen == SCREEN.LEVEL and state.screen_next == SCREEN.TRANSITION)
    local changingWorld = (state.world_next > state.world) and (state.level_next == 1)

    if goingIntoTransition and changingWorld and not nextWorldUnlocked then
        state.theme_next = state.theme_start
    end

    if state.screen_next == SCREEN.CHARACTER_SELECT then
        update_characters(true)
    end

    if state.screen_next == SCREEN.CAMP then
        ap_save.last_character = savegame.players[1]
        update_characters(false)
        set_shortcut_progress(get_shortcut_level())
    end

    if (state.screen_next == SCREEN.CAMP
       or state.screen_next == SCREEN.MENU)
       and apPlayer ~= nil then
        apPlayer = nil
    end
    hudLevelIcon = get_hud().level_icon
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
    if not entity or not entity.uid then
        return
    end
    if not state.room_owners or not state.room_owners.owned_items then
        return
    end
    local owner_uid = entity.last_owner_uid
    if not owner_uid or owner_uid == -1 then
        return
    end
    for uid, entry in pairs(state.room_owners.owned_items) do
        if uid ~= entity.uid or entry.owner_uid ~= owner_uid then
            goto continue
        end
        debug_print(f"Removed entity UID {uid} from shop owned by UID {owner_uid}")
        state.room_owners.owned_items:erase(uid)
        entity.last_owner_uid = -1
        break;
        ::continue::
    end
    return owner_uid
end

-- This handles all of the permanent upgrades to give the player at the start of every run
set_callback(function()
    debug_print("START")

    done8Favour = false
    done16Favour = false
    apPlayer = get_player(1)
    apPlayer.health = player_options.starting_health + ap_save.stat_upgrades[Spel2AP.permanent_upgrades.Health]
    apPlayer.inventory.bombs = player_options.starting_bombs + ap_save.stat_upgrades[Spel2AP.permanent_upgrades.Bomb]
    apPlayer.inventory.ropes = player_options.starting_ropes + ap_save.stat_upgrades[Spel2AP.permanent_upgrades.Rope]
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
            journal_index = (value == 2 and savegame.items[10]) and 11 or 10
        else
            journal_index = ItemCode_to_Index[item_code]
        end
        if journal_index
                and savegame.items[journal_index] ~= true
                and player_options.journal_entry_required then
            goto continue -- Not something we care about, stop doing stuff with it.
        end
        if item_code == Spel2AP.upgrades.Elixir then
            apPlayer:set_pre_update_state_machine(function()
                if not test_flag(apPlayer.more_flags, ENT_MORE_FLAG.FINISHED_SPAWNING) then
                    return
                end
                clear_callback()
                local flags = get_entity_flags2(apPlayer.uid)
                flags = set_flag(flags, ENT_MORE_FLAG.ELIXIR_BUFF)
                set_entity_flags2(apPlayer.uid, flags)
            end)
            goto continue -- We've done a special handling.
        end
        local ent, isPowerup = SpawnJournalIndex(journal_index, true)
        if isPowerup then
            apPlayer:give_powerup(ent)
        else
            local playerX, playerY, playerLayer = get_position(apPlayer.uid)
            local spawnItem = spawn_entity_snapped_to_floor(ent, playerX, playerY, playerLayer)
            local spawnEntity = get_entity(spawnItem)
            if item_code == Spel2AP.upgrades.Ushabti then
                spawnEntity.animation_frame = state:get_correct_ushabti()
            end
        end
        ::continue::
    end
end, ON.START)

set_callback(function()
    set_callback(function()
        clear_callback()
        waddlerClover = false
        usedBossDoor = false
        local compassCount = 0
        for item_code, is_unlocked in pairs(ap_save.waddler_item_unlocks) do
            if is_unlocked ~= true then
                goto continue -- Not something we care about, stop doing stuff with it.
            end
            if item_code == Spel2AP.upgrades.Alien_Compass
                    or item_code == Spel2AP.upgrades.Compass then
                compassCount = compassCount + 1
                goto continue -- Not something we care about, stop doing stuff with it.
            end
            local journal_index = ItemCode_to_Index[item_code]
            if journal_index
                    and savegame.items[journal_index] ~= true
                    and player_options.journal_entry_required then
                goto continue -- Not something we care about, stop doing stuff with it.
            end
            local ent, _ = SpawnJournalIndex(journal_index, false)
            local itemSlot = waddler_store_entity(ent)
            if item_code == Spel2AP.upgrades.Four_Leaf_Clover then
                waddler_set_entity_meta(itemSlot, Spel2AP.upgrades.Four_Leaf_Clover)
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
    if state.level >= 10
       and state.level <= ap_save.stat_upgrades[Spel2AP.permanent_upgrades.Cosmic_Ocean_Checkpoint] * 10 then
        state.world_start = 7
        state.theme_start = THEME.COSMIC_OCEAN
        state.level_start = math.floor(state.level / 10) * 10
    end

    if savegame.shortcuts > ap_save.shortcut_progress then
        ap_save.shortcut_progress = savegame.shortcuts
        write_save()
    end

    set_callback(function()
        clear_callback()
        if (ap_save.permanent_item_upgrades[Spel2AP.upgrades.Four_Leaf_Clover] or waddlerClover)
            and
           (savegame.items[ItemCode_to_Index[Spel2AP.upgrades.Four_Leaf_Clover]] or not player_options.journal_entry_required)
        then
            local level_flags = get_level_flags()
            level_flags = set_flag(level_flags, ENT_FLAG.CLOVER_FLAG)
            set_level_flags(level_flags)
        end
    end, ON.PRE_UPDATE)

    if (IsTiamatLevel() and player_options.goal ~= AP_Goal.EASY)
       or
       (IsHundunLevel() and player_options.goal ~= AP_Goal.HARD) then
        state.theme_info:set_post_virtual(THEME_OVERRIDE.PRE_TRANSITION, function()
            if state.win_state ~= WIN_STATE.NO_WIN then
                state.win_state = WIN_STATE.NO_WIN
            end
        end)
    end
    apPlayer = get_player(1)
    update_nextworld_variable()
end, ON.LEVEL)


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
        if unrestricted_items[storedItem] then
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
end, SPAWN_TYPE.ANY, MASK.ITEM, {ENT_TYPE.ITEM_CRATE, ENT_TYPE.ITEM_PRESENT, ENT_TYPE.ITEM_GHIST_PRESENT})


--[[
If it's not our goal, let us beat the boss and loop back.
]]--
set_post_entity_spawn(function (door)
    if player_options.goal == AP_Goal.EASY then
        return
    end
    if state.screen ~= SCREEN.LEVEL or state.world <= 5 or state.level <= 3 then
        return
    end
    local isTiamatWorld = IsTiamatLevel()
    if player_options.goal == AP_Goal.HARD and not isTiamatWorld then
        return
    end
    local isHunDunWorld = IsHundunLevel()
    local isCosmicOcean = state.level > 4
    if player_options.goal == AP_Goal.CO and isCosmicOcean and state.level < player_options.goal_level - 1 then
        return
    end
    door:set_pre_enter(function()
        if isTiamatWorld -- Send Guy Spelunky if we go in. Because we normally would.
                and not ap_save.checked_locations[Spel2AP.locations.people.Guy_Spelunky] then
            update_journal(journal.chapters["people"], character_data[Spel2AP.locations.people.Guy_Spelunky].index, true)
        elseif isHunDunWorld -- Classic Guy, same reason.
                and not ap_save.checked_locations[Spel2AP.locations.people.Classic_Guy] then
            update_journal(journal.chapters["people"], character_data[Spel2AP.locations.people.Classic_Guy].index, true)
        end
        if isTiamatWorld or isHunDunWorld then
            usedBossDoor = true
            state.screen_next = SCREEN.TRANSITION
            state.world_next = state.world_start
            state.level_next = state.level_start
            state.theme_next = state.theme_start
        else
            state.win_state = 3
            state.screen_next = SCREEN.WIN
            state.level_next = 99
        end
    end)
end, SPAWN_TYPE.ANY, MASK.ANY, ENT_TYPE.FLOOR_DOOR_EXIT)


set_post_entity_spawn(function(clover)
    if ap_save.waddler_item_unlocks[Spel2AP.upgrades.Four_Leaf_Clover] ~= true or waddlerClover then
        return
    end
    clover:set_pre_apply_metadata(function(_, meta)
        if meta ~= Spel2AP.upgrades.Four_Leaf_Clover then
            return
        end
        clover:set_pre_virtual(ENTITY_OVERRIDE.GIVE_POWERUP, function()
            waddlerClover = true
        end)
    end)
end, SPAWN_TYPE.ANY, MASK.ITEM, ENT_TYPE.ITEM_PICKUP_CLOVER)

local replacingUshabti = false
set_post_entity_spawn(function(ushabti)
    if ap_save.waddler_item_unlocks[Spel2AP.upgrades.Ushabti] ~= true or not IsWaddlerLevel() then
        return
    end
    if replacingUshabti then
        replacingUshabti = false
        return
    end
    ushabti:set_pre_update_state_machine(function()
        if not test_flag(ushabti.more_flags, ENT_MORE_FLAG.FINISHED_SPAWNING) then
            return
        end
        clear_callback()
        replacingUshabti = true
        local spawnItem = spawn_entity_snapped_to_floor(ENT_TYPE.ITEM_USHABTI, ushabti.x, ushabti.y, ushabti.layer)
        local spawnEntity = get_entity(spawnItem)
        spawnEntity.animation_frame = state:get_correct_ushabti()
        ushabti:destroy()
    end)
end, SPAWN_TYPE.ANY, MASK.ITEM, ENT_TYPE.USHABTI)

set_callback(function()
    local popupUI = game_manager.save_related.journal_popup_ui
    if popupUI.timer > 0 and popupUI.chapter_to_show == 6 then
        debug_print(f"[ON.GAMEFRAME::popupCheck] Timer > 0 + Chapter 6 [Items]")
        local save_entries = savegame.items
        local journalID = popupUI.entry_to_show + 1
        if save_entries and save_entries[journalID] == false then
            debug_print(f"[ON.GAMEFRAME::lockedItem] Setting popup timer to 0")
            popupUI.timer = 0
        end
    end
    for _, chapter in ipairs(journal.chapters) do
        local save_entries = savegame[chapter]  -- numeric array from game save
        local ap_entries   = ap_save[chapter]   -- numeric array from AP

        -- Loop over numeric save indexes
        for save_index = 1, #save_entries do
            if not save_entries[save_index] or ap_entries[save_index] then
                goto continue
            end
            for _, entry in pairs(journal[chapter]) do
                if entry.index == save_index then
                    if givingItem ~= nil then
                        debug_print(f"[ON.GAMEFRAME::check_journal::giveItemCheck] giveItem is NOT nil. Set Entry to false")
                        save_entries[save_index] = false
                        ap_entries[save_index] = false
                        givingItem = nil
                    else
                        debug_print(f"[ON.GAMEFRAME::check_journal::giveItemCheck] giveItem is nil. send check.")
                        update_journal(chapter, entry.id, true)
                    end
                    break
                end
            end
            ::continue::
        end
    end
end, ON.GAMEFRAME)

set_callback(function(ctx, hud)
    if not IsInGame() then
        return
    end
    local opacity   = hud.data.opacity * hud.opacity
    if get_setting(GAME_SETTING.HUD_STYLE) == 2 then
        opacity = opacity / 2
    end
    local iconWidth  = hudLevelIcon.destination_top_right_x - hudLevelIcon.destination_top_left_x
    local iconHeight = hudLevelIcon.destination_top_left_y - hudLevelIcon.destination_bottom_left_y
    local function draw_scaled(texture, tileX, tileY, scale, yOffset_extra, color)
        local x_offset = iconWidth * hudXOffset
        local y_offset = iconHeight * (hudYOffset + yOffset_extra)
        local left   = (hudLevelIcon.x + x_offset) + (hudLevelIcon.destination_top_left_x    * scale)
        local right  = (hudLevelIcon.x + x_offset) + (hudLevelIcon.destination_top_right_x   * scale)
        local top    = (hudLevelIcon.y + y_offset) + (hudLevelIcon.destination_top_left_y    * scale)
        local bottom = (hudLevelIcon.y + y_offset) + (hudLevelIcon.destination_bottom_left_y * scale)
        ctx:draw_screen_texture(texture, tileX, tileY, left, top, right, bottom, color)
    end
    local showLock = not nextWorldUnlocked
    local hudColorWorld = Color:new(1, 1, 1, opacity * (showLock and 0.8 or 1.0))
    local hudColorLock  = Color:new(1, 1, 1, math.min(opacity * 1.2, 1))
    draw_scaled(TEXTURE.DATA_TEXTURES_MENU_BASIC_2, 6, 7, 1.0, 0, hudColorWorld)
    if showLock then
        draw_scaled(TEXTURE.DATA_TEXTURES_ITEMS_0, 13, 3, 0.55, 0.05, hudColorLock)
    end
end, ON.RENDER_PRE_HUD)


set_callback(function()
    debug_print("TRANSITION")

    local function run_reset()
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

    if usedBossDoor then
        run_reset()
        usedBossDoor = false
        return
    end

    local shouldReset
    if player_options.progressive_worlds then
        shouldReset = state.world_next > ap_save.max_world
    else
        local unlock_id = theme_to_world_unlock_id[state.theme_next]
        shouldReset = unlock_id and not ap_save.world_unlocks[unlock_id]
    end

    if shouldReset then
        toast("Next world not unlocked. Returning to the start")
        state.world_next = state.world_start
        state.level_next = state.level_start
        state.theme_next = state.theme_start
        run_reset()
    end

end, ON.TRANSITION)

local purchasable_list = become_lookup_table({
    ENT_TYPE.ITEM_PURCHASABLE_JETPACK,
    ENT_TYPE.ITEM_PURCHASABLE_POWERPACK,
    ENT_TYPE.ITEM_PURCHASABLE_HOVERPACK,
    ENT_TYPE.ITEM_PURCHASABLE_TELEPORTER_BACKPACK,
    ENT_TYPE.ITEM_PURCHASABLE_CAPE
})

local purchasable_counterpart = {
    [ENT_TYPE.ITEM_PURCHASABLE_JETPACK] = ENT_TYPE.ITEM_JETPACK,
    [ENT_TYPE.ITEM_PURCHASABLE_POWERPACK] = ENT_TYPE.ITEM_POWERPACK,
    [ENT_TYPE.ITEM_PURCHASABLE_HOVERPACK] = ENT_TYPE.ITEM_HOVERPACK,
    [ENT_TYPE.ITEM_PURCHASABLE_TELEPORTER_BACKPACK] = ENT_TYPE.ITEM_TELEPORTER_BACKPACK,
    [ENT_TYPE.ITEM_PURCHASABLE_CAPE] = ENT_TYPE.ITEM_CAPE,
}
--[[
Auto-complete the moon challenge if the mattock is missing.
]]--
set_callback(function()
    if not state.logic or not state.logic.tun_moon_challenge then
        return
    end
    local moonMattockID = state.logic.tun_moon_challenge.mattock_uid
    if moonMattockID ~= -1 then
        return
    end
    local fakeMattock = spawn_entity(ENT_TYPE.ITEM_SKULL, -1000, -1000, LAYER.BACK, 0, 0)
    state.logic.tun_moon_challenge.mattock_uid = fakeMattock
end, ON.SPEECH_BUBBLE)

local function process_potential_kali_item(entity, isUnlocked, entEnumName)
    debug_print(f"[processKaliItem] Checking if {entEnumName} is in kali list")
    if not KALI_REWARDS.ALL[entity.type.id] then
        debug_print("[processKaliItem] Not in the list. Stop working.")
        return
    end
    if (entity.owner_uid and entity.owner_uid ~= -1) or (entity.last_owner_uid and entity.last_owner_uid ~= -1) then
        debug_print("[processKaliItem] Held by someone. Assuming it's not a Kali item.")
        return
    end
    local altar_entities = get_entities_at(ENT_TYPE.FLOOR_ALTAR, MASK.FLOOR, entity.x, entity.y - 1, entity.layer, 1)
    if #altar_entities == 0 then
        debug_print("[processKaliItem] No altars found. Assuming it's not a Kali item.")
        return
    end
    local journalID = KALI_REWARDS.JOURNALID[entity.type.id]
    local shouldReplace = journalID and not isUnlocked
    if not done8Favour then
        if state.kali_favor > 7 then
            done8Favour = true
        end
    else
        if not done16Favour then
            if state.kali_favor > 15 then
                done16Favour = true
            end
        end
    end
    if shouldReplace then
        debug_print("[processKaliItem::shouldReplace] Should replace. Figuring one out")
        local foundReplacement = false
        for entry, _ in pairs(KALI_REWARDS['8FAVOUR']) do
            local entryJournalID = KALI_REWARDS.JOURNALID[entry]
            if not entryJournalID then
                goto continue
            end
            local powerupID = Journal_to_ItemEnt[entryJournalID].powerup
            if not powerupID then
                goto continue
            end
            if ap_save.item_unlocks[entryJournalID] and not apPlayer:has_powerup(powerupID) then
                debug_print(f"[processKaliItem::shouldReplace] Found and spawning {enum_get_name(ENT_TYPE,entry.type.id)} as a replacement")
                foundReplacement = true
                spawn_entity_snapped_to_floor(entry, entity.x, entity.y, entity.layer)
                break
            end
            ::continue::
        end
        if not foundReplacement then
            debug_print("[processKaliItem::shouldReplace] No replacement, giving a Bomb Bag")
            spawn_entity_snapped_to_floor(ENT_TYPE.ITEM_PICKUP_BOMBBAG, entity.x, entity.y, entity.layer)
        end
    else
        debug_print("[processKaliItem::shouldReplace] Do not replace.")
    end
end

local function process_potential_shop_item(entity, entEnumName)
    local shopOwner = remove_from_shop(entity)
    if shopOwner and shopOwner ~= -1 then
        local spawnItem = getBombOrRope()
        debug_print(f"[processShopItem] Found {entEnumName} in shop. Replacing with {enum_get_name(ENT_TYPE,spawnItem)})")
        local newItem = spawn_entity_snapped_to_floor(spawnItem, entity.x, entity.y, entity.layer)
        if state.shoppie_aggro < 1 and state.shoppie_aggro_next < 1 then
            if newItem and newItem ~= -1 then
                add_item_to_shop(newItem, shopOwner)
            else
                debug_print("[processShopItem] Something went wrong replacing a shop item.")
            end
        end
        if purchasable_list[entity.type.id] then
            entity:set_pre_destroy(function()
                local liberatedItems = get_entities_at(purchasable_counterpart[entity.type.id], MASK.ITEM, entity.x, entity.y, entity.layer, 1)
                for _, liberatedItem in ipairs(liberatedItems) do
                    local liberatedEntity = get_entity(liberatedItem)
                    liberatedEntity:destroy()
                end
            end)
        end
    end
end

for _, data in pairs(Journal_to_ItemEnt) do
    set_post_entity_spawn(function(entity, _)
        entity:set_pre_update_state_machine(function (_)
            if not test_flag(entity.more_flags, ENT_MORE_FLAG.FINISHED_SPAWNING) then
                return
            end
            local entType = entity.type.id
            if (entType == ENT_TYPE.ITEM_PICKUP_CROWN
               or entType == ENT_TYPE.ITEM_PICKUP_HEDJET) then
                if apPlayer.layer ~= entity.layer then
                    return
                end
                if distance(apPlayer.uid, entity.uid) > 9 then
                    return
                end
                if entType == ENT_TYPE.ITEM_PICKUP_CROWN then
                    clear_callback()
                    local crownX, crownY, crownL = get_position(entity.uid)
                    spawn_entity(getBombOrRope(), crownX, crownY, crownL, 0, 0)
                    entity:destroy()
                    return
                end
            end
            clear_callback()
            local isUnlocked = ap_save.item_unlocks[data.lock]
            local enumName = enum_get_name(ENT_TYPE,entity.type.id)
            process_potential_kali_item(entity, isUnlocked, enumName)
            if isUnlocked then
                return
            end
            process_potential_shop_item(entity, enumName)
            local heldEnt = entity:get_held_entity()
            if heldEnt ~= nil then
                heldEnt:destroy()
            end

            if entType == ENT_TYPE.ITEM_PICKUP_UDJATEYE then
                local entVelX, entVelY = get_velocity(entity.uid)
                spawn_entity(getBombOrRope(), entity.x, entity.y, entity.layer, entVelX, entVelY)
            end
            entity:destroy()
        end)
    end, SPAWN_TYPE.ANY, MASK.ITEM, data.type)
end

function SpawnJournalIndex(journalIndex, asPowerup)
    local entry = Journal_to_ItemEnt[journalIndex]
    if not entry then
        debug_print("No entry found for: " .. tostring(journalIndex))
        return nil, false
    end

    if asPowerup and entry.powerup then
        return entry.powerup, true
    end

    if entry.type then
        return entry.type, false
    end

    debug_print("No valid type for: " .. tostring(journalIndex))
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

function give_item(itemID, inLevel)
    local def = item_definitions[itemID] or item_definitions[Spel2AP.filler_items.Diamond_Gem]
    local goldValue = def.value or -1
    if goldValue ~= -1 and inLevel ~= true and player_options.increase_wallet then
        ap_save.starting_wallet = ap_save.starting_wallet + goldValue
    end
    if apPlayer ~= nil and inLevel then
        local journalEntry = def.journal or -1
        local entID = def.ent or ENT_TYPE.ITEM_DIAMOND
        give_entity(apPlayer, entID, journalEntry)
    end
end

function give_entity(player, ent, journalEntry)
    givingItem = savegame.items[journalEntry]
    local hideJournal = journalEntry ~= -1 and not givingItem
    local playerX, playerY, playerLayer = get_position(player.uid)
    local newItem = get_entity(spawn_entity(ent, playerX, playerY, playerLayer, 0, 0))
    debug_print(f"[give_entity::hideJournal-check] hideJournal: {hideJournal}")
    if not hideJournal then
        debug_print(f"[give_entity::hideJournal-check::false] hideJournal: {hideJournal}")
        givingItem = nil
    else
        debug_print(f"[give_entity::hideJournal-check::true] hideJournal: {hideJournal}")
        savegame.items[journalEntry] = false
        ap_save.items[journalEntry] = false
    end
    newItem.stand_counter = 25
end

local trap_effects = {
    [Spel2AP.traps.Ghost] = function()
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
    if apPlayer ~= nil and trap_effects[type] then
        trap_effects[type](apPlayer)
    end
end