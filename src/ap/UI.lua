---@class APUI
local APUI = {}

APUI.__index = APUI

local function RGB2Color(r, g, b)
    return Color.new(r/255, g/255, b/255, 1)
end

local colors = {
---@type Color
    white = RGB2Color(255, 255, 255),
---@type Color
    paleYellow = RGB2Color(240, 230, 210),
---@type Color
    yellow = RGB2Color(230, 220, 80),
---@type Color
    brown = RGB2Color(120, 80, 60),
---@type Color
    darkGray = RGB2Color(10, 10, 10),
---@type Color
    black = RGB2Color(0, 0, 0),
}

---@class ThemeData
---@field access boolean Have access to the world with this theme
---@field display integer TextureID
---@field TileX integer
---@field TileY integer
---@field width float
---@field height float
---@field offsetX float
---@field offsetY float

---@class PopupBox
---@field texture TEXTURE
---@field title TextRenderingInfo
---@field message TextRenderingInfo
---@field tileX integer
---@field tileY integer
local popupBox

---@class PopupData
local popupData = {}
---@field backgroundLeft float
popupData.backgroundLeft = -0.27
---@field backgroundTop float
popupData.backgroundTop = 0.81
---@field backgroundBottom float
popupData.backgroundBottom = popupData.backgroundTop + 0.155
---@field backgroundRight float
popupData.backgroundRight = popupData.backgroundLeft + 0.610
---@field iconLeft float
popupData.iconLeft = popupData.backgroundLeft + 0.013
---@field iconTop float
popupData.iconTop = popupData.backgroundTop + 0.013
---@field iconBottom float
popupData.iconBottom = popupData.iconTop + 0.130
---@field iconRight float
popupData.iconRight = popupData.iconLeft + 0.075
---@field textureLeft float
popupData.textureLeft = popupData.backgroundLeft + 0.013
---@field textureTop float
popupData.textureTop = popupData.backgroundTop + 0.143
---@field textureRight float
popupData.textureRight = popupData.backgroundLeft + 0.088
---@field textureBottom float
popupData.textureBottom = popupData.backgroundTop + 0.013
---@field titleLeft float
popupData.titleLeft = popupData.backgroundLeft + 0.1
---@field titleTop float
popupData.titleTop = popupData.backgroundTop + 0.095
---@field titleBottom float
popupData.titleBottom = popupData.titleTop + 0.06
---@field titleRight float
popupData.titleRight = popupData.titleLeft + 0.51
---@field topTextX float
popupData.topTextX = popupData.titleLeft + 0.015
---@field topTextY float
popupData.topTextY = popupData.titleTop + 0.03
---@field messageX_left float
popupData.messageX_left = popupData.backgroundLeft + 0.1
---@field messageX_right float
popupData.messageX_right = popupData.backgroundRight + 0.16
---@field messageY float
popupData.messageY = popupData.backgroundTop + 0.05

--- C#-like "private" variables. In a table so local functions don't shadow over them.
local private = {
---@type Core
    core = nil,
---@type TextureRenderingInfo
    hudIcon = nil,
    hudIconWidth = 0,
    hudIconHeight = 0,
    nextWorldUnlocked = false,
    hudXOffset = 6.55,
    hudYOffset = 0.55,
---@type table<integer, ThemeData> # Look-up table world availability
    availableWorlds = {
    [THEME.DWELLING] = {
        access = true,
        display = TEXTURE.DATA_TEXTURES_MONSTERS01_0,
        TileY = 2,
        TileX = 11,
        width = 0.18,
        height = 0.18,
        offsetX = -0.01,
        offsetY = 0.00,
    },
    [THEME.JUNGLE] = {
        access = false,
        display = TEXTURE.DATA_TEXTURES_MONSTERS01_0,
        TileY = 7,
        TileX = 5,
        width = 0.26,
        height = 0.26,
        offsetX = -0.05,
        offsetY = 0.01,
    },
    [THEME.VOLCANA] = {
        access = false,
        display = TEXTURE.DATA_TEXTURES_MONSTERS01_0,
        TileY = 1,
        TileX = 10,
        width = 0.18,
        height = 0.18,
        offsetX = 0.0,
        offsetY = -0.02,
    },
    [THEME.OLMEC] = {
        access = false,
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 5,
        TileX = 13,
        width = 0.13,
        height = 0.13,
        offsetX = 0.02,
        offsetY = -0.03,
    },
    [THEME.TIDE_POOL] = {
        access = false,
        display = TEXTURE.DATA_TEXTURES_MONSTERS02_0,
        TileY = 7,
        TileX = 7,
        width = 0.17,
        height = 0.17,
        offsetX = 0.0,
        offsetY = -0.01,
    },
    [THEME.TEMPLE] = {
        access = false,
        display = TEXTURE.DATA_TEXTURES_MONSTERS02_0,
        TileY = 14,
        TileX = 9,
        width = 0.14,
        height = 0.14,
        offsetX = 0.03,
        offsetY = 0.02,
    },
    [THEME.ICE_CAVES] = {
        access = false,
        display = TEXTURE.DATA_TEXTURES_MONSTERS03_0,
        TileY = 3,
        TileX = 6,
        width = 0.14,
        height = 0.14,
        offsetX = 0.02,
        offsetY = 0.04,
        worldCount = 5
    },
    [THEME.NEO_BABYLON] = {
        access = false,
        display = TEXTURE.DATA_TEXTURES_MONSTERS03_0,
        TileY = 4,
        TileX = 1,
        width = 0.14,
        height = 0.14,
        offsetX = 0.02,
        offsetY = 0.02,
    },
    [THEME.SUNKEN_CITY] = {
        access = false,
        display = TEXTURE.DATA_TEXTURES_MONSTERS03_0,
        TileY = 5,
        TileX = 0,
        width = 0.34,
        height = 0.34,
        offsetX = -0.09,
        offsetY = 0.15,
    },
    [THEME.COSMIC_OCEAN] = {
        access = false,
        display = TEXTURE.DATA_TEXTURES_MONSTERS_GHOST_0,
        TileY = 7,
        TileX = 0,
        width = 0.13,
        height = 0.13,
        offsetX = 0.03,
        offsetY = 0.04,
    }}
}

---@param ctx VanillaRenderContext
local function DrawOutlinedRectangle(ctx, left, top, right, bottom, color)
    ctx:draw_screen_rect_filled(AABB:new(left, top, right, bottom), color)
    ctx:draw_screen_rect(AABB:new(left, top, right, bottom), 3, colors.black)
end

---@param ctx VanillaRenderContext
local function drawScaledHudTexture(ctx, texture, tileX, tileY, scale, yOffset_extra, color)
    if private.hudIcon == nil then
        return
    end
    local xOffset = private.hudIconWidth * private.hudXOffset
    local yOffset = private.hudIconHeight * (private.hudYOffset + yOffset_extra)
    local left = (private.hudIcon.x + xOffset) + (private.hudIcon.destination_top_left_x * scale)
    local right = (private.hudIcon.x + xOffset) + (private.hudIcon.destination_top_right_x * scale)
    local top = (private.hudIcon.y + yOffset) + (private.hudIcon.destination_top_left_y * scale)
    local bottom = (private.hudIcon.y + yOffset) + (private.hudIcon.destination_bottom_left_y * scale)
    ctx:draw_screen_texture(texture, tileX, tileY, left, top, right, bottom, color)
end

---@param text String
---@param x integer
---@param y integer
---@param scale float
---@param fontstyle VANILLA_TEXT_ALIGNMENT
---@return TextRenderingInfo
local function drawText(text, x, xClamp, y, scale, fontstyle)
    fontstyle = fontstyle or VANILLA_FONT_STYLE.NORMAL
    ---@type TextRenderingInfo
    local textRenderInfo = TextRenderingInfo:new(text, x, y, scale, scale, VANILLA_TEXT_ALIGNMENT.LEFT, fontstyle)
    local letters = textRenderInfo:get_dest()
    if xClamp == nil then
        goto returnValue
    end
    for index, letter in pairs(letters) do
        local quad = letter:get_quad()
        if quad.bottom_right_x > xClamp then
            textRenderInfo:set_text(text:sub(1, index - 1), scale, scale, VANILLA_TEXT_ALIGNMENT.LEFT, fontstyle)
            break
        end
    end
    ::returnValue::
    return textRenderInfo
end

---@param ctx VanillaRenderContext
function APUI:RenderPopupBox(ctx)
    if popupBox == nil then
        return
    end
    -- Main pop-up window
    DrawOutlinedRectangle(ctx, popupData.backgroundLeft, popupData.backgroundTop, popupData.backgroundRight, popupData.backgroundBottom, colors.paleYellow)
    -- Icon window
    DrawOutlinedRectangle(ctx, popupData.iconLeft, popupData.iconTop, popupData.iconRight, popupData.iconBottom, colors.yellow)
    -- Icon sprite
    ctx:draw_screen_texture(popupBox.texture, popupBox.tileY, popupBox.tileX, popupData.textureLeft, popupData.textureTop, popupData.textureRight, popupData.textureBottom, colors.white)
    -- Title window
    DrawOutlinedRectangle(ctx, popupData.titleLeft, popupData.titleTop, popupData.titleRight, popupData.titleBottom, colors.brown)
    ctx:draw_text(popupBox.title, colors.white)
    ctx:draw_text(popupBox.message, colors.brown)
end

---@param ctx VanillaRenderContext
function APUI:RenderWorldAccessIcon(ctx, hud)
    if IsInLevel() == false then
        return
    end

    local opacity = hud.data.opacity * hud.opacity
    if get_setting(GAME_SETTING.HUD_STYLE) == 2 then
        opacity = opacity / 2
    end

    local hudColorWorld = Color:new(1, 1, 1, opacity * (private.nextWorldUnlocked and 1.0 or 0.8))
    drawScaledHudTexture(ctx, TEXTURE.DATA_TEXTURES_MENU_BASIC_2, 6, 7, 1.0, 0, hudColorWorld)
    if private.nextWorldUnlocked then
        return
    end
    local hudColorLock  = Color:new(1, 1, 1, math.min(opacity * 1.2, 1))
    drawScaledHudTexture(ctx, TEXTURE.DATA_TEXTURES_ITEMS_0, 13, 3, 0.55, 0.05, hudColorLock)
end

---@param ctx VanillaRenderContext
---@param page JournalPageProgress
function APUI:RenderJournalIcons(ctx, type, page)
    if type ~= JOURNAL_PAGE_TYPE.PROGRESS then
        return
    end
    local goal = private.core.apState:GetAPGoal()
    local pageQuad = page.background:dest_get_quad():get_AABB()
    local pageDimensions = pageQuad:width() / pageQuad:height()
    local iconCount = 0
    for theme, iconData in pairs(private.availableWorlds) do
        if (theme == THEME.SUNKEN_CITY and goal == Spel2Goal.NORMAL) or
                (theme == THEME.COSMIC_OCEAN and goal ~= Spel2Goal.CO) then
            goto continue
        end
        local iconColor = iconData.access and colors.white or colors.darkGray
        local left = -0.65 + page.background.x + iconData.offsetX
        local top = 0.70 - page.background.y - iconCount * 0.111 + iconData.offsetY
        local right = left + iconData.width / pageDimensions
        local bottom = top - iconData.height
        ctx:draw_screen_texture(iconData.display, iconData.TileY, iconData.TileX, left, top, right, bottom, iconColor)
        iconCount = iconCount + 1
        ::continue::
    end
end

---Set internal flag for access to the -next- world specifically (for UI elements)
function APUI:SetNextWorldAccess(state)
    private.nextWorldUnlocked = state
end

---Set internal state of access to world `theme` to `access`
---@param theme integer
---@param access boolean
function APUI:AssignWorldAccess(theme, access)
    private.availableWorlds[theme].access = access
end

---@param texture TEXTURE
---@param title string
---@param message string
---@param tileX integer
---@param tileY integer
function APUI:SpawnPopupBox(texture, title, message, tileX, tileY)
    tileX = tileX or 0
    tileY = tileY or 0
    popupBox = {texture = texture, tileX = tileX, tileY = tileY}
    popupBox.title = drawText(title, popupData.topTextX, nil, popupData.topTextY, 0.0005, VANILLA_FONT_STYLE.BOLD)
    popupBox.message = drawText(message, popupData.messageX_left, popupData.messageX_right, popupData.messageY, 0.0007)
end

function APUI:ClearPopupBox()
    popupBox = nil
end

---@param core Core
function APUI:initialize(core)
    local instance = setmetatable({}, APUI)
    private.core = core
    private.hudIcon = get_hud().dollar_icon
    private.hudIconWidth = private.hudIcon.destination_top_right_x - private.hudIcon.destination_top_left_x
    private.hudIconHeight = private.hudIcon.destination_top_left_y - private.hudIcon.destination_bottom_left_y
    return instance
end

return APUI