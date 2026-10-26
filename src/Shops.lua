---@class SpelunkyShop
local SpelunkyShop = {}

-- All have an equal chance. So just
local generalShop = AsLookupTable({
    ENT_TYPE.ITEM_PICKUP_COMPASS,
    ENT_TYPE.ITEM_PICKUP_PASTE,
    ENT_TYPE.ITEM_PICKUP_PARACHUTE,
})

---@param core Core
---@return ENT_TYPE
local function GetUnlockedGeneralShopItem(core)
    local returnEntity = ENT_TYPE.ITEM_PICKUP_BOMBBOX
    local dice = #generalShop
    for entity, _ in pairs(generalShop) do
        if core.apState:IsEntityLocked(entity) then
            goto continue
        end
        if SucceedRoll(dice) then
            returnEntity = entity
            break
        end
        ::continue::
        dice = dice - 1
    end
    return returnEntity
end

-- All have an equal chance. So just
local weaponShop = AsLookupTable({
    ENT_TYPE.ITEM_MACHETE,
    ENT_TYPE.ITEM_FREEZERAY,
    ENT_TYPE.ITEM_WEBGUN,
    ENT_TYPE.ITEM_PICKUP_SPIKESHOES,
    ENT_TYPE.ITEM_PURCHASABLE_POWERPACK,
})

---@param core Core
---@return ENT_TYPE
local function GetUnlockedWeaponShopItem(core)
    local returnEntity = ENT_TYPE.ITEM_PICKUP_BOMBBAG
    local dice = #weaponShop
    for entity, _ in pairs(weaponShop) do
        if core.apState:IsEntityLocked(entity) then
            goto continue
        end
        if SucceedRoll(dice) then
            returnEntity = entity
            break
        end
        ::continue::
        dice = dice - 1
    end
    return returnEntity
end

-- All have an equal chance. So just
local specialistShop = AsLookupTable({
    ENT_TYPE.ITEM_PICKUP_SPECTACLES,
    ENT_TYPE.ITEM_PICKUP_COMPASS,
    ENT_TYPE.ITEM_CAMERA,
    ENT_TYPE.ITEM_MATTOCK,
    ENT_TYPE.ITEM_FREEZERAY,
    ENT_TYPE.ITEM_PURCHASABLE_JETPACK,
    ENT_TYPE.ITEM_PURCHASABLE_HOVERPACK,
    ENT_TYPE.ITEM_TELEPORTER,
    ENT_TYPE.ITEM_PURCHASABLE_TELEPORTER_BACKPACK,
    ENT_TYPE.ITEM_PURCHASABLE_POWERPACK,
    ENT_TYPE.ITEM_PICKUP_SKELETON_KEY,
    ENT_TYPE.ITEM_METAL_SHIELD,
})

---@param core Core
---@return ENT_TYPE
local function GetUnlockedSpecialistShopItem(core)
    local returnEntity = ENT_TYPE.ITEM_PICKUP_BOMBBOX
    local dice = #specialistShop
    for entity, _ in pairs(specialistShop) do
        if core.apState:IsEntityLocked(entity) then
            goto continue
        end
        if SucceedRoll(dice) then
            returnEntity = entity
            break;
        end
        ::continue::
        dice = dice - 1
    end
    return returnEntity
end

-- All have an equal chance. So just
local clothShop = AsLookupTable({
    ENT_TYPE.ITEM_PURCHASABLE_CAPE,
    ENT_TYPE.ITEM_PICKUP_SPECTACLES,
    ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES,
    ENT_TYPE.ITEM_PICKUP_PITCHERSMITT,
    ENT_TYPE.ITEM_PICKUP_SPIKESHOES
})

---@param core Core
---@return ENT_TYPE
local function GetUnlockedClothShopItem(core)
    local returnEntity = ENT_TYPE.ITEM_PICKUP_ROPEPILE
    local dice = #clothShop
    for entity, _ in pairs(clothShop) do
        if core.apState:IsEntityLocked(entity) then
            goto continue
        end
        if SucceedRoll(dice) then
            returnEntity = entity
            break;
        end
        ::continue::
        dice = dice - 1
    end
    return returnEntity
end

-- All have an equal chance. So just
local hiredHandShop = AsLookupTable({
    ENT_TYPE.ITEM_PURCHASABLE_CAPE,
    ENT_TYPE.ITEM_PICKUP_SPECTACLES,
    ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES,
    ENT_TYPE.ITEM_PICKUP_PITCHERSMITT,
    ENT_TYPE.ITEM_PICKUP_SPIKESHOES
})
---@param core Core
---@return ENT_TYPE
local function GetUnlockedHiredHandShopItem(core)
    local returnEntity = ENT_TYPE.ITEM_PICKUP_ROPEPILE
    local dice = #hiredHandShop
    for entity, _ in pairs(hiredHandShop) do
        if core.apState:IsEntityLocked(entity) then
            goto continue
        end
        if SucceedRoll(dice) then
            returnEntity = entity
            break
        end
        ::continue::
        dice = dice - 1
    end
    return returnEntity
end

-- All have an equal chance. So just
local tunShop = AsLookupTable({
    ENT_TYPE.ITEM_PICKUP_COMPASS,
    ENT_TYPE.ITEM_PICKUP_PASTE,
    ENT_TYPE.ITEM_PICKUP_PARACHUTE,
    ENT_TYPE.ITEM_PURCHASABLE_CAPE,
    ENT_TYPE.ITEM_PICKUP_SPECTACLES,
    ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES,
    ENT_TYPE.ITEM_PICKUP_PITCHERSMITT,
    ENT_TYPE.ITEM_PICKUP_SPIKESHOES,
    ENT_TYPE.ITEM_PICKUP_SPRINGSHOES,
    ENT_TYPE.ITEM_MACHETE,
    ENT_TYPE.ITEM_FREEZERAY,
    ENT_TYPE.ITEM_WEBGUN,
    ENT_TYPE.ITEM_CAMERA,
    ENT_TYPE.ITEM_MATTOCK,
    ENT_TYPE.ITEM_PURCHASABLE_JETPACK,
    ENT_TYPE.ITEM_PURCHASABLE_HOVERPACK,
    ENT_TYPE.ITEM_TELEPORTER,
    ENT_TYPE.ITEM_PURCHASABLE_TELEPORTER_BACKPACK,
    ENT_TYPE.ITEM_PURCHASABLE_POWERPACK,
    ENT_TYPE.ITEM_PLASMACANNON,
    ENT_TYPE.ITEM_METAL_SHIELD,
})

---@param core Core
---@return ENT_TYPE
local function GetUnlockedTunShopItem(core)
    local returnEntity = ENT_TYPE.ITEM_PICKUP_BOMBBAG
    local dice = #tunShop
    for entity, _ in pairs(tunShop) do
        if core.apState:IsEntityLocked(entity) then
            goto continue
        end
        if SucceedRoll(dice) then
            returnEntity = entity
            break
        end
        ::continue::
        dice = dice - 1
    end
    return returnEntity
end

-- All have an equal chance. So just
local cavemanShop = AsLookupTable({
    ENT_TYPE.ITEM_PICKUP_COMPASS,
    ENT_TYPE.ITEM_PICKUP_PASTE,
    ENT_TYPE.ITEM_PICKUP_PARACHUTE,
    ENT_TYPE.ITEM_PURCHASABLE_CAPE,
    ENT_TYPE.ITEM_PICKUP_SPECTACLES,
    ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES,
    ENT_TYPE.ITEM_PICKUP_PITCHERSMITT,
    ENT_TYPE.ITEM_PICKUP_SPIKESHOES,
    ENT_TYPE.ITEM_PICKUP_SPRINGSHOES,
    ENT_TYPE.ITEM_MACHETE,
    ENT_TYPE.ITEM_FREEZERAY,
    ENT_TYPE.ITEM_WEBGUN,
    ENT_TYPE.ITEM_CAMERA,
    ENT_TYPE.ITEM_MATTOCK,
    ENT_TYPE.ITEM_PURCHASABLE_JETPACK,
    ENT_TYPE.ITEM_PURCHASABLE_HOVERPACK,
    ENT_TYPE.ITEM_TELEPORTER,
    ENT_TYPE.ITEM_PURCHASABLE_TELEPORTER_BACKPACK,
    ENT_TYPE.ITEM_PURCHASABLE_POWERPACK,
    ENT_TYPE.ITEM_PLASMACANNON,
})

---@param core Core
---@return ENT_TYPE
local function GetUnlockedCavemanShopItem(core)
    local returnEntity = SucceedRoll(2) and ENT_TYPE.ITEM_PICKUP_ROPEPILE or ENT_TYPE.ITEM_PICKUP_BOMBBAG
    local dice = #cavemanShop
    for entity, _ in pairs(cavemanShop) do
        if core.apState:IsEntityLocked(entity) then
            goto continue
        end
        if SucceedRoll(dice) then
            returnEntity = entity
            break
        end
        ::continue::
        dice = dice - 1
    end
    return returnEntity
end

--- Need one guaranteed way to determine shops which works even for black-market.
--- Only way looks to be checking the decoration sign, based on "animation" frame
local shopType = {
    [86] = GetUnlockedGeneralShopItem,
    [87] = GetUnlockedWeaponShopItem,
    [88] = GetUnlockedSpecialistShopItem,
    [97] = GetUnlockedClothShopItem,
    [98] = GetUnlockedHiredHandShopItem,
}

local function GetShoppieItem(core, x, y, layer)
    local shoppies = get_entities_at({ENT_TYPE.MONS_MERCHANT,ENT_TYPE.MONS_CAVEMAN_SHOPKEEPER}, MASK.MONSTER, x, y - 6.5, layer, 1)
    if #shoppies ~= 1 then
        return nil
    end
    if get_entity(shoppies[1]).type == ENT_TYPE.MONS_MERCHANT then
        return GetUnlockedTunShopItem(core)
    end
    return GetUnlockedCavemanShopItem(core)
end

--- Try determine a shop type based on the shop sign icon, because we have no other way
---@param x integer
---@param y integer
---@param layer LAYER
---@return SHOP_TYPE?
function SpelunkyShop:GetShopReplacement(core, x, y, layer)
    local roomX, roomY = get_room_index(x, y)
    local posX, posY = get_room_pos(roomX, roomY)
    local returnValue = GetShoppieItem(core, posX + 2.5, posY, layer)
    returnValue = returnValue or GetShoppieItem(core, posX + 7.5, posY, layer)
    if IsNotNull(returnValue) then
        return returnValue
    end
    posX = posX + 1.0
    posY = posY - 3.0
    local signs = get_entities_at(ENT_TYPE.DECORATION_SHOPSIGNICON, MASK.DECORATION, posX, posY, layer, 1)
    if #signs ~= 1 then
        posX = posX + 8.0
        signs = get_entities_at(ENT_TYPE.DECORATION_SHOPSIGNICON, MASK.DECORATION, posX, posY, layer, 1)
    end
    if #signs ~= 1 then
        spawn_entity(ENT_TYPE.FLOOR_ALTAR, posX, posY, layer, 0, 0)
        print(f"Unidentified shop. Look for a shop with scrap in the {layer == LAYER.FRONT and \"front\" or \"back\"} layer.")
        return ENT_TYPE.ITEM_SCRAP
    end
    local signIcon = get_entity(signs[1]).animation_frame
    local unlockShopFunction = shopType[signIcon]
    if unlockShopFunction == nil then
        spawn_entity(ENT_TYPE.FLOOR_ALTAR, posX, posY, layer, 0, 0)
        print(f"Unidentified Sign shop ({signIcon}). Look for a shop with scrap in the {layer == LAYER.FRONT and \"front\" or \"back\"} layer")
        return ENT_TYPE.ITEM_SCRAP
    end
    return unlockShopFunction(core)
end

return SpelunkyShop