---@class APNetworkState
local APNetworkState = {}

---@class APLocation
---@field player string Stored receiving player's name
---@field item string Received item
---@field type integer APFlags for the item, a bit-number.

APNetworkState.__index = APNetworkState

local networkState =
{
    Live = 0,
    Disconnecting = 1,
    Disconnected = 2
}

local starters = {
    [Spel2AP.locations.people.Ana_Spelunky] = ENT_TYPE.CHAR_ANA_SPELUNKY,
    [Spel2AP.locations.people.Margaret_Tunnel] = ENT_TYPE.CHAR_MARGARET_TUNNEL,
    [Spel2AP.locations.people.Colin_Northward] = ENT_TYPE.CHAR_COLIN_NORTHWARD,
    [Spel2AP.locations.people.Roffy_D_Sloth] = ENT_TYPE.CHAR_ROFFY_D_SLOTH
}

local unsentStarters = {}

--- C#-like "private" variables. In a table so local functions don't shadow over them.
local private = {
---@type Core
    core = nil,
---@type APClient # Active client session, if any.
    apClient = nil,
---@type int[] # LuaAP client ID
    clientVersion = {0, 5, 1},
---@type integer # connected slot's Multiworld seed
    seed = -1,
---@type integer # connected slot's Multiworld slot number
    slotID = -1,
---@type integer # connected slot's Multiworld team number
    teamID = -1,
---@type integer # Item handling flag value ("Full Remote")
    itemHandleID = 7,
---@type string # multiworld game identifier
    gameID = "Spelunky 2",
---@type ConnectState # internal flag for disconnecting state
    connectState = networkState.Live,
---@type string # Disconnection reason, if any.
    disconnectReason = nil,
---@type table # Slot IDs and associated player names
    players = {},
---@type table<APLocation> # item and player names of all items for our slots
    locationInfo = {},
}

---@param deathlink boolean
---@return string[] Associated tags to connected client
local function GetAPTags(deathlink)
    if deathlink then
        return {"Lua-APClientPP","NoText", "DeathLink"}
    end
    return {"Lua-APClientPP","NoText"}
end

local function PollClient()
    if private.apClient == nil then
        return
    end
    if private.connectState == networkState.Disconnecting then
        private.apClient = nil
        collectgarbage("collect")
        private.core.apMenu:OnDisconnected()
        if IsNotNull(private.disconnectReason) then
            print(private.disconnectReason)
            private.disconnectReason = nil
        end
        print("Disconnected from APServer")
        private.connectState = networkState.Disconnected
    end
    local ok, pollError = pcall(function()
        if IsNotNull(private.apClient) then
            private.apClient:poll()
        end
    end)
    if not ok then
        DebugPrint(debugLevel.NETWORK, f"[ERROR] during client polling -- {pollError}")
    end
end

local function SetStatus(status)
    private.apClient:StatusUpdate(status)
end

---@param server int[]
---@return boolean
function APNetworkState:IsClientOutdated(server)
    local client = private.core.supportedVersion
    if IsNotNull(server[1]) and client[1] ~= server[1]  then
        return client[1] < server[1]
    elseif IsNotNull(server[2]) and client[2] ~= server[2] then
        return client[2] < server[2]
    end
    return IsNotNull(server[3]) and client[3] < server[3]
end

---@param slot string Multiworld slot name to connect with
---@param address string Multiworld server address to connect to
---@return boolean True on success
function APNetworkState:TryConnect(slot, address)
    print("Connecting...")
    private.apClient = private.core.apLib(slot, private.gameID, address)
    private.connectState = networkState.Live
    return private.apClient
end

function APNetworkState:OnConnected()
    local players = private.apClient:get_players()
    while #players > 0 do
        ---@type NetworkPlayer
        local player = table.remove(players, 1)
        local game = private.apClient:get_player_game(player.slot)
        private.players[player.slot] = {name = player.name, game = game}
    end
    private.apClient:LocationScouts(private.apClient.missing_locations, false)
    private.apClient.missing_locations = AsLookupTable(private.apClient.missing_locations)
end

---@param items NetworkItem[] List of itemIDs scouted
------@void Handle response from items queried about
function APNetworkState:OnScoutLocation(items)
    while #items > 0 do
        ---@type NetworkItem
        local item = table.remove(items, 1)
        local player, game = private.core.apNetwork:GetPlayer(item.player)
        local itemName = private.core.apNetwork:GetClient():get_item_name(item.item, game)
        private.locationInfo[item.location] = {player = player, item = itemName, type = item.flags > 3 and 4 or item.flags}
    end
end

---@param locations integer[] locationIDs that have been sent
------@void Handle response from server when locations get sent (multi-player on one slot or something)
function APNetworkState:OnLocationChecked(locations)
    private.apClient.missing_locations = AsLookupTable(private.apClient.missing_locations)
    while #locations > 0 do
        local location = table.remove(locations, 1)
        private.locationInfo[location] = nil
        local iteration = math.floor(location / 1000)
        if iteration <= 5 and iteration >= 1 then
            local index = location % 1000
            private.core.apState:UpdateJournal(iteration, index)
        end
    end
end

---@param slotID int
---@return string, string Associated player name or "Unknown"
function APNetworkState:GetPlayer(slotID)
    if slotID == private.slotID then
        return nil, nil
    end
    local player = private.players[slotID]
    if not player or player == nil then
        return "Server", nil
    end
    return player.name, player.game
end

---@return string Our player name
function APNetworkState:GetLocalPlayer()
    return private.players[private.slotID].name
end

---@param locationID int
---@return APLocation
function APNetworkState:GetLocationData(locationID)
    return private.locationInfo[locationID]
end

---@param locationID int
---@return boolean
function APNetworkState:NotSentLocation(locationID)
    return private.apClient.missing_locations[locationID] ~= nil
end

---@return ENT_TYPE ENTID of un-sent damsel check, or nil if none are missing.
function APNetworkState:GetUnsentDamsel()
    if self:NotSentLocation(Spel2AP.locations.bestiary.Monty) then
        return ENT_TYPE.MONS_PET_DOG
    elseif self:NotSentLocation(Spel2AP.locations.bestiary.Percy) then
        return ENT_TYPE.MONS_PET_CAT
    elseif self:NotSentLocation(Spel2AP.locations.bestiary.Poochi) then
        return ENT_TYPE.MONS_PET_HAMSTER
    end
    return nil
end

--- Refresh local table of Unsent "Starter" characters (the ones you begin with, Ana; Colin; Margarat; Roffy)
function APNetworkState:RefreshUnsentStarters()
    unsentStarters = {}
    for starter, ent in pairs(starters) do
        if self:NotSentLocation(starter) then
            table.insert(unsentStarters, ent)
        end
    end
end

---@return ENT_TYPE ENTID of un-sent starter character, or nil if none are missing.
function APNetworkState:GetUnsentStarter()
    return table.remove(unsentStarters, 1)
end

function APNetworkState:OnGuiFrame()
    PollClient()
end

---@param serverVersion int[]
---@return boolean # Checks external world reported version and checks if client is compatible
function APNetworkState:IsSupportedVersion(serverVersion)
    if serverVersion == false then
        private.apClient:Say("Joined and found no version, disconnecting.")
        self:HandleDisconnect(f"Could not detect APWorld's version, likely too old. Not stable for play.")
        return false
    end
    if self:IsClientOutdated(serverVersion) then
        private.apClient:Say("Joined with a too old version, disconnecting.")
        self:HandleDisconnect(f"Client is too old ({table.concat(private.coreModule.supportedVersion, \".\")}), server supports {table.concat(externalVersion, \".\")} or newer")
        return false
    end
    return true
end

---@return boolean # Checks if the server's seed+player slot+team are identical. Best way to check if it's the "same" server. Stores results if false
function APNetworkState:IsSameConnection()
    local remoteSeed = private.apClient:get_seed()
    local remotePID = private.apClient:get_player_number()
    local remoteTID = private.apClient:get_team_number()
    if private.seed == remoteSeed and private.slotID == remotePID and private.teamID == remoteTID then
        return true
    end
    private.seed = remoteSeed
    private.slotID = remotePID
    private.teamID = remoteTID
    return false
end

---@param slot string Multiworld slot name to connect with
---@param password string Multiworld server address to connect to
function APNetworkState:TryConnectSlot(slot, password)
    private.apClient:ConnectSlot(slot, password, private.itemHandleID, GetAPTags(private.core.apDeath:GetDeathlinkState()), private.clientVersion)
end

---@param deathlinkState boolean Should assign or remove Deathlink tag
---@void Update the client's connected multiworld tags
function APNetworkState:UpdateTags(deathlinkState)
    private.apClient:ConnectUpdate(private.itemHandleID, GetAPTags(deathlinkState))
end

---@param reason string
---@void Terminate client connection and perform clean-up
function APNetworkState:HandleDisconnect(reason)
    private.connectState = networkState.Disconnecting
    private.core.apState:SetGameState(false)
    private.disconnectReason = reason
end

---@return boolean # TRUE if we have active apClient instance.
function APNetworkState:HasActiveClient()
    return IsNotNull(private.apClient)
end

---@return APClient # Fetch currently connected client instance
function APNetworkState:GetClient()
    return private.apClient
end

---@return string # WorldID is just seed_teamNum_slotNum
function APNetworkState:GetWorldID()
    return string.format("%s_%d_%d", private.seed, private.teamID, private.slotID)
end

---@void Set client to Goal state
function APNetworkState:SetGoalStatus()
    SetStatus(private.apClient.ClientStatus.GOAL)
end

function APNetworkState:initialize(core)
    local instance = setmetatable({}, APNetworkState)
    private.core = core
    set_callback(function() -- SHOULD be in hooks, has to be here, to clear up fast enough.
        private.apClient = nil
        collectgarbage("collect")
    end, ON.SCRIPT_DISABLE)
    return instance
end

return APNetworkState
