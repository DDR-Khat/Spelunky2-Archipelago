local Screen = {}

Screen.target = SCREEN.CHARACTER_SELECT

---@param state StateMemory
---@param core Core
function Screen.BeforeScreenLoad(_, core)
    local characterValue = 0
    local firstAvailable = 0
    for index, characterIndex in ipairs(core.apState:GetAvailableCharacters()) do
        characterValue = set_flag(characterValue, characterIndex)
        if index == 1 then
            firstAvailable = characterIndex - 1 -- This particular one is 0-indexed.
        end
    end
    savegame.characters = characterValue
    if not test_flag(characterValue, savegame.players[GetLocalPlayerSpelunkyID()]) then -- If last selected character isn't a valid choice.
        savegame.players[GetLocalPlayerSpelunkyID()] = firstAvailable -- swap to one we know they have
    end
end

return Screen