--- @class APMenu

local APMenu = {}

APMenu.__index = APMenu
local private = {
---@type Core
    core = nil,
---@type boolean #Save connection password to file
    savePassword = false,
--- @type boolean #Show archipelago credentials menu (title screen only)
    showLoginData = false,
--- @type boolean #Show Connect button if true -- Disconnect if false
    showConnect = true,
--- @type boolean #If "Delete" credentials button should display
    showDelete = false,
--- @type boolean #Only allow WSS:// connection
    secureOnly = false,
--- @type string #archipelago slot to connect to
    slotName = "",
--- @type string #server address to connect to
    serverIP = "archipelago.gg",
--- @type string #server port to address to
    serverPort = "38281",
--- @type string #password to connect to multiworld
    serverPassword = "",
}

---@param mode mode string: "r"|"w"|"a"|"r+"|"w+"|"a+"|"rb"|"wb"|"ab"|"rb+"|"wb+"|"ab+"
---@return file Locally stored credentials file
local function GetLoginFile(mode)
    return io.open_data("login.json", mode)
end

---@void Write private.slotName, password, port and ip to local file
local function WriteLastLogin()
    local data = lunaJson.encode
    ({
        slot = private.slotName,
        password = private.savePassword and private.serverPassword or "",
        port = private.serverPort,
        ip = private.serverIP
    })
    local loginFile = GetLoginFile("w+")
    loginFile:write(data)
    loginFile:close()
end

---@return boolean True if successful login file read, any valid data written to local variables
local function ReadLastLogin()
    local loginFile = GetLoginFile("r")
    if loginFile == nil then
        return false
    end
    local data = loginFile:read("*all")
    loginFile:close()
    if not data or data == "" then
        return false
    end
    local success, loginData = pcall(lunaJson.decode, data)
    if success ~= true
            or not loginData
            or loginData == ""
            or type(loginData) ~= "table"
            or next(loginData) == nil then
        return false
    end
    private.slotName = loginData.slot
    private.serverIP = loginData.ip
    private.serverPort = loginData.port
    private.serverPassword = loginData.password
    private.savePassword = (IsNotNull(loginData.password) and loginData.password ~= "")
    return true
end

---@void Restore non-specific default values, more importantly -- clear password and slot fields
local function SetLoginDefaults()
    private.serverIP = "archipelago.gg"
    private.serverPort = "38281"
    private.slotName = ""
    private.serverPassword = ""
    WriteLastLogin()
end

---@return string Server + Port
local function GetServerAddress()
    if private.secureOnly then
        return "wss://" .. private.serverIP .. ":" .. private.serverPort
    end
    return private.serverIP .. ":" .. private.serverPort
end

---@param ctx GuiDrawContext
local function HandleLoginSettings(ctx)
    if private.showLoginData ~= true then
        return
    end
    ctx:win_text("Slot")
    ctx:win_width(0.30)
    private.slotName = ctx:win_input_text(" ##Slot Name", private.slotName)

    ctx:win_text("Server")
    ctx:win_width(0.30)
    private.serverIP = ctx:win_input_text(" ##Host", private.serverIP)
    ctx:win_inline()
    ctx:win_text("Port")
    ctx:win_inline()
    ctx:win_width(0.15)
    private.serverPort = ctx:win_input_text(" ##Port", private.serverPort)

    ctx:win_text("Password")
    ctx:win_width(0.30)
    private.serverPassword = ctx:win_input_text(" ##Password", private.serverPassword)

    private.savePassword = ctx:win_check("Remember Password", private.savePassword)
end

---@param ctx GuiDrawContext
local function HandleConnectionButton(ctx)
    if private.showConnect then
        if ctx:win_button("Connect") then
            private.core.apHooks:TryConnect(private.slotName, private.serverPassword, GetServerAddress())
        end
    else
        if ctx:win_button("Disconnect") then
            private.core.apNetwork:HandleDisconnect()
        end
    end
end

---@param ctx GuiDrawContext
local function HandleDeleteButton(ctx)
    if private.showDelete ~= true then
        return
    end
    if ctx:win_button("Delete login details") then
        SetLoginDefaults()
        private.showDelete = false
        private.showLoginData = true
    end
end

---@void Menu state clean-up
function APMenu:OnConnected()
    WriteLastLogin()
    private.showDelete = true
    private.showLoginData = false
    private.showConnect = false
end

---@void Menu state clean-up
function APMenu:OnDisconnected()
    private.showConnect = true
end

---@return boolean True -> Should only attempt secure (WSS://) logins
function APMenu:IsSecureLogin()
    return private.secureOnly
end

---@param ctx GuiDrawContext
---@void Hook up and handle in-game mod UI buttons/etc
function APMenu:MenuOptions(ctx)
    private.showLoginData = ctx:win_check("Show login details", private.showLoginData)
    HandleDeleteButton(ctx)
    HandleLoginSettings(ctx)
    private.secureOnly = ctx:win_check("Secure connect only", private.secureOnly)
    HandleConnectionButton(ctx)
end

---@param core Core
function APMenu:initialize(core)
    local instance = setmetatable({}, APMenu)
    private.core = core
    if ReadLastLogin(instance) then
        private.showDelete = true
    else
        SetLoginDefaults()
    end
    return instance
end

return APMenu
