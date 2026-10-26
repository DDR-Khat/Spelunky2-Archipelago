---@class APGameState
local APGameState = {}

APGameState.__index = APGameState

---@class Spel2SlotData
---@field APWorldVersion int[] Version assigned to APWorld, for compatibility checking
---@field goal Spel2Goal Data value of player's goal
---@field goalLevel integer? Target Cosmic level (or nil if goal is NOT cosmic)
---@field ironmanMode boolean Goal modifier, forces beating the game without using a shortcut
---@field progressiveWorlds boolean True if worlds are not individually shuffled into the multiworld
---@field shortcutMode ShortcutType Modifier ruleset for access to camp's shortcuts
---@field increaseWallet boolean Modify the player's gold count on level start, based on received filler gold
---@field startingHealth integer On Start/Reset, set the stat to THIS + Upgrades from multiworld
---@field startingBombs integer On Start/Reset, set the stat to THIS + Upgrades from multiworld
---@field startingRopes integer On Start/Reset, set the stat to THIS + Upgrades from multiworld
---@field journalEntryRequired boolean Multiworld upgrades modifier, forces needing to have discovered the item to receive
---@field startingCharacters table<int> Table of characters player may select to play at select screen
---@field lockedItems table<int> Items locked out and shuffled into the multiworld
---@field itemUpgrades table<int> Items to grant on Start/Reset, once received from multiworld
---@field waddlerUpgrades table<int> Items to store into Waddler on Start/Reset, once received from multiworld
---@field deathLink boolean Participate in sending deaths (upon dying) or being killed remotely (upon another player dying)
---@field bypassAnkh boolean? Modifier to remove ankh from player before killing them, upon receiving a deathlink.
---@field graceCount integer? Count of multiworld deaths before killing the player
---@field amnestyCount integer? Count of deaths before sending a deathlink

---@class APPowerup
---@field ent ENT_TYPE Entity to spawn
---@field powerup ENT_TYPE Powerup to grant to player
---@field saveItem integer in-game journal index for the associated powerup
---@field texture TEXTURE Texture sheet
---@field frame integer animation frame for graphic on the texture sheet

local APTraps = require "src.ap.Traps"
local APStats = require "src.ap.Stats"
APGameState.APMeta = require "src.ap.MetaItems"

---@field table # SaveData-relevant table names for journal entries from Spelunky2 save data
local journalEntries = {"places", "people", "bestiary", "items", "traps"}

---@field popupCallback integer callbackID for active popup
local popupCallback = -1
---@field fillerCallback integer callbackID for active filler
local fillerCallback = -1
---@field fillerSaveIndex integer savegame item
local fillerSaveIndex = -1

--- C#-like "private" variables. In a table so local functions don't shadow over them.
local private = {
---@type Core
    core = nil,
---@type boolean # Boolean to short-circuit the SendLocation() look-up check
    gameIsLive = false,
---@type Spel2Goal
    goal = Spel2Goal.NORMAL,
---@type integer # Goal level
    cosmicGoal = 99,
---@type boolean
    isIronman = false,
---@type boolean
    increaseWallet = false,
---@type int
    walletAmount = 0,
---@type boolean
    requireJournal = false,
---@type integer # Overrides players beginning health value for each run
    startingHealth = 4,
---@type integer # Overrides players beginning health value for each run
    startingBombs = 4,
---@type integer # Overrides players beginning health value for each run
    startingRopes = 4,
---@type integer # Offsets starting level number in cosmic ocean
    coShortcutCount = 0,
---@type table # Overrides characters player may select to play as
    availableCharacters = {},
---@type table # Entities that need to be received from the multiworld first
    lockedItems = {},
    starterUpgrades = {},
    waddlerUpgrades = {},
---@type table<integer, APPowerup> # Multiworld items to start with, indexed by multiworld powerup ID
    powerups = {},
---@type boolean # True/False if we've picked up Waddler's four-leaf clover, so we assign it to all levels (to match 'item' clover functionality)
    waddlerCloverCollected = false,
---@type string # AP save-file directory path
    savePath = "saves/",
---@type table # Multiworld state of "Journal" data
    journal = {},
---@type table # Table of all items received from the world.
    receivedItems = {},
---@type integer # Last received item index
    receivedIndex = -1,
---@type table # Queued item queue (sent/received) for visual feedback
    popupQueue = {},
---@type table # Queued filler (for being given later when the player is in a item-receivable state)
    fillerQueue = {},
---@type table # Queued up power-ups received that aren't locked out, so we receive them during a run.
    powerupQueue = {},
---@type integer # Length of time for visual pop-up of queued sent/received item to remain
    popupTime = 3,
    isInLevel = false,
    isWorldLooping = false,
---@type Player # Local player entity, if it exists, nil otherwise.
    localPlayer = nil,
}

---@param mode mode string: "r"|"w"|"a"|"r+"|"w+"|"a+"|"rb"|"wb"|"ab"|"rb+"|"wb+"|"ab+"
---@return file? Locally stored credentials file
local function GetAPSave(mode)
    local success, result = pcall(io.open_data,f"{private.savePath}AP_{private.core.apNetwork:GetWorldID()}.json", mode)
    if success == true then
        return result
    end
    return nil
end

local function SaveDataToFile()
    local saveFile = GetAPSave("w+")
    if saveFile == nil then
        return
    end
    local itemData = {}
    for key, value in pairs(private.receivedItems) do
        if value == true then
            table.insert(itemData, key)
        end
    end
    local success, writeData = pcall(lunaJson.encode,
            {fillers = itemData, wallet = private.walletAmount, itemIndex = private.receivedIndex, visitedWorlds = APGameState.APMeta:GetVisitedWorlds()})
    if success == true then
        saveFile:write(writeData)
        saveFile:close()
        return
    end
end

local function LoadSavedData()
    local saveFile = GetAPSave("r")
    if saveFile == nil then
        return
    end
    local data = saveFile:read("*all")
    saveFile:close()
    if data == nil or data == "" then
        return
    end
    local success, saveData = pcall(lunaJson.decode, data)
    if success == false then
        return
    end
    if IsNotNull(saveData.fillers) then
        for _, value in pairs(saveData.fillers) do
            table.set(private.receivedItems, value)
        end
    end
    if IsNotNull(saveData.visitedWorlds) then
        for _, value in pairs(saveData.visitedWorlds) do
            APGameState.APMeta:SetWorldVisited(value, true)
        end
    end
    private.walletAmount = saveData.wallet or private.walletAmount
    private.receivedIndex = saveData.itemIndex or private.receivedIndex
end

---@param player Player
---@param entity Entity
---@param index integer
local function GiftEntity(player, entity, index)
    local playerX, playerY, playerLayer = get_position(player.uid)
    local popupUI = game_manager.save_related.journal_popup_ui
    ---@type Movable
    local giftedEntity = get_entity(spawn_entity(entity, playerX, playerY, playerLayer, 0, 0))
    giftedEntity.stand_counter = 25
    if index == -1 then
        return
    end
    if not private.journal["items"][index] then
        set_global_interval(function()
            if popupUI.timer <= 0 then
                clear_callback()
                return
            end
            popupUI.timer = 0
        end, 1)
        fillerSaveIndex = index
    end
end

---@param value MultiItem
---@param isFiller boolean
---@param receiver string
---@param sender string
---@void Inserts `value` into the popupQueue's `priority` index, at it's furthest index. (And filler table, if appropriate)
local function QueueItem(value, isFiller, receiver, sender)
    local priority = value.priority or 1
    value.receiver = receiver
    value.sender = sender
    table.insert(private.popupQueue[priority], value)
    if isFiller then
        table.insert(private.fillerQueue[priority], {ent = value.ent, value = value.value or 0, saveItem = value.saveItem or -1})
    end
end

---@param queueTable Table
---@param isPopup boolean
---@return MultiItem
local function GetHighestPriority(queueTable, isPopup)
    for priority = 10, 0, -1 do
        local queue = queueTable[priority]
        if queue == nil then
            DebugPrint(debugLevel.ITEM, string.format("[ERROR] %s ID %d didn't exist!!",
            isPopup and "popupQueue" or "fillerQueue",
            priority))
            goto continue
        end
        if #queue > 0 then
            local entry = table.remove(queue, 1)
            return entry
        end
        ::continue::
    end
    return nil
end

local function ProcessPopupQueue()
    if popupCallback ~= -1 or not IsInLevel() then
        return
    end
    ---@type MultiItem?
    local popup = GetHighestPriority(private.popupQueue, true)
    if popup == nil then
        return
    end
    local title =
        (IsNotNull(popup.receiver) and f"Discovered {popup.receiver}'s item") or
        (IsNotNull(popup.sender) and f"Item received from {popup.sender}") or
        "Item found"
    private.core.apUI:SpawnPopupBox(popup.display, title, popup.name, popup.TileX, popup.TileY)
    ::timer::
    popupCallback = set_global_timeout(function()
        private.core.apUI:ClearPopupBox()
        popupCallback = -1
        return false
    end, private.popupTime * 60)
end

local function ShouldPreventAlienCompass(entity)
    return entity == ENT_TYPE.ITEM_PICKUP_SPECIALCOMPASS and
            private.core.apNetwork:NotSentLocation(Spel2AP.locations.item.Compass)
end

local function TryQueuePowerup(itemSaveIndex)
    if private.requireJournal and private.journal.items[itemSaveIndex] == false then
        return -- If we need the journal, and not found it yet; Cease.
    end
    ---@type APPowerup
    local powerupData
    for key, powerup in pairs(private.powerups) do -- For loop isn't great, but this is our most flexible approach.
        if powerup.saveItem == itemSaveIndex then
            powerupData = powerup
            powerupData.key = key
            break
        end
    end
    if powerupData == nil then
        return -- If we don't find it, we've not received it.
    end
    if APGameState:IsEntityLocked(powerupData.ent) then
        return -- If it's not received, don't grant yet.
    end
    if ShouldPreventAlienCompass(powerupData.ent) then
        return -- If we have the alien compass, we can't pick up normal ones, breaks sending the location.
    end
    table.insert(private.powerupQueue,
            {
                key = powerupData.key,
                entity = powerupData.ent,
                powerup = powerupData.powerup,
                texture = powerupData.texture,
                frame = powerupData.frame
            })
end

local function ProcessFillerQueue()
    if fillerCallback ~= -1 or not IsInLevel() then
        return
    end
    if private.localPlayer == nil then
        return
    end
    if private.localPlayer.exit_invincibility_timer > 0 then
        return -- Door exit timer prevents interacting with entities
    end
    if test_flag(private.localPlayer.flags, ENT_FLAG.PASSES_THROUGH_OBJECTS) then
        return -- We are currently passing through items.
    end
    local playerState = private.localPlayer.state
    if playerState == CHAR_STATE.ENTERING or playerState == CHAR_STATE.EXITING then
        return -- Currently swapping layers (or going through a pipe).
    end
    local filler = GetHighestPriority(private.fillerQueue, false)
    if filler == nil then
        return
    end
    local trapEntity = filler.ent - private.core.apItems.trapOffset
    if trapEntity > 0 then
        APTraps[trapEntity](private.localPlayer)
    else
        GiftEntity(private.localPlayer, filler.ent, filler.saveItem)
    end
    fillerCallback = set_global_timeout(function()
        fillerCallback = -1
        return false
    end, 10)
    private.walletAmount = private.walletAmount + filler.value
    SaveDataToFile()
end

local function InitializeGameSave()
    savegame.tutorial_state = 4 -- Fully unlock camp
    savegame.wins_normal = math.max(savegame.wins_normal, 1) -- Character coffin chances are affected by this
    savegame.wins_hard = math.max(savegame.wins_hard, 1) -- Same as above
    savegame.wins_special = math.max(savegame.wins_special, 1) -- Same as above
    savegame.plays = math.max(savegame.plays, 200) -- Speculative same as above
    savegame.deaths = math.max(savegame.deaths, 100) -- Same as above
    savegame.completed_normal = true -- Speculative same as above
    savegame.completed_hard = true -- Speculative same as above
    savegame.completed_ironman = true -- Speculative same as above
    savegame.deepest_area = 8 -- Speculative same as above
    savegame.deepest_level = 99 -- Speculative same as above
end

---@void Due to lack of ON.JOURNAL_UPDATE hook, check the tables every game frame... ugly but no other way.
local function CheckJournalState(initialize)
    if private.gameIsLive ~= true then
        return
    end
    for iteration, entry in ipairs(journalEntries) do
        for index = 1, #savegame[entry] do
            if entry == "items" and index == fillerSaveIndex then -- If it's a filler we received.
                savegame[entry][index] = false -- Clear it.
                fillerSaveIndex = -1
                goto continue
            end
            if private.journal[entry][index] == true then
                savegame[entry][index] = true -- Re-sync game to multiworld
                goto continue
            end

            if savegame[entry][index] ~= true and initialize == nil then
                goto continue -- Not true, next one to check...
            end

            local locationID = (iteration * 1000) + index -- Calculated ID, no need for look-up value

            if IsNotNull(initialize) and private.core.apNetwork:NotSentLocation(locationID) then -- If we've NOT sent it
                savegame[entry][index] = false -- Force it as not sent
                private.journal[entry][index] = false -- Correct our Multiworld Journal
                goto continue
            end

            if initialize == nil and private.core.apState:SendLocation(locationID) ~= true then
                goto continue
            end

            private.journal[entry][index] = true
            DebugPrint(debugLevel.INFO, f"Sending location: {locationID}")

            if locationID == Spel2AP.locations.people.Terra_Tunnel then -- If we've met Terra, make her ask for the gold key
                savegame.shortcuts = 10 -- TODO: After incorporating QuestSanity, don't do this, or something.
            end

            ::continue:: -- C# type continue; instruction
        end
    end
end

local function ProcessStarterItem(powerup)
    if powerup.ent == ENT_TYPE.ITEM_PICKUP_CLOVER then
        return -- We handle this elsewhere.
    end
    if powerup.ent == ENT_TYPE.ITEM_PICKUP_ELIXIR then
        private.localPlayer.more_flags = set_flag(private.localPlayer.more_flags, ENT_MORE_FLAG.ELIXIR_BUFF)
        return
    end
    if IsNotNull(powerup.powerup) then
        private.localPlayer:give_powerup(powerup.powerup)
        return
    end
    local x, y, layer = get_position(private.localPlayer.uid)
    ---@type Entity
    local newEntity = spawn_entity_snapped_to_floor(powerup.ent, x, y, layer)
    if powerup.ent == ENT_TYPE.USHABTI then
        newEntity.animation_frame = get_local_state().get_correct_ushabti()
    end
end

---@param powerup ENT_TYPE
local function ProcessWaddlerItem(powerup)
    local storeID = waddler_store_entity(powerup)
    if storeID == -1 then
        print(f"[FATAL waddler] Failed storing {enum_get_name(ENT_TYPE, powerup)}")
        return
    end
    if powerup == ENT_TYPE.ITEM_PICKUP_CLOVER then
        waddler_set_entity_meta(storeID, Spel2AP.upgrades.Four_Leaf_Clover)
        return
    end
    if powerup == ENT_TYPE.ITEM_USHABTI then
        waddler_set_entity_meta(storeID, Spel2AP.upgrades.Ushabti)
    end
end


local function ProcessPowerupQueue()
    if not IsInLevel() or #private.powerupQueue < 1 then
        return
    end
    ---@type APPowerup
    local data = table.remove(private.powerupQueue, 1)
    if private.starterUpgrades[data.key] then
        ProcessStarterItem({ent = data.entity, powerup = data.powerup})
    elseif private.waddlerUpgrades[data.key] then
        ProcessWaddlerItem(data.entity)
    else
        print(f"[FATAL ProcessPowerup] no match for {data.enum_get_name(ENT_TYPE, data.entity)}")
    end
    local playerX, playerY, playerL = get_position(private.localPlayer.uid)
    local powerupFXid = spawn_entity(ENT_TYPE.FX_PICKUPEFFECT, playerX, playerY, playerL, 0, 0)
    if powerupFXid == nil then
        return
    end
    local powerupFX = get_entity(powerupFXid)
    if powerupFX == nil then
        return
    end
    powerupFX:set_texture(data.texture)
    powerupFX.animation_frame = data.frame
    play_sound(VANILLA_SOUND.UI_SECRET2, private.localPlayer.uid)
end

local function ProcessCloverStarter()
    if private.waddlerCloverCollected == true then
        goto grantClover
    end
    if APGameState:IsEntityLocked(ENT_TYPE.ITEM_PICKUP_CLOVER) then
        return
    end
    if private.starterUpgrades[Spel2AP.upgrades.Four_Leaf_Clover] == nil then
        return
    end
    if private.powerups[Spel2AP.upgrades.Four_Leaf_Clover] == nil then
        return
    end
    ::grantClover::
    set_level_flags(set_flag(get_level_flags(), ENT_FLAG.CLOVER_FLAG))
end

function APGameState:SetWaddlerCloverState(state)
    private.waddlerCloverCollected = state
end

---Set internal reference to the spawned local player entity
---@param player Player
function APGameState:SetLocalPlayer(player)
    private.localPlayer = player
end

---Set internal "inLevel" state.
---@param state boolean
function APGameState:SetLevelState(state, shouldSave)
    shouldSave = shouldSave or false
    private.isInLevel = state
    if state == true then
        ProcessCloverStarter()
    end
    if shouldSave then
        SaveDataToFile()
    end
end

function APGameState:GetLevelState()
    return private.isInLevel
end

---@param state StateMemory
function APGameState:HandleCosmicGoal(state)
    if state.theme ~= THEME.COSMIC_OCEAN then
        return
    end
    if state.level ~= private.cosmicGoal then
        return
    end
    local exitDoors = get_entities_by_type(ENT_TYPE.FLOOR_DOOR_EXIT)
    if #exitDoors < 0 then
        print("[FATAL HandleCosmic] No exits found on our GOAL LEVEL")
    end
    for _, doorID in pairs(exitDoors) do
        local door = get_entity(doorID)
        if door == nil then
            print("[[FATAL HandleCosmic] Failed to get exit door entity")
            goto continue
        end
        door:set_pre_hide_hud(function()
            state.win_state = WIN_STATE.COSMIC_OCEAN_WIN
            state.screen_next = SCREEN.WIN
            state.level_next = 99
        end)
        ::continue::
    end
end

---@param iteration int
---@param index int
---@void Update archipelago journal and by extension the game-state's journal
function APGameState:UpdateJournal(iteration, index)
    local journal = journalEntries[iteration]
    if private.journal[journal] == nil then
        print(f"[FATAL UpdateJournal] {journal} doesn't exist in multiworld Journal?!")
        return
    end
    if private.journal[journal][index] == nil then
        print(f"[FATAL UpdateJournal] {index} doesn't exist in {journal}?!")
        return
    end
    private.journal[journal][index] = true
    if get_local_state().screen == SCREEN.MENU then
        return
    end
    if journalEntries[iteration] == "items" then
        TryQueuePowerup(index)
    end
end

---@void Methods to call per gameframe in gameplay loop
function APGameState:OnGameFrame()
    CheckJournalState()
    ProcessPopupQueue()
    ProcessFillerQueue()
    ProcessPowerupQueue()
end

---@void Code to execute from the ON.RESET SpelunkyAPI event
function APGameState:OnRunStart()
    local itemPowerups = {}
    local state = get_local_state()
    if private.core.apNetwork:NotSentLocation(Spel2AP.locations.people.Terra_Tunnel) then -- Make Terra show up in 1-4 exits
        savegame.shortcuts = 1 -- TODO: After incorporating QuestSanity, don't do this, or something.
    end
    self.APMeta:IsNextWorldUnlocked(state.theme)
    local isCosmicStart = state.theme == THEME.COSMIC_OCEAN
    if private.increaseWallet then
        add_money(private.walletAmount, 0)
    end
    if isCosmicStart and private.isIronman == false then
        local startLevel = self:GetCosmicShortcutLevel()
        state.level = startLevel
        local exitDoors = get_entities_by_type(ENT_TYPE.FLOOR_DOOR_EXIT)
        for _, doorID in pairs(exitDoors) do
            set_door_target(doorID, state.world_start, state.startLevel + 1, state.theme_start)
        end
    end
    self:SetWaddlerCloverState(isCosmicStart)
    for key, powerup in pairs(private.powerups) do
        if self:IsEntityLocked(powerup.ent) then
            goto continue
        end
        if private.requireJournal and self:GetMWJournal().items[powerup.saveItem] == false then
            goto continue
        end
        if ShouldPreventAlienCompass(powerup.ent) then
            goto continue
        end
        if IsNotNull(private.starterUpgrades[key]) or isCosmicStart then
            table.insert(itemPowerups, powerup)
        elseif IsNotNull(private.waddlerUpgrades[key]) then
            ProcessWaddlerItem(powerup.ent)
        else
            print(f"[OnRunStart] Unhandled powerup!! {key} with entity {powerup.ent}")
        end
        ::continue::
    end
    set_global_timeout(function()
        if private.localPlayer == nil then
            DebugPrint(debugLevel.INFO, "!WARNING! Player setting is failing for some damn reason.")
            private.localPlayer = get_player(1, false)
        end
        private.localPlayer.health = private.startingHealth
        private.localPlayer.inventory.bombs = private.startingBombs
        private.localPlayer.inventory.ropes = private.startingRopes
        for _, powerup in pairs(itemPowerups) do
            ProcessStarterItem(powerup)
        end
    end, 1)
end

---@param state boolean
---@void Set to TRUE/FALSE to allow/prevent
function APGameState:SetGameState(state)
    private.gameIsLive = state
end

---@param slotData Spel2SlotData
---@void Populate would state data
function APGameState:InitializeMultiworld(slotData)
    InitializeGameSave()
    for _, entry in ipairs(journalEntries) do
        private.journal[entry] = private.journal[entry] or {} -- If it doesn't exist yet, initialize it.
        for index = 1, #savegame[entry] do
            savegame[entry][index] = false
            private.journal[entry][index] = false
        end
    end
    private.goal = slotData.goal
    if private.goal == Spel2Goal.CO then
        private.cosmicGoal = slotData.goalLevel
    end
    private.isIronman = slotData.ironmanMode
    self.APMeta:initialize(private.core, slotData.progressiveWorlds, slotData.shortcutMode, slotData.mustVisitWorld)
    private.increaseWallet = slotData.increaseWallet
    private.walletAmount = 0
    private.startingHealth = slotData.startingHealth
    private.startingBombs = slotData.startingBombs
    private.startingRopes = slotData.startingRopes
    private.requireJournal = slotData.journalEntryRequired
    private.availableCharacters = {}
    for _, value in ipairs(slotData.startingCharacters) do
        table.insert(private.availableCharacters, private.core.apItems.characters[value].savegameIndex)
    end
    private.lockedItems = {}
    for _, value in ipairs(slotData.lockedItems) do
        table.set(private.lockedItems, private.core.apItems.locked[value].ent)
    end
    private.starterUpgrades = {}
    for _, value in ipairs(slotData.itemUpgrades) do
        table.set(private.starterUpgrades, value)
    end
    private.waddlerUpgrades = {}
    for _, value in ipairs(slotData.waddlerUpgrades) do
        table.set(private.waddlerUpgrades, value)
    end
    if slotData.deathLink == true then
        private.core.apDeath:SetupDeathlink(slotData.bypassAnkh, slotData.grace, slotData.amnesty)
    end
    private.receivedItems = {}
    private.receivedIndex = -1
    LoadSavedData()
    self:SetGameState(true)
    CheckJournalState(true)
end

---@param items NetworkItem[] List of itemIDs received
---@void Handle and process items from multiworld
function APGameState:OnItemFromMultiworld(items)
    while #items > 0 do
        ---@type NetworkItem
        local item = table.remove(items, 1)
        if IsNotNull(private.receivedItems[item.index]) then
            goto continue -- We've already received this item.
        end
        local isFiller = false
        local itemData = private.core.apItems.filler[item.item]
        local givePowerup
        if IsNotNull(itemData) then
            isFiller = true
            goto queueItem
        end
        itemData = private.core.apItems.trap[item.item]
        if IsNotNull(itemData) then
            isFiller = true
            goto queueItem
        end
        itemData = private.core.apItems.powerups[item.item]
        if IsNotNull(itemData) then
            private.powerups[item.item] =
            {
                ent = itemData.ent,
                powerup = itemData.powerup,
                saveItem = itemData.saveItem,
                texture = itemData.display,
                frame = itemData.frame
            }
            givePowerup = itemData.saveItem
            goto queueItem
        end
        itemData = private.core.apItems.characters[item.item]
        if IsNotNull(itemData) then
            table.insert(private.availableCharacters, itemData.savegameIndex)
            goto queueItem
        end
        itemData = private.core.apItems.locked[item.item]
        if IsNotNull(itemData) then
            private.lockedItems[itemData.ent] = nil
            givePowerup = private.core.apItems.powerups[itemData.powerup].saveItem
            goto queueItem
        end
        itemData = private.core.apItems.stats[item.item]
        if IsNotNull(itemData) then
            APStats[item.item](private)
            goto queueItem
        end
        itemData = private.core.apItems.meta[item.item]
        if IsNotNull(itemData) then
            self.APMeta:ProcessItem(item.item, itemData)
            goto queueItem
        else
            DebugPrint(debugLevel.ITEM, f"Failed to find a match for itemID: {item.item}!!")
            goto continue
        end
        ::queueItem::
        if item.index > private.receivedIndex then
            private.receivedIndex = item.index
            private.receivedItems[item.index] = isFiller
            local receiver, _ = private.core.apNetwork:GetPlayer(item.player)
            QueueItem(itemData, isFiller, nil, receiver)
            if IsNotNull(givePowerup) then
                TryQueuePowerup(givePowerup)
            end
            SaveDataToFile()
        end
        ::continue::
    end
end

---@param location integer
---@void Send the location out into the multiworld
function APGameState:SendLocation(location)
    local locationData = private.core.apNetwork:GetLocationData(location)
    if IsNotNull(locationData) == false then
        DebugPrint(debugLevel.NETWORK, f"[SEND error] Trying to send unexpected locationID: {location} . Ceasing.")
        return true
    end
    local apClient = private.core.apNetwork:GetClient()
    if apClient == nil then
        return false
    end
    if apClient:LocationChecks({location}) == false then
        return false
    end
    private.core.apNetwork:OnLocationChecked({location})
    if IsNotNull(locationData.player) then
        ---@type APLocation
        local sentItem =
        {
            name = locationData.item,
            display = private.core.apItems.MultiworldItem[locationData.type],
            TileY = 0,
            TileX = 0,
            priority = private.core.apItems.priority.SENT
        }
        QueueItem(sentItem, false, locationData.player, nil)
    end
    return true
end

---The target Cosmic ocean level which can be adjusted by shortcuts from the multiworld
---@return integer
function APGameState:GetCosmicShortcutLevel()
    return private.coShortcutCount < 1 and 5 or private.coShortcutCount * 10
end

---@param entityID ENT_TYPE
---@return boolean
function APGameState:IsEntityLocked(entityID)
    if entityID == ENT_TYPE.ITEM_PURCHASABLE_HOVERPACK then
        entityID = ENT_TYPE.ITEM_HOVERPACK
    elseif entityID == ENT_TYPE.ITEM_PURCHASABLE_TELEPORTER_BACKPACK then
        entityID = ENT_TYPE.ITEM_TELEPORTER_BACKPACK
    elseif entityID == ENT_TYPE.ITEM_PURCHASABLE_POWERPACK then
        entityID = ENT_TYPE.ITEM_POWERPACK
    elseif entityID == ENT_TYPE.ITEM_PURCHASABLE_CAPE then
        entityID = ENT_TYPE.ITEM_CAPE
    elseif entityID == ENT_TYPE.ITEM_PURCHASABLE_JETPACK then
        entityID = ENT_TYPE.ITEM_JETPACK
    end
    return IsNotNull(private.lockedItems[entityID])
end

---@return integer Spel2Goal
function APGameState:GetAPGoal()
    return private.goal
end

---@return table
function APGameState:GetAvailableCharacters()
    return private.availableCharacters
end

---Any goal-state modifier checks such as ironman mode
---@return boolean
function APGameState:CanGoal()
    local state = get_local_state()
    return private.isIronman == false or state.world_start == 1
end

---Multiworld-state of the in-game journal , similar to savegame.people , savegame.places , etc.
---@return table
function APGameState:GetMWJournal()
    return private.journal
end

---@param ctx GuiDrawContext
---@void Hook up and handle in-game mod UI buttons/etc
function APGameState:MenuOptions(ctx)
    ctx:win_text("Time (in seconds) to display the\nSent/Received items will show for")
    private.popupTime = ctx:win_slider_int(" ##popupTime", private.popupTime, 0, 10)
    if ctx:win_button("Delete AP saves") then
        print("Saves purged")
        for _, file in pairs(list_data_dir(private.savePath)) do
            os.remove_data(file)
        end
    end
    ctx:win_inline()
    ctx:win_text("Deletes !ALL! archipelago saves.")
end

---Clears all internal state-flags of world generation pieces and npc quest lines,
---@param state StateMemory
function APGameState:DoWorldWrap(state)
    private.isWorldLooping = true
    local questReset = 0
    if test_flag(QUEST_FLAG.VAULT_SPAWNED, state.quest_flags) then
        questReset = set_flag(QUEST_FLAG.VAULT_SPAWNED, questReset)
    end
    if test_flag(QUEST_FLAG.SHORTCUT_USED, state.quest_flags) then
        questReset = set_flag(QUEST_FLAG.SHORTCUT_USED, questReset)
    end
    private.core.apUI:SetNextWorldAccess(true)
    state.quest_flags = questReset
    state.quests.yang_state = 0
    state.quests.jungle_sisters_flags = 0
    state.quests.van_horsing_state = 0
    state.quests.sparrow_state = 0
    state.quests.madame_tusk_state = 0
    state.quests.beg_state = 0
    state.kali_altars_destroyed = 0
    state.kali_gifts = 0
    state.world_next = state.world_start
    state.level_next = state.level_start
    state.theme_next = state.theme_start
end

---Return if we've 'world wrapped', if we went into a boss door that wasn't goal OR
---if we entered a world we don't have multiworld access to
---@boolean
function APGameState:DidWorldWrap()
    if private.isWorldLooping then
        private.isWorldLooping = false
        return true
    end
    return false
end

---@param core Core
function APGameState:initialize(core)
    local instance = setmetatable({}, APGameState)
    private.core = core
    for _, index in pairs(core.apItems.priority) do
        private.popupQueue[index] = {}
        private.fillerQueue[index] = {}
    end
    return instance
end

return APGameState
