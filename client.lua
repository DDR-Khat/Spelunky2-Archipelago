safe_require("lib/popup")

local aplib = safe_loadlib("lua-apclientpp.dll", "luaopen_apclientpp")
local AP = aplib and aplib() or nil

if not AP then
    print("Failed to load Archipelago Client!\nIs **lua-apclientpp.dll** in the mod's folder??")
    return
end

---@type APClient
local ap = nil

-- Various variables to run the client
local item_queue = {}
local send_item_queue = {}
local ready_for_item = true
local caused_by_death_link = false
local goal_completed = false
local id
ourSlot = nil
ourTeam = nil
apSlots = {}
apGames = {}
local packWorlds = {
    [1] = "Dwellings",
    [2] = "Jungle",
    [3] = "Volcana",
    [4] = "Olmec",
    [5] = "Tide Pool",
    [6] = "Temple",
    [7] = "Ice Caves",
    [8] = "Neo Babylon",
    [9] = "Sunken City",
    [12] = "Duat",
    [13] = "Abzu",
    [15] = "Eggplant World"
}

game_info = {
    game = "Spelunky 2",
    username = "",
    host = "archipelago.gg:38281",
    password = "",
    items_handling = 7, -- full remote
    message_format = AP.RenderFormat.TEXT,
    ap_client_version = {0, 5, 1}
}

secure_connect_only = false
save_password = false
local show_login_data = false
local show_connect_button = true
local show_delete_button = false

player_options = {
    seed = "BACKUP",
    goal = 0,
    goal_level = 30,
    increase_wallet = false,
    progressive_worlds = true,
    starting_characters = {"Ana Spelunky", "Margaret Tunnel", "Colin Northward", "Roffy D. Sloth"},
    starting_health = 4,
    starting_bombs = 4,
    starting_ropes = 4,
    death_link = false,
    bypass_ankh = false,
    include_hard_locations = false,
}

if read_last_login() then
    show_delete_button = true
else
    show_login_data = true
end

if game_info.password ~= "" then
    save_password = true
end
set_callback(function()
    if state.screen == SCREEN.MENU then
        register_option_callback("Spelunky 2 Archipelago", player_options, function(ctx)
            if show_delete_button then
                if ctx:win_button("Delete login details") then
                    write_last_login("wipe")
                    game_info.username = ""
                    game_info.host = "archipelago.gg:38281"
                    game_info.password = ""
                    show_delete_button = false
                    show_login_data = true
                end
            end
            show_login_data = ctx:win_check("Show login details",show_login_data)
            secure_connect_only = ctx:win_check("Secure connection only", secure_connect_only)

            if show_login_data then
                ctx:win_text("Slot Name")
                game_info.username = ctx:win_input_text(" ##Slot Name", game_info.username)

                ctx:win_text("Server Address")
                game_info.host = ctx:win_input_text(" ##Host", game_info.host)

                ctx:win_text("Password")
                game_info.password = ctx:win_input_text(" ##Password", game_info.password)

                save_password = ctx:win_check("Remember Password", save_password)
            end
            ctx:win_separator()

            if show_connect_button then
                if ctx:win_button("Connect") then
                    prinspect("Connecting to the server...")
                    id = set_callback(function()
                        return true
                    end, ON.PRE_PROCESS_INPUT)
                    connect(game_info.host, game_info.username, game_info.password)
                end
            else
                if ctx:win_button("Disconnect") then
                    show_connect_button = true
                    prinspect("Disconnecting from the server...")
                    ap = nil
                    collectgarbage("collect")
                end
            end
        end)
    end

    if ap ~= nil then
        local ok, err = pcall(function()
            ap:poll()
        end)
        if not ok and debugging then
            print("[ERROR] during ap:poll -- " .. tostring(err))
        end
    end
end, ON.GUIFRAME)

function connect(server, slot, password)
    function on_socket_connected()
        print(f"Socket connected")
    end

    function on_socket_error(msg)
        if string.match(msg, "TLS handshake failed") and secure_connect_only ~= true then
            return
        elseif string.match(msg, "Invalid HTTP status") then
            print("Fatal connection failure. Please reboot Spelunky 2")
            clear_callback(id)
            return
        else
            print("Socket error: " .. msg)
        end
        show_connect_button = true
        clear_callback(id)
    end

    function on_socket_disconnected()
        print("Disconnected from the server.")
        show_connect_button = true
        ourSlot = nil
        ourTeam = nil
        apSlots = {}
        apGames = {}
    end

    function on_room_info()
        ap:ConnectSlot(slot, password, game_info.items_handling, {"Lua-APClientPP","NoText"}, game_info.ap_client_version)
    end

    function on_slot_connected(slot_data)
        print(f"Slot connected")

        show_connect_button = false
        clear_callback(id)

        ourSlot = ap:get_player_number()
        ourTeam = ap:get_team_number()
        apSlots = ap:get_players()
        for _, entry in ipairs(apSlots) do
            table.insert(apGames, ap:get_player_game(entry.slot))
        end
        player_options.seed = ap:get_seed()
        player_options.goal = slot_data.goal
        player_options.goal_level = slot_data.goal_level
        -- player_options.starting_characters = slot_data.starting_characters
        player_options.increase_wallet = slot_data.increase_starting_wallet
        player_options.progressive_worlds = slot_data.progressive_worlds
        player_options.starting_health = slot_data.starting_health
        player_options.starting_bombs = slot_data.starting_bombs
        player_options.starting_ropes = slot_data.starting_ropes
        player_options.death_link = slot_data.death_link
        player_options.include_hard_locations = slot_data.include_hard_locations
        ap:Set(f"{ourSlot}_{ourTeam}_worldTab", "Entire map", false, { { operation = "add", value = "Entire map" } }, nil)

        if player_options.death_link then
            ap:ConnectUpdate(nil, {"Lua-APClientPP", "NoText", "DeathLink"})

            player_options.bypass_ankh = slot_data.bypass_ankh

            set_callback(function()
                if not caused_by_death_link then
                    local data = {
                        time = ap:get_server_time(),
                        source = game_info.username
                    }
                    ap:Bounce(data, nil, nil, {"DeathLink"})
                end
            end, ON.DEATH)
        end
        write_last_login()
        show_delete_button = true
        show_login_data = false
        set_ap_callbacks()
        initialize_save()
        local restricted_lookup = {}
        for _, name in pairs(slot_data.restricted_items or {}) do
            restricted_lookup[name] = true
        end

        for code, entry in pairs(item_ids) do
            if entry.type == Spel2AP.locked_items then
                if restricted_lookup[entry.lock_name] then
                    ap_save.item_unlocks[code] = false
                else
                    ap_save.item_unlocks[code] = true
                end
            end
        end
        read_save()
        savegame.players[1] = ap_save.last_character
    end

    function on_slot_refused(reasons)
        print("Slot refused: " .. table.concat(reasons, ", "))
        clear_callback(id)
    end

    function on_items_received(items)
        local sender = "another world"
        for _, data in ipairs(items) do
            if data.index > ap_save.last_index then
                if data.player ~= ourSlot then
                    local players = ap:get_players()
                    for _, player in ipairs(players) do
                        if player.slot == data.player then
                            sender = player.name
                            break
                        end
                    end
                else
                    sender = "you"
                end
                item_handler(data.item, false)
                table.insert(item_queue, #item_queue + 1, {item = data.item,player = sender})
            end
        end
    end

    function on_location_info(items)
        local success, err = pcall(function()
            debug_print("Locations scouted:")
            for _, data in ipairs(items or {}) do
                local receiving = data.player or -1
                if (receiving ~= ourSlot) then
                    local item_id = data.item or -1

                    local player_data = apSlots[receiving]
                    local player_name = player_data and player_data.name or "Unknown Player"
                    local game_name = apGames[receiving] or "Unknown Game"
                    local flags = -1

                    if data.flags ~= nil then
                        if data.flags == 0 or data.flags == 2 then
                            flags = 0
                        elseif data.flags == 4 then
                            flags = 1
                        elseif data.flags == 1 then
                            flags = 2
                        end
                    end

                    -- Get item and location names using the known game
                    local item_name = "Unknown Item"
                    local ok_item, result_item = pcall(function()
                        return ap:get_item_name(item_id, game_name)
                    end)
                    if ok_item and result_item then
                        item_name = result_item
                    end

                    table.insert(send_item_queue, #send_item_queue + 1, {item = item_name, target = player_name, classification = flags})

                    debug_print(string.format(
                            "Item: %s (ID: %d), Owner: %s (Slot: %d), Game: %s, Flags: %s",
                            item_name, item_id,
                            player_name, receiving,
                            game_name, flags
                    ))
                end
            end
        end)

        if not success then
            debug_print("[ERROR] on_location_info crashed: " .. tostring(err))
        end
    end

    function on_location_checked(locations)
        debug_print("Locations checked:" .. table.concat(locations, ", "))
        debug_print("Checked locations: " .. table.concat(ap.checked_locations, ", "))
    end

    function on_data_package_changed(data_package)
        debug_print("Data package changed:")
        debug_print(data_package)
    end

    function on_print(msg)
        debug_print(msg)
    end

    function on_print_json(msg, extra)
        if (extra.type == "ItemSend") and extra.receiving ~= ourSlot then
            if extra.item and type(extra.item) == "table" and extra.item.player == ourSlot then
                local receiver = apSlots[extra.receiving].name
                local sendItem = ap:get_item_name(extra.item.item, apGames[extra.receiving])
                table.insert(send_item_queue, #send_item_queue + 1, {item = sendItem, target = receiver})
            end
        end
    end

    function on_bounced(bounce)
        if bounce.tags ~= nil then
            for _, tag in ipairs(bounce.tags) do
                if tag == "DeathLink" and bounce.data.source ~= game_info.username then
                    queue_death_link()
                end
            end
        end
    end

    function on_retrieved(map, keys, extra)
        debug_print("Retrieved:")
        for _, key in ipairs(keys) do
            debug_print("  " .. key .. ": " .. tostring(map[key]))
        end
        debug_print("Extra:")
        for key, value in pairs(extra) do
            debug_print("  " .. key .. ": " .. tostring(value))
        end
    end

    function on_set_reply(message)
        debug_print("Set Reply:")
        for key, value in pairs(message) do
            debug_print("  " .. key .. ": " .. tostring(value))
            if key == "value" and type(value) == "table" then
                for subkey, subvalue in pairs(value) do
                    debug_print("    " .. subkey .. ": " .. tostring(subvalue))
                end
            end
        end
    end

    if secure_connect_only then
        ap = AP(slot, game_info.game, "wss://"..server);
    else
        ap = AP(slot, game_info.game, server);
    end

    --ap:set_socket_connected_handler(on_socket_connected)
    ap:set_socket_error_handler(on_socket_error)
    ap:set_socket_disconnected_handler(on_socket_disconnected)
    ap:set_room_info_handler(on_room_info)
    ap:set_slot_connected_handler(on_slot_connected)
    ap:set_slot_refused_handler(on_slot_refused)
    ap:set_items_received_handler(on_items_received)
    ap:set_location_info_handler(on_location_info)
    --ap:set_location_checked_handler(on_location_checked)
    --ap:set_data_package_changed_handler(on_data_package_changed)
    --ap:set_print_handler(on_print)
    --ap:set_print_json_handler(on_print_json)
    ap:set_bounced_handler(on_bounced)
    --ap:set_retrieved_handler(on_retrieved)
    ap:set_set_reply_handler(on_set_reply)
end

function set_ap_callbacks()
    set_callback(function()
        local popupFrames = math.ceil(options.popup_time*60)
        local currentPlayer = get_player(1)
        local playerState = currentPlayer.state
        local isInDoor = playerState == CHAR_STATE.ENTERING or playerState == CHAR_STATE.EXITING
        local inPipe = false
        if currentPlayer.overlay then
            inPipe = currentPlayer.overlay.type.id == ENT_TYPE.FLOOR_PIPE
        end
        if isInDoor or inPipe then
            goto continue
        end
        if state.screen ~= SCREEN.LEVEL or not ready_for_item then
            goto continue
        end
        local item
        local display = generalItem
        local msgTitle
        local msgDesc
        if IsType(item_queue,"table") and #item_queue > 0 then
            local player = item_queue[1].player
            item = item_ids[item_queue[1].item]
            if item == nil or item.display == nil then
                debug_print(f"{item_queue[1].item} does not have a display?!")
                return
            end
            display = item.display
            item_handler(item_queue[1].item, true)
            msgTitle = (player == "you" and "You found an item!") or f"Item received from {player}"
            msgDesc = (player == "you" and f"{item.name}") or f"Received {item.name}"
            table.remove(item_queue, 1)
            ap_save.last_index = ap_save.last_index + 1
            write_save()
        elseif IsType(send_item_queue, "table") and #send_item_queue >0 then
            item = (type(send_item_queue[1].item) == "string" and send_item_queue[1].item) or "<Error>"
            if #item > 31 then
                item = item:sub(1, 29) .. "..."
            end
            local target = send_item_queue[1].target or "<Unknown>"
            local classification = send_item_queue[1].classification
            if classification == 1 then
                display = trapItem
            elseif classification == 2 then
                display = progressionItem
            end
            msgTitle = f"Found {target}'s Item from another world!"
            if #msgTitle > 39 then
                msgTitle = f"Found {target}'s Item!"
                if #msgTitle > 39 then
                    local truncated_target = target:sub(1, 22)
                    msgTitle = f"Found {truncated_target}...'s Item!"
                end
            end
            msgDesc = f"Sent \"{item}\""
            table.remove(send_item_queue, 1)
        else
            return
        end

        ready_for_item = false
        set_interval(function()
            ready_for_item = true
            return false
        end, popupFrames)

        ShowFeatBox(display, msgTitle, msgDesc, popupFrames, item.TileX, item.TileY)
        ::continue::
    end, ON.GAMEFRAME)

    set_callback(function()
        ready_for_item = true
        if ourSlot ~= nil then
            local worldTab = packWorlds[state.theme] or "Entire map"
            ap:Set(f"{ourSlot}_{ourTeam}_worldTab", "Entire map", false, { { operation = "replace", value = worldTab } }, nil)
        end
    end, ON.POST_LEVEL_GENERATION)

    set_callback(function()
        caused_by_death_link = false
        state.toast_timer = 0
        state.speechbubble_timer = 0
    end, ON.RESET)

    set_callback(function()
        if player_options.goal == AP_Goal.CO and state.world == 8 and state.level == player_options.goal_level - 1 then
            state.win_state = 3
            state.level_next = 99
        end
    end, ON.LEVEL)

    set_callback(function()
        if (player_options.goal == AP_Goal.EASY and state.win_state == 1) or (player_options.goal == AP_Goal.HARD and state.win_state == 2) then
            complete_goal()
        end
    end, ON.WIN)

    set_callback(function()
        if player_options.goal == AP_Goal.CO and state.win_state == 3 then
            complete_goal()
        end
    end, ON.CONSTELLATION)
end


function complete_goal()
    ap:StatusUpdate(ap.ClientStatus.GOAL)
    toast("You have completed your goal!")

    while #item_queue > 0 do
        local item = item_ids[item_queue[1]]
        item_handler(item.type, false)

        table.remove(item_queue, 1)
        ap_save.last_index = ap_save.last_index + 1

        write_save()
    end
end

function item_handler(itemID, isQueued)
    local item_info = item_ids[itemID]
    if not item_info then
        return false
    elseif goal_completed then
        return true
    end
    local category = item_info.type
    if category == Spel2AP.filler_items and isQueued then
        give_item(itemID)
        return true
    elseif category == Spel2AP.characters and isQueued then
        ap_save.character_unlocks[itemID] = true
        update_characters()
        write_save()
        return true
    elseif category == Spel2AP.locked_items and not isQueued then
        ap_save.item_unlocks[itemID] = true
        write_save()
        return true
    elseif category == Spel2AP.upgrades and not isQueued then
        if itemID == Spel2AP.upgrades.Compass then
            ap_save.permanent_item_upgrades[itemID] = (ap_save.permanent_item_upgrades[itemID] or 0) + 1
        else
            ap_save.permanent_item_upgrades[itemID] = true
        end
        write_save()
        return true
    elseif category == Spel2AP.waddler_upgrades and not isQueued then
        ap_save.waddler_item_unlocks[itemID] = true
        write_save()
        return true
    elseif category == Spel2AP.permanent_upgrades and not isQueued then
        ap_save.stat_upgrades[itemID] = (ap_save.stat_upgrades[itemID] or 0) + 1
        write_save()
        return true
    elseif category == Spel2AP.world_unlocks and not isQueued then
        if player_options.progressive_worlds then
            if itemID == Spel2AP.world_unlocks.Progressive_World then
                ap_save.max_world = ap_save.max_world + 1
            end
        else
            ap_save.world_unlocks[itemID] = true
        end
        write_save()
        return true
    elseif category == Spel2AP.shortcuts and not isQueued then
        ap_save.shortcut_unlocks[itemID] = true
        write_save()
        return true
    elseif category == Spel2AP.traps and isQueued then
        give_trap(itemID)
        return true
    else
        return false
    end
end

function queue_death_link()
    set_global_interval(function()
        if state.screen == SCREEN.LEVEL then
            local player = get_player(1, false)

            if player_options.bypass_ankh and player:has_powerup(ENT_TYPE.ITEM_POWERUP_ANKH) then
                player:remove_powerup(ENT_TYPE.ITEM_POWERUP_ANKH)
            end

            player:kill(false, nil)

            caused_by_death_link = true

            clear_callback()
        end
    end, 1)
end

function send_location(location_id)
    if givingItem then
        return
    end

    local success_checked, checked = pcall(function()
        return ap:LocationChecks({location_id})
    end)

    if not success_checked then
        debug_print("ERROR: LocationChecks call failed (Lua error caught): " .. tostring(checked))
        return
    end

    if checked then
        debug_print("We checked a location! Now scouting it for details...")
        local success_scout, scout_err = pcall(function()
            ap:LocationScouts({location_id}, 0)
        end)
        if not success_scout then
            debug_print("ERROR: LocationScouts (delayed) call failed: " .. tostring(scout_err))
        end
    end

    write_save()
end

function verify_locations(location_list)
    for index, location_id in ipairs(ap_save.checked_locations) do
        if location_list[index] ~= location_id then
            send_location(location_id)
        end
    end
end