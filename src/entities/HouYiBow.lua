local Entity = {}

Entity.type = ENT_TYPE.ITEM_HOUYIBOW

---@param ent Entity
function Entity.OnSpawn(core, ent, _)
    if not core.apState:IsEntityLocked(Entity.type) then
        return
    end
    local arrow = ent:get_held_entity()
    if IsNotNull(arrow) then
        arrow:destroy()
    end
    local x, y, layer = get_position(ent.uid)
    spawn_entity_snapped_to_floor(GetBasicItem(), x, y, layer)
    ent:destroy()
end

return Entity