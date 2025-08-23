local json = safe_require("lib/lunajson")
path = "saves/"
save_name = ""

ap_save = {
    last_character = 1,
    last_index = -1, -- Stores AP item data sent from the server
    checked_locations = {},

    max_world = 1,
    shortcut_progress = 0,

    character_unlocks =
    {
        [Spel2AP.characters.Ana_Spelunky] = true,
        [Spel2AP.characters.Margaret_Tunnel] = true,
        [Spel2AP.characters.Colin_Northward] = true,
        [Spel2AP.characters.Roffy_D_Sloth] = true,
    },

    item_unlocks = {},

    permanent_item_upgrades = {},

    waddler_item_unlocks = {},

    stat_upgrades = {
        [Spel2AP.permanent_upgrades.Health] = 0,
        [Spel2AP.permanent_upgrades.Bomb] = 0,
        [Spel2AP.permanent_upgrades.Rope] = 0,
        [Spel2AP.permanent_upgrades.Cosmic_Ocean_Checkpoint] = 0,
    },

    world_unlocks = {},

    shortcut_unlocks = {},

    places = {
        [1] = false,  -- Dwelling
        [2] = false,  -- Jungle
        [3] = false,  -- Volcana
        [4] = false,  -- Olmec's Lair
        [5] = false,  -- Tide Pool
        [6] = false,  -- Abzu
        [7] = false,  -- Temple of Anubis
        [8] = false,  -- City of Gold
        [9] = false,  -- Duat
        [10] = false, -- Ice Caves
        [11] = false, -- Neo Babylon
        [12] = false, -- Tiamat's Throne
        [13] = false, -- Sunken Cty
        [14] = false, -- Eggplant World
        [15] = false, -- Hundun's Hideaway
        [16] = false  -- Cosmic Ocean
    },

    people = {
        [1] = true,  -- Ana Spelunky
        [2] = true,  -- Margaret Tunnel
        [3] = true,  -- Colin Northward
        [4] = true,  -- Roffy D. Sloth
        [5] = false,  -- Alto Singh
        [6] = false,  -- Liz Mutton
        [7] = false,  -- Nekka the Eagle
        [8] = false,  -- LISE Project
        [9] = false,  -- Coco Von Diamonds
        [10] = false, -- Manfred Tunnel
        [11] = false, -- Little Jay
        [12] = false, -- Tina Flan
        [13] = false, -- Valerie Crump
        [14] = false, -- Au
        [15] = false, -- Demi Von Diamonds
        [16] = false, -- Pilot
        [17] = false, -- Princess Airyn
        [18] = false, -- Dirk Yamaoka
        [19] = false, -- Guy Spelunky
        [20] = false, -- Classic Guy
        [21] = false, -- Terra Tunnel
        [22] = false, -- Hired Hand
        [23] = false, -- Eggplant Child
        [24] = false, -- Shopkeeper
        [25] = false, -- Tun
        [26] = false, -- Yang
        [27] = false, -- Madame Tusk
        [28] = false, -- Tusk's Bodyguard
        [29] = false, -- Waddler
        [30] = false, -- Caveman Shopkeeper
        [31] = false, -- Ghist Shopkeeper
        [32] = false, -- Van Horsing
        [33] = false, -- Parsley
        [34] = false, -- Parsnip
        [35] = false, -- Parmesan
        [36] = false, -- Sparrow
        [37] = false, -- Beg
        [38] = false, -- Eggplant King
    },

    bestiary = {
        [1] = false,  -- Snake
        [2] = false,  -- Spider
        [3] = false,  -- Bat
        [4] = false,  -- Caveman
        [5] = false,  -- Skeleton
        [6] = false,  -- Horned Lizard
        [7] = false,  -- Cave Mole
        [8] = false,  -- Quillback
        [9] = false,  -- Mantrap
        [10] = false, -- Tikiman
        [11] = false, -- Witch Doctor
        [12] = false, -- Mosquito
        [13] = false, -- Monkey
        [14] = false, -- Hang Spider
        [15] = false, -- Giant Spider
        [16] = false, -- Magmar
        [17] = false, -- Robot
        [18] = false, -- Fire Bug
        [19] = false, -- Imp
        [20] = false, -- Lavamander
        [21] = false, -- Vampire
        [22] = false, -- Vlad
        [23] = false, -- Olmec
        [24] = false, -- Jiangshi
        [25] = false, -- Jiangshi Assassin
        [26] = false, -- Fish
        [27] = false, -- Octopy
        [28] = false, -- Hermit Crab
        [29] = false, -- Pangxie
        [30] = false, -- Great Humphead
        [31] = false, -- Kingu
        [32] = false, -- Crocman
        [33] = false, -- Cobra
        [34] = false, -- Mummy
        [35] = false, -- Sorceress
        [36] = false, -- Cat Mummy
        [37] = false, -- Necromancer
        [38] = false, -- Anubis
        [39] = false, -- Ammit
        [40] = false, -- Apep
        [41] = false, -- Anubis II
        [42] = false, -- Osiris
        [43] = false, -- UFO
        [44] = false, -- Alien
        [45] = false, -- Yeti
        [46] = false, -- Yeti King
        [47] = false, -- Yeti Queen
        [48] = false, -- Lahamu
        [49] = false, -- Proto Shopkeeper
        [50] = false, -- Olmite
        [51] = false, -- Lamassu
        [52] = false, -- Tiamat
        [53] = false, -- Tadpole
        [54] = false, -- Frog
        [55] = false, -- Fire Frog
        [56] = false, -- Goliath Frog
        [57] = false, -- Grub
        [58] = false, -- Giant Fly
        [59] = false, -- Hundun
        [60] = false, -- Eggplant Minister
        [61] = false, -- Eggplup
        [62] = false, -- Celestial Jelly
        [63] = false, -- Scorpion
        [64] = false, -- Bee
        [65] = false, -- Queen Bee
        [66] = false, -- Scarab
        [67] = false, -- Golden Monkey
        [68] = false, -- Leprechaun
        [69] = false, -- Monty
        [70] = false, -- Percy
        [71] = false, -- Poochi
        [72] = false, -- Ghist
        [73] = false, -- Ghost
        [74] = false, -- Cave Turkey
        [75] = false, -- Rock Dog
        [76] = false, -- Axolotl
        [77] = false, -- Qilin
        [78] = false  -- Mech Rider
    },

    items = {
        [1] = false, -- Rope Pile
        [2] = false, -- Bomb Bag
        [3] = false, -- Bomb Box
        [4] = false, -- Paste
        [5] = false, -- Spectacles
        [6] = false, -- Climbing Gloves
        [7] = false, -- Pitcher's Mitt
        [8] = false, -- Spring Shoes
        [9] = false, -- Spike Shoes
        [10] = false, -- Compass
        [11] = false, -- Alien Compass
        [12] = false, -- Parachute
        [13] = false, -- Udjat Eye
        [14] = false, -- Kapala
        [15] = false, -- Hedjet
        [16] = false, -- Crown
        [17] = false, -- Eggplant Crown
        [18] = false, -- True Crown
        [19] = false, -- Ankh
        [20] = false, -- Tablet of Destiny
        [21] = false, -- Skeleton Key
        [22] = false, -- Royal Jelly
        [23] = false, -- Cape
        [24] = false, -- Vlad's Cape
        [25] = false, -- Jetpack
        [26] = false, -- Telepack
        [27] = false, -- Hoverpack
        [28] = false, -- Powerpack
        [29] = false, -- Webgun
        [30] = false, -- Shotgun
        [31] = false, -- Freeze Ray
        [32] = false, -- Clone Gun
        [33] = false, -- Crossbow
        [34] = false, -- Camera
        [35] = false, -- Teleporter
        [36] = false, -- Mattock
        [37] = false, -- Boomerang
        [38] = false, -- Machete
        [39] = false, -- Excalibur
        [40] = false, -- Broken Sword
        [41] = false, -- Plasma Cannon
        [42] = false, -- Scepter
        [43] = false, -- Hou Yi's Bow
        [44] = false, -- Arrow of Light
        [45] = false, -- Wooden Shield
        [46] = false, -- Metal Shield
        [47] = false, -- Idol
        [48] = false, -- The Tusk Idol
        [49] = false, -- Curse Pot
        [50] = false, -- Ushabti
        [51] = false, -- Eggplant
        [52] = false, -- Cooked Turkey
        [53] = false, -- Elixir
        [54] = false, -- Four-Leaf Clover
    },

    traps = {
        [1] = false, -- Spikes
        [2] = false, -- Arrow Trap
        [3] = false, -- Totem Trap
        [4] = false, -- Log Trap
        [5] = false, -- Spear Trap
        [6] = false, -- Thorny Vine
        [7] = false, -- Bear Trap
        [8] = false, -- Powder Box
        [9] = false, -- Falling Platform
        [10] = false, -- Spikeball
        [11] = false, -- Lion Trap
        [12] = false, -- Giant Clam
        [13] = false, -- Sliding Wall
        [14] = false, -- Crush Trap
        [15] = false, -- Giant Crush Trap
        [16] = false, -- Boulder
        [17] = false, -- Spring Trap
        [18] = false, -- Landmine
        [19] = false, -- Laser Trap
        [20] = false, -- Spark Trap
        [21] = false, -- Frog Trap
        [22] = false, -- Sticky Trap
        [23] = false, -- Bone Drop
        [24] = false  -- Egg Sac
    }
}

function initialize_save()
    -- Clearing game save
    savegame.tutorial_state = 4
    savegame.shortcuts = 0
    savegame.wins_normal = math.max(savegame.wins_normal, 1)
    savegame.wins_hard = math.max(savegame.wins_hard, 1)
    savegame.wins_special = math.max(savegame.wins_special, 1)
    savegame.deaths = math.max(savegame.deaths, 100)

    for _, chapter in ipairs(journal.chapters) do
        clear_journal(savegame[chapter])
    end

    -- Clearing AP save
    ap_save.last_character = 0
    ap_save.max_world = 1

    --[[
    for _, character in ipairs(player_options.starting_characters) do
        local index = character_data.name_to_index[character]
        ap_save.unlocked_characters[index] = true
        
        if index <= 4 then
            table.remove(ap_save.default_character_queue, index)
        end
    end
    ]]

    update_characters()
    -- savegame.players[1] = character_data.name_to_index[player_options.starting_characters[1]] - 1
    savegame.players[1] = 0
end


function update_game_save()
    for _, chapter in ipairs(journal.chapters) do
        copy_journal_data(chapter)
    end
end


function update_characters()
    local character_sum = 0
    -- Iterate through the character_unlocks table using pairs(), as the keys are not sequential.
    for item_code, is_unlocked in pairs(ap_save.character_unlocks) do
        if is_unlocked then
            -- Use the item_code to look up the character's binary value from character_data
            if character_data[item_code] then
                character_sum = character_sum + character_data[item_code].binary
            end
        end
    end

    savegame.characters = character_sum
end


function lock_characters()
    local character_sum = 0
    for index, is_unlocked in ipairs(ap_save.people) do
        -- index is within this range to not check the characters that don't show up in coffins
        if is_unlocked and index > 4 and index <= 18 then
            local entry = character_data[index]
            if entry ~= nil and entry.binary ~= nil then
                character_sum = character_sum + entry.binary
            else
                debug_print(f"lock_characters: failed to find binary for {tostring(index)}")
            end
        end
    end

    savegame.characters = character_sum
end


function update_journal(chapter, index)
    ap_save[chapter][index] = true

    debug_print(F"Updated {chapter} entry {journal[chapter][index]}")

    local location_name = f"{journal[chapter][index]} Journal Entry"
    local location_id = location_name_to_id[location_name]

    table.insert(ap_save.checked_locations, #ap_save.checked_locations + 1, location_id)
    send_location(location_id)
end


function copy_journal_data(chapter)
    local array = ap_save[chapter]
    for index, value in ipairs(array) do
        savegame[chapter][index] = value
    end
end


function clear_journal(array)
    for i, _ in ipairs(array) do
        array[i] = false
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
    if not file then return end
    local contents = file:read("a")
    file:close()
    local ok, data = pcall(json.decode, contents)
    if not ok then
        debug_print("read_save: JSON decode failed: " .. tostring(data))
        return
    end
    -- Keep numeric keys *in memory* for code that expects them
    local function restore_number_keys(tbl)
        if type(tbl) ~= "table" then return tbl end
        local out = {}
        for k, v in pairs(tbl) do
            local nk = tonumber(k) or k
            out[nk] = restore_number_keys(v)
        end
        return out
    end
    ap_save = restore_number_keys(data)
    ap_save.item_unlocks = ap_save.item_unlocks or {}
    ap_save.permanent_item_upgrades = ap_save.permanent_item_upgrades or {}
    ap_save.waddler_item_unlocks = ap_save.waddler_item_unlocks or {}
    update_game_save()
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
        local loginData = loginFile:read("*all")
        loginFile:close()
        if loginData and loginData ~= "" then
            local success, loginData = pcall(json.decode,loginData)
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
