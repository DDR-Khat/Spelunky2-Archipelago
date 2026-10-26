local Screen = {}

Screen.target = SCREEN.TRANSITION

---@param state StateMemory
---@param core Core
function Screen.BeforeScreenLoad(state, core)
    if state.theme_next == THEME.COSMIC_OCEAN and state.theme_start ~= THEME.COSMIC_OCEAN then
        state.theme_start = THEME.COSMIC_OCEAN
        state.level_next = core.apState.GetCosmicShortcutLevel()
    end
    if core.apState.APMeta:HaveWorldAccess(state.theme_next) then
        core.apState.APMeta:IsNextWorldUnlocked(state.theme_next)
        return
    end
    core.apState:DoWorldWrap(state)
end

---@param state StateMemory
---@param core Core
function Screen.AfterScreenLoad(_, core)
    if core.apState:DidWorldWrap() then
        toast(get_string(hash_to_stringid(0xa0a8f1ca))) -- "The Walls are shifting" message.
    end
end

return Screen