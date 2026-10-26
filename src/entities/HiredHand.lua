local Entity = {}

Entity.type = ENT_TYPE.CHAR_HIREDHAND

---@param core Core
function Entity.BeforeSpawn(core, x, y, layer, _, _)
    if layer ~= LAYER.BACK then
        return nil
    end
    local roomX, roomY = get_room_index(x, y)
    local roomTemplate = get_room_template(roomX, roomY, layer)
    if roomTemplate == nil or roomTemplate ~= ROOM_TEMPLATE.SHOP_JAIL_BACKLAYER then
        return nil
    end
    local replacement = core.apNetwork:GetUnsentStarter()
    if replacement == nil then
        return nil
    end
    return spawn_entity(replacement, x, y, layer, 0, 0)
end

return Entity