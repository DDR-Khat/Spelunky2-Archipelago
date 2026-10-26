ENT_MORE_FLAG.FINISHED_SPAWNING = 7 -- Manually define this missing flag. So we don't have a "Magic number" in code.
ENT_FLAG.CLOVER_FLAG = 23 -- Add level flag not in ent_flag list. So we don't have a "Magic number" in code.

_G.lunaJson = require "lib.lunajson"

_G.debugLevel = {
    NONE = 0,
    NETWORK = 1,
    ITEM = 2,
    INFO = 98,
    FULL = 99
}

_G.debugging = debugLevel.NONE

_G.journal = _G.journal or {}
_G.journal.people = {
    AnaSpelunky = 1,
    MargaretTunnel = 2,
    ColinNorthward = 3,
    RoffyDSloth = 4,
    AltoSing = 5,
    LizMutton = 6,
    NekkaTheEagle = 7,
    LISEProject = 8,
    CocoVonDiamonds = 9,
    ManfredTunnel = 10,
    LittleJay = 11,
    TinaFlan = 12,
    ValerieCrump = 13,
    Au = 14,
    DemiVonDiamonds = 15,
    Pilot = 16,
    PrincessAiryn = 17,
    DirkYamaoka = 18,
    GuySpelunky = 19,
    ClassicGuy = 20,
    TerraTunnel = 21,
    HiredHand = 22,
    EggplantChild = 23,
    Shopkeeper = 24,
    Tun = 25,
    Yang = 26,
    MadameTusk = 27,
    TusksBodyguard = 28,
    Waddler = 29,
    CavemanShopkeeper = 30,
    GhistShopkeeper = 31,
    VanHorsing = 32,
    Parsley = 33,
    Parsnip = 34,
    Parmesan = 35,
    Sparrow = 36,
    Beg = 37,
    EggplantKing = 38
}

_G.journal.places = {
    Dwelling = 1,
    Jungle = 2,
    Volcana = 3,
    OlmecLair = 4,
    TidePool = 5,
    Abzu = 6,
    Temple = 7,
    CityOfGold = 8,
    Duat = 9,
    IceCaves = 10,
    NeoBabylon = 11,
    TiamatThrone = 12,
    SunkenCity = 13,
    EggplantWorld = 14,
    HundunHideaway = 15,
    CosmicOcean = 16
}

_G.journal.bestiary = {
    Monty = 69,
    Percy = 70,
    Poochi = 71,
}

---@class Spel2Goal ### [0] NORMAL ("Tiamat") | [1] HARD ("Hundun") | [2] CO ("Cosmic")
_G.Spel2Goal = {
    NORMAL = 0,
    HARD = 1,
    CO = 2
}

---@class ShortcutType ### [0] OFF | [1] PROGRESSIVE | [2] INDIVIDUAL
_G.ShortcutType = {
    OFF = 0,
    PROGRESSIVE = 1,
    INDIVIDUAL = 2
}

function _G.DebugPrint(level, message)
    if debugging ~= level and debugging ~= debugLevel.FULL then
        return
    end
    print(message)
end

---@return table # Assigns "true" value to all values in provided list
function AsLookupTable(list)
    local lookup = {}
    for _, value in ipairs(list) do
        lookup[value] = true
    end
    return lookup
end

function _G.IsOnMenuScreen()
    return get_local_state().screen == SCREEN.MENU
end

function _G.IsInLevel()
    return get_local_state().screen == SCREEN.LEVEL
end

---Inserts TRUE value for `key` into `list`
---@param list table
---@param key any
---@void
function table.set(list, key)
    list[key] = true
end

function _G.IsNotNull(value)
    return value ~= nil
end

---@param integer integer dice size
---@return boolean Returns if Rolled 1D(`integer`) is max value
function _G.SucceedRoll(integer)
    return prng:random(1, integer) == integer
end

--- Fetch an entity to swap with. 1d50 -> Bombbox | 1d5 -> Bombbox | Ropepile
---@return ENT_TYPE
function _G.GetBasicItem()
    if SucceedRoll(50) then
        return ENT_TYPE.ITEM_PICKUP_BOMBBOX
    end
    if SucceedRoll(5) then
        return ENT_TYPE.ITEM_PICKUP_BOMBBAG
    end
    return ENT_TYPE.ITEM_PICKUP_ROPEPILE
end

---Local player's index number (1 to 4)
---@return integer
function _G.GetLocalPlayerSpelunkyID()
    if online == nil then
        return 1
    end
    if online.lobby == nil then
        return 1
    end
    return online.lobby.local_player_slot
end