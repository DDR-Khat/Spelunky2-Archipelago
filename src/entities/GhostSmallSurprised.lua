local Entity = {}

Entity.type = ENT_TYPE.MONS_GHOST_SMALL_SURPRISED

---@param core Core
---@param ent Entity
function Entity.OnSpawn(core, ent, _)
    ent:set_pre_on_collision1(function(_, other)
        core.apDeath:OnInstantKillerDeath(ENT_TYPE.MONS_GHOST, other)
    end)
end

return Entity