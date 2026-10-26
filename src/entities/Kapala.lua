local Entity = {}

Entity.type = ENT_TYPE.ITEM_PICKUP_KAPALA

---@param core Core
function Entity.BeforeSpawn(core, x, y, layer, _, overlay)
    if not core.apState:IsEntityLocked(Entity.type) then
        return nil
    end
    local replacement = GetBasicItem()
    if IsNotNull(overlay) then
        return spawn_over(replacement, overlay.uid, x, y)
    end
    return spawn_entity(replacement, x, y, layer, 0, 0)
end

return Entity