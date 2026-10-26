local Screen = {}

Screen.target = SCREEN.LEVEL

local diceShopEntities = AsLookupTable({ENT_TYPE.ITEM_PICKUP_BOMBBAG, ENT_TYPE.ITEM_PICKUP_BOMBBOX, ENT_TYPE.ITEM_PICKUP_ROPEPILE,
ENT_TYPE.ITEM_PICKUP_COMPASS, ENT_TYPE.ITEM_PICKUP_PASTE, ENT_TYPE.ITEM_PICKUP_PARACHUTE, ENT_TYPE.ITEM_PURCHASABLE_CAPE,
ENT_TYPE.ITEM_PICKUP_SPECTACLES, ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES, ENT_TYPE.ITEM_PICKUP_PITCHERSMITT, ENT_TYPE.ITEM_PICKUP_SPIKESHOES,
ENT_TYPE.ENT_TYPE_ITEM_PICKUP_SPRINGSHOES, ENT_TYPE.ITEM_MACHETE, ENT_TYPE.ITEM_BOOMERANG, ENT_TYPE.ITEM_CROSSBOW, ENT_TYPE.ITEM_SHOTGUN,
ENT_TYPE.ITEM_FREEZERAY, ENT_TYPE.ITEM_WEBGUN, ENT_TYPE.ITEM_CAMERA, ENT_TYPE.ITEM_MATTOCK, ENT_TYPE.ITEM_PURCHASABLE_JETPACK,
ENT_TYPE.ITEM_PURCHASABLE_HOVERPACK, ENT_TYPE.ITEM_TELEPORTER, ENT_TYPE.ITEM_PURCHASABLE_TELEPORTER_BACKPACK, ENT_TYPE.ITEM_PURCHASABLE_POWERPACK})

local altarDrops = {
    [DROP.ALTAR_DICE_CLIMBINGGLOVES] = ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES,
    [DROP.ALTAR_DICE_MACHETE] = ENT_TYPE.ITEM_MACHETE,
    [DROP.ALTAR_DICE_SPECTACLES] = ENT_TYPE.ITEM_PICKUP_SPECTACLES,
    [DROP.ALTAR_DICE_TELEPACK] = ENT_TYPE.ITEM_TELEPORTER_BACKPACK,
    [DROP.ALTAR_DICE_WEBGUN] = ENT_TYPE.ITEM_WEBGUN,
    [DROP.ALTAR_GIFT_CAPE] = ENT_TYPE.ITEM_CAPE,
    [DROP.ALTAR_KAPALA] = ENT_TYPE.ITEM_PICKUP_KAPALA,
    [DROP.ALTAR_PRESENT_EGGPLANT] = ENT_TYPE.ITEM_EGGPLANT
}

---@param core Core
function Screen.BeforeScreenLoad(_, core)
    core.apState:SetLevelState(false)
    core.apNetwork:RefreshUnsentStarters()
    local dicePrizes = {}
    for entity, _ in pairs(diceShopEntities) do
        if not core.apState:IsEntityLocked(entity) then
            table.insert(dicePrizes, entity)
        end
    end
    while #dicePrizes < 6 do
        table.insert(dicePrizes, ENT_TYPE.ITEM_PICKUP_ROPEPILE)
    end
    change_diceshop_prizes(dicePrizes)
    for drop, entity in pairs(altarDrops) do
        if core.apState:IsEntityLocked(entity) then
            replace_drop(drop, GetBasicItem())
        else
            replace_drop(drop, 0)
        end
    end
end

---@param state StateMemory
---@param core Core
function Screen.AfterScreenLoad(state, core)
    local didVisit = core.apState.APMeta:SetWorldVisited(state.theme, true)
    core.apState:SetLevelState(true, didVisit)
    core.apState:HandleCosmicGoal(state)
end

return Screen