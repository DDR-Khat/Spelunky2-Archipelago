local Screen = {}

local shortcutData = {
    [1] = {x = 26, y = 84, worldNumber = 2, target = THEME.JUNGLE,       texture = TEXTURE.DATA_TEXTURES_FLOOR_JUNGLE_1},
    [2] = {x = 23, y = 84, worldNumber = 2, target = THEME.VOLCANA,      texture = TEXTURE.DATA_TEXTURES_FLOOR_VOLCANO_2},
    [3] = {x = 20, y = 84, worldNumber = 3, target = THEME.OLMEC,        texture = TEXTURE.DATA_TEXTURES_DECO_JUNGLE_2},
    [4] = {x = 26, y = 87, worldNumber = 4, target = THEME.TIDE_POOL,    texture = TEXTURE.DATA_TEXTURES_FLOOR_TIDEPOOL_3},
    [5] = {x = 23, y = 87, worldNumber = 4, target = THEME.TEMPLE,       texture = TEXTURE.DATA_TEXTURES_FLOOR_TEMPLE_1},
    [6] = {x = 20, y = 87, worldNumber = 5, target = THEME.ICE_CAVES,    texture = TEXTURE.DATA_TEXTURES_FLOOR_ICE_1},
    [7] = {x = 26, y = 90, worldNumber = 6, target = THEME.NEO_BABYLON,  texture = TEXTURE.DATA_TEXTURES_FLOOR_BABYLON_1},
    [8] = {x = 23, y = 90, worldNumber = 7, target = THEME.SUNKEN_CITY,  texture = TEXTURE.DATA_TEXTURES_FLOOR_SUNKEN_3},
    [9] = {x = 20, y = 90, worldNumber = 7, target = THEME.COSMIC_OCEAN, texture = TEXTURE.DATA_TEXTURES_FLOOR_CAVE_2},
}

Screen.target = SCREEN.CAMP

---@param state StateMemory
---@param core Core
function Screen.BeforeScreenLoad(_, core)
    local apSave = core.apState:GetMWJournal()
    local characters = 0
    for index = 1, 20, 1 do
        if apSave.people[index] == true then
            characters = set_flag(characters, index)
        end
    end
    savegame.characters = characters
    savegame.shortcuts = 10
end

---@param state StateMemory
---@param core Core
function Screen.AfterScreenLoad(_, core)
    for index, doorData in ipairs(shortcutData) do
        local backgroundDoorUID = spawn_entity_snapped_to_floor(ENT_TYPE.BG_DOOR, doorData.x, doorData.y, LAYER.FRONT)
        local doorIsUnlocked = core.apState.APMeta:HaveShortcutAccess(doorData.target)
        if IsNotNull(backgroundDoorUID) then
            local backgroundDoor = get_entity(backgroundDoorUID)
            backgroundDoor:set_texture(doorData.texture)
            backgroundDoor.animation_frame = doorIsUnlocked and 1 or 0
        end
        if (index == 8 and core.apState:GetAPGoal() < Spel2Goal.HARD) or
           (index == 9 and core.apState:GetAPGoal() < Spel2Goal.CO) then
            goto continue
        end
        local exitUID = spawn_entity_snapped_to_floor(ENT_TYPE.FLOOR_DOOR_STARTING_EXIT, doorData.x, doorData.y, LAYER.FRONT)
        local exitDoor = get_entity(exitUID)
        if IsNotNull(exitDoor) then
            exitDoor:unlock(doorIsUnlocked)
        end
        set_door_target(exitUID, doorData.worldNumber, index == 9 and core.apState:GetCosmicShortcutLevel() or 1, doorData.target)
        ::continue::
    end
end

return Screen