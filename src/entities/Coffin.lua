local Entity = {}

Entity.type = ENT_TYPE.ITEM_COFFIN

---@param core Core
---@param ent Coffin
function Entity.OnSpawn(core, ent, _)
    if ent.layer ~= LAYER.BACK then
        return nil
    end
    if ent.inside ~= ENT_TYPE.CHAR_HIREDHAND then
        return nil
    end
    local vlads = get_entities_by(ENT_TYPE.MONS_VLAD, MASK.MONSTER, LAYER.BACK)
    if #vlads <= 0 then
        return nil
    end
    local starter = core.apNetwork:GetUnsentStarter()
    if starter == nil then
        return nil
    end
    set_contents(ent.uid, starter)
end

return Entity