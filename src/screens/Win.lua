local Screen = {}

Screen.target = SCREEN.WIN

---@param state StateMemory
---@param core Core
function Screen.BeforeScreenLoad(state, core)
    local goal = core.apState:GetAPGoal() + 1
    local canGoal = core.apState:CanGoal()
    local showPopup = false
    if state.win_state == goal and canGoal then
        core.apNetwork:SetGoalStatus()
        return
    end
    if state.win_state == WIN_STATE.TIAMAT_WIN then
        force_custom_theme(THEME.NEO_BABYLON) -- Need to force, so Tiamat doesn't crash due to expecting 0 entities.
        if core.apNetwork:NotSentLocation(Spel2AP.locations.people.Guy_Spelunky) then
            savegame.people[journal.people.GuySpelunky] = true
            showPopup = true
        end
    elseif state.win_state == WIN_STATE.HUNDUN_WIN and core.apNetwork:NotSentLocation(Spel2AP.locations.people.Classic_Guy) then
        savegame.people[journal.people.ClassicGuy] = true
        showPopup = true
    end
    if showPopup then
        local popupUI = game_manager.save_related.journal_popup_ui
        popupUI.entry_to_show = journal.people.ClassicGuy -- Both "Guy"s are same page, so this works for both.
        popupUI.chapter_to_show = 4
        popupUI.timer = 60 * 3
    end
    state.win_state = WIN_STATE.NO_WIN
    state.screen_next = SCREEN.TRANSITION
    core.apState:DoWorldWrap(state)
end

function Screen.AfterScreenLoad(_, _)
    toast(get_string(hash_to_stringid(0x8f6adac8))) -- "You've won!" message from Tun
end

return Screen