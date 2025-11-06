local json = safe_require("lib/lunajson")
path = "saves/"
save_name = ""

local function deep_merge(base, new_data)
    for k, v in pairs(new_data) do
        if type(base[k]) == "table" and type(v) == "table" and next(base[k]) ~= nil and next(v) ~= nil then
            deep_merge(base[k], v)
        else
            base[k] = v
        end
    end
    return base
end

locked_starters = {ENT_TYPE.CHAR_ANA_SPELUNKY, ENT_TYPE.CHAR_MARGARET_TUNNEL,
                   ENT_TYPE.CHAR_COLIN_NORTHWARD, ENT_TYPE.CHAR_ROFFY_D_SLOTH}

session_locked_starters = {}

function refresh_session_starters()
    session_locked_starters = {}
    for index, value in ipairs(locked_starters) do
        session_locked_starters[index] = value
    end
end

function try_fetch_starter()
    returnValue = nil
    if session_locked_starters ~= nil and #session_locked_starters > 0 then
        returnValue = session_locked_starters[1]
        table.remove(session_locked_starters, 1)
    end
    return returnValue
end

ap_save = {}

function initialize_save(playerGoal, includeHardLocations)
    debug_print("Initialising save to defaults")

    local set_first_character = false

    ap_save = {
        last_character = 0,
        last_index = -1, -- Stores AP item data sent from the server
        checked_locations = {},

        max_world = 1,
        shortcut_progress = 0,

        character_unlocks = {},

        item_unlocks = {},

        permanent_item_upgrades = {},

        waddler_item_unlocks = {},

        stat_upgrades = {
            [Spel2AP.permanent_upgrades.Health] = 0,
            [Spel2AP.permanent_upgrades.Bomb] = 0,
            [Spel2AP.permanent_upgrades.Rope] = 0,
            [Spel2AP.permanent_upgrades.CO_Checkpoint] = 0,
        },

        starting_wallet = 0,

        world_unlocks = {},

        shortcut_unlocks = {},

        places = {},

        people = {},

        bestiary = {},

        items = {},

        traps = {}
    }

    for character in pairs(player_options.starting_characters) do
        local character_index = character_data[character].index
        table.insert(ap_save.checked_locations, character)
        ap_save.character_unlocks[character] = true
        ap_save.people[character_index] = true
        savegame.people[character_index] = true
        if not set_first_character then
            ap_save.last_character = character_index - 1
            set_first_character = true
        end
    end
    if not includeHardLocations then
        table.insert(ap_save.checked_locations, Spel2AP.locations.bestiary.Magmar)
        ap_save.bestiary[journal.bestiary.MAGMAR.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.bestiary.Lavamander)
        ap_save.bestiary[journal.bestiary.LAVAMANDER.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.bestiary.Mech_Rider)
        ap_save.bestiary[journal.bestiary.MECH_RIDER.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.bestiary.Scorpion)
        ap_save.bestiary[journal.bestiary.SCORPION.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.item.True_Crown)
        ap_save.items[journal.items.TRUE_CROWN.index] = true
    end
    if playerGoal < AP_Goal.CO then
        table.insert(ap_save.checked_locations, Spel2AP.locations.place.Cosmic_Ocean)
        ap_save.places[journal.places.COSMIC_OCEAN.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.people.Classic_Guy)
        ap_save.people[journal.people.CLASSIC_GUY.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.bestiary.Celestial_Jelly)
        ap_save.bestiary[journal.bestiary.CELESTIAL_JELLY.index] = true
    end
    if playerGoal < AP_Goal.HARD then
        table.insert(ap_save.checked_locations, Spel2AP.locations.place.Tiamats_Throne)
        ap_save.places[journal.places.TIAMATS_THRONE.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.place.Sunken_City)
        ap_save.places[journal.places.SUNKEN_CITY.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.place.Eggplant_World)
        ap_save.places[journal.places.EGGPLANT_WORLD.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.place.Hunduns_Hideaway)
        ap_save.places[journal.places.HUNDUNS_HIDEAWAY.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.people.Dirk_Yamaoka)
        ap_save.people[journal.people.DIRK_YAMAOKA.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.people.Guy_Spelunky)
        ap_save.people[journal.people.GUY_SPELUNKY.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.people.Eggplant_King)
        ap_save.people[journal.people.EGGPLANT_KING.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.bestiary.Tiamat)
        ap_save.bestiary[journal.bestiary.TIAMAT.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.bestiary.Tadpole)
        ap_save.bestiary[journal.bestiary.TADPOLE.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.bestiary.Frog)
        ap_save.bestiary[journal.bestiary.FROG.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.bestiary.Fire_Frog)
        ap_save.bestiary[journal.bestiary.FIRE_FROG.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.bestiary.Goliath_Frog)
        ap_save.bestiary[journal.bestiary.GOLIATH_FROG.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.bestiary.Grub)
        ap_save.bestiary[journal.bestiary.GRUB.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.bestiary.Giant_Fly)
        ap_save.bestiary[journal.bestiary.GIANT_FLY.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.bestiary.Hundun)
        ap_save.bestiary[journal.bestiary.HUNDUN.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.bestiary.Eggplant_Minister)
        ap_save.bestiary[journal.bestiary.EGGPLANT_MINISTER.index] = true
        table.insert(ap_save.checked_locations, Spel2AP.locations.bestiary.Eggplup)
        ap_save.bestiary[journal.bestiary.EGGPLUP.index] = true
    end

    -- Adjust savegame data
    savegame.tutorial_state = 4
    savegame.shortcuts = 0
    savegame.wins_normal = math.max(savegame.wins_normal, 1)
    savegame.wins_hard = math.max(savegame.wins_hard, 1)
    savegame.wins_special = math.max(savegame.wins_special, 1)
    savegame.deaths = math.max(savegame.deaths, 100)
    savegame.completed_normal = true
    savegame.completed_hard = true
    savegame.completed_ironman = true
    savegame.deepest_area = 8
    savegame.deepest_level = 99

    update_game_save()
    update_characters(false)
end


function update_game_save()
    for _, chapter in ipairs(journal.chapters) do
        copy_journal_data(chapter)
    end
end

function copy_journal_data(chapter)
    local source = ap_save[chapter]
    local target = savegame[chapter]

    if not source or not target then return end

    for index = 1, #target do
        target[index] = source[index] or false
    end
end

function update_characters(characterSelect)
    local flags = 0
    if characterSelect then
        for item_code, is_unlocked in pairs(ap_save.character_unlocks) do
            local entry = character_data[item_code]
            if entry then
                if is_unlocked then
                    flags = set_flag(flags, entry.index)
                else
                    flags = clr_flag(flags, entry.index)
                end
            else
                debug_print(f"update_characters: no character_data for item_code {tostring(item_code)}}")
            end
        end
    else
        local characters_in_journal = {}
        for _, location in pairs(ap_save.checked_locations) do
            characters_in_journal[location] = true
        end
        for _, data in pairs(character_data) do
            local character_index = data.index
            local location = data.location

            local is_unlocked = characters_in_journal[location] == true

            if is_unlocked then
                flags = set_flag(flags, character_index)
            else
                flags = clr_flag(flags, character_index)
            end
        end
    end
    savegame.characters = flags
end

function update_journal(chapter, location, sendLocation)
    local locationInfo = journal_lookup[location]
    local entry
    if locationInfo and locationInfo.chapter == chapter then
        entry = journal[chapter][locationInfo.entry]
    else
        for _, data in pairs(journal[chapter]) do
            if data.id == location then
                entry = data
                break
            end
        end
    end

    if not entry then
        debug_print(f"Warning: Tried to update unknown {chapter} entry for location ID {tostring(location)}")
        return
    end

    -- Mark as unlocked in AP save
    ap_save[chapter][entry.index] = true
    if not sendLocation then
        savegame[chapter][entry.index] = true
    end

    debug_print(f"Updated {chapter} entry {entry.name}")

    -- Track in checked_locations
    table.insert(ap_save.checked_locations, location)

    -- Skip sending if excluded by player options, because it won't exist in the multiworld
    if not player_options.include_hard_locations
            and obnoxious_journal_entries[location] then
        return
    end

    if player_options.goal == AP_Goal.EASY
            and (hard_journal_entries[location] or co_journal_entries[location]) then
        return
    end

    if player_options.goal == AP_Goal.HARD
            and co_journal_entries[location] then
        return
    end

    if sendLocation then
        -- Send the location to AP
        send_location(location)
    end
end

local function stringify_keys(tbl)
    if type(tbl) ~= "table" then return tbl end
    local out = {}
    for k, v in pairs(tbl) do
        local sk = type(k) == "string" and k or tostring(k)
        out[sk] = stringify_keys(v)
    end
    return out
end

function write_save()
    local filename = f"{path}AP_{game_info.username}_{player_options.seed}.json"
    local safe_save = stringify_keys(ap_save)
    local ok, json_str = pcall(json.encode, safe_save)
    if not ok then
        debug_print("write_save: JSON encode failed: " .. tostring(json_str))
        return
    end
    local file = io.open_data(filename, "w+")
    if file then
        file:write(json_str)
        file:close()
        debug_print(f"Saved data to {filename}")
    end
end

function read_save()
    local filename = f"{path}AP_{game_info.username}_{player_options.seed}.json"
    local file = io.open_data(filename, "r")
    if not file then
        debug_print("No save file found. Using freshly initialized state.")
        update_game_save() -- Apply the default journal state to the game
        return
    end

    local contents = file:read("a")
    file:close()

    local ok, data = pcall(json.decode, contents)
    if not ok or data == nil then
        debug_print("read_save: JSON decode failed or file empty: " .. tostring(data) .. ". Using initialized state.")
        update_game_save()
        return
    end

    local function restore_number_keys(tbl)
        if type(tbl) ~= "table" then return tbl end
        local out = {}
        for k, v in pairs(tbl) do
            local nk = tonumber(k) or k
            out[nk] = restore_number_keys(v)
        end
        return out
    end
    local loaded_data = restore_number_keys(data)

    ap_save = deep_merge(ap_save, loaded_data)

    -- Sync the merged data to the game's own save structure
    update_game_save() -- Syncs journal
    update_characters(false) -- Syncs character unlocks

    debug_print(f"Loaded data from {filename}")
end


function write_last_login(clear)
    local saveData = ""
    if clear == nil then
        saveData = json.encode({username = game_info.username, host = game_info.host, password = save_password and game_info.password or ""})
    end
    local loginFile = io.open_data("login.json", "w+")
    loginFile:write(saveData)
    loginFile:close()
end


function read_last_login()
    game_info.username = ""
    game_info.host = "archipelago.gg:38281"
    local loginFile = io.open_data("login.json", "r")
    if loginFile == nil then
        return false
    else
        local saveData = loginFile:read("*all")
        loginFile:close()
        if saveData and saveData ~= "" then
            local success, loginData = pcall(json.decode, saveData)
            if success then
                if (loginData and loginData ~= "") and (type(loginData) == "table" and next(loginData) ~= nil) then
                    game_info.host = loginData.host
                    game_info.username = loginData.username
                    game_info.password = loginData.password or ""
                    return true
                end
            end
        end
    end
    return false
end
