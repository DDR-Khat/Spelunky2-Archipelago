local Entity = {}

Entity.type = ENT_TYPE.ITEM_CRATE

local lootTable = {
    {check = Spel2AP.locations.item.Plasma_Cannon, entity = ENT_TYPE.ITEM_PLASMACANNON,           chance = 10000},
    {check = Spel2AP.locations.item.Jetpack, entity = ENT_TYPE.ITEM_JETPACK,                chance = 500},
    {check = Spel2AP.locations.item.Powerpack, entity = ENT_TYPE.ITEM_POWERPACK,              chance = 500},
    {check = Spel2AP.locations.item.Freeze_Ray, entity = ENT_TYPE.ITEM_FREEZERAY,              chance = 200},
    {check = Spel2AP.locations.item.Crossbow, entity = ENT_TYPE.ITEM_CROSSBOW,               chance = 200},
    {check = Spel2AP.locations.item.Cape, entity = ENT_TYPE.ITEM_CAPE,                   chance = 200},
    {check = Spel2AP.locations.item.Shotgun, entity = ENT_TYPE.ITEM_SHOTGUN,                chance = 100},
    {check = Spel2AP.locations.item.Mattock, entity = ENT_TYPE.ITEM_MATTOCK,                chance = 100},
    {check = Spel2AP.locations.item.Teleporter, entity = ENT_TYPE.ITEM_TELEPORTER,             chance = 100},
    {check = Spel2AP.locations.item.Climbing_Gloves, entity = ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES,  chance = 90},
    {check = Spel2AP.locations.item.Spectacles, entity = ENT_TYPE.ITEM_PICKUP_SPECTACLES,      chance = 90},
    {check = Spel2AP.locations.item.Webgun, entity = ENT_TYPE.ITEM_WEBGUN,                 chance = 80},
    {check = Spel2AP.locations.item.Camera, entity = ENT_TYPE.ITEM_CAMERA,                 chance = 80},
    {check = Spel2AP.locations.item.Pitchers_Mitt, entity = ENT_TYPE.ITEM_PICKUP_PITCHERSMITT,    chance = 80},
    {check = Spel2AP.locations.item.Paste, entity = ENT_TYPE.ITEM_PICKUP_PASTE,           chance = 60},
    {check = Spel2AP.locations.item.Spring_Shoes, entity = ENT_TYPE.ITEM_PICKUP_SPRINGSHOES,     chance = 60},
    {check = Spel2AP.locations.item.Spike_Shoes, entity = ENT_TYPE.ITEM_PICKUP_SPIKESHOES,      chance = 60},
    {check = Spel2AP.locations.item.Boomerang, entity = ENT_TYPE.ITEM_BOOMERANG,              chance = 60},
    {check = Spel2AP.locations.item.Machete, entity = ENT_TYPE.ITEM_MACHETE,                chance = 40},
    {check = Spel2AP.locations.item.Bomb_Box, entity = ENT_TYPE.ITEM_PICKUP_BOMBBOX,         chance = 40},
    {check = Spel2AP.locations.item.Compass, entity = ENT_TYPE.ITEM_PICKUP_COMPASS,         chance = 20},
    {check = Spel2AP.locations.item.Parachute, entity = ENT_TYPE.ITEM_PICKUP_PARACHUTE,       chance = 10},
    {check = Spel2AP.locations.item.Rope_Pile, entity = ENT_TYPE.ITEM_PICKUP_ROPEPILE,        chance = 2},
}

---@param core Core
---@param ent Container
function Entity.OnSpawn(core, ent, _)
    if core.apState:IsEntityLocked(ent.inside) == false then
        return
    end
    local contentsID
    for _, loot in ipairs(lootTable) do
        if core.apState:IsEntityLocked(loot.entity) then
            goto continue
        end
        if core.apNetwork:NotSentLocation(loot.check) then
            contentsID = loot.entity
            break
        end
        if SucceedRoll(loot.chance) and contentsID == nil then
            contentsID = loot.entity
        end
        ::continue::
    end
    set_contents(ent.uid, contentsID or ENT_TYPE.ITEM_PICKUP_BOMBBAG)
end

return Entity