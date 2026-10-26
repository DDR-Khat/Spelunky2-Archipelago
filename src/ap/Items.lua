---@class APItem
---@field priority Table
---@field filler Table
---@field characters Table
---@field powerups Table
---@field locked Table
---@field stats Table
---@field meta Table
---@field trap Table
---@field type Table
---@field trapOffset int
---@field MultiworldItem Table

---@class MultiItem
---@field name string
---@field ent Entity
---@field value int
---@field display int
---@field TileY int
---@field TileX int
---@field priority int
---@field receiver string
---@field sender string

---@return TEXTURE Create and return a custom texture for rendering in AP pop-up graphic
local function makeTexture(path, width, height)
    local definition = TextureDefinition.new()
    definition.texture_path = path
    definition.width = width
    definition.height = height
    definition.tile_width = width
    definition.tile_height = height
    local define = define_texture(definition)
    if define == nil then
        print("Failed to define texture: " .. path)
    else
        return define
    end
end

local APItems = {}

APItems.trapOffset = 10000

APItems.type = {
    FILLER = 0,
    PROGRESSION = 1,
    HELPFUL = 2,
    HELPFUL_PROGRESSION = 3,
    TRAP = 4
}

APItems.MultiworldItem = {
    [APItems.type.FILLER] = makeTexture("assets/filler.png", 128, 128),
    [APItems.type.HELPFUL] = makeTexture("assets/helpful.png", 128, 128),
    [APItems.type.PROGRESSION] = makeTexture("assets/progression.png", 128, 128),
    [APItems.type.HELPFUL_PROGRESSION] = makeTexture("assets/progressionhelpful.png", 128, 128),
    [APItems.type.TRAP] = makeTexture("assets/trap.png", 128, 128)
}

APItems.priority = {
    WORLD = 10,
    SHORTCUT = 9,
    UNLOCKS = 8,
    UPGRADES = 7,
    STATS = 6,
    TRAP = 5,
    FILLER_HIGH = 4,
    FILLER_MED = 3,
    FILLER_LOW = 2,
    CHARACTER = 1,
    SENT = 0
}

APItems.filler = {
    [Spel2AP.filler_items.Rope_Pile] = {
        name = "Rope Pile",
        ent = ENT_TYPE.ITEM_PICKUP_ROPEPILE,
        value = 0,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 0,
        saveItem = 1,
        priority = APItems.priority.FILLER_MED
    },
    [Spel2AP.filler_items.Bomb_Bag] = {
        name = "Bomb Bag",
        ent = ENT_TYPE.ITEM_PICKUP_BOMBBAG,
        value = 0,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 1,
        saveItem = 2,
        priority = APItems.priority.FILLER_MED
    },
    [Spel2AP.filler_items.Bomb_Box] = {
        name = "Bomb Box",
        ent = ENT_TYPE.ITEM_PICKUP_BOMBBOX,
        value = 0,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 2,
        saveItem = 3,
        priority = APItems.priority.FILLER_HIGH
    },
    [Spel2AP.filler_items.Cooked_Turkey] = {
        name = "Cooked Turkey",
        ent = ENT_TYPE.ITEM_PICKUP_COOKEDTURKEY,
        value = 0,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 5,
        saveItem = 52,
        priority = APItems.priority.FILLER_LOW
    },
    [Spel2AP.filler_items.Royal_Jelly] = {
        name = "Royal Jelly",
        ent = ENT_TYPE.ITEM_PICKUP_ROYALJELLY,
        value = 0,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 6,
        saveItem = 22,
        priority = APItems.priority.FILLER_HIGH
    },
    [Spel2AP.filler_items.Gold_Bar] = {
        name = "Gold Bar",
        ent = ENT_TYPE.ITEM_GOLDBAR,
        value = 500,
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 8,
        TileX = 12,
        priority = APItems.priority.FILLER_LOW
    },
    [Spel2AP.filler_items.Emerald_Gem] = {
        name = "Emerald",
        ent = ENT_TYPE.ITEM_EMERALD,
        value = 800,
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 0,
        TileX = 3,
        priority = APItems.priority.FILLER_LOW
    },
    [Spel2AP.filler_items.Sapphire_Gem] = {
        name = "Sapphire",
        ent = ENT_TYPE.ITEM_SAPPHIRE,
        value = 1200,
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 0,
        TileX = 4,
        priority = APItems.priority.FILLER_LOW
    },
    [Spel2AP.filler_items.Ruby_Gem] = {
        name = "Ruby",
        ent = ENT_TYPE.ITEM_RUBY,
        value = 1600,
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 0,
        TileX = 5,
        priority = APItems.priority.FILLER_LOW
    },
    [Spel2AP.filler_items.Diamond_Gem] = {
        name = "Diamond",
        ent = ENT_TYPE.ITEM_DIAMOND,
        value = 5000,
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 0,
        TileX = 6,
        priority = APItems.priority.FILLER_HIGH
    },
}

APItems.characters = {
    [Spel2AP.characters.Ana_Spelunky] = {
        name = get_character_name(ENT_TYPE.CHAR_ANA_SPELUNKY),
        savegameIndex = 1,
        display = TEXTURE.DATA_TEXTURES_CHAR_YELLOW_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Margaret_Tunnel] = {
        name = get_character_name(ENT_TYPE.CHAR_MARGARET_TUNNEL),
        savegameIndex = 2,
        display = TEXTURE.DATA_TEXTURES_CHAR_MAGENTA_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Colin_Northward] = {
        name = get_character_name(ENT_TYPE.CHAR_COLIN_NORTHWARD),
        savegameIndex = 3,
        display = TEXTURE.DATA_TEXTURES_CHAR_CYAN_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Roffy_D_Sloth] = {
        name = get_character_name(ENT_TYPE.CHAR_ROFFY_D_SLOTH),
        savegameIndex = 4,
        display = TEXTURE.DATA_TEXTURES_CHAR_BLACK_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Alto_Singh] = {
        name = get_character_name(ENT_TYPE.CHAR_BANDA),
        savegameIndex = 5,
        display = TEXTURE.DATA_TEXTURES_CHAR_CINNABAR_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Liz_Mutton] = {
        name = get_character_name(ENT_TYPE.CHAR_GREEN_GIRL),
        savegameIndex = 6,
        display = TEXTURE.DATA_TEXTURES_CHAR_GREEN_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Nekka_The_Eagle] = {
        name = get_character_name(ENT_TYPE.CHAR_AMAZON),
        savegameIndex = 7,
        display = TEXTURE.DATA_TEXTURES_CHAR_OLIVE_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.LISE_Project] = {
        name = get_character_name(ENT_TYPE.CHAR_LISE_SYSTEM),
        savegameIndex = 8,
        display = TEXTURE.DATA_TEXTURES_CHAR_WHITE_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Coco_Von_Diamonds] = {
        name = get_character_name(ENT_TYPE.CHAR_COCO_VON_DIAMONDS),
        savegameIndex = 9,
        display = TEXTURE.DATA_TEXTURES_CHAR_CERULEAN_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Manfred_Tunnel] = {
        name = get_character_name(ENT_TYPE.CHAR_MANFRED_TUNNEL),
        savegameIndex = 10,
        display = TEXTURE.DATA_TEXTURES_CHAR_BLUE_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Little_Jay] = {
        name = get_character_name(ENT_TYPE.CHAR_OTAKU),
        savegameIndex = 11,
        display = TEXTURE.DATA_TEXTURES_CHAR_LIME_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Tina_Flan] = {
        name = get_character_name(ENT_TYPE.CHAR_TINA_FLAN),
        savegameIndex = 12,
        display = TEXTURE.DATA_TEXTURES_CHAR_LEMON_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Valerie_Crump] = {
        name = get_character_name(ENT_TYPE.CHAR_VALERIE_CRUMP),
        savegameIndex = 13,
        display = TEXTURE.DATA_TEXTURES_CHAR_IRIS_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Au] = {
        name = get_character_name(ENT_TYPE.CHAR_AU),
        savegameIndex = 14,
        display = TEXTURE.DATA_TEXTURES_CHAR_GOLD_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Demi_Von_Diamonds] = {
        name = get_character_name(ENT_TYPE.CHAR_DEMI_VON_DIAMONDS),
        savegameIndex = 15,
        display = TEXTURE.DATA_TEXTURES_CHAR_RED_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Pilot] = {
        name = get_character_name(ENT_TYPE.CHAR_PILOT),
        savegameIndex = 16,
        display = TEXTURE.DATA_TEXTURES_CHAR_PINK_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Princess_Airyn] = {
        name = get_character_name(ENT_TYPE.CHAR_PRINCESS_AIRYN),
        savegameIndex = 17,
        display = TEXTURE.DATA_TEXTURES_CHAR_VIOLET_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Dirk_Yamaoka] = {
        name = get_character_name(ENT_TYPE.CHAR_DIRK_YAMAOKA),
        savegameIndex = 18,
        display = TEXTURE.DATA_TEXTURES_CHAR_GRAY_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Guy_Spelunky] = {
        name = get_character_name(ENT_TYPE.CHAR_GUY_SPELUNKY),
        savegameIndex = 19,
        display = TEXTURE.DATA_TEXTURES_CHAR_KHAKI_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
    [Spel2AP.characters.Classic_Guy] = {
        name = get_character_name(ENT_TYPE.CHAR_CLASSIC_GUY),
        savegameIndex = 20,
        display = TEXTURE.DATA_TEXTURES_CHAR_ORANGE_0,
        TileY = 0,
        TileX = 0,
        priority = APItems.priority.CHARACTER
    },
}

APItems.powerups = {
    [Spel2AP.upgrades.Alien_Compass] = {
        name = "Alien Compass Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_COMPASS,
        powerup = ENT_TYPE.ITEM_POWERUP_SPECIALCOMPASS,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 8,
        frame = 48,
        saveItem = 11,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Ankh] = {
        name = "Ankh Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_ANKH,
        powerup = ENT_TYPE.ITEM_POWERUP_ANKH,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 5,
        frame = 15,
        saveItem = 19,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Arrow_Of_Light] = {
        name = "Arrow of Light Upgrade",
        ent = ENT_TYPE.ITEM_LIGHT_ARROW,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 5,
        TileX = 1,
        frame = 51,
        saveItem = 44,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Camera] = {
        name = "Camera Upgrade",
        ent = ENT_TYPE.ITEM_CAMERA,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 4,
        frame = 24,
        saveItem = 34,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Cape] = {
        name = "Cape Upgrade",
        ent = ENT_TYPE.ITEM_CAPE,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 7,
        frame = 17,
        saveItem = 23,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Climbing_Gloves] = {
        name = "Climbing Gloves Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES,
        powerup = ENT_TYPE.ITEM_POWERUP_CLIMBING_GLOVES,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 5,
        frame = 5,
        saveItem = 6,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Clone_Gun] = {
        name = "Clone Gun Upgrade",
        ent = ENT_TYPE.ITEM_CLONEGUN,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 7,
        frame = 37,
        saveItem = 32,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Compass] = {
        name = "Compass Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_COMPASS,
        powerup = ENT_TYPE.ITEM_POWERUP_COMPASS,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 9,
        frame = 9,
        saveItem = 10,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Crown] = {
        name = "Crown Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_CROWN,
        powerup = ENT_TYPE.ITEM_POWERUP_CROWN,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 4,
        frame = 14,
        saveItem = 16,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Eggplant] = {
        name = "Eggplant Upgrade",
        ent = ENT_TYPE.ITEM_EGGPLANT,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 4,
        frame = 34,
        saveItem = 51,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Eggplant_Crown] = {
        name = "Eggplant Crown Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_EGGPLANTCROWN,
        powerup = ENT_TYPE.ITEM_POWERUP_EGGPLANTCROWN,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 5,
        TileX = 3,
        frame = 53,
        saveItem = 17,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Elixir] = {
        name = "Elixir Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_ELIXIR,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 6,
        frame = 46,
        saveItem = 53,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Excalibur] = {
        name = "Excalibur Upgrade",
        ent = ENT_TYPE.ITEM_EXCALIBUR,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileX = 2,
        TileY = 10,
        frame = 162,
        saveItem = 39,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Four_Leaf_Clover] = {
        name = "Four-Leaf Clover Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_CLOVER,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 2,
        frame = 42,
        saveItem = 54,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Freeze_Ray] = {
        name = "Freeze Ray Upgrade",
        ent = ENT_TYPE.ITEM_FREEZERAY,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 2,
        frame = 22,
        saveItem = 31,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Hedjet] = {
        name = "Hedjet Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_HEDJET,
        powerup = ENT_TYPE.ITEM_POWERUP_HEDJET,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 3,
        frame = 13,
        saveItem = 15,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Hoverpack] = {
        name = "Hoverpack Upgrade",
        ent = ENT_TYPE.ITEM_HOVERPACK,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 6,
        frame = 36,
        saveItem = 27,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Hou_Yis_Bow] = {
        name = "Hou Yi's Bow Upgrade",
        ent = ENT_TYPE.ITEM_HOUYIBOW,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 5,
        TileX = 0,
        frame = 50,
        saveItem = 43,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Jetpack] = {
        name = "Jetpack Upgrade",
        ent = ENT_TYPE.ITEM_JETPACK,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 8,
        frame = 18,
        saveItem = 25,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Kapala] = {
        name = "Kapala Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_KAPALA,
        powerup = ENT_TYPE.ITEM_POWERUP_KAPALA,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 2,
        frame = 12,
        saveItem = 14,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Machete] = {
        name = "Machete Upgrade",
        ent = ENT_TYPE.ITEM_MACHETE,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 8,
        frame = 28,
        saveItem = 38,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Mattock] = {
        name = "Mattock Upgrade",
        ent = ENT_TYPE.ITEM_MATTOCK,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 6,
        frame = 26,
        saveItem = 36,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Paste] = {
        name = "Paste Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_PASTE,
        powerup = ENT_TYPE.ITEM_POWERUP_PASTE,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 3,
        frame = 3,
        saveItem = 4,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Pitchers_Mitt] = {
        name = "Pitcher's Mitt Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_PITCHERSMITT,
        powerup = ENT_TYPE.ITEM_POWERUP_PITCHERSMITT,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 6,
        frame = 6,
        saveItem = 7,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Plasma_Cannon] = {
        name = "Plasma Cannon Upgrade",
        ent = ENT_TYPE.ITEM_PLASMACANNON,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 0,
        frame = 30,
        saveItem = 41,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Powerpack] = {
        name = "Powerpack Upgrade",
        ent = ENT_TYPE.ITEM_POWERPACK,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 4,
        frame = 44,
        saveItem = 28,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Scepter] = {
        name = "Scepter Upgrade",
        ent = ENT_TYPE.ITEM_SCEPTER,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 1,
        frame = 31,
        saveItem = 42,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Shield] = {
        name = "Shield Upgrade",
        ent = ENT_TYPE.ITEM_METAL_SHIELD,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 1,
        frame = 41,
        saveItem = 46,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Skeleton_Key] = {
        name = "Skeleton Key Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_SKELETON_KEY,
        powerup = ENT_TYPE.ITEM_POWERUP_SKELETON_KEY,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 8,
        frame = 38,
        saveItem = 21,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Spectacles] = {
        name = "Spectacles Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_SPECTACLES,
        powerup = ENT_TYPE.ITEM_POWERUP_SPECTACLES,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 4,
        frame = 4,
        saveItem = 5,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Spike_Shoes] = {
        name = "Spike Shoes Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_SPIKESHOES,
        powerup = ENT_TYPE.ITEM_POWERUP_SPIKE_SHOES,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 8,
        frame = 8,
        saveItem = 9,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Spring_Shoes] = {
        name = "Spring Shoes Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_SPRINGSHOES,
        powerup = ENT_TYPE.ITEM_POWERUP_SPRING_SHOES,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 7,
        frame = 7,
        saveItem = 8,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Tablet_Of_Destiny] = {
        name = "Tablet of Destiny Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_TABLETOFDESTINY,
        powerup = ENT_TYPE.ITEM_POWERUP_TABLETOFDESTINY,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 9,
        frame = 39,
        saveItem = 20,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Telepack] = {
        name = "Telepack Upgrade",
        ent = ENT_TYPE.ITEM_TELEPORTER_BACKPACK,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 9,
        frame = 19,
        saveItem = 26,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Teleporter] = {
        name = "Teleporter Upgrade",
        ent = ENT_TYPE.ITEM_TELEPORTER,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 5,
        frame = 25,
        saveItem = 35,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.True_Crown] = {
        name = "True Crown Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_TRUECROWN,
        powerup = ENT_TYPE.ITEM_POWERUP_TRUECROWN,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 3,
        frame = 43,
        saveItem = 18,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Udjat_Eye] = {
        name = "Udjat Eye Upgrade",
        ent = ENT_TYPE.ITEM_PICKUP_UDJATEYE,
        powerup = ENT_TYPE.ITEM_POWERUP_UDJATEYE,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 1,
        frame = 11,
        saveItem = 13,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Ushabti] = {
        name = "Ushabti Upgrade",
        ent = ENT_TYPE.ITEM_USHABTI,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 3,
        frame = 33,
        saveItem = 50,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Vlads_Cape] = {
        name = "Vlad's Cape Upgrade",
        ent = ENT_TYPE.ITEM_VLADS_CAPE,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 5,
        frame = 45,
        saveItem = 24,
        priority = APItems.priority.UPGRADES
    },
    [Spel2AP.upgrades.Webgun] = {
        name = "Webgun Upgrade",
        ent = ENT_TYPE.ITEM_WEBGUN,
        powerup = nil,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 0,
        frame = 20,
        saveItem = 29,
        priority = APItems.priority.UPGRADES
    },
}

APItems.locked = {
    [Spel2AP.locked_items.Alien_Compass] = {
        name = "Alien Compass Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_SPECIALCOMPASS,
        powerup = Spel2AP.upgrades.Alien_Compass,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 8,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Ankh] = {
        name = "Ankh Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_ANKH,
        powerup = Spel2AP.upgrades.Ankh,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 5,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Arrow_Of_Light] = {
        name = "Arrow of Light Unlocked",
        ent = ENT_TYPE.ITEM_LIGHT_ARROW,
        powerup = Spel2AP.upgrades.Arrow_Of_Light,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 5,
        TileX = 1,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Camera] = {
        name = "Camera Unlocked",
        ent = ENT_TYPE.ITEM_CAMERA,
        powerup = Spel2AP.upgrades.Camera,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 4,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Cape] = {
        name = "Cape Unlocked",
        ent = ENT_TYPE.ITEM_CAPE,
        powerup = Spel2AP.upgrades.Cape,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 7,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Climbing_Gloves] = {
        name = "Climbing Gloves Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES,
        powerup = Spel2AP.upgrades.Climbing_Gloves,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 5,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Clone_Gun] = {
        name = "Clone Gun Unlocked",
        ent = ENT_TYPE.ITEM_CLONEGUN,
        powerup = Spel2AP.upgrades.Clone_Gun,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 7,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Compass] = {
        name = "Compass Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_COMPASS,
        powerup = Spel2AP.upgrades.Compass,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 9,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Crown] = {
        name = "Crown Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_CROWN,
        powerup = Spel2AP.upgrades.Crown,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 4,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Eggplant] = {
        name = "Eggplant Unlocked",
        ent = ENT_TYPE.ITEM_EGGPLANT,
        powerup = Spel2AP.upgrades.Eggplant,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 4,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Eggplant_Crown] = {
        name = "Eggplant Crown Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_EGGPLANTCROWN,
        powerup = Spel2AP.upgrades.Eggplant_Crown,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 5,
        TileX = 3,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Elixir] = {
        name = "Elixir Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_ELIXIR,
        powerup = Spel2AP.upgrades.Elixir,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 6,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Excalibur] = {
        name = "Excalibur Unlocked",
        ent = ENT_TYPE.ITEM_EXCALIBUR,
        powerup = Spel2AP.upgrades.Excalibur,
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileX = 2,
        TileY = 10,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Four_Leaf_Clover] = {
        name = "Four-Leaf Clover Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_CLOVER,
        powerup = Spel2AP.upgrades.Four_Leaf_Clover,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 2,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Freeze_Ray] = {
        name = "Freeze Ray Unlocked",
        ent = ENT_TYPE.ITEM_FREEZERAY,
        powerup = Spel2AP.upgrades.Freeze_Ray,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 2,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Hedjet] = {
        name = "Hedjet Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_HEDJET,
        powerup = Spel2AP.upgrades.Hedjet,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 3,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Hoverpack] = {
        name = "Hoverpack Unlocked",
        ent = ENT_TYPE.ITEM_HOVERPACK,
        powerup = Spel2AP.upgrades.Hoverpack,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 6,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Hou_Yis_Bow] = {
        name = "Hou Yi's Bow Unlocked",
        ent = ENT_TYPE.ITEM_HOUYIBOW,
        powerup = Spel2AP.upgrades.Hou_Yis_Bow,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 5,
        TileX = 0,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Jetpack] = {
        name = "Jetpack Unlocked",
        ent = ENT_TYPE.ITEM_JETPACK,
        powerup = Spel2AP.upgrades.Jetpack,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 8,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Kapala] = {
        name = "Kapala Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_KAPALA,
        powerup = Spel2AP.upgrades.Kapala,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 2,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Machete] = {
        name = "Machete Unlocked",
        ent = ENT_TYPE.ITEM_MACHETE,
        powerup = Spel2AP.upgrades.Machete,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 8,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Mattock] = {
        name = "Mattock Unlocked",
        ent = ENT_TYPE.ITEM_MATTOCK,
        powerup = Spel2AP.upgrades.Mattock,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 6,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Paste] = {
        name = "Paste Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_PASTE,
        powerup = Spel2AP.upgrades.Paste,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 3,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Pitchers_Mitt] = {
        name = "Pitcher's Mitt Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_PITCHERSMITT,
        powerup = Spel2AP.upgrades.Pitchers_Mitt,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 6,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Plasma_Cannon] = {
        name = "Plasma Cannon Unlocked",
        ent = ENT_TYPE.ITEM_PLASMACANNON,
        powerup = Spel2AP.upgrades.Plasma_Cannon,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 0,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Powerpack] = {
        name = "Powerpack Unlocked",
        ent = ENT_TYPE.ITEM_POWERPACK,
        powerup = Spel2AP.upgrades.Powerpack,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 4,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Scepter] = {
        name = "Scepter Unlocked",
        ent = ENT_TYPE.ITEM_SCEPTER,
        powerup = Spel2AP.upgrades.Scepter,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 1,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Shield] = {
        name = "Shield Unlocked",
        ent = ENT_TYPE.ITEM_METAL_SHIELD,
        powerup = Spel2AP.upgrades.Shield,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 1,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Skeleton_Key] = {
        name = "Skeleton Key Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_SKELETON_KEY,
        powerup = Spel2AP.upgrades.Skeleton_Key,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 8,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Spectacles] = {
        name = "Spectacles Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_SPECTACLES,
        powerup = Spel2AP.upgrades.Spectacles,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 4,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Spike_Shoes] = {
        name = "Spike Shoes Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_SPIKESHOES,
        powerup = Spel2AP.upgrades.Spike_Shoes,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 8,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Spring_Shoes] = {
        name = "Spring Shoes Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_SPRINGSHOES,
        powerup = Spel2AP.upgrades.Spike_Shoes,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 7,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Tablet_Of_Destiny] = {
        name = "Tablet of Destiny Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_TABLETOFDESTINY,
        powerup = Spel2AP.upgrades.Tablet_Of_Destiny,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 9,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Telepack] = {
        name = "Telepack Unlocked",
        ent = ENT_TYPE.ITEM_TELEPORTER_BACKPACK,
        powerup = Spel2AP.upgrades.Telepack,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 9,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Teleporter] = {
        name = "Teleporter Unlocked",
        ent = ENT_TYPE.ITEM_TELEPORTER,
        powerup = Spel2AP.upgrades.Teleporter,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 5,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.True_Crown] = {
        name = "True Crown Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_TRUECROWN,
        powerup = Spel2AP.upgrades.True_Crown,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 3,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Udjat_Eye] = {
        name = "Udjat Eye Unlocked",
        ent = ENT_TYPE.ITEM_PICKUP_UDJATEYE,
        powerup = Spel2AP.upgrades.Udjat_Eye,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 1,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Ushabti] = {
        name = "Ushabti Unlocked",
        ent = ENT_TYPE.ITEM_USHABTI,
        powerup = Spel2AP.upgrades.Ushabti,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 3,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Vlads_Cape] = {
        name = "Vlad's Cape Unlocked",
        ent = ENT_TYPE.ITEM_VLADS_CAPE,
        powerup = Spel2AP.upgrades.Vlads_Cape,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 5,
        priority = APItems.priority.UNLOCKS
    },
    [Spel2AP.locked_items.Webgun] = {
        name = "Webgun Unlocked",
        ent = ENT_TYPE.ITEM_WEBGUN,
        powerup = Spel2AP.upgrades.Webgun,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 0,
        priority = APItems.priority.UNLOCKS
    },
}

APItems.stats = {
    [Spel2AP.permanent_upgrades.Health] = {
        name = "Health Upgrade",
        display = TEXTURE.DATA_TEXTURES_FX_SMALL_0,
        TileY = 7,
        TileX = 7,
        priority = APItems.priority.STATS
    },
    [Spel2AP.permanent_upgrades.Bomb] = {
        name = "Bomb Upgrade",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 5,
        TileX = 0,
        priority = APItems.priority.STATS
    },
    [Spel2AP.permanent_upgrades.Rope] = {
        name = "Rope Upgrade",
        display = TEXTURE.DATA_TEXTURES_CHAR_YELLOW_0,
        TileY = 12,
        TileX = 4,
        priority = APItems.priority.STATS
    },
    [Spel2AP.permanent_upgrades.CO_Checkpoint] = {
        name = "Cosmic Ocean Checkpoint",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_BG_0,
        TileX = 1,
        TileY = 2,
        priority = APItems.priority.STATS
    }
}

APItems.meta = {
    [Spel2AP.world_unlocks.Progressive] = {
        name = "Progressive World Unlocked",
        display = TEXTURE.DATA_TEXTURES_FX_SMALL3_0,
        TileY = 6,
        TileX = 6,
        priority = APItems.priority.WORLD
    },
    [Spel2AP.world_unlocks.Jungle] = {
        name = "Jungle Unlocked",
        display = TEXTURE.DATA_TEXTURES_FLOOR_JUNGLE_0,
        world = THEME.JUNGLE,
        TileY = 2,
        TileX = 10,
        priority = APItems.priority.WORLD
    },
    [Spel2AP.world_unlocks.Volcana] = {
        name = "Volcana Unlocked",
        display = TEXTURE.DATA_TEXTURES_FLOOR_VOLCANO_0,
        world = THEME.VOLCANA,
        TileY = 6,
        TileX = 3,
        priority = APItems.priority.WORLD
    },
    [Spel2AP.world_unlocks.Olmecs_Lair] = {
        name = "Olmec's Lair Unlocked",
        display = TEXTURE.DATA_TEXTURES_FLOORSTYLED_STONE_2,
        world = THEME.OLMEC,
        TileY = 1,
        TileX = 7,
        priority = APItems.priority.WORLD
    },
    [Spel2AP.world_unlocks.Tide_Pool] = {
        name = "Tide Pool Unlocked",
        display = TEXTURE.DATA_TEXTURES_FLOOR_TIDEPOOL_0,
        world = THEME.TIDE_POOL,
        TileY = 0,
        TileX = 2,
        priority = APItems.priority.WORLD
    },
    [Spel2AP.world_unlocks.Temple] = {
        name = "Temple Unlocked",
        display = TEXTURE.DATA_TEXTURES_FLOOR_TEMPLE_0,
        world = THEME.TEMPLE,
        TileY = 0,
        TileX = 7,
        priority = APItems.priority.WORLD
    },
    [Spel2AP.world_unlocks.Ice_Caves] = {
        name = "Ice Caves Unlocked",
        display = TEXTURE.DATA_TEXTURES_FLOOR_ICE_0,
        world = THEME.ICE_CAVES,
        TileY = 1,
        TileX = 7,
        priority = APItems.priority.WORLD
    },
    [Spel2AP.world_unlocks.Neo_Babylon] = {
        name = "Neo Babylon Unlocked",
        display = TEXTURE.DATA_TEXTURES_FLOORSTYLED_BABYLON_0,
        world = THEME.NEO_BABYLON,
        TileY = 2,
        TileX = 7,
        priority = APItems.priority.WORLD
    },
    [Spel2AP.world_unlocks.Sunken_City] = {
        name = "Sunken City Unlocked",
        display = TEXTURE.DATA_TEXTURES_FLOOR_SUNKEN_0,
        world = THEME.SUNKEN_CITY,
        TileY = 5,
        TileX = 2,
        priority = APItems.priority.WORLD
    },
    [Spel2AP.world_unlocks.Cosmic_Ocean] = {
        name = "Cosmic Ocean Unlocked",
        display = TEXTURE.DATA_TEXTURES_FX_BIG_0,
        world = THEME.COSMIC_OCEAN,
        TileX = 2,
        TileY = 2,
        priority = APItems.priority.WORLD
    },
    [Spel2AP.shortcuts.Progressive] = {
        name = "Progressive Shortcut",
        display = TEXTURE.DATA_TEXTURES_FX_SMALL2_0,
        TileX = 2,
        TileY = 7,
        priority = APItems.priority.SHORTCUT
    },
    [Spel2AP.shortcuts.Jungle] = {
        name = "Jungle Shortcut",
        display = TEXTURE.DATA_TEXTURES_FLOOR_JUNGLE_2,
        shortcut = THEME.JUNGLE,
        TileX = 0,
        TileY = 0,
        priority = APItems.priority.SHORTCUT
    },
    [Spel2AP.shortcuts.Volcana] = {
        name = "Volcana Shortcut",
        display = TEXTURE.DATA_TEXTURES_FLOOR_VOLCANO_3,
        shortcut = THEME.VOLCANA,
        TileX = 0,
        TileY = 0,
        priority = APItems.priority.SHORTCUT
    },
    [Spel2AP.shortcuts.Olmecs_Lair] = {
        name = "Olmec's Lair Shortcut",
        display = TEXTURE.DATA_TEXTURES_FLOORSTYLED_STONE_2,
        shortcut = THEME.OLMEC,
        TileY = 1,
        TileX = 7,
        priority = APItems.priority.SHORTCUT
    },
    [Spel2AP.shortcuts.Tide_Pool] = {
        name = "Tide Pool Shortcut",
        display = TEXTURE.DATA_TEXTURES_FLOOR_TIDEPOOL_4,
        shortcut = THEME.TIDE_POOL,
        TileX = 0,
        TileY = 0,
        priority = APItems.priority.SHORTCUT
    },
    [Spel2AP.shortcuts.Temple] = {
        name = "Temple Shortcut",
        display = TEXTURE.DATA_TEXTURES_FLOOR_TEMPLE_2,
        shortcut = THEME.TEMPLE,
        TileX = 0,
        TileY = 0,
        priority = APItems.priority.SHORTCUT
    },
    [Spel2AP.shortcuts.Ice_Caves] = {
        name = "Ice Caves Shortcut",
        display = TEXTURE.DATA_TEXTURES_FLOOR_ICE_2,
        shortcut = THEME.ICE_CAVES,
        TileX = 0,
        TileY = 0,
        priority = APItems.priority.SHORTCUT
    },
    [Spel2AP.shortcuts.Neo_Babylon] = {
        name = "Neo Babylon Shortcut",
        display = TEXTURE.DATA_TEXTURES_FLOOR_EGGPLANT_3,
        shortcut = THEME.NEO_BABYLON,
        TileX = 0,
        TileY = 0,
        priority = APItems.priority.SHORTCUT
    },
    [Spel2AP.shortcuts.Sunken_City] = {
        name = "Sunken City Shortcut",
        display = TEXTURE.DATA_TEXTURES_FLOOR_SUNKEN_4,
        shortcut = THEME.SUNKEN_CITY,
        TileX = 0,
        TileY = 0,
        priority = APItems.priority.SHORTCUT
    }
}

APItems.trap = {
    [Spel2AP.traps.Poison] = {
        name = "Poison Trap",
        ent = APItems.trapOffset + Spel2AP.traps.Poison,
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 14,
        TileX = 3,
        priority = APItems.priority.TRAP
    },
    [Spel2AP.traps.Curse] = {
        name = "Curse Trap",
        ent = APItems.trapOffset + Spel2AP.traps.Curse,
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 15,
        TileX = 4,
        priority = APItems.priority.TRAP
    },
    [Spel2AP.traps.Ghost] = {
        name = "Ghost Trap",
        ent = APItems.trapOffset + Spel2AP.traps.Ghost,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_PEOPLE_0,
        TileY = 3,
        TileX = 3,
        priority = APItems.priority.TRAP
    },
    [Spel2AP.traps.Stun] = {
        name = "Stun Trap",
        ent = APItems.trapOffset + Spel2AP.traps.Stun,
        display = TEXTURE.DATA_TEXTURES_CHAR_YELLOW_0,
        TileY = 13,
        TileX = 4,
        priority = APItems.priority.TRAP
    },
    [Spel2AP.traps.Loose_Bombs] = {
        name = "Loose Bombs Trap",
        ent = APItems.trapOffset + Spel2AP.traps.Loose_Bombs,
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 6,
        TileX = 2,
        priority = APItems.priority.TRAP
    },
    [Spel2AP.traps.Blindness] = {
        name = "Blindness Trap",
        ent = APItems.trapOffset + Spel2AP.traps.Blindness,
        display = TEXTURE.DATA_TEXTURES_FX_SMALL3_0,
        TileY = 6,
        TileX = 0,
        priority = APItems.priority.TRAP
    },
    [Spel2AP.traps.Amnesia] = {
        name = "Amnesia Trap",
        ent = APItems.trapOffset + Spel2AP.traps.Amnesia,
        display = TEXTURE.DATA_TEXTURES_FX_SMALL_0,
        TileY = 3,
        TileX = 3,
        priority = APItems.priority.TRAP
    },
    [Spel2AP.traps.Angry_Shopkeepers] = {
        name = "Angry Shopkeepers Trap",
        ent = APItems.trapOffset + Spel2AP.traps.Angry_Shopkeepers,
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_PEOPLE_0,
        TileY = 2,
        TileX = 2,
        priority = APItems.priority.TRAP
    },
    [Spel2AP.traps.Punish_Ball] = {
        name = "Punish Ball Trap",
        ent = APItems.trapOffset + Spel2AP.traps.Punish_Ball,
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 6,
        TileX = 11,
        priority = APItems.priority.TRAP
    }
}


return APItems