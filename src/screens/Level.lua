local Screen = {}

Screen.target = SCREEN.LEVEL

---@param core Core
function Screen.BeforeScreenLoad(_, core)
    core.apState:SetLevelState(false)
    core.apNetwork:RefreshUnsentStarters()
    core.apState:RefreshShopAndAltar()
end

---@param state StateMemory
---@param core Core
function Screen.AfterScreenLoad(state, core)
    local didVisit = core.apState.APMeta:SetWorldVisited(state.theme, true)
    core.apState:SetLevelState(true, didVisit)
    core.apState:HandleCosmicGoal(state)
end

return Screen