local Screen = {}

Screen.target = SCREEN.CONSTELLATION

---@param state StateMemory
---@param core Core
function Screen.BeforeScreenLoad(state, core)
    local goal = core.apState:GetAPGoal() + 1
    local canGoal = core.apState:CanGoal()
    if state.win_state == goal and canGoal then
        core.apNetwork:SetGoalStatus()
        return
    end
    state.win_state = WIN_STATE.NO_WIN
    state.screen_next = SCREEN.TRANSITION
    core.apState:DoWorldWrap(state)
end

function Screen.AfterScreenLoad(_, _)
    toast(get_string(hash_to_stringid(0x8f6adac8))) -- "You've won!" message from Tun
end

return Screen