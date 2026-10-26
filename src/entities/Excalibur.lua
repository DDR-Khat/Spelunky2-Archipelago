local Entity = {}

Entity.type = ENT_TYPE.ITEM_EXCALIBUR

---@param core Core
function Entity.BeforeSpawn(core, x, y, layer, _, overlay)
    if not core.apState:IsEntityLocked(Entity.type) then
        return nil
    end
    local replacement = GetBasicItem()
    return spawn_entity(replacement, x, y + 1, layer, 0, 0)
end

return Entity