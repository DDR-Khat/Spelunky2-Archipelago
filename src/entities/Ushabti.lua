local Entity = {}

Entity.type = ENT_TYPE.ITEM_USHABTI

---@param core Core
function Entity.BeforeSpawn(core, x, y, layer, _, _)
    if not core.apState:IsEntityLocked(Entity.type) then
        return nil
    end
    return spawn_entity(ENT_TYPE.FX_PICKUPEFFECT, x, y, layer, 0, 0)
end

---@param ent Entity
function Entity.OnSpawn(core, ent, _)
    ent:set_pre_apply_metadata(function(_, meta)
        if meta ~= Spel2AP.upgrades.Ushabti then
            return
        end
        ent:set_pre_get_metadata(function()
            local standingID = ent.standing_on_uid
            if standingID == nil or standingID == -1 then
                return
            end
            local standENT = get_entity(standingID)
            if standENT == nil then
                return
            end
            if standENT.type.id == ENT_TYPE.FLOOR_STORAGE then
                return Spel2AP.upgrades.Ushabti -- Set our flag, so we get it from waddler again.
            end
        end)
        ent:set_pre_update_state_machine(function()
            if not test_flag(ent.more_flags, ENT_MORE_FLAG.FINISHED_SPAWNING) then
                return
            end
            clear_callback()
            ent.animation_frame = get_local_state():get_correct_ushabti()
        end)
    end)
end

return Entity