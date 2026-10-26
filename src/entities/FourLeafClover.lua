local Entity = {}

Entity.type = ENT_TYPE.ITEM_PICKUP_CLOVER

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

---@param core Core
---@param ent Entity
function Entity.OnSpawn(core, ent, _)
    ent:set_pre_apply_metadata(function(_, meta)
        if meta ~= Spel2AP.upgrades.Four_Leaf_Clover then
            return
        end
        ent:set_pre_virtual(ENTITY_OVERRIDE.GIVE_POWERUP, function()
            core.apState:SetWaddlerCloverState(true)
        end)
        ent:set_pre_get_metadata(function()
            return Spel2AP.upgrades.Four_Leaf_Clover
        end)
    end)
end

return Entity