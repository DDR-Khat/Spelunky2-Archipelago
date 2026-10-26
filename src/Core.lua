---@class Core
---@field apLib APClient
---@field apHooks APHooks
---@field apState APGameState
---@field apNetwork APNetworkState
---@field apMenu APMenu
---@field apDeath APDeathlink
---@field apItems APItem
---@field apUI APUI
---@field lunkyShops SpelunkyShop
---@field apCore APCore

---@type Core
local Core = {}
Core.__index = Core
Core.supportedVersion = {0,5,0} -- {Major, Minor, Rev}

function Core:initialize()
    local instance = setmetatable({}, Core)

    local clientSrc = package.loadlib("lib/lua-apclientpp.dll", "luaopen_apclientpp")
    instance.apLib = clientSrc and clientSrc() or nil

    if not instance.apLib then
        print("Failed to load Archipelago Client!\nincorrect or missing **lua-apclientpp.dll** inside 'lib' folder")
        return nil
    end

    instance.apItems = require "src.ap.Items"

    local apUISrc = require "src.ap.UI"
    instance.apUI = apUISrc:initialize(instance)

    local apNetworkSrc = require "src.ap.NetworkState"
    instance.apNetwork = apNetworkSrc:initialize(instance)

    local apStateSrc = require "src.ap.GameState"
    instance.apState = apStateSrc:initialize(instance)

    local apMenuSrc = require "src.ap.Menu"
    instance.apMenu = apMenuSrc:initialize(instance)

    local apHooksSrc = require "src.ap.Hooks"
    instance.apHooks = apHooksSrc:initialize(instance)

    local apDeathSrc = require "src.ap.Deathlink"
    instance.apDeath = apDeathSrc:initialize(instance)

    local hooks = require "src.Hooks"
    hooks.Initialize(instance)

    instance.lunkyShops = require "src.Shops"

    return instance
end

return Core