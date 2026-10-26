local Entity = {}

Entity.type = ENT_TYPE.MONS_PET_DOG

---@param core Core
function Entity.BeforeSpawn(core, x, y, layer, _, _)
    if core.apNetwork:NotSentLocation(Spel2AP.locations.bestiary.Monty) then
        return
    end
    local replacement = core.apNetwork:GetUnsentDamsel()
    if IsNotNull(replacement) and replacement ~= Entity.type then
        return spawn_entity(replacement, x, y, layer, 0, 0)
    end
    return nil
end

return Entity