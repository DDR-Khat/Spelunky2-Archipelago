local Entity = {}

Entity.type = ENT_TYPE.PLAYER

---@param core Core
---@param ent Entity
function Entity.OnSpawn(core, ent, _)
    core.apDeath:HookDeathToPlayer(ent)
    core.apState:SetLocalPlayer(ent)
end

return Entity