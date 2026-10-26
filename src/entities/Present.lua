local Entity = {}

Entity.type = ENT_TYPE.ITEM_PRESENT

local lootTable = {
    [Spel2AP.locations.item.Plasma_Cannon] = ENT_TYPE.ITEM_PLASMACANNON,
    [Spel2AP.locations.item.Bomb_Box] = ENT_TYPE.ITEM_PICKUP_BOMBBOX,
    [Spel2AP.locations.item.Spectacles] = ENT_TYPE.ITEM_PICKUP_SPECTACLES,
    [Spel2AP.locations.item.Climbing_Gloves] = ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES,
    [Spel2AP.locations.item.Pitchers_Mitt] = ENT_TYPE.ITEM_PICKUP_PITCHERSMITT,
    [Spel2AP.locations.item.Spring_Shoes] = ENT_TYPE.ITEM_PICKUP_SPRINGSHOES,
    [Spel2AP.locations.item.Spike_Shoes] = ENT_TYPE.ITEM_PICKUP_SPIKESHOES,
    [Spel2AP.locations.item.Paste] = ENT_TYPE.ITEM_PICKUP_PASTE,
    [Spel2AP.locations.item.Compass] = ENT_TYPE.ITEM_PICKUP_COMPASS,
    [Spel2AP.locations.item.Mattock] = ENT_TYPE.ITEM_MATTOCK,
    [Spel2AP.locations.item.Boomerang] = ENT_TYPE.ITEM_BOOMERANG,
    [Spel2AP.locations.item.Machete] = ENT_TYPE.ITEM_MACHETE,
    [Spel2AP.locations.item.Cape] = ENT_TYPE.ITEM_CAPE,
    [Spel2AP.locations.item.Webgun] = ENT_TYPE.ITEM_WEBGUN,
    [Spel2AP.locations.item.Shotgun] = ENT_TYPE.ITEM_SHOTGUN,
    [Spel2AP.locations.item.Freeze_Ray] = ENT_TYPE.ITEM_FREEZERAY,
    [Spel2AP.locations.item.Jetpack] = ENT_TYPE.ITEM_JETPACK,
    [Spel2AP.locations.item.Camera] = ENT_TYPE.ITEM_CAMERA,
    [Spel2AP.locations.item.Teleporter] = ENT_TYPE.ITEM_TELEPORTER,
    [Spel2AP.locations.item.Parachute] = ENT_TYPE.ITEM_PICKUP_PARACHUTE,
    [Spel2AP.locations.item.Crossbow] = ENT_TYPE.ITEM_CROSSBOW,
    [Spel2AP.locations.item.Powerpack] = ENT_TYPE.ITEM_POWERPACK,
    [-1] = ENT_TYPE.ITEM_SNAP_TRAP,
    [Spel2AP.locations.item.Royal_Jelly] = ENT_TYPE.ITEM_PICKUP_ROYALJELLY,
    [Spel2AP.locations.item.Rope_Pile] = ENT_TYPE.ITEM_PICKUP_ROPEPILE,
    [Spel2AP.locations.item.Bomb_Bag] = ENT_TYPE.ITEM_PICKUP_BOMBBAG,
}

---@param core Core
---@param ent Container
function Entity.OnSpawn(core, ent, _)
    if core.apState:IsEntityLocked(ent.inside) == false then
        return
    end
    local contentsID
    local rolls = 1
    for location, entity in pairs(lootTable) do
        if core.apState:IsEntityLocked(entity) then
            goto continue
        end
        if location ~= 1 and core.apNetwork:NotSentLocation(location) then
            contentsID = entity
            break
        end
        if (SucceedRoll(entity == ENT_TYPE.ITEM_PLASMACANNON and 1001 or (#lootTable - rolls)))
           and contentsID == nil then
            contentsID = entity
        end
        ::continue::
        rolls = rolls + 1
    end
    set_contents(ent.uid, contentsID or ENT_TYPE.ITEM_PICKUP_BOMBBAG)
end

return Entity