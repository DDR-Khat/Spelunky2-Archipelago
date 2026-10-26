local Hooks = {}

local entitiesToWatch = {}
local petEnts = ENT_TYPE.MONS_PET_HAMSTER | ENT_TYPE.MONS_PET_CAT | ENT_TYPE.MONS_PET_DOG
local entTypeHooks = MASK.ITEM | MASK.MOUNT | petEnts | ENT_TYPE.PLAYER
local replacedEntities = {}
local screensToWatch = {}

---@param entType EntityDB
---@return boolean
local function IsPlayerEntity(entType)
    return entType >= ENT_TYPE.CHAR_ANA_SPELUNKY and entType <= ENT_TYPE.CHAR_CLASSIC_GUY
end

---@return string[]
local function FetchSrcFiles(target)
    local files = list_dir("src/" .. target)
    if not files or #files < 1 then
        error(f"Failed to load files in '{target}'. Incorrect install?", 2)
    end
    return files
end

---@return table
local function LoadSrcFile(directory, filePath, fileValidator)
    local function ThrowError(msg)
        error(string.format("%s '%s' %s", directory, filePath, msg), 2)
    end
    local _, fileData = pcall(require, filePath)
    if fileData == nil then
        ThrowError("failed to load. Invalid?")
    elseif type(fileData) ~= "table" then
        ThrowError("data mismatch. Corruption?")
    elseif fileData[fileValidator] == nil then
        ThrowError("expected dataField missing. Malformed?")
    end
    return fileData --[[@as table]]
end

local function LoadEntities()
    local targetDir = 'entities'
    local validator = 'type'
    local files = FetchSrcFiles(targetDir)
    for _, fileName in ipairs(files) do
        if not fileName:match("%.lua$") then
            goto continue
        end
        local fileData = LoadSrcFile(targetDir, fileName, validator)
        entitiesToWatch[fileData[validator]] = fileData --[[@as EntityModule]]
        if IsNotNull(fileData.shopType) then
            entitiesToWatch[fileData.shopType] = fileData --[[@as EntityModule]]
        end
        ::continue:: -- C#-style skip-to-next-entry
    end
end

--- @param core Core
local function RegisterEntityHooks(core)
    set_pre_entity_spawn(function(type, x, y, layer, overlay)
        if not IsInLevel() then
            return
        end
        local entity = entitiesToWatch[type]
        if not (entity and entity.BeforeSpawn) then
            return
        end
        local isInShop = is_inside_active_shop_room(x, y, layer) and not core.apState:GetLevelState()
        local replacedUID = entity.BeforeSpawn(core, x, y, layer, isInShop, overlay)
        if replacedUID == nil then
            return
        end
        replacedEntities[replacedUID] = true
        return replacedUID
    end, SPAWN_TYPE.ANY, entTypeHooks)

    set_post_entity_spawn(function(ent)
        if not IsInLevel() then
            return
        end
        if replacedEntities[ent.uid] == true then
            replacedEntities[ent.uid] = nil
            return
        end
        local isPlayer = IsPlayerEntity(ent.type.id)
        local entity = isPlayer and entitiesToWatch[ENT_TYPE.PLAYER] or entitiesToWatch[ent.type.id]
        if not (entity and entity.OnSpawn) then
            return
        end
        if entity.type == ENT_TYPE.ITEM_PICKUP_CLOVER or entity.type == ENT_TYPE.ITEM_USHABTI then -- Need to be a tiny bit faster, to catch apply_meta
            entity.OnSpawn(core, ent, false)
            return
        end
        ent:set_pre_update_state_machine(function()
            if not test_flag(ent.more_flags, ENT_MORE_FLAG.FINISHED_SPAWNING) then
                return
            end
            clear_callback()
            if isPlayer and ent.uid ~= get_player(GetLocalPlayerSpelunkyID(), false).uid then
                return
            end
            local x, y, layer = get_position(ent.uid)
            local isInShop = is_inside_active_shop_room(x, y, layer) and not core.apState:GetLevelState()
            entity.OnSpawn(core, ent, isInShop)
        end)
    end, SPAWN_TYPE.ANY, entTypeHooks)
end

local function LoadScreens()
    local targetDir = 'screens'
    local validator = 'target'
    local files = FetchSrcFiles(targetDir)
    for _, fileName in ipairs(files) do
        if not fileName:match("%.lua$") then
            goto continue
        end
        local fileData = LoadSrcFile(targetDir, fileName, validator)
        screensToWatch[fileData[validator]] = fileData --[[@as ScreenModule]]
        ::continue:: -- C#-style skip-to-next-entry
    end
end

---@param core Core
local function RegisterScreenHooks(core)
    set_callback(function()
        local localState = get_local_state()
        local targetScreen = screensToWatch[localState.screen_next]
        if not (targetScreen and targetScreen.BeforeScreenLoad) then
            return
        end
        targetScreen.BeforeScreenLoad(localState, core)
    end, ON.PRE_LOAD_SCREEN)
    set_callback(function()
        local localState = get_local_state()
        local targetScreen = screensToWatch[localState.screen_next]
        if not (targetScreen and targetScreen.AfterScreenLoad) then
            return
        end
        targetScreen.AfterScreenLoad(localState, core)
    end, ON.POST_LOAD_SCREEN)
end

--- @param core Core
function Hooks.Initialize(core)
    LoadEntities()
    RegisterEntityHooks(core)
    LoadScreens()
    RegisterScreenHooks(core)
    register_option_callback("", nil, function(ctx)
        ctx:win_separator_text("Connection Details")
        core.apMenu:MenuOptions(ctx)
        core.apState:MenuOptions(ctx)
        ctx:win_separator_text("Deathlink Settings")
        core.apDeath:MenuOptions(ctx)
    end)
    set_callback(function()
        set_callback(function()
            clear_callback()
            core.apState:OnRunStart()
        end, ON.PRE_LEVEL_GENERATION)
    end, ON.RESET)
    set_callback(function()
        if not core.apState:IsEntityLocked(ENT_TYPE.ITEM_MATTOCK) then
            return
        end
        local state = get_local_state()
        if state.logic == nil or state.logic.tun_moon_challenge == nil then
            return
        end
        local moonMattockID = state.logic.tun_moon_challenge.mattock_uid
        if moonMattockID ~= -1 then
            return
        end
        moonMattockID = spawn_entity(ENT_TYPE.ITEM_SKULL, -1000, -1000, LAYER.BACK, 0, 0)
        state.logic.tun_moon_challenge.mattock_uid = moonMattockID
    end, ON.SPEECH_BUBBLE)
    set_callback(function(ctx, hud)
        core.apUI:RenderPopupBox(ctx)
        core.apUI:RenderWorldAccessIcon(ctx, hud)
    end, ON.RENDER_POST_HUD)
    set_callback(function(ctx, type, page)
        core.apUI:RenderJournalIcons(ctx, type, page)
    end, ON.RENDER_POST_JOURNAL_PAGE)
    set_callback(function()
        core.apState:OnGameFrame()
    end, ON.GAMEFRAME)

    set_callback(function()
        core.apNetwork:OnGuiFrame()
    end, ON.GUIFRAME)
end

return Hooks
