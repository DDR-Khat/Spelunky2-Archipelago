function IsNull(data)
    if data and data ~= nil then
        return false
    else
        return true
    end
end

function IsType(data, dataType)
    if IsNull(data) then
        error("Arg1 missing -- data expected")
    end
    if IsNull(dataType) or type(dataType) ~= "string" then
        error("Arg2 invalid -- string expected")
    end
    return type(data) == dataType
end

function ClampedInt(data, min, max)
    if not IsType(data, "number") then
        error("Arg1 invalid -- number expected")
    elseif not IsType(min, "number") or not IsType(max, "number") then
        error("Min/Max invalid -- number expected")
    end
    return math.max(min, math.min(data, max))
end

function RGB2Color(r, g, b, a)
    r = ClampedInt(r, 0, 255)
    g = ClampedInt(g, 0, 255)
    b = ClampedInt(b, 0, 255)
    a = ClampedInt(a, 0, 255)
    return Color.new(r/255, g/255, b/255, a/255)
end

-- State for feat box
featBoxTimer = 0
featBoxData = nil

-- Call this to show a feat box
function ShowFeatBox(isTexture, entity, title, description, durationFrames, spriteIndex, spriteOffset)
    if isTexture~=true and not IsType(entity,"number") and (not IsType(entity,"table") or IsNull(entity.uid)) then
        error(f"Entity arg not ENT_TYPE or entity\nReceived -- {tostring(entity)} / type: {type(entity)}")
        return
    end
    title = title or "Title"
    description = description or "Description"
    durationFrames = durationFrames or 60
    local tex_def
    local success, texture
    if isTexture~=true then
        local makeEntity = IsType(entity,"number")
        if makeEntity then
            entity = get_entity(spawn_entity(entity, -1000, -1000, LAYER.FRONT, 0, 0))
        end
        success, texture = pcall(function() return entity:get_texture() end)
        if not success then
            error("Failed to get texture for FeatBox")
        end
        tex_def = get_texture_definition(texture)
        spriteIndex = spriteIndex or (IsType(entity.type,"table") and not IsNull(entity.type.animations[1]) and not IsNull(entity.type.animations[1].first_tile) and entity.type.animations[1].first_tile)
                or (not IsNull(entity.animation_frame) and entity.animation_frame)
                or 0
        spriteOffset = spriteOffset or 0
        local tiles_per_row = math.floor(tex_def.width / tex_def.tile_width)
        if spriteIndex >= tiles_per_row then
            spriteOffset = math.floor(spriteIndex / tiles_per_row)
            spriteIndex = spriteIndex % tiles_per_row
        end
    else
        texture = entity
        spriteIndex = 0
        spriteOffset = 0
    end
    featBoxData = {
        texture = texture,
        tileX = spriteIndex,
        tileY = spriteOffset,
        title = title,
        description = description,
        duration = durationFrames
    }
    featBoxTimer = durationFrames
    if makeEntity then
        entity:destroy()
    end
end

-- Set anchor
local anchorX = -0.27
local anchorY = 0.81
local border_size = 3

-- Rectangle helper
local function draw_outlined_rect(render_ctx, x, y, w, h, fill_color)
    render_ctx:draw_screen_rect_filled(
            AABB:new(
                    x, y,
                    w, h
            ),
            fill_color
    )
    render_ctx:draw_screen_rect(
            AABB:new(x, y, w, h),
            border_size,
            RGB2Color(0,0,0,255)
    )
end

local layoutData = {
    bgX = anchorX + 0.0,
    bgY = anchorY + 0.0,
    bgWidth = 0.610,
    bgHeight = 0.155,

    iconX = anchorX + 0.013,
    iconY = anchorY + 0.013,
    iconWidth = 0.075,
    iconHeight = 0.130,

    iconTextureOffsetX = 0.0,
    iconTextureOffsetY = 0.0,
    iconTextureWidth = 0.075,
    iconTextureHeight = 0.130,
    iconTextureScale = 1.0,

    titleX = anchorX + 0.100,
    titleY = anchorY + 0.095,
    titleRectWidth = 0.510,
    titleRectHeight = 0.060,
    titleTextOffsetX = 0.015,
    titleTextOffsetY = 0.030,

    descX = anchorX + 0.100,
    descY = anchorY + 0.050,
}

set_callback(function(renderCtx)
    if featBoxTimer > 0 and featBoxData then
        -- Main Window
        draw_outlined_rect(renderCtx, layoutData.bgX, layoutData.bgY, layoutData.bgX + layoutData.bgWidth, layoutData.bgY + layoutData.bgHeight,RGB2Color(240,230,210,255))

        -- Icon rectangle (background)
        draw_outlined_rect(renderCtx, layoutData.iconX, layoutData.iconY, layoutData.iconX + layoutData.iconWidth, layoutData.iconY + layoutData.iconHeight,RGB2Color(230,220,80,255))

        -- Icon texture (sprite)
        renderCtx:draw_screen_texture(
                featBoxData.texture, featBoxData.tileY, featBoxData.tileX,
                layoutData.iconX + layoutData.iconTextureOffsetX,
                layoutData.iconY + layoutData.iconTextureHeight * layoutData.iconTextureScale,
                layoutData.iconX + layoutData.iconTextureOffsetX + layoutData.iconTextureWidth * layoutData.iconTextureScale,
                layoutData.iconY + layoutData.iconTextureOffsetY,
                RGB2Color(255,255,255,255)
        )

        -- Title rectangle (background)
        draw_outlined_rect(renderCtx, layoutData.titleX, layoutData.titleY, layoutData.titleX + layoutData.titleRectWidth, layoutData.titleY + layoutData.titleRectHeight,RGB2Color(120, 80, 60, 255))

        -- Title text
        renderCtx:draw_text(
                featBoxData.title,
                layoutData.titleX + layoutData.titleTextOffsetX,
                layoutData.titleY + layoutData.titleTextOffsetY,
                0.0005, 0.0005,
                RGB2Color(255, 255, 255, 255),
                VANILLA_TEXT_ALIGNMENT.LEFT, VANILLA_FONT_STYLE.BOLD
        )

        -- Description text
        renderCtx:draw_text(
                featBoxData.description,
                layoutData.descX,
                layoutData.descY,
                0.0007, 0.0007,
                RGB2Color(120, 80, 60, 255),
                VANILLA_TEXT_ALIGNMENT.LEFT, VANILLA_FONT_STYLE.NORMAL
        )

        featBoxTimer = featBoxTimer - 1
        if featBoxTimer <= 0 then featBoxData = nil end
    end
end, ON.RENDER_POST_HUD)
