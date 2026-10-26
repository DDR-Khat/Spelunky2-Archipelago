local Entity = {}

Entity.type = ENT_TYPE.ITEM_PICKUP_ANKH

---@param core Core
---@param ankh Entity
function Entity.OnSpawn(core, ankh, _)
    if not core.apState:IsEntityLocked(Entity.type) then
        return
    end
    local x, y, layer = get_position(ankh.uid)
    local replacement = get_entity(spawn_entity_snapped_to_floor(GetBasicItem(), x, y, layer))
    replacement:set_pre_destroy(function()
        if core.apState:IsEntityLocked(Entity.type) then
            ankh:destroy()
        end
    end)
    ankh.flags = set_flag(ankh.flags, ENT_FLAG.NO_GRAVITY) -- Keep it secret, keep it safe.
    move_entity(ankh.uid, 0, 55, 0, 0) -- Hide it out-of-bounds
    ankh:set_pre_update_state_machine(function()
        if core.apState:IsEntityLocked(Entity.type) then
            return
        end
        clear_callback()
        replacement:destroy()
        ankh.flags = clr_flag(ankh.flags, ENT_FLAG.NO_GRAVITY)
        move_entity(ankh.uid, x, y, 0, 0)
    end)
end

return Entity