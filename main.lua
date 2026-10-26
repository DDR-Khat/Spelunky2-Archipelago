meta =
{
    name = "Archipelago",
    description = "Adds Archipelago Multiworld Randomizer support",
    author = "DDRKhat",
    version = "0.5.0",
    online_safe = false,
    unsafe = true
}

local autoSync = get_setting(GAME_SETTING.CROSSPROGRESS_AUTOSYNC) == 1 and true or false
if autoSync then
    print("!!Cross-Progress AutoSync was enabled!! Please disable it and reboot Spelunky 2")
else
    require "src.Globals"
    local lunkipelago = require "src.Core"
    local Spel2AP = require "lib.Spel2APItems"

    lunkipelago:initialize()
end