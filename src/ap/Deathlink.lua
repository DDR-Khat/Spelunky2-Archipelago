---@class APDeathlink
local APDeathlink = {}

APDeathlink.__index = APDeathlink

---@class DeathlinkListing
---@field deaths integer # Observed count of deaths
---@field allowDeathlinks boolean

local META_DEATHS = {
    ["FALL"] = 10000,
    ["BOTTOMLESS"] = 10001,
    ["POISON"] = 10002,
    ["MISSED"] = 10003,
}

--- C#-like "private" variables. In a table so local functions don't shadow over them.
local private = {
---@type Core
    core = nil,
---@type integer # Minimum setting allowed for Grace/Amnesty
    minSetting = 0,
---@type integer # Arbitrary maximum setting allowed for Grace/Amnesty
    maxSetting = 10,
    deathLinkIsEnabled = false,
    bypassAnkh = false,
---@type integer # Amount of deaths from the multiworld before killing the player
    graceMax = 10,
---@type integer # Current count of deaths player has suffered
    graceCount = 0,
---@type integer # Amount of deaths the player(s) must suffer before sending a deathlink
    amnestyMax = 10,
---@type integer # Current count of deaths from the multiworld
    amnestyCount = 0,
---@type table<string, DeathlinkListing>
    playerDeaths = {},
---@type table # integer -> "Name"
    playerDeathLookup = {},
---@type integer # Currently selected index for dropdown menu
    blacklistIndex = 1,
---@type string # Prepared string for dropdown menu
    blacklistNames = "(None tracked)\0\0",
---@type integer # UNIX timestamp of last out-bound deathlink
    deathTime = 0,
---@type integer # callbackID of a received deathlink
    deathID = -1,
---@type Player # Local player entity
    localPlayer = nil,
}

local function TryKillPlayer()
    if private.deathID == -1 then
        return
    end
    if not IsInLevel() then
        return
    end
    if private.localPlayer == nil or private.localPlayer.uid == nil then
        return
    end
    if test_flag(private.localPlayer.flags, ENT_FLAG.DEAD) then
        return
    end
    if test_flag(private.localPlayer.flags, ENT_FLAG.PASSES_THROUGH_OBJECTS)
            or test_flag(private.localPlayer.flags, ENT_FLAG.PASSES_THROUGH_EVERYTHING) then
        return
    end
    if private.bypassAnkh and private.localPlayer:has_powerup(ENT_TYPE.ITEM_POWERUP_ANKH) then
        private.localPlayer:remove_powerup(ENT_TYPE.ITEM_POWERUP_ANKH)
    end
    local playerX, playerY, playerL = get_position(private.localPlayer.uid)
    private.localPlayer:kill(true, nil)
    spawn_entity(ENT_TYPE.FX_ALIENBLAST, playerX, playerY, playerL, 0, 0)
end

local deathLookup = {
    [META_DEATHS.POISON] = "failed to find an antidote in time",
    [META_DEATHS.FALL] = "didn't stick the landing",
    [META_DEATHS.BOTTOMLESS] = "is falling... still falling... STILL falling...",
    [META_DEATHS.MISSED] = "ran the numbers... but was bad at math, and ended up in the wall",
    [ENT_TYPE.MONS_GHOST] = "got too friendly with ghosts",
    [ENT_TYPE.MONS_MEGAJELLYFISH] = "became one with the celestial jellies",
    ["FLOOR_ALTAR"] = "offered themselves to blood mama",
    [ENT_TYPE.PLAYER] = "accidentally killed themselves with a %s"
}

local function GetDeathReason(killer, weapon)
    if killer == ENT_TYPE.PLAYER then
        return string.format(deathLookup[killer], weapon)
    end
    if deathLookup[killer] ~= nil then
        return deathLookup[killer]
    end
    return string.format("was killed by a %s (WIP message)", killer)
end

---@void Update the list of names presented in the dropdown for Blacklisting players
local function UpdateBlacklist()
    local nameTable = {}
    private.playerDeathLookup = {}
    for name, info in pairs(private.playerDeaths) do
        -- would f-string but this shuts IDE up.
        table.insert(nameTable, string.format("%s (%d) [%s]", name, info.deaths, info.allowDeathlinks and "✓" or "X"))
        table.insert(private.playerDeathLookup, name)
    end
    private.blacklistNames = table.concat(nameTable, "\0") .. "\0\0"
end

local function IsRemoteDeath()
    return private.deathID ~= -1
end

local function PrintSafetyMessage(count, cause)
    local isGraceMessage = IsNotNull(cause)
    local messageType = isGraceMessage and "Grace" or "Amnesty"
    local safety = (isGraceMessage and "protection")
            or (count > 1 and "live")
            or "life"
    local notice = (count < 1 and "Next is fatal")
            or (count > 1 and f"{count} {safety}s remain")
            or f"{count} {safety} remains"
    print(string.format(
            "[Deathlink] Prevented%s due to %s! %s",
            isGraceMessage and cause or "",
            messageType,
            notice))
end

local function ProcessDeathlink(cause, weapon)
    if private.amnestyCount < private.amnestyMax then
        private.amnestyCount = private.amnestyCount + 1
        local remaining = private.amnestyMax - private.amnestyCount
        PrintSafetyMessage(remaining)
        return
    end
    private.amnestyCount = 0
    local apClient = private.core.apNetwork:GetClient()
    if apClient == nil then
        print("[FATAL SendDeathlink] Apclient doesn't exist! (Disconnected?)")
        return
    end
    local deathCause = GetDeathReason(cause, weapon)
    private.deathTime = apClient:get_server_time()
    local deathData = {
        time = private.deathTime,
        source = private.core.apNetwork:GetLocalPlayer(),
        cause = string.format("%s %s", private.core.apNetwork:GetLocalPlayer(), deathCause)
    }
    apClient:Bounce(deathData, nil, nil, {"DeathLink"})
    print(f"[Deathlink] {deathData.cause}")
end

---@param player Player
---@void Handle deathlink callbacks/etc for player to send to multiworld
function APDeathlink:HookDeathToPlayer(player)
    private.localPlayer = player
    ---@param other Entity
    player:set_pre_on_collision2(function(_, other)
        if not private.deathLinkIsEnabled then
            return -- Check here IN CASE we change it on the fly. Rather than at spawn of entity
        end
        local isGhost = other.type.id == ENT_TYPE.MONS_GHOST
        local isJelly = other.type.id == ENT_TYPE.MONS_MEGAJELLYFISH
        if isGhost == false and isJelly == false then
            return -- Not a collision we care about.
        end
        if private.localPlayer:has_powerup(ENT_TYPE.ITEM_POWERUP_ANKH) then
            return -- Ankh saved us, don't deathlink
        end
        if private.localPlayer.exit_invincibility_timer > 0 then
            return -- Door exit timer prevents interacting with entities
        end
        if test_flag(private.localPlayer.flags, ENT_FLAG.PASSES_THROUGH_OBJECTS) then
            return -- We are currently passing through items.
        end
        ProcessDeathlink(isJelly and ENT_TYPE.MONS_MEGAJELLYFISH or ENT_TYPE.MONS_GHOST)
    end)
    ---@param culprit Entity
    player:set_pre_kill(function(_, _, culprit)
        if not private.deathLinkIsEnabled then
            return -- Check here IN CASE we change it on the fly. Rather than at spawn of entity
        end
        if IsRemoteDeath() then
            clear_callback(private.deathID)
            private.deathID = -1
            return -- Multiworld sent the death, don't do anything.
        end
        if test_flag(player.flags, ENT_FLAG.DEAD) then
            return -- If we are already dead, don't die again. (Shoutout to "Welowas" trying to clone puppies)
        end
        if player:has_powerup(ENT_TYPE.ITEM_POWERUP_ANKH) then
            return -- Ankh saved us, don't deathlink
        end
        -- Have to delay it a gameframe, so that cause of death is properly populated... :|
        set_global_timeout(function()
            local localState = get_local_state()
            local cogSacrifice = localState.logic.city_of_gold_ankh_sacrifice
            if IsNotNull(cogSacrifice) and cogSacrifice.timer > 0 then
                return -- Player is going into duat.
            end
            local causeOfDeath = localState.cause_of_death
            local deathReason
            local deathWeapon
            if IsNotNull(culprit) and culprit.uid == private.localPlayer.uid then
                deathReason = ENT_TYPE.PLAYER
                deathWeapon = enum_get_name(ENT_TYPE, localState.cause_of_death_entity_type)
            elseif causeOfDeath == CAUSE_OF_DEATH.ENTITY then
                deathReason = enum_get_name(ENT_TYPE, localState.cause_of_death_entity_type)
            elseif causeOfDeath == CAUSE_OF_DEATH.POISONED then
                deathReason = META_DEATHS.POISON
            elseif causeOfDeath == CAUSE_OF_DEATH.LONG_FALL then
                deathReason = META_DEATHS.FALL
            elseif causeOfDeath == CAUSE_OF_DEATH.MISSED then
                deathReason = META_DEATHS.MISSED
            elseif causeOfDeath == CAUSE_OF_DEATH.STILL_FALLING then
                deathReason = META_DEATHS.BOTTOMLESS
            end
            ProcessDeathlink(deathReason, deathWeapon) -- TODO: Finish figuring out the cause
        end, 1)
    end)
end

---@param packet table bounce packet with "Deathlink" tag
function APDeathlink:HandleDeathlink(packet)
    if private.deathLinkIsEnabled == false then
        return -- We shouldn't be ending up in here if it's off... but anyway.
    end

    local screen = get_local_state().screen
    if screen <= SCREEN.CAMP or screen >= SCREEN.WIN then
        return -- If we aren't actually in-game yet, we'll ignore the deathlink.
    end

    local dyingPlayer = packet.data.source
    if packet.data.time == nil then
        print(f"[Deathlink] Deathlink packet had no time data. {dyingPlayer}'s game needs the developer notifying")
    elseif private.deathTime == packet.data.time then
        return -- Have to assume it's OUR death based on time. Packets have no slot number, name can be lied about.
    end
    local reason = packet.data.cause or f"Received from {dyingPlayer}"
    ---@type DeathlinkListing
    local deathEntry = private.playerDeaths[dyingPlayer] or { deaths = 0, allowDeathlinks = true }
    deathEntry.deaths = deathEntry.deaths + 1
    private.playerDeaths[dyingPlayer] = deathEntry
    UpdateBlacklist()

    if deathEntry.allowDeathlinks ~= true then
        return
    end

    if private.graceCount < private.graceMax then
        private.graceCount = private.graceCount + 1
        local remaining = private.graceMax - private.graceCount
        PrintSafetyMessage(remaining, f" (from: {dyingPlayer})")
        return
    end
    private.graceCount = 0

    print(string.format("[Deathlink] %s", reason)) -- Shut up, IDE, 'reason' is used.

    if private.deathID ~= -1 then
        return
    end

    private.deathID = set_global_interval(function()
        TryKillPlayer()
    end, 1)
end

---@param state boolean
---@void Set deathlink handling state
function APDeathlink:SetDeathlinkState(state)
    private.deathLinkIsEnabled = state
    private.core.apNetwork:UpdateTags(state)
end

---@return boolean Current Deathlink state
function APDeathlink:GetDeathlinkState()
    return private.deathLinkIsEnabled
end

---@param bypassAnkh boolean
---@param grace integer Multiworld deaths before ACCEPTING deathlink
---@param amnesty integer Deaths before SENDING deathlink
---@void Populate deathlink-relevant data and enable state
function APDeathlink:SetupDeathlink(bypassAnkh, grace, amnesty)
    local wasEnabled = private.deathLinkIsEnabled
    private.deathLinkIsEnabled = true
    if not wasEnabled then
        private.core.apNetwork:UpdateTags(private.deathLinkIsEnabled)
    end
    private.bypassAnkh = bypassAnkh
    private.graceMax = grace
    private.amnestyMax = amnesty
end

---@param ctx GuiDrawContext
---@void Hook up and handle in-game mod UI buttons/etc
function APDeathlink:MenuOptions(ctx)
    local currentState = private.deathLinkIsEnabled
    private.deathLinkIsEnabled = ctx:win_check("Enable", private.deathLinkIsEnabled)

    if currentState ~= private.deathLinkIsEnabled and private.core.apNetwork:HasActiveClient() then
        private.core.apNetwork:UpdateTags(private.deathLinkIsEnabled)
    end

    if not private.deathLinkIsEnabled then
        return
    end

    private.amnestyMax = ctx:win_slider_int("Amnesty count", private.amnestyMax, private.minSetting, private.maxSetting)
    ctx:win_text("(How many deaths before YOU kill OTHER players)\n0 = EACH death")
    private.graceMax = ctx:win_slider_int("Grace count", private.graceMax, private.minSetting, private.maxSetting)
    ctx:win_text("(How many deaths FROM other players before it kills YOU)\n0 = EACH death")
    ctx:win_separator()
    ctx:win_text("Blacklist Controls (Optional ignoring of select players dying)")
    ctx:win_text("Tracked Players (# of Deaths) [Allowed/Disallowed]")
    ctx:win_width(0.50)
    private.blacklistIndex = ctx:win_combo("##playerNames", private.blacklistIndex, private.blacklistNames)
    local selectedBlacklist = private.playerDeaths[private.playerDeathLookup[private.blacklistIndex]]
    if selectedBlacklist == nil then
        return
    end
    local wasAllowed = selectedBlacklist.allowDeathlinks
    selectedBlacklist.allowDeathlinks = ctx:win_check("Allow deathlinks from this player", selectedBlacklist.allowDeathlinks)
    if selectedBlacklist.allowDeathlinks ~= wasAllowed then
        UpdateBlacklist()
    end
end

function APDeathlink:initialize(core)
    local instance = setmetatable({}, APDeathlink)
    private.core = core
    return instance
end

return APDeathlink