--- @class APHooks

local APHooks = {}

APHooks.__index = APHooks

--- C#-like "private" variables. In a table so local functions don't shadow over them.
local private = {
---@type Core
    core = nil
}

---@param client APClient Current client state
---@param slot string Multiworld slot name to connect with
---@param password string Multiworld password to connect with
function APHooks:SetupHooks(client, slot, password)
    local apState = private.core.apState
    local apNetwork = private.core.apNetwork
    client:set_room_info_handler(function()
        self:OnRoomInfo(slot, password)
    end)
    client:set_slot_connected_handler(function(data)
        self:OnConnected(data)
    end)
    client:set_socket_error_handler(function(error)
        self:OnSocketError(error)
    end)
    client:set_slot_refused_handler(function(errors)
        self:OnSlotRefused(errors)
    end)
    client:set_socket_disconnected_handler(function()
        self:OnDisconnected()
    end)
    client:set_items_received_handler(function(items)
        apState:OnItemFromMultiworld(items)
    end)
    client:set_location_info_handler(function(items)
        apNetwork:OnScoutLocation(items)
    end)
    client:set_location_checked_handler(function(locations)
        apNetwork:OnLocationChecked(locations)
    end)
    client:set_bounced_handler(function(packet)
        if IsNotNull(packet.tags) and string.find(table.concat(packet.tags, ","), "DeathLink", 1, true) then
            private.core.apDeath:HandleDeathlink(packet)
        end
    end)
end

---@param error string Socket failure reason
function APHooks:OnSocketError(error)
    if string.match(error, "TLS handshake failed") and not private.core.apMenu:IsSecureLogin() then
        return
    end
    if string.match(error, "No connection could be made because the target machine actively refused it.") then
        private.core.apNetwork:HandleDisconnect("Connection failure. Incorrect address or port ?")
        return
    end
    if string.match(error, "Timer Expired") then
        private.core.apNetwork:HandleDisconnect("Connection failure. Timed out. Wrong port or no internet?")
        return
    end
    print(f"Socket error:\n{error}")
end

---@param errors string Reason for failure to connect to slot
function APHooks:OnSlotRefused(errors)
    private.core.apNetwork:HandleDisconnect("Refused -- " .. table.concat(errors, ", "))
end

---@param slot string Multiworld slot name to connect with
---@param password string Multiworld password to connect with
---@param address string Multiworld server address to connect to
---@return boolean True on successful attempt
function APHooks:TryConnect(slot, password, address)
    local client = private.core.apNetwork:TryConnect(slot, address)
    self:SetupHooks(client, slot, password)
end

---@param slot string Multiworld slot name to connect with
---@param password string Multiworld password to connect with
function APHooks:OnRoomInfo(slot, password)
    private.core.apNetwork:TryConnectSlot(slot, password)
end



---@param slotData Spel2SlotData
---@return void
function APHooks:OnConnected(slotData)
    private.core.apMenu:OnConnected()
    private.core.apNetwork:OnConnected()
    if not private.core.apNetwork:IsSupportedVersion(slotData.APWorldVersion or false) then
        return
    end
    if private.core.apNetwork:IsSameConnection() then
        private.core.apState:SetGameState(true)
        print("Connection re-established")
        return
    end
    print("Connected")
    private.core.apState:InitializeMultiworld(slotData)
end

function APHooks:OnDisconnected()
    private.core.apNetwork:HandleDisconnect()
end

---@param core Core
---@return APHooks
function APHooks:initialize(core)
    local instance = setmetatable({}, APHooks)
    private.core = core
    return instance
end

return APHooks
