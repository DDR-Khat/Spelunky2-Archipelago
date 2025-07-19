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
local id = nil
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

save_password = false
local show_login_data = false
local show_connect_button = true
local show_delete_button = false

player_options = {
    seed = "BACKUP",
    goal = 0,
    goal_level = 30,
    progressive_worlds = true,
    starting_characters = {"Ana Spelunky", "Margaret Tunnel", "Colin Northward", "Roffy D. Sloth"},
    starting_health = 4,
    starting_bombs = 4,
    starting_ropes = 4,
    death_link = false,
    bypass_ankh = false
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

            if show_login_data then
                ctx:win_text("Slot Name")
                game_info.username = ctx:win_input_text(" ##Slot Name", game_info.username)

                ctx:win_text("Server Address")
                game_info.host = ctx:win_input_text(" ##Host", game_info.host)

                ctx:win_text("Password")
                game_info.password = ctx:win_input_text(" ##Password", game_info.password)
                
                save_password = ctx:win_check("Remember Password",save_password)
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
        ap:poll()
    end
end, ON.GUIFRAME)


function connect(server, slot, password)
    function on_socket_connected()
        print("Socket connected")
    end

    function on_socket_error(msg)
        print("Socket error: " .. msg)
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
        print("Slot connected")

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
        player_options.progressive_worlds = slot_data.progressive_worlds
        player_options.starting_health = slot_data.starting_health
        player_options.starting_bombs = slot_data.starting_bombs
        player_options.starting_ropes = slot_data.starting_ropes
        player_options.death_link = slot_data.death_link
        ap:Set(f"{ourSlot}_{ourTeam}_worldTab", "Entire map", false, { { operation = "add", value = "Entire map" } }, nil)
        
        if player_options.death_link then
            ap:ConnectUpdate(nil, {"Lua-APClientPP", "DeathLink"})

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
        read_save()
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
                table.insert(item_queue, #item_queue + 1, {item = data.item,player = sender})
            end
        end
    end

    function on_location_info(items)
        print("Locations scouted:")
        for _, item in ipairs(items) do
            print(item.item)
        end
    end

    function on_location_checked(locations)
        print("Locations checked:" .. table.concat(locations, ", "))
        print("Checked locations: " .. table.concat(ap.checked_locations, ", "))
    end

    function on_data_package_changed(data_package)
        print("Data package changed:")
        print(data_package)
    end

    function on_print(msg)
        print(msg)
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
        print("Retrieved:")
        -- since lua tables won't contain nil values, we can use keys array
        for _, key in ipairs(keys) do
            print("  " .. key .. ": " .. tostring(map[key]))
        end
        -- extra will include extra fields from Get
        print("Extra:")
        for key, value in pairs(extra) do
            print("  " .. key .. ": " .. tostring(value))
        end
        -- both keys and extra are optional
    end

    function on_set_reply(message)
        print("Set Reply:")
        for key, value in pairs(message) do
            print("  " .. key .. ": " .. tostring(value))
            if key == "value" and type(value) == "table" then
                for subkey, subvalue in pairs(value) do
                    print("    " .. subkey .. ": " .. tostring(subvalue))
                end
            end
        end
    end

    ap = AP(slot, game_info.game, server);

    --ap:set_socket_connected_handler(on_socket_connected)
    ap:set_socket_error_handler(on_socket_error)
    ap:set_socket_disconnected_handler(on_socket_disconnected)
    ap:set_room_info_handler(on_room_info)
    ap:set_slot_connected_handler(on_slot_connected)
    ap:set_slot_refused_handler(on_slot_refused)
    ap:set_items_received_handler(on_items_received)
    ap:set_location_info_handler(on_location_info)
    --ap:set_location_checked_handler(on_location_checked)
    ap:set_data_package_changed_handler(on_data_package_changed)
    --ap:set_print_handler(on_print)
    ap:set_print_json_handler(on_print_json)
    ap:set_bounced_handler(on_bounced)
    ap:set_retrieved_handler(on_retrieved)
    ap:set_set_reply_handler(on_set_reply)
end


function set_ap_callbacks()
    set_callback(function()
        local popupFrames = math.ceil(options.popup_time*60)
        if state.screen == SCREEN.LEVEL and ready_for_item then
            local item
            local display
            local msgTitle
            local msgDesc
            if IsType(item_queue,"table") and #item_queue > 0 then
                local player = item_queue[1].player
                item = item_ids[item_queue[1].item]
                display = item.display or (type(item.type) == "number" and item.type) or ENT_TYPE.ITEM_CHEST
                item_handler(item.type)
                msgTitle = (player == "you" and "You found an item!") or f"Item received from {player}"
                msgDesc = (player == "you" and f"{item.name}") or f"Received {item.name}"
                table.remove(item_queue, 1)
                ap_save.last_index = ap_save.last_index + 1
                write_save()
            elseif IsType(send_item_queue, "table") and #send_item_queue >0 then
                item = (type(send_item_queue[1].item) == "string" and send_item_queue[1].item) or "<Error>"
                if #item > 34 then
                    item = item:sub(1, 32) .. "..."
                end
                display = ENT_TYPE.ITEM_PRESENT
                local target = send_item_queue[1].target or "<Unknown>"
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

            ShowFeatBox(display, msgTitle, msgDesc, popupFrames)
        end
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
        if player_options.goal == 2 and state.world == 8 and state.level == player_options.goal_level - 1 then
            state.win_state = 3
            state.level_next = 99
        end
    end, ON.LEVEL)

    set_callback(function()
        if (player_options.goal == 0 and state.win_state == 1) or (player_options.goal == 1 and state.win_state == 2) then
            complete_goal()
        end
    end, ON.WIN)

    set_callback(function()
        if player_options.goal == 2 and state.win_state == 3 then
            complete_goal()
        end
    end, ON.CONSTELLATION)
end


function verify_locations(location_list)
    for index, location_id in ipairs(ap_save.checked_locations) do
        if location_list[index] ~= location_id then
            send_location(location_id)
        end
    end
end


function send_location(location_id)
    ap:LocationChecks({location_id})
    write_save()
end


function item_handler(type)
    local was_item_processed = false
    
    if not goal_completed then
        for _, item_type in ipairs(item_categories.filler_items) do
            if type == item_type then
                give_item(type)
                was_item_processed = true
            end
        end


        for _, trap in ipairs(item_categories.traps) do
            if type == trap then
                give_trap(type)
                was_item_processed = true
            end
        end
    end

    for index, character_type in ipairs(character_data.types) do
        if type == character_type and not ap_save.unlocked_characters[index] then
            ap_save.unlocked_characters[index] = true
            was_item_processed = true
        end
    end

    for index, key_item_type in ipairs(item_categories.key_items) do
        if type == key_item_type then
            ap_save.unlocked_key_items[index] = true
            was_item_processed = true
        end
    end

    for _, upgrade in ipairs(item_categories.permanent_upgrades) do
        if type == upgrade then
            ap_save.permanent_upgrades[upgrade] = ap_save.permanent_upgrades[upgrade] + 1
            was_item_processed = true
        end
    end

    if type == "max_world" then
        ap_save.max_world = ap_save.max_world + 1
        was_item_processed = true
    end

    for _, world in ipairs(item_categories.worlds) do
        if type == world then
            ap_save.unlocked_worlds[world] = true
            was_item_processed = true
        end
    end

    for _, shortcut in ipairs(item_categories.shortcuts) do
        if type == shortcut then
            ap_save.unlocked_shortcuts[shortcut] = ap_save.unlocked_shortcuts[shortcut] + 1
            was_item_processed = true
        end
    end

    return was_item_processed
end


function complete_goal()
    ap:StatusUpdate(ap.ClientStatus.GOAL)
    toast("You have completed your goal!")

    while #item_queue > 0 do
        local item = item_ids[item_queue[1]]
        item_handler(item.type)

        table.remove(item_queue, 1)
        ap_save.last_index = ap_save.last_index + 1

        write_save()
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