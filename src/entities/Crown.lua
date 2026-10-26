local Entity = {}

Entity.type = ENT_TYPE.ITEM_PICKUP_CROWN

local crownYoffset = 1.40000152588 -- The positional offset from 0,0 based on crown's position when initialized.

---@param core Core
---@param crown Entity
function Entity.OnSpawn(core, crown, _)
    if not core.apState:IsEntityLocked(Entity.type) then
        return
    end
    local replacement = get_entity(spawn_over(GetBasicItem(), crown.overlay.uid, 0, crownYoffset))
    replacement:set_pre_destroy(function()
        if core.apState:IsEntityLocked(Entity.type) then
            crown:destroy()
        end
    end)
    crown.flags = set_flag(crown.flags, ENT_FLAG.NO_GRAVITY) -- Keep it secret, keep it safe.
    move_entity(crown.uid, 0, 63, 0, 0) -- Hide it out-of-bounds
    crown:set_pre_update_state_machine(function()
        if core.apState:IsEntityLocked(Entity.type) then
           return
        end
        clear_callback()
        if replacement == nil then
            return
        end
        crown.flags = clr_flag(crown.flags, ENT_FLAG.NO_GRAVITY)
        local replaceX, replaceY = get_position(replacement.uid)
        replacement:destroy()
        move_entity(crown.uid, replaceX, replaceY, 0, 0)
        if IsNotNull(replacement.overlay) then
            crown:attach(replacement.overlay)
        end
    end)
end

return Entity


--[[
set_post_entity_spawn(function(crown)
    local holder = crown.overlay
    crown.flags = set_flag(crown.flags, ENT_FLAG.NO_GRAVITY)
    local gameState = get_local_state()
    gameState.quest_flags = 0
    local x, y, layer = get_position(crown.uid)
    print(f"Crown is at: {x} / {y}")
    move_entity(crown.uid, -1, y, 0, 0)
    spawn_entity(ENT_TYPE.LOGICAL_ROOM_LIGHT, -1, y, layer, 0, 0)
    local ropeID = spawn_over(ENT_TYPE.ITEM_PICKUP_ROPEPILE, holder.uid, 0, 1.40000152588)
    local rope = get_entity(ropeID)
    print(f"Crown Owner: {tostring(crown.overlay)} | Rope: {tostring(rope.overlay)}")
    rope:set_pre_update_state_machine(function()
      local posX, posY = get_position(ropeID)
      if x ~= posX or y ~= posY then
        print(f"rope in wrong spot! {posX} / {posY}")
        clear_callback()
      end
    end)
end, SPAWN_TYPE.ANY, MASK.ITEM, ENT_TYPE.ITEM_PICKUP_CROWN)
]]