local Entity = {}

Entity.type = ENT_TYPE.ITEM_PICKUP_HEDJET

---@param core Core
---@param hedjet Entity
function Entity.OnSpawn(core, hedjet, _)
    if not core.apState:IsEntityLocked(Entity.type) then
        return
    end
    local x, y, layer = get_position(hedjet.uid)
    local replacement = get_entity(spawn_entity_snapped_to_floor(GetBasicItem(), x, y, layer))
    replacement:set_pre_destroy(function()
        if core.apState:IsEntityLocked(Entity.type) then
            hedjet:destroy()
        end
    end)
    hedjet.flags = set_flag(hedjet.flags, ENT_FLAG.NO_GRAVITY) -- Keep it secret, keep it safe.
    move_entity(hedjet.uid, 0, 55, 0, 0) -- Hide it out-of-bounds
    add_item_to_shop(replacement.uid, hedjet.last_owner_uid)
    hedjet:set_pre_update_state_machine(function()
        if core.apState:IsEntityLocked(Entity.type) then
            return
        end
        clear_callback()
        replacement:destroy()
        hedjet.flags = clr_flag(hedjet.flags, ENT_FLAG.NO_GRAVITY)
        move_entity(hedjet.uid, x, y, 0, 0)
    end)
end

return Entity