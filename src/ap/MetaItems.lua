local MetaItems = {}

--- C#-like "private" variables. In a table so local functions don't shadow over them.
local private = {
---@type Core
    core = nil,
---@type boolean
    progressiveWorlds = true,
---@type boolean # Must have gotten to the world (YAML setting) for shortcut to be available
    mustVisit = false,
---@type ShortcutType
    shortcutMode = ShortcutType.OFF,
---@type integer # How many worlds we have access to
    worldCount = 1,
---@type integer # How many shortcuts we have access to
    shortcutCount = 1,
    receivedWorlds = {},
    receivedShortcuts = {},
    worldThemes = {THEME.DWELLING, THEME.JUNGLE, THEME.VOLCANA, THEME.OLMEC, THEME.TIDE_POOL, THEME.TEMPLE,
                   THEME.ICE_CAVES, THEME.NEO_BABYLON, THEME.SUNKEN_CITY, THEME.COSMIC_OCEAN},
---@type Table<THEME, boolean> # Lookup table for state of worlds that have been visited
    visitedWorlds = {
        [THEME.DWELLING] = false,
        [THEME.JUNGLE] = false,
        [THEME.VOLCANA] = false,
        [THEME.OLMEC] = false,
        [THEME.TIDE_POOL] = false,
        [THEME.TEMPLE] = false,
        [THEME.ICE_CAVES] = false,
        [THEME.NEO_BABYLON] = false,
        [THEME.SUNKEN_CITY] = false,
        [THEME.COSMIC_OCEAN] = false,
    },
}

local themeToCount = {
    [THEME.DWELLING] = 1,
    [THEME.JUNGLE] = 2,
    [THEME.VOLCANA] = 2,
    [THEME.OLMEC] = 3,
    [THEME.TIDE_POOL] = 4,
    [THEME.TEMPLE] = 4,
    [THEME.ICE_CAVES] = 5,
    [THEME.NEO_BABYLON] = 6,
    [THEME.SUNKEN_CITY] = 7,
    [THEME.COSMIC_OCEAN] = 8,
}

---Shifts the theme to parent areas
---@return THEME
local function ThemeClamp(theme)
    if theme == THEME.ABZU then
        return THEME.TIDE_POOL
    elseif theme == THEME.CITY_OF_GOLD or theme == THEME.DUAT then
        return THEME.TEMPLE
    elseif theme == THEME.TIAMAT then
        return THEME.NEO_BABYLON
    elseif theme == THEME.EGGPLANT_WORLD or theme == THEME.HUNDUN then
        return THEME.SUNKEN_CITY
    end
    return theme
end

---@param theme integer
---@return boolean
local function HaveWorldAccess(theme)
    if private.progressiveWorlds then
        return themeToCount[theme] <= private.worldCount
    end
    return IsNotNull(private.receivedWorlds[theme])
end

local function RefreshAvailableWorlds()
    for _, world in pairs(private.worldThemes) do
        private.core.apUI:AssignWorldAccess(world, HaveWorldAccess(world))
    end
end

---@param theme integer
---@return boolean, boolean
local function CheckGoalArea(theme)
    local goal = private.core.apState:GetAPGoal()
    if theme == THEME.NEO_BABYLON and goal == Spel2Goal.NORMAL then
        return true, HaveWorldAccess(theme)
    end
    if theme == THEME.SUNKEN_CITY and goal == Spel2Goal.HARD then
        return true, HaveWorldAccess(theme)
    end
    if theme == THEME.COSMIC_OCEAN and goal == Spel2Goal.CO then
        return true, HaveWorldAccess(theme)
    end
    return false, nil
end

---@param core Core
---@param progressiveWorld boolean
---@param shortcutMode ShortcutType
---@param mustVisit boolean
function MetaItems:initialize(core, progressiveWorld, shortcutMode, mustVisit)
    private.core = core
    private.progressiveWorlds = progressiveWorld
    private.shortcutMode = shortcutMode
    private.mustVisit = mustVisit or false
    private.worldCount = 1
    private.shortcutCount = 1
    private.receivedWorlds = AsLookupTable({THEME.DWELLING})
    private.receivedShortcuts = {}
    RefreshAvailableWorlds()
end

---@param itemID integer
function MetaItems:ProcessItem(itemID, data)
    if IsNotNull(data.world) then
        table.set(private.receivedWorlds, data.world)
        RefreshAvailableWorlds()
        self:IsNextWorldUnlocked(get_local_state().theme)
        return
    end
    if IsNotNull(data.shortcut) then
        table.set(private.receivedShortcuts, data.shortcut)
        return
    end
    if itemID == Spel2AP.world_unlocks.Progressive then
        private.worldCount = private.worldCount + 1
        RefreshAvailableWorlds()
        self:IsNextWorldUnlocked(get_local_state().theme)
        return
    end
    if itemID == Spel2AP.shortcuts.Progressive then
        private.shortcutCount = private.shortcutCount + 1
        return
    end
    print(f"[FATAL MetaItem] Unhandled Meta reward received ID {itemID}")
end

---Checks if multiworld access to the theme is granted
---@param theme integer World theme value
---@return boolean
function MetaItems:HaveWorldAccess(theme)
    theme = ThemeClamp(theme)
    return HaveWorldAccess(theme)
end

---Checks if multiworld access to the next theme(s) available is granted
---@param theme integer Current world theme
---@return boolean
function MetaItems:IsNextWorldUnlocked(theme)
    local returnValue
    theme = ThemeClamp(theme)
    local isGoal, haveAccess = CheckGoalArea(theme)
    if isGoal then
        returnValue = haveAccess
        goto send
    end
    if theme == THEME.BASE_CAMP then
        returnValue = false
        goto send
    end
    if theme == THEME.DWELLING then
        returnValue = self:HaveWorldAccess(THEME.JUNGLE) and true or nil
        returnValue = returnValue or self:HaveWorldAccess(THEME.VOLCANA)
        goto send
    end
    if theme == THEME.JUNGLE or theme == THEME.VOLCANA then
        returnValue = self:HaveWorldAccess(THEME.OLMEC)
        goto send
    end
    if theme == THEME.OLMEC then
        returnValue = self:HaveWorldAccess(THEME.TIDE_POOL) and true or nil
        returnValue = returnValue or self:HaveWorldAccess(THEME.TEMPLE)
        goto send
    end
    if theme == THEME.TIDE_POOL or theme == THEME.TEMPLE or theme == THEME.DUAT or theme == THEME.ABZU then
        returnValue = self:HaveWorldAccess(THEME.ICE_CAVES)
        goto send
    end
    if theme == THEME.ICE_CAVES then
        returnValue = self:HaveWorldAccess(THEME.NEO_BABYLON)
        goto send
    end
    if theme == THEME.NEO_BABYLON then
        returnValue = self:HaveWorldAccess(THEME.SUNKEN_CITY)
    end
    if theme == THEME.SUNKEN_CITY or theme == THEME.EGGPLANT_WORLD then
        returnValue = self:HaveWorldAccess(THEME.COSMIC_OCEAN)
    end
    if returnValue == nil then
        print(f"[FATAL NextWorldLocked] Unhandled theme: {enum_get_name(THEME, theme)}")
    end
    ::send::
    private.core.apUI:SetNextWorldAccess(returnValue or false)
end

---Set internal flag for visited worlds
---@param theme integer Target world's ThemeID
---@param state boolean If we have or haven't visited this world
---@return boolean TRUE/FALSE if the state was changed
function MetaItems:SetWorldVisited(theme, state)
    local currentState = private.visitedWorlds[theme]
    private.visitedWorlds[theme] = state
    return currentState ~= state
end

---Get table of visited worlds
---@return table<THEME, boolean>
function MetaItems:GetVisitedWorlds()
    local returnValue = {}
    for key, value in pairs(private.visitedWorlds) do
        if value == true then
            table.insert(returnValue, key)
        end
    end
    return returnValue
end

---Checks if multiworld access to the shortcut is granted
---@param theme integer World theme value
---@return boolean
function MetaItems:HaveShortcutAccess(theme)
    if theme == THEME.COSMIC_OCEAN and private.core.apState:GetAPGoal() == Spel2Goal.CO then
        return private.visitedWorlds[theme] -- Gain access once we've gone there once. Not multi-world gated.
    end
    if private.mustVisit and private.visitedWorlds[theme] == false then
        return false
    end
    theme = ThemeClamp(theme)
    if self:HaveWorldAccess(theme) == false then
        return false
    end
    if private.shortcutMode == ShortcutType.OFF then
        return true
    end
    if private.shortcutMode == ShortcutType.PROGRESSIVE then
        return themeToCount[theme] <= private.shortcutCount
    end
    return IsNotNull(private.receivedShortcuts[theme])
end

return MetaItems