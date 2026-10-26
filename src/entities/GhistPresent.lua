local Entity = {}

Entity.type = ENT_TYPE.ITEM_GHIST_PRESENT

local packLoot = AsLookupTable({
    ENT_TYPE.ITEM_JETPACK,
    ENT_TYPE.ITEM_HOVERPACK,
    ENT_TYPE.ITEM_TELEPORTER_BACKPACK,
    ENT_TYPE.ITEM_POWERPACK
})

local weaponLoot = AsLookupTable({
    ENT_TYPE.ITEM_WEBGUN,
    ENT_TYPE.ITEM_SHOTGUN,
    ENT_TYPE.ITEM_FREEZERAY,
    ENT_TYPE.ITEM_PLASMACANNON
})

---@param core Core
---@param ent Container
function Entity.OnSpawn(core, ent, _)
    local function TryGetReplacement(table)
        local dice = #table
        for entity, _ in pairs(table) do
            if core.apState:IsEntityLocked(entity) then
                goto continue
            end
            if SucceedRoll(dice) then
                return entity
            end
            ::continue::
            dice = dice - 1
        end
        return nil
    end
    if core.apState:IsEntityLocked(ent.inside) == false then
        return
    end
    local contentsID = packLoot[ent.inside] and TryGetReplacement(packLoot) or nil
    contentsID = contentsID or weaponLoot[ent.inside] and TryGetReplacement(weaponLoot) or nil
    contentsID = contentsID or ENT_TYPE.ITEM_PICKUP_PLAYERBAG
    set_contents(ent.uid, contentsID)
end

return Entity