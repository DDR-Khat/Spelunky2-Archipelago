safe_require("lib/Spel2ItemCodes")
safe_require("lib/popup")

function become_lookup_table(list)
    local lookup = {}
    for _, value in ipairs(list) do
        lookup[value] = true
    end
    return lookup
end

function table.set(table, key)
    table[key] = true
end

journal = {
    chapters = { "places", "people", "bestiary", "items", "traps" },

    places = {
        DWELLING =          { name = "Dwelling",          id = Spel2AP.locations.place.Dwelling,         index = 1  },
        JUNGLE =            { name = "Jungle",            id = Spel2AP.locations.place.Jungle,           index = 2  },
        VOLCANA =           { name = "Volcana",           id = Spel2AP.locations.place.Volcana,          index = 3  },
        OLMECS_LAIR =       { name = "Olmec's Lair",      id = Spel2AP.locations.place.Olmecs_Lair,      index = 4  },
        TIDE_POOL =         { name = "Tide Pool",         id = Spel2AP.locations.place.Tide_Pool,        index = 5  },
        ABZU =              { name = "Abzu",              id = Spel2AP.locations.place.Abzu,             index = 6  },
        TEMPLE =            { name = "Temple of Anubis",  id = Spel2AP.locations.place.Temple,           index = 7  },
        CITY_OF_GOLD =      { name = "City of Gold",      id = Spel2AP.locations.place.City_Of_Gold,     index = 8  },
        DUAT =              { name = "Duat",              id = Spel2AP.locations.place.Duat,             index = 9  },
        ICE_CAVES =         { name = "Ice Caves",         id = Spel2AP.locations.place.Ice_Caves,        index = 10 },
        NEO_BABYLON =       { name = "Neo Babylon",       id = Spel2AP.locations.place.Neo_Babylon,      index = 11 },
        TIAMATS_THRONE =    { name = "Tiamat's Throne",   id = Spel2AP.locations.place.Tiamats_Throne,   index = 12 },
        SUNKEN_CITY =       { name = "Sunken City",       id = Spel2AP.locations.place.Sunken_City,      index = 13 },
        EGGPLANT_WORLD =    { name = "Eggplant World",    id = Spel2AP.locations.place.Eggplant_World,   index = 14 },
        HUNDUNS_HIDEAWAY =  { name = "Hundun's Hideaway", id = Spel2AP.locations.place.Hunduns_Hideaway, index = 15 },
        COSMIC_OCEAN =      { name = "Cosmic Ocean",      id = Spel2AP.locations.place.Cosmic_Ocean,     index = 16 },
    },
    people = {
        ANA_SPELUNKY =       { name = "Ana Spelunky",       id = Spel2AP.locations.people.Ana_Spelunky,       index = 1, ent_type = ENT_TYPE.CHAR_ANA_SPELUNKY },
        MARGARET_TUNNEL =    { name = "Margaret Tunnel",    id = Spel2AP.locations.people.Margaret_Tunnel,    index = 2, ent_type = ENT_TYPE.CHAR_MARGARET_TUNNEL  },
        COLIN_NORTHWARD =    { name = "Colin Northward",    id = Spel2AP.locations.people.Colin_Northward,    index = 3, ent_type = ENT_TYPE.CHAR_COLIN_NORTHWARD  },
        ROFFY_D_SLOTH =      { name = "Roffy D. Sloth",     id = Spel2AP.locations.people.Roffy_D_Sloth,      index = 4, ent_type = ENT_TYPE.CHAR_ROFFY_D_SLOTH  },
        ALTO_SINGH =         { name = "Alto Singh",         id = Spel2AP.locations.people.Alto_Singh,         index = 5  },
        LIZ_MUTTON =         { name = "Liz Mutton",         id = Spel2AP.locations.people.Liz_Mutton,         index = 6  },
        NEKKA_THE_EAGLE =    { name = "Nekka the Eagle",    id = Spel2AP.locations.people.Nekka_The_Eagle,    index = 7  },
        LISE_PROJECT =       { name = "LISE Project",       id = Spel2AP.locations.people.LISE_Project,       index = 8  },
        COCO_VON_DIAMONDS =  { name = "Coco Von Diamonds",  id = Spel2AP.locations.people.Coco_Von_Diamonds,  index = 9  },
        MANFRED_TUNNEL =     { name = "Manfred Tunnel",     id = Spel2AP.locations.people.Manfred_Tunnel,     index = 10 },
        LITTLE_JAY =         { name = "Little Jay",         id = Spel2AP.locations.people.Little_Jay,         index = 11 },
        TINA_FLAN =          { name = "Tina Flan",          id = Spel2AP.locations.people.Tina_Flan,          index = 12 },
        VALERIE_CRUMP =      { name = "Valerie Crump",      id = Spel2AP.locations.people.Valerie_Crump,      index = 13 },
        AU =                 { name = "Au",                 id = Spel2AP.locations.people.Au,                 index = 14 },
        DEMI_VON_DIAMONDS =  { name = "Demi Von Diamonds",  id = Spel2AP.locations.people.Demi_Von_Diamonds,  index = 15 },
        PILOT =              { name = "Pilot",              id = Spel2AP.locations.people.Pilot,              index = 16 },
        PRINCESS_AIRYN =     { name = "Princess Airyn",     id = Spel2AP.locations.people.Princess_Airyn,     index = 17 },
        DIRK_YAMAOKA =       { name = "Dirk Yamaoka",       id = Spel2AP.locations.people.Dirk_Yamaoka,       index = 18 },
        GUY_SPELUNKY =       { name = "Guy Spelunky",       id = Spel2AP.locations.people.Guy_Spelunky,       index = 19 },
        CLASSIC_GUY =        { name = "Classic Guy",        id = Spel2AP.locations.people.Classic_Guy,        index = 20 },
        TERRA_TUNNEL =       { name = "Terra Tunnel",       id = Spel2AP.locations.people.Terra_Tunnel,       index = 21 },
        HIRED_HAND =         { name = "Hired Hand",         id = Spel2AP.locations.people.Hired_Hand,         index = 22 },
        EGGPLANT_CHILD =     { name = "Eggplant Child",     id = Spel2AP.locations.people.Eggplant_Child,     index = 23 },
        SHOPKEEPER =         { name = "Shopkeeper",         id = Spel2AP.locations.people.Shopkeeper,         index = 24 },
        TUN =                { name = "Tun",                id = Spel2AP.locations.people.Tun,                index = 25 },
        YANG =               { name = "Yang",               id = Spel2AP.locations.people.Yang,               index = 26 },
        MADAME_TUSK =        { name = "Madame Tusk",        id = Spel2AP.locations.people.Madame_Tusk,        index = 27 },
        TUSKS_BODYGUARD =    { name = "Tusk's Bodyguard",   id = Spel2AP.locations.people.Tusks_Bodyguard,    index = 28 },
        WADDLER =            { name = "Waddler",            id = Spel2AP.locations.people.Waddler,            index = 29 },
        CAVEMAN_SHOPKEEPER = { name = "Caveman Shopkeeper", id = Spel2AP.locations.people.Caveman_Shopkeeper, index = 30 },
        GHIST_SHOPKEEPER =   { name = "Ghist Shopkeeper",   id = Spel2AP.locations.people.Ghist_Shopkeeper,   index = 31 },
        VAN_HORSING =        { name = "Van Horsing",        id = Spel2AP.locations.people.Van_Horsing,        index = 32 },
        PARSLEY =            { name = "Parsley",            id = Spel2AP.locations.people.Parsley,            index = 33 },
        PARSNIP =            { name = "Parsnip",            id = Spel2AP.locations.people.Parsnip,            index = 34 },
        PARMESAN =           { name = "Parmesan",           id = Spel2AP.locations.people.Parmesan,           index = 35 },
        SPARROW =            { name = "Sparrow",            id = Spel2AP.locations.people.Sparrow,            index = 36 },
        BEG =                { name = "Beg",                id = Spel2AP.locations.people.Beg,                index = 37 },
        EGGPLANT_KING =      { name = "Eggplant King",      id = Spel2AP.locations.people.Eggplant_King,      index = 38 },
    },
    bestiary = {
        SNAKE =             { name = "Snake",              id = Spel2AP.locations.bestiary.Snake,              index = 1  },
        SPIDER =            { name = "Spider",             id = Spel2AP.locations.bestiary.Spider,             index = 2  },
        BAT =               { name = "Bat",                id = Spel2AP.locations.bestiary.Bat,                index = 3  },
        CAVEMAN =           { name = "Caveman",            id = Spel2AP.locations.bestiary.Caveman,            index = 4  },
        SKELETON =          { name = "Skeleton",           id = Spel2AP.locations.bestiary.Skeleton,           index = 5  },
        HORNED_LIZARD =     { name = "Horned Lizard",      id = Spel2AP.locations.bestiary.Horned_Lizard,      index = 6  },
        CAVE_MOLE =         { name = "Cave Mole",          id = Spel2AP.locations.bestiary.Cave_Mole,          index = 7  },
        QUILLBACK =         { name = "Quillback",          id = Spel2AP.locations.bestiary.Quillback,          index = 8  },
        MANTRAP =           { name = "Mantrap",            id = Spel2AP.locations.bestiary.Mantrap,            index = 9  },
        TIKI_MAN =          { name = "Tiki Man",           id = Spel2AP.locations.bestiary.Tiki_Man,           index = 10 },
        WITCH_DOCTOR =      { name = "Witch Doctor",       id = Spel2AP.locations.bestiary.Witch_Doctor,       index = 11 },
        MOSQUITO =          { name = "Mosquito",           id = Spel2AP.locations.bestiary.Mosquito,           index = 12 },
        MONKEY =            { name = "Monkey",             id = Spel2AP.locations.bestiary.Monkey,             index = 13 },
        HANG_SPIDER =       { name = "Hang Spider",        id = Spel2AP.locations.bestiary.Hang_Spider,        index = 14 },
        GIANT_SPIDER =      { name = "Giant Spider",       id = Spel2AP.locations.bestiary.Giant_Spider,       index = 15 },
        MAGMAR =            { name = "Magmar",             id = Spel2AP.locations.bestiary.Magmar,             index = 16 },
        ROBOT =             { name = "Robot",              id = Spel2AP.locations.bestiary.Robot,              index = 17 },
        FIRE_BUG =          { name = "Fire Bug",           id = Spel2AP.locations.bestiary.Fire_Bug,           index = 18 },
        IMP =               { name = "Imp",                id = Spel2AP.locations.bestiary.Imp,                index = 19 },
        LAVAMANDER =        { name = "Lavamander",         id = Spel2AP.locations.bestiary.Lavamander,         index = 20 },
        VAMPIRE =           { name = "Vampire",            id = Spel2AP.locations.bestiary.Vampire,            index = 21 },
        VLAD =              { name = "Vlad",               id = Spel2AP.locations.bestiary.Vlad,               index = 22 },
        OLMEC =             { name = "Olmec",              id = Spel2AP.locations.bestiary.Olmec,              index = 23 },
        JIANGSHI =          { name = "Jiangshi",           id = Spel2AP.locations.bestiary.Jiangshi,           index = 24 },
        JIANGSHI_ASSASSIN = { name = "Jiangshi Assassin",  id = Spel2AP.locations.bestiary.Jiangshi_Assassin,  index = 25 },
        FLYING_FISH =       { name = "Flying Fish",        id = Spel2AP.locations.bestiary.Flying_Fish,        index = 26 },
        OCTOPY =            { name = "Octopy",             id = Spel2AP.locations.bestiary.Octopy,             index = 27 },
        HERMIT_CRAB =       { name = "Hermit Crab",        id = Spel2AP.locations.bestiary.Hermit_Crab,        index = 28 },
        PANGXIE =           { name = "Pangxie",            id = Spel2AP.locations.bestiary.Pangxie,            index = 29 },
        GREAT_HUMPHEAD =    { name = "Great Humphead",     id = Spel2AP.locations.bestiary.Great_Humphead,     index = 30 },
        KINGU =             { name = "Kingu",              id = Spel2AP.locations.bestiary.Kingu,              index = 31 },
        CROCMAN =           { name = "Crocman",            id = Spel2AP.locations.bestiary.Crocman,            index = 32 },
        COBRA =             { name = "Cobra",              id = Spel2AP.locations.bestiary.Cobra,              index = 33 },
        MUMMY =             { name = "Mummy",              id = Spel2AP.locations.bestiary.Mummy,              index = 34 },
        SORCERESS =         { name = "Sorceress",          id = Spel2AP.locations.bestiary.Sorceress,          index = 35 },
        CAT_MUMMY =         { name = "Cat Mummy",          id = Spel2AP.locations.bestiary.Cat_Mummy,          index = 36 },
        NECROMANCER =       { name = "Necromancer",        id = Spel2AP.locations.bestiary.Necromancer,        index = 37 },
        ANUBIS =            { name = "Anubis",             id = Spel2AP.locations.bestiary.Anubis,             index = 38 },
        AMMIT =             { name = "Ammit",              id = Spel2AP.locations.bestiary.Ammit,              index = 39 },
        APEP =              { name = "Apep",               id = Spel2AP.locations.bestiary.Apep,               index = 40 },
        ANUBIS_II =         { name = "Anubis II",          id = Spel2AP.locations.bestiary.Anubis_II,          index = 41 },
        OSIRIS =            { name = "Osiris",             id = Spel2AP.locations.bestiary.Osiris,             index = 42 },
        UFO =               { name = "UFO",                id = Spel2AP.locations.bestiary.Ufo,                index = 43 },
        ALIEN =             { name = "Alien",              id = Spel2AP.locations.bestiary.Alien,              index = 44 },
        YETI =              { name = "Yeti",               id = Spel2AP.locations.bestiary.Yeti,               index = 45 },
        YETI_KING =         { name = "Yeti King",          id = Spel2AP.locations.bestiary.Yeti_King,          index = 46 },
        YETI_QUEEN =        { name = "Yeti Queen",         id = Spel2AP.locations.bestiary.Yeti_Queen,         index = 47 },
        LAMAHU =            { name = "Lamahu",             id = Spel2AP.locations.bestiary.Lamahu,             index = 48 },
        PROTO_SHOPKEEPER =  { name = "Proto Shopkeeper",   id = Spel2AP.locations.bestiary.Proto_Shopkeeper,   index = 49 },
        OLMITE =            { name = "Olmite",             id = Spel2AP.locations.bestiary.Olmite,             index = 50 },
        LAMASSU =           { name = "Lamassu",            id = Spel2AP.locations.bestiary.Lamassu,            index = 51 },
        TIAMAT =            { name = "Tiamat",             id = Spel2AP.locations.bestiary.Tiamat,             index = 52 },
        TADPOLE =           { name = "Tadpole",            id = Spel2AP.locations.bestiary.Tadpole,            index = 53 },
        FROG =              { name = "Frog",               id = Spel2AP.locations.bestiary.Frog,               index = 54 },
        FIRE_FROG =         { name = "Fire Frog",          id = Spel2AP.locations.bestiary.Fire_Frog,          index = 55 },
        GOLIATH_FROG =      { name = "Goliath Frog",       id = Spel2AP.locations.bestiary.Goliath_Frog,       index = 56 },
        GRUB =              { name = "Grub",               id = Spel2AP.locations.bestiary.Grub,               index = 57 },
        GIANT_FLY =         { name = "Giant Fly",          id = Spel2AP.locations.bestiary.Giant_Fly,          index = 58 },
        HUNDUN =            { name = "Hundun",             id = Spel2AP.locations.bestiary.Hundun,             index = 59 },
        EGGPLANT_MINISTER = { name = "Eggplant Minister",  id = Spel2AP.locations.bestiary.Eggplant_Minister,  index = 60 },
        EGGPLUP =           { name = "Eggplup",            id = Spel2AP.locations.bestiary.Eggplup,            index = 61 },
        CELESTIAL_JELLY =   { name = "Celestial Jelly",    id = Spel2AP.locations.bestiary.Celestial_Jelly,    index = 62 },
        SCORPION =          { name = "Scorpion",           id = Spel2AP.locations.bestiary.Scorpion,           index = 63 },
        BEE =               { name = "Bee",                id = Spel2AP.locations.bestiary.Bee,                index = 64 },
        QUEEN_BEE =         { name = "Queen Bee",          id = Spel2AP.locations.bestiary.Queen_Bee,          index = 65 },
        SCARAB =            { name = "Scarab",             id = Spel2AP.locations.bestiary.Scarab,             index = 66 },
        GOLDEN_MONKEY =     { name = "Golden Monkey",      id = Spel2AP.locations.bestiary.Golden_Monkey,      index = 67 },
        LEPRECHAUN =        { name = "Leprechaun",         id = Spel2AP.locations.bestiary.Leprechaun,         index = 68 },
        MONTY =             { name = "Monty",              id = Spel2AP.locations.bestiary.Monty,              index = 69 },
        PERCY =             { name = "Percy",              id = Spel2AP.locations.bestiary.Percy,              index = 70 },
        POOCHI =            { name = "Poochi",             id = Spel2AP.locations.bestiary.Poochi,             index = 71 },
        GHIST =             { name = "Ghist",              id = Spel2AP.locations.bestiary.Ghist,              index = 72 },
        GHOST =             { name = "Ghost",              id = Spel2AP.locations.bestiary.Ghost,              index = 73 },
        CAVE_TURKEY =       { name = "Cave Turkey",        id = Spel2AP.locations.bestiary.Cave_Turkey,        index = 74 },
        ROCK_DOG =          { name = "Rock Dog",           id = Spel2AP.locations.bestiary.Rock_Dog,           index = 75 },
        AXOLOTL =           { name = "Axolotl",            id = Spel2AP.locations.bestiary.Axolotl,            index = 76 },
        QILIN =             { name = "Qilin",              id = Spel2AP.locations.bestiary.Qilin,              index = 77 },
        MECH_RIDER =        { name = "Mech Rider",         id = Spel2AP.locations.bestiary.Mech_Rider,         index = 78 },
    },
    items = {
        ROPE_PILE        = { name = "Rope Pile",         id = Spel2AP.locations.item.Rope_Pile,         index = 1,  ent_type = ENT_TYPE.ITEM_PICKUP_ROPEPILE },
        BOMB_BAG         = { name = "Bomb Bag",          id = Spel2AP.locations.item.Bomb_Bag,          index = 2,  ent_type = ENT_TYPE.ITEM_PICKUP_BOMBBAG },
        BOMB_BOX         = { name = "Bomb Box",          id = Spel2AP.locations.item.Bomb_Box,          index = 3,  ent_type = ENT_TYPE.ITEM_PICKUP_BOMBBOX },
        PARACHUTE        = { name = "Parachute",         id = Spel2AP.locations.item.Parachute,         index = 12, ent_type = ENT_TYPE.ITEM_PICKUP_PARACHUTE },
        ROYAL_JELLY      = { name = "Royal Jelly",       id = Spel2AP.locations.item.Royal_Jelly,       index = 22, ent_type = ENT_TYPE.ITEM_PICKUP_ROYALJELLY },
        SHOTGUN          = { name = "Shotgun",           id = Spel2AP.locations.item.Shotgun,           index = 30, ent_type = ENT_TYPE.ITEM_SHOTGUN },
        CROSSBOW         = { name = "Crossbow",          id = Spel2AP.locations.item.Crossbow,          index = 33, ent_type = ENT_TYPE.ITEM_CROSSBOW },
        BOOMERANG        = { name = "Boomerang",         id = Spel2AP.locations.item.Boomerang,         index = 37, ent_type = ENT_TYPE.ITEM_BOOMERANG },
        BROKEN_SWORD     = { name = "Broken Sword",      id = Spel2AP.locations.item.Broken_Sword,      index = 40, ent_type = ENT_TYPE.ITEM_BROKEN_SWORD },
        WOODEN_SHIELD    = { name = "Wooden Shield",     id = Spel2AP.locations.item.Wooden_Shield,     index = 45, ent_type = ENT_TYPE.ITEM_WOODEN_SHIELD },
        IDOL             = { name = "Idol",              id = Spel2AP.locations.item.Idol,              index = 47, ent_type = ENT_TYPE.ITEM_IDOL },
        THE_TUSK_IDOL    = { name = "The Tusk Idol",     id = Spel2AP.locations.item.The_Tusk_Idol,     index = 48, ent_type = ENT_TYPE.ITEM_SPECIAL_IDOL },
        CURSE_POT        = { name = "Curse Pot",         id = Spel2AP.locations.item.Curse_Pot,         index = 49, ent_type = ENT_TYPE.ITEM_CURSEDPOT },
        COOKED_TURKEY    = { name = "Cooked Turkey",     id = Spel2AP.locations.item.Cooked_Turkey,     index = 52, ent_type = ENT_TYPE.ITEM_PICKUP_COOKEDTURKEY },
        SKELETON_KEY     = { name = "Skeleton Key",      id = Spel2AP.locations.item.Skeleton_Key,      index = 21, ent_type = ENT_TYPE.ITEM_PICKUP_SKELETON_KEY,    lock = Spel2AP.locked_items.Skeleton_Key },
        CAPE             = { name = "Cape",              id = Spel2AP.locations.item.Cape,              index = 23, ent_type = ENT_TYPE.ITEM_CAPE,                   lock = Spel2AP.locked_items.Cape },
        VLADS_CAPE       = { name = "Vlad's Cape",       id = Spel2AP.locations.item.Vlads_Cape,        index = 24, ent_type = ENT_TYPE.ITEM_VLADS_CAPE,             lock = Spel2AP.locked_items.Vlads_Cape },
        JETPACK          = { name = "Jetpack",           id = Spel2AP.locations.item.Jetpack,           index = 25, ent_type = ENT_TYPE.ITEM_JETPACK,                lock = Spel2AP.locked_items.Jetpack },
        TELEPACK         = { name = "Telepack",          id = Spel2AP.locations.item.Telepack,          index = 26, ent_type = ENT_TYPE.ITEM_TELEPORTER_BACKPACK,    lock = Spel2AP.locked_items.Telepack },
        HOVERPACK        = { name = "Hoverpack",         id = Spel2AP.locations.item.Hoverpack,         index = 27, ent_type = ENT_TYPE.ITEM_HOVERPACK,              lock = Spel2AP.locked_items.Hoverpack },
        POWERPACK        = { name = "Powerpack",         id = Spel2AP.locations.item.Powerpack,         index = 28, ent_type = ENT_TYPE.ITEM_POWERPACK,              lock = Spel2AP.locked_items.Powerpack },
        WEBGUN           = { name = "Webgun",            id = Spel2AP.locations.item.Webgun,            index = 29, ent_type = ENT_TYPE.ITEM_WEBGUN,                 lock = Spel2AP.locked_items.Webgun },
        FREEZE_RAY       = { name = "Freeze Ray",        id = Spel2AP.locations.item.Freeze_Ray,        index = 31, ent_type = ENT_TYPE.ITEM_FREEZERAY,              lock = Spel2AP.locked_items.Freeze_Ray },
        CLONE_GUN        = { name = "Clone Gun",         id = Spel2AP.locations.item.Clone_Gun,         index = 32, ent_type = ENT_TYPE.ITEM_CLONEGUN,               lock = Spel2AP.locked_items.Clone_Gun },
        CAMERA           = { name = "Camera",            id = Spel2AP.locations.item.Camera,            index = 34, ent_type = ENT_TYPE.ITEM_CAMERA,                 lock = Spel2AP.locked_items.Camera },
        TELEPORTER       = { name = "Teleporter",        id = Spel2AP.locations.item.Teleporter,        index = 35, ent_type = ENT_TYPE.ITEM_TELEPORTER,             lock = Spel2AP.locked_items.Teleporter },
        MATTOCK          = { name = "Mattock",           id = Spel2AP.locations.item.Mattock,           index = 36, ent_type = ENT_TYPE.ITEM_MATTOCK,                lock = Spel2AP.locked_items.Mattock },
        MACHETE          = { name = "Machete",           id = Spel2AP.locations.item.Machete,           index = 38, ent_type = ENT_TYPE.ITEM_MACHETE,                lock = Spel2AP.locked_items.Machete },
        EXCALIBUR        = { name = "Excalibur",         id = Spel2AP.locations.item.Excalibur,         index = 39, ent_type = ENT_TYPE.ITEM_EXCALIBUR,              lock = Spel2AP.locked_items.Excalibur },
        PLASMA_CANNON    = { name = "Plasma Cannon",     id = Spel2AP.locations.item.Plasma_Cannon,     index = 41, ent_type = ENT_TYPE.ITEM_PLASMACANNON,           lock = Spel2AP.locked_items.Plasma_Cannon },
        SCEPTER          = { name = "Scepter",           id = Spel2AP.locations.item.Scepter,           index = 42, ent_type = ENT_TYPE.ITEM_SCEPTER,                lock = Spel2AP.locked_items.Scepter },
        HOUYIS_BOW       = { name = "Hou Yi's Bow",      id = Spel2AP.locations.item.Hou_Yis_Bow,       index = 43, ent_type = ENT_TYPE.ITEM_HOUYIBOW,               lock = Spel2AP.locked_items.Hou_Yis_Bow },
        ARROW_OF_LIGHT   = { name = "Arrow of Light",    id = Spel2AP.locations.item.Arrow_Of_Light,    index = 44, ent_type = ENT_TYPE.ITEM_LIGHT_ARROW,            lock = Spel2AP.locked_items.Arrow_Of_Light },
        METAL_SHIELD     = { name = "Metal Shield",      id = Spel2AP.locations.item.Metal_Shield,      index = 46, ent_type = ENT_TYPE.ITEM_METAL_SHIELD,           lock = Spel2AP.locked_items.Shield },
        USHABTI          = { name = "Ushabti",           id = Spel2AP.locations.item.Ushabti,           index = 50, ent_type = ENT_TYPE.ITEM_USHABTI,                lock = Spel2AP.locked_items.Ushabti },
        EGGPLANT         = { name = "Eggplant",          id = Spel2AP.locations.item.Eggplant,          index = 51, ent_type = ENT_TYPE.ITEM_EGGPLANT,               lock = Spel2AP.locked_items.Eggplant },
        ELIXIR           = { name = "Elixir",            id = Spel2AP.locations.item.Elixir,            index = 53, ent_type = ENT_TYPE.ITEM_PICKUP_ELIXIR,          lock = Spel2AP.locked_items.Elixir },
        FOUR_LEAF_CLOVER = { name = "Four-Leaf Clover",  id = Spel2AP.locations.item.Four_Leaf_Clover,  index = 54, ent_type = ENT_TYPE.ITEM_PICKUP_CLOVER,          lock = Spel2AP.locked_items.Four_Leaf_Clover },
        PASTE            = { name = "Paste",             id = Spel2AP.locations.item.Paste,             index = 4,  ent_type = ENT_TYPE.ITEM_PICKUP_PASTE,           lock = Spel2AP.locked_items.Paste,             powerup = ENT_TYPE.ITEM_POWERUP_PASTE },
        SPECTACLES       = { name = "Spectacles",        id = Spel2AP.locations.item.Spectacles,        index = 5,  ent_type = ENT_TYPE.ITEM_PICKUP_SPECTACLES,      lock = Spel2AP.locked_items.Spectacles,        powerup = ENT_TYPE.ITEM_POWERUP_SPECTACLES },
        CLIMBING_GLOVES  = { name = "Climbing Gloves",   id = Spel2AP.locations.item.Climbing_Gloves,   index = 6,  ent_type = ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES,  lock = Spel2AP.locked_items.Climbing_Gloves,   powerup = ENT_TYPE.ITEM_POWERUP_CLIMBING_GLOVES },
        PITCHERS_MITT    = { name = "Pitcher's Mitt",    id = Spel2AP.locations.item.Pitchers_Mitt,     index = 7,  ent_type = ENT_TYPE.ITEM_PICKUP_PITCHERSMITT,    lock = Spel2AP.locked_items.Pitchers_Mitt,     powerup = ENT_TYPE.ITEM_POWERUP_PITCHERSMITT },
        SPRING_SHOES     = { name = "Spring Shoes",      id = Spel2AP.locations.item.Spring_Shoes,      index = 8,  ent_type = ENT_TYPE.ITEM_PICKUP_SPRINGSHOES,     lock = Spel2AP.locked_items.Spring_Shoes,      powerup = ENT_TYPE.ITEM_POWERUP_SPRING_SHOES },
        SPIKE_SHOES      = { name = "Spike Shoes",       id = Spel2AP.locations.item.Spike_Shoes,       index = 9,  ent_type = ENT_TYPE.ITEM_PICKUP_SPIKESHOES,      lock = Spel2AP.locked_items.Spike_Shoes,       powerup = ENT_TYPE.ITEM_POWERUP_SPIKE_SHOES },
        COMPASS          = { name = "Compass",           id = Spel2AP.locations.item.Compass,           index = 10, ent_type = ENT_TYPE.ITEM_PICKUP_COMPASS,         lock = Spel2AP.locked_items.Compass,           powerup = ENT_TYPE.ITEM_POWERUP_COMPASS },
        ALIEN_COMPASS    = { name = "Alien Compass",     id = Spel2AP.locations.item.Alien_Compass,     index = 11, ent_type = ENT_TYPE.ITEM_PICKUP_SPECIALCOMPASS,  lock = Spel2AP.locked_items.Alien_Compass,     powerup = ENT_TYPE.ITEM_POWERUP_SPECIALCOMPASS },
        UDJAT_EYE        = { name = "Udjat Eye",         id = Spel2AP.locations.item.Udjat_Eye,         index = 13, ent_type = ENT_TYPE.ITEM_PICKUP_UDJATEYE,        lock = Spel2AP.locked_items.Udjat_Eye,         powerup = ENT_TYPE.ITEM_POWERUP_UDJATEYE },
        KAPALA           = { name = "Kapala",            id = Spel2AP.locations.item.Kapala,            index = 14, ent_type = ENT_TYPE.ITEM_PICKUP_KAPALA,          lock = Spel2AP.locked_items.Kapala,            powerup = ENT_TYPE.ITEM_POWERUP_KAPALA },
        HEDJET           = { name = "Hedjet",            id = Spel2AP.locations.item.Hedjet,            index = 15, ent_type = ENT_TYPE.ITEM_PICKUP_HEDJET,          lock = Spel2AP.locked_items.Hedjet,            powerup = ENT_TYPE.ITEM_POWERUP_HEDJET },
        CROWN            = { name = "Crown",             id = Spel2AP.locations.item.Crown,             index = 16, ent_type = ENT_TYPE.ITEM_PICKUP_CROWN,           lock = Spel2AP.locked_items.Crown,             powerup = ENT_TYPE.ITEM_POWERUP_CROWN },
        EGGPLANT_CROWN   = { name = "Eggplant Crown",    id = Spel2AP.locations.item.Eggplant_Crown,    index = 17, ent_type = ENT_TYPE.ITEM_PICKUP_EGGPLANTCROWN,   lock = Spel2AP.locked_items.Eggplant_Crown,    powerup = ENT_TYPE.ITEM_POWERUP_EGGPLANTCROWN },
        TRUE_CROWN       = { name = "True Crown",        id = Spel2AP.locations.item.True_Crown,        index = 18, ent_type = ENT_TYPE.ITEM_PICKUP_TRUECROWN,       lock = Spel2AP.locked_items.True_Crown,        powerup = ENT_TYPE.ITEM_POWERUP_TRUECROWN },
        ANKH             = { name = "Ankh",              id = Spel2AP.locations.item.Ankh,              index = 19, ent_type = ENT_TYPE.ITEM_PICKUP_ANKH,            lock = Spel2AP.locked_items.Ankh,              powerup = ENT_TYPE.ITEM_POWERUP_ANKH },
        TABLET_OF_DESTINY= { name = "Tablet of Destiny", id = Spel2AP.locations.item.Tablet_Of_Destiny, index = 20, ent_type = ENT_TYPE.ITEM_PICKUP_TABLETOFDESTINY, lock = Spel2AP.locked_items.Tablet_Of_Destiny, powerup = ENT_TYPE.ITEM_POWERUP_TABLETOFDESTINY },
    },
    traps = {
        SPIKES =           { name = "Spikes",            id = Spel2AP.locations.trap.Spikes,            index = 1  },
        ARROW =            { name = "Arrow Trap",        id = Spel2AP.locations.trap.Arrow_Trap,        index = 2  },
        TOTEM =            { name = "Totem Trap",        id = Spel2AP.locations.trap.Totem_Trap,        index = 3  },
        LOG =              { name = "Log Trap",          id = Spel2AP.locations.trap.Log_Trap,          index = 4  },
        SPEAR =            { name = "Spear Trap",        id = Spel2AP.locations.trap.Spear_Trap,        index = 5  },
        THORNY_VINE =      { name = "Thorny Vine",       id = Spel2AP.locations.trap.Thorny_Vine,       index = 6  },
        BEAR =             { name = "Bear Trap",         id = Spel2AP.locations.trap.Bear_Trap,         index = 7  },
        POWDER_BOX =       { name = "Powder Box",        id = Spel2AP.locations.trap.Powder_Box,        index = 8  },
        FALLING_PLATFORM = { name = "Falling Platform",  id = Spel2AP.locations.trap.Falling_Platform,  index = 9  },
        SPIKEBALL =        { name = "Spikeball",         id = Spel2AP.locations.trap.Spikeball,         index = 10 },
        LION =             { name = "Lion Trap",         id = Spel2AP.locations.trap.Lion_Trap,         index = 11 },
        GIANT_CLAM =       { name = "Giant Clam",        id = Spel2AP.locations.trap.Giant_Clam,        index = 12 },
        SLIDING_WALL =     { name = "Sliding Wall",      id = Spel2AP.locations.trap.Sliding_Wall,      index = 13 },
        CRUSH =            { name = "Crush Trap",        id = Spel2AP.locations.trap.Crush_Trap,        index = 14 },
        GIANT_CRUSH =      { name = "Giant Crush Trap",  id = Spel2AP.locations.trap.Giant_Crush_Trap,  index = 15 },
        BOULDER =          { name = "Boulder",           id = Spel2AP.locations.trap.Boulder,           index = 16 },
        SPRING =           { name = "Spring Trap",       id = Spel2AP.locations.trap.Spring_Trap,       index = 17 },
        LANDMINE =         { name = "Landmine",          id = Spel2AP.locations.trap.Landmine,          index = 18 },
        LASER =            { name = "Laser Trap",        id = Spel2AP.locations.trap.Laser_Trap,        index = 19 },
        SPARK =            { name = "Spark Trap",        id = Spel2AP.locations.trap.Spark_Trap,        index = 20 },
        FROG =             { name = "Frog Trap",         id = Spel2AP.locations.trap.Frog_Trap,         index = 21 },
        STICKY =           { name = "Sticky Trap",       id = Spel2AP.locations.trap.Sticky_Trap,       index = 22 },
        BONE =             { name = "Bone Drop",         id = Spel2AP.locations.trap.Bone_Drop,         index = 23 },
        EGG_SAC =          { name = "Egg Sac",           id = Spel2AP.locations.trap.Egg_Sac,           index = 24 },
    }
}

journal_lookup = {}
for _, chapter in ipairs(journal.chapters) do
    for key, entry in pairs(journal[chapter]) do
        journal_lookup[entry.id] = { chapter = chapter, entry = key, ent = entry.ent_type, index = entry.index }
    end
end

starter_lookup = {
    [Spel2AP.locations.people.Ana_Spelunky]    = journal.people.ANA_SPELUNKY.ent_type,
    [Spel2AP.locations.people.Margaret_Tunnel] = journal.people.MARGARET_TUNNEL.ent_type,
    [Spel2AP.locations.people.Colin_Northward] = journal.people.COLIN_NORTHWARD.ent_type,
    [Spel2AP.locations.people.Roffy_D_Sloth]   = journal.people.ROFFY_D_SLOTH.ent_type
}

character_data = {
    [Spel2AP.characters.Ana_Spelunky] =
    {
        index = 1,
        ent = ENT_TYPE.CHAR_ANA_SPELUNKY,
        location = Spel2AP.locations.people.Ana_Spelunky
    },
    [Spel2AP.characters.Margaret_Tunnel] =
    {
        index = 2,
        ent = ENT_TYPE.CHAR_MARGARET_TUNNEL,
        location = Spel2AP.locations.people.Margaret_Tunnel
    },
    [Spel2AP.characters.Colin_Northward] =
    {
        index = 3,
        ent = ENT_TYPE.CHAR_COLIN_NORTHWARD,
        location = Spel2AP.locations.people.Colin_Northward
    },
    [Spel2AP.characters.Roffy_D_Sloth] =
    {
        index = 4,
        ent = ENT_TYPE.CHAR_ROFFY_D_SLOTH,
        location = Spel2AP.locations.people.Roffy_D_Sloth
    },
    [Spel2AP.characters.Alto_Singh] =
    {
        index = 5,
        ent = ENT_TYPE.CHAR_BANDA,
        location = Spel2AP.locations.people.Alto_Singh
    },
    [Spel2AP.characters.Liz_Mutton] =
    {
        index = 6,
        ent = ENT_TYPE.CHAR_GREEN_GIRL,
        location = Spel2AP.locations.people.Liz_Mutton
    },
    [Spel2AP.characters.Nekka_The_Eagle] =
    {
        index = 7,
        ent = ENT_TYPE.CHAR_AMAZON,
        location = Spel2AP.locations.people.Nekka_The_Eagle
    },
    [Spel2AP.characters.LISE_Project] =
    {
        index = 8,
        ent = ENT_TYPE.CHAR_LISE_SYSTEM,
        location = Spel2AP.locations.people.LISE_Project
    },
    [Spel2AP.characters.Coco_Von_Diamonds] =
    {
        index = 9,
        ent = ENT_TYPE.CHAR_COCO_VON_DIAMONDS,
        location = Spel2AP.locations.people.Coco_Von_Diamonds
    },
    [Spel2AP.characters.Manfred_Tunnel] =
    {
        index = 10,
        ent = ENT_TYPE.CHAR_MANFRED_TUNNEL,
        location = Spel2AP.locations.people.Manfred_Tunnel
    },
    [Spel2AP.characters.Little_Jay] =
    {
        index = 11,
        ent = ENT_TYPE.CHAR_OTAKU,
        location = Spel2AP.locations.people.Little_Jay
    },
    [Spel2AP.characters.Tina_Flan] =
    {
        index = 12,
        ent = ENT_TYPE.CHAR_TINA_FLAN,
        location = Spel2AP.locations.people.Tina_Flan
    },
    [Spel2AP.characters.Valerie_Crump] =
    {
        index = 13,
        ent = ENT_TYPE.CHAR_VALERIE_CRUMP,
        location = Spel2AP.locations.people.Valerie_Crump
    },
    [Spel2AP.characters.Au] =
    {
        index = 14,
        ent = ENT_TYPE.CHAR_AU,
        location = Spel2AP.locations.people.Au
    },
    [Spel2AP.characters.Demi_Von_Diamonds] =
    {
        index = 15,
        ent = ENT_TYPE.CHAR_DEMI_VON_DIAMONDS,
        location = Spel2AP.locations.people.Demi_Von_Diamonds
    },
    [Spel2AP.characters.Pilot] =
    {
        index = 16,
        ent = ENT_TYPE.CHAR_PILOT,
        location = Spel2AP.locations.people.Pilot
    },
    [Spel2AP.characters.Princess_Airyn] =
    {
        index = 17,
        ent = ENT_TYPE.CHAR_PRINCESS_AIRYN,
        location = Spel2AP.locations.people.Princess_Airyn
    },
    [Spel2AP.characters.Dirk_Yamaoka] =
    {
        index = 18,
        ent = ENT_TYPE.CHAR_DIRK_YAMAOKA,
        location = Spel2AP.locations.people.Dirk_Yamaoka
    },
    [Spel2AP.characters.Guy_Spelunky] =
    {
        index = 19,
        ent = ENT_TYPE.CHAR_GUY_SPELUNKY,
        location = Spel2AP.locations.people.Guy_Spelunky
    },
    [Spel2AP.characters.Classic_Guy] =
    {
        index = 20,
        ent = ENT_TYPE.CHAR_CLASSIC_GUY,
        location = Spel2AP.locations.people.Classic_Guy
    },
}

theme_to_world_unlock_id = {
    [THEME.JUNGLE]       = Spel2AP.world_unlocks.Jungle,
    [THEME.VOLCANA]      = Spel2AP.world_unlocks.Volcana,
    [THEME.OLMEC]        = Spel2AP.world_unlocks.Olmecs_Lair,
    [THEME.TIDE_POOL]    = Spel2AP.world_unlocks.Tide_Pool,
    [THEME.TEMPLE]       = Spel2AP.world_unlocks.Temple,
    [THEME.ICE_CAVES]    = Spel2AP.world_unlocks.Ice_Caves,
    [THEME.NEO_BABYLON]  = Spel2AP.world_unlocks.Neo_Babylon,
    [THEME.SUNKEN_CITY]  = Spel2AP.world_unlocks.Sunken_City,
    [THEME.COSMIC_OCEAN] = Spel2AP.world_unlocks.Cosmic_Ocean,
}

function update_nextworld_variable()
    local maxUnlock = 1
    if player_options.progressive_worlds then
        maxUnlock = ap_save.max_world
    else
        maxUnlock = get_unlock_world_number()
    end
    local goalWorld = 8
    if player_options.goal == AP_Goal.EASY then
        goalWorld = 6
    elseif player_options.goal == AP_Goal.HARD then
        goalWorld = 7
    end
    nextWorldUnlocked = maxUnlock >= math.min(state.world_next + 1, goalWorld)
end

local progressive_world_unlocks = {
    { Spel2AP.world_unlocks.Jungle, Spel2AP.world_unlocks.Volcana },
    { Spel2AP.world_unlocks.Olmecs_Lair },
    { Spel2AP.world_unlocks.Tide_Pool, Spel2AP.world_unlocks.Temple },
    { Spel2AP.world_unlocks.Ice_Caves },
    { Spel2AP.world_unlocks.Neo_Babylon },
    { Spel2AP.world_unlocks.Sunken_City },
    { Spel2AP.world_unlocks.Cosmic_Ocean },
}

function get_unlock_world_number()
    local level = 1
    for _, worlds in ipairs(progressive_world_unlocks) do
        local unlocked = false
        for _, world in ipairs(worlds) do
            if ap_save.world_unlocks[world] then
                unlocked = true
                break
            end
        end
        if unlocked then
            level = level + 1
        else
            break
        end
    end
    return level
end

PRIORITY = {
    WORLD = 10,
    SHORTCUT = 9,
    UNLOCKS = 8,
    UPGRADES = 7,
    STATS = 6,
    TRAP = 5,
    FILLER_HIGH = 4,
    FILLER_MED = 3,
    FILLER_LOW = 2,
    CHARACTER = 1
}
fullColor = RGB2Color(255, 255, 255, 255)
dullColor = RGB2Color(10, 10, 10, 255)

journal_world_icons = {
    [600] = {
        display = TEXTURE.DATA_TEXTURES_MONSTERS01_0,
        TileY = 2,
        TileX = 11,
        width = 0.18,
        height = 0.18,
        offsetX = -0.01,
        offsetY = 0.00,
        worldCount = 1
    },
    [Spel2AP.world_unlocks.Jungle] = {
        display = TEXTURE.DATA_TEXTURES_MONSTERS01_0,
        TileY = 7,
        TileX = 5,
        width = 0.26,
        height = 0.26,
        offsetX = -0.05,
        offsetY = 0.01,
        worldCount = 2
    },
    [Spel2AP.world_unlocks.Volcana] = {
        display = TEXTURE.DATA_TEXTURES_MONSTERS01_0,
        TileY = 1,
        TileX = 10,
        width = 0.18,
        height = 0.18,
        offsetX = 0.0,
        offsetY = -0.02,
        worldCount = 2
    },
    [Spel2AP.world_unlocks.Olmecs_Lair] = {
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 5,
        TileX = 13,
        width = 0.13,
        height = 0.13,
        offsetX = 0.02,
        offsetY = -0.03,
        worldCount = 3
    },
    [Spel2AP.world_unlocks.Tide_Pool] = {
        display = TEXTURE.DATA_TEXTURES_MONSTERS02_0,
        TileY = 7,
        TileX = 7,
        width = 0.17,
        height = 0.17,
        offsetX = 0.0,
        offsetY = -0.01,
        worldCount = 4
    },
    [Spel2AP.world_unlocks.Temple] = {
        display = TEXTURE.DATA_TEXTURES_MONSTERS02_0,
        TileY = 14,
        TileX = 9,
        width = 0.14,
        height = 0.14,
        offsetX = 0.03,
        offsetY = 0.02,
        worldCount = 4
    },
    [Spel2AP.world_unlocks.Ice_Caves] = {
        display = TEXTURE.DATA_TEXTURES_MONSTERS03_0,
        TileY = 3,
        TileX = 6,
        width = 0.14,
        height = 0.14,
        offsetX = 0.02,
        offsetY = 0.04,
        worldCount = 5
    },
    [Spel2AP.world_unlocks.Neo_Babylon] = {
        display = TEXTURE.DATA_TEXTURES_MONSTERS03_0,
        TileY = 4,
        TileX = 1,
        width = 0.14,
        height = 0.14,
        offsetX = 0.02,
        offsetY = 0.02,
        worldCount = 6
    },
    [Spel2AP.world_unlocks.Sunken_City] = {
        display = TEXTURE.DATA_TEXTURES_MONSTERS03_0,
        TileY = 5,
        TileX = 0,
        width = 0.34,
        height = 0.34,
        offsetX = -0.09,
        offsetY = 0.15,
        worldCount = 7
    },
    [Spel2AP.world_unlocks.Cosmic_Ocean] = {
        display = TEXTURE.DATA_TEXTURES_MONSTERS_GHOST_0,
        TileY = 7,
        TileX = 0,
        width = 0.13,
        height = 0.13,
        offsetX = 0.03,
        offsetY = 0.04,
        worldCount = 8
    }
}

item_ids = {
    [Spel2AP.filler_items.Rope_Pile] = {
        type = Spel2AP.filler_items,
        name = "Rope Pile",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.FILLER_MED
    },
    [Spel2AP.filler_items.Bomb_Bag] = {
        type = Spel2AP.filler_items,
        name = "Bomb Bag",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 1,
        priority = PRIORITY.FILLER_MED
    },
    [Spel2AP.filler_items.Bomb_Box] = {
        type = Spel2AP.filler_items,
        name = "Bomb Box",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 2,
        priority = PRIORITY.FILLER_HIGH
    },
    [Spel2AP.filler_items.Cooked_Turkey] = {
        type = Spel2AP.filler_items,
        name = "Cooked Turkey",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 5,
        priority = PRIORITY.FILLER_LOW
    },
    [Spel2AP.filler_items.Royal_Jelly] = {
        type = Spel2AP.filler_items,
        name = "Royal Jelly",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 6,
        priority = PRIORITY.FILLER_HIGH
    },
    [Spel2AP.filler_items.Gold_Bar] = {
        type = Spel2AP.filler_items,
        name = "Gold Bar",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 8,
        TileX = 12,
        priority = PRIORITY.FILLER_LOW
    },
    [Spel2AP.filler_items.Emerald_Gem] = {
        type = Spel2AP.filler_items,
        name = "Emerald",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 0,
        TileX = 3,
        priority = PRIORITY.FILLER_LOW
    },
    [Spel2AP.filler_items.Sapphire_Gem] = {
        type = Spel2AP.filler_items,
        name = "Sapphire",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 0,
        TileX = 4,
        priority = PRIORITY.FILLER_LOW
    },
    [Spel2AP.filler_items.Ruby_Gem] = {
        type = Spel2AP.filler_items,
        name = "Ruby",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 0,
        TileX = 5,
        priority = PRIORITY.FILLER_LOW
    },
    [Spel2AP.filler_items.Diamond_Gem] = {
        type = Spel2AP.filler_items,
        name = "Diamond",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 0,
        TileX = 6,
        priority = PRIORITY.FILLER_HIGH
    },
    [Spel2AP.characters.Ana_Spelunky] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_ANA_SPELUNKY),
        display = TEXTURE.DATA_TEXTURES_CHAR_YELLOW_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Margaret_Tunnel] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_MARGARET_TUNNEL),
        display = TEXTURE.DATA_TEXTURES_CHAR_MAGENTA_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Colin_Northward] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_COLIN_NORTHWARD),
        display = TEXTURE.DATA_TEXTURES_CHAR_CYAN_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Roffy_D_Sloth] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_ROFFY_D_SLOTH),
        display = TEXTURE.DATA_TEXTURES_CHAR_BLACK_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Alto_Singh] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_BANDA),
        display = TEXTURE.DATA_TEXTURES_CHAR_CINNABAR_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Liz_Mutton] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_GREEN_GIRL),
        display = TEXTURE.DATA_TEXTURES_CHAR_GREEN_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Nekka_The_Eagle] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_AMAZON),
        display = TEXTURE.DATA_TEXTURES_CHAR_OLIVE_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.LISE_Project] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_LISE_SYSTEM),
        display = TEXTURE.DATA_TEXTURES_CHAR_WHITE_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Coco_Von_Diamonds] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_COCO_VON_DIAMONDS),
        display = TEXTURE.DATA_TEXTURES_CHAR_CERULEAN_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Manfred_Tunnel] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_MANFRED_TUNNEL),
        display = TEXTURE.DATA_TEXTURES_CHAR_BLUE_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Little_Jay] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_OTAKU),
        display = TEXTURE.DATA_TEXTURES_CHAR_LIME_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Tina_Flan] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_TINA_FLAN),
        display = TEXTURE.DATA_TEXTURES_CHAR_LEMON_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Valerie_Crump] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_VALERIE_CRUMP),
        display = TEXTURE.DATA_TEXTURES_CHAR_IRIS_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Au] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_AU),
        display = TEXTURE.DATA_TEXTURES_CHAR_GOLD_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Demi_Von_Diamonds] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_DEMI_VON_DIAMONDS),
        display = TEXTURE.DATA_TEXTURES_CHAR_RED_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Pilot] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_PILOT),
        display = TEXTURE.DATA_TEXTURES_CHAR_PINK_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Princess_Airyn] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_PRINCESS_AIRYN),
        display = TEXTURE.DATA_TEXTURES_CHAR_VIOLET_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Dirk_Yamaoka] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_DIRK_YAMAOKA),
        display = TEXTURE.DATA_TEXTURES_CHAR_GRAY_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Guy_Spelunky] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_GUY_SPELUNKY),
        display = TEXTURE.DATA_TEXTURES_CHAR_KHAKI_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.characters.Classic_Guy] = {
        type = Spel2AP.characters,
        name = get_character_name(ENT_TYPE.CHAR_CLASSIC_GUY),
        display = TEXTURE.DATA_TEXTURES_CHAR_ORANGE_0,
        TileY = 0,
        TileX = 0,
        priority = PRIORITY.CHARACTER
    },
    [Spel2AP.locked_items.Alien_Compass] = {
        type = Spel2AP.locked_items,
        name = "Alien Compass Unlocked",
        lock_name = "Alien Compass",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 8,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Ankh] = {
        type = Spel2AP.locked_items,
        name = "Ankh Unlocked",
        lock_name = "Ankh",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 5,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Arrow_Of_Light] = {
        type = Spel2AP.locked_items,
        name = "Arrow of Light Unlocked",
        lock_name = "Arrow of Light",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 5,
        TileX = 1,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Camera] = {
        type = Spel2AP.locked_items,
        name = "Camera Unlocked",
        lock_name = "Camera",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 4,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Cape] = {
        type = Spel2AP.locked_items,
        name = "Cape Unlocked",
        lock_name = "Cape",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 7,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Climbing_Gloves] = {
        type = Spel2AP.locked_items,
        name = "Climbing Gloves Unlocked",
        lock_name = "Climbing Gloves",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 5,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Clone_Gun] = {
        type = Spel2AP.locked_items,
        name = "Clone Gun Unlocked",
        lock_name = "Clone Gun",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 7,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Compass] = {
        type = Spel2AP.locked_items,
        name = "Compass Unlocked",
        lock_name = "Compass",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 9,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Crown] = {
        type = Spel2AP.locked_items,
        name = "Crown Unlocked",
        lock_name = "Crown",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 4,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Eggplant] = {
        type = Spel2AP.locked_items,
        name = "Eggplant Unlocked",
        lock_name = "Eggplant",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 4,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Eggplant_Crown] = {
        type = Spel2AP.locked_items,
        name = "Eggplant Crown Unlocked",
        lock_name = "Eggplant Crown",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 5,
        TileX = 3,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Elixir] = {
        type = Spel2AP.locked_items,
        name = "Elixir Unlocked",
        lock_name = "Elixir",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 6,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Excalibur] = {
        type = Spel2AP.locked_items,
        name = "Excalibur Unlocked",
        lock_name = "Excalibur",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileX = 2,
        TileY = 10,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Four_Leaf_Clover] = {
        type = Spel2AP.locked_items,
        name = "Four-Leaf Clover Unlocked",
        lock_name = "Four-Leaf Clover",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 2,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Freeze_Ray] = {
        type = Spel2AP.locked_items,
        name = "Freeze Ray Unlocked",
        lock_name = "Freeze Ray",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 2,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Hedjet] = {
        type = Spel2AP.locked_items,
        name = "Hedjet Unlocked",
        lock_name = "Hedjet",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 3,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Hoverpack] = {
        type = Spel2AP.locked_items,
        name = "Hoverpack Unlocked",
        lock_name = "Hoverpack",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 6,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Hou_Yis_Bow] = {
        type = Spel2AP.locked_items,
        name = "Hou Yi's Bow Unlocked",
        lock_name = "Hou Yi's Bow",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 5,
        TileX = 0,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Jetpack] = {
        type = Spel2AP.locked_items,
        name = "Jetpack Unlocked",
        lock_name = "Jetpack",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 8,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Kapala] = {
        type = Spel2AP.locked_items,
        name = "Kapala Unlocked",
        lock_name = "Kapala",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 2,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Machete] = {
        type = Spel2AP.locked_items,
        name = "Machete Unlocked",
        lock_name = "Machete",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 8,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Mattock] = {
        type = Spel2AP.locked_items,
        name = "Mattock Unlocked",
        lock_name = "Mattock",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 6,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Paste] = {
        type = Spel2AP.locked_items,
        name = "Paste Unlocked",
        lock_name = "Paste",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 3,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Pitchers_Mitt] = {
        type = Spel2AP.locked_items,
        name = "Pitcher's Mitt Unlocked",
        lock_name = "Pitcher's Mitt",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 6,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Plasma_Cannon] = {
        type = Spel2AP.locked_items,
        name = "Plasma Cannon Unlocked",
        lock_name = "Plasma Cannon",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 0,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Powerpack] = {
        type = Spel2AP.locked_items,
        name = "Powerpack Unlocked",
        lock_name = "Powerpack",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 4,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Scepter] = {
        type = Spel2AP.locked_items,
        name = "Scepter Unlocked",
        lock_name = "Scepter",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 1,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Shield] = {
        type = Spel2AP.locked_items,
        name = "Shield Unlocked",
        lock_name = "Shield",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 1,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Skeleton_Key] = {
        type = Spel2AP.locked_items,
        name = "Skeleton Key Unlocked",
        lock_name = "Skeleton Key",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 8,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Spectacles] = {
        type = Spel2AP.locked_items,
        name = "Spectacles Unlocked",
        lock_name = "Spectacles",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 4,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Spike_Shoes] = {
        type = Spel2AP.locked_items,
        name = "Spike Shoes Unlocked",
        lock_name = "Spike Shoes",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 8,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Spring_Shoes] = {
        type = Spel2AP.locked_items,
        name = "Spring Shoes Unlocked",
        lock_name = "Spring Shoes",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 7,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Tablet_Of_Destiny] = {
        type = Spel2AP.locked_items,
        name = "Tablet of Destiny Unlocked",
        lock_name = "Tablet of Destiny",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 9,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Telepack] = {
        type = Spel2AP.locked_items,
        name = "Telepack Unlocked",
        lock_name = "Telepack",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 9,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Teleporter] = {
        type = Spel2AP.locked_items,
        name = "Teleporter Unlocked",
        lock_name = "Teleporter",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 5,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.True_Crown] = {
        type = Spel2AP.locked_items,
        name = "True Crown Unlocked",
        lock_name = "True Crown",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 3,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Udjat_Eye] = {
        type = Spel2AP.locked_items,
        name = "Udjat Eye Unlocked",
        lock_name = "Udjat Eye",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 1,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Ushabti] = {
        type = Spel2AP.locked_items,
        name = "Ushabti Unlocked",
        lock_name = "Ushabti",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 3,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Vlads_Cape] = {
        type = Spel2AP.locked_items,
        name = "Vlad's Cape Unlocked",
        lock_name = "Vlad's Cape",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 5,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.locked_items.Webgun] = {
        type = Spel2AP.locked_items,
        name = "Webgun Unlocked",
        lock_name = "Webgun",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 0,
        priority = PRIORITY.UNLOCKS
    },
    [Spel2AP.upgrades.Alien_Compass] = {
        type = Spel2AP.upgrades,
        name = "Alien Compass Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 8,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Ankh] = {
        type = Spel2AP.upgrades,
        name = "Ankh Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 5,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Arrow_Of_Light] = {
        type = Spel2AP.upgrades,
        name = "Arrow of Light Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 5,
        TileX = 1,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Camera] = {
        type = Spel2AP.upgrades,
        name = "Camera Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 4,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Cape] = {
        type = Spel2AP.upgrades,
        name = "Cape Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 7,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Climbing_Gloves] = {
        type = Spel2AP.upgrades,
        name = "Climbing Gloves Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 5,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Clone_Gun] = {
        type = Spel2AP.upgrades,
        name = "Clone Gun Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 7,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Compass] = {
        type = Spel2AP.upgrades,
        name = "Compass Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 9,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Crown] = {
        type = Spel2AP.upgrades,
        name = "Crown Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 4,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Eggplant] = {
        type = Spel2AP.upgrades,
        name = "Eggplant Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 4,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Eggplant_Crown] = {
        type = Spel2AP.upgrades,
        name = "Eggplant Crown Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 5,
        TileX = 3,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Elixir] = {
        type = Spel2AP.upgrades,
        name = "Elixir Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 6,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Excalibur] = {
        type = Spel2AP.upgrades,
        name = "Excalibur Upgrade",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileX = 2,
        TileY = 10,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Four_Leaf_Clover] = {
        type = Spel2AP.upgrades,
        name = "Four-Leaf Clover Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 2,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Freeze_Ray] = {
        type = Spel2AP.upgrades,
        name = "Freeze Ray Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 2,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Hedjet] = {
        type = Spel2AP.upgrades,
        name = "Hedjet Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 3,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Hoverpack] = {
        type = Spel2AP.upgrades,
        name = "Hoverpack Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 6,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Hou_Yis_Bow] = {
        type = Spel2AP.upgrades,
        name = "Hou Yi's Bow Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 5,
        TileX = 0,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Jetpack] = {
        type = Spel2AP.upgrades,
        name = "Jetpack Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 8,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Kapala] = {
        type = Spel2AP.upgrades,
        name = "Kapala Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 2,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Machete] = {
        type = Spel2AP.upgrades,
        name = "Machete Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 8,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Mattock] = {
        type = Spel2AP.upgrades,
        name = "Mattock Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 6,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Paste] = {
        type = Spel2AP.upgrades,
        name = "Paste Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 3,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Pitchers_Mitt] = {
        type = Spel2AP.upgrades,
        name = "Pitcher's Mitt Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 6,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Plasma_Cannon] = {
        type = Spel2AP.upgrades,
        name = "Plasma Cannon Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 0,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Powerpack] = {
        type = Spel2AP.upgrades,
        name = "Powerpack Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 4,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Scepter] = {
        type = Spel2AP.upgrades,
        name = "Scepter Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 1,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Shield] = {
        type = Spel2AP.upgrades,
        name = "Shield Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 1,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Skeleton_Key] = {
        type = Spel2AP.upgrades,
        name = "Skeleton Key Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 8,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Spectacles] = {
        type = Spel2AP.upgrades,
        name = "Spectacles Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 4,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Spike_Shoes] = {
        type = Spel2AP.upgrades,
        name = "Spike Shoes Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 8,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Spring_Shoes] = {
        type = Spel2AP.upgrades,
        name = "Spring Shoes Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 0,
        TileX = 7,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Tablet_Of_Destiny] = {
        type = Spel2AP.upgrades,
        name = "Tablet of Destiny Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 9,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Telepack] = {
        type = Spel2AP.upgrades,
        name = "Telepack Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 9,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Teleporter] = {
        type = Spel2AP.upgrades,
        name = "Teleporter Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 5,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.True_Crown] = {
        type = Spel2AP.upgrades,
        name = "True Crown Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 3,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Udjat_Eye] = {
        type = Spel2AP.upgrades,
        name = "Udjat Eye Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 1,
        TileX = 1,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Ushabti] = {
        type = Spel2AP.upgrades,
        name = "Ushabti Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 3,
        TileX = 3,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Vlads_Cape] = {
        type = Spel2AP.upgrades,
        name = "Vlad's Cape Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 4,
        TileX = 5,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.upgrades.Webgun] = {
        type = Spel2AP.upgrades,
        name = "Webgun Upgrade",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0,
        TileY = 2,
        TileX = 0,
        priority = PRIORITY.UPGRADES
    },
    [Spel2AP.permanent_upgrades.Health] = {
        type = Spel2AP.permanent_upgrades,
        name = "Health Upgrade",
        display = TEXTURE.DATA_TEXTURES_FX_SMALL_0,
        TileY = 7,
        TileX = 7,
        priority = PRIORITY.STATS
    },
    [Spel2AP.permanent_upgrades.Bomb] = {
        type = Spel2AP.permanent_upgrades,
        name = "Bomb Upgrade",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 5,
        TileX = 0,
        priority = PRIORITY.STATS
    },
    [Spel2AP.permanent_upgrades.Rope] = {
        type = Spel2AP.permanent_upgrades,
        name = "Rope Upgrade",
        display = TEXTURE.DATA_TEXTURES_CHAR_YELLOW_0,
        TileY = 12,
        TileX = 4,
        priority = PRIORITY.STATS
    },
    [Spel2AP.permanent_upgrades.CO_Checkpoint] = {
        type = Spel2AP.permanent_upgrades,
        name = "Cosmic Ocean Checkpoint",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_BG_0,
        TileX = 1,
        TileY = 2,
        priority = PRIORITY.STATS
    },
    [Spel2AP.world_unlocks.Progressive] = {
        type = Spel2AP.world_unlocks,
        name = "Progressive World Unlocked",
        display = TEXTURE.DATA_TEXTURES_FX_SMALL3_0,
        TileY = 6,
        TileX = 6,
        priority = PRIORITY.WORLD
    },
    [Spel2AP.world_unlocks.Jungle] = {
        type = Spel2AP.world_unlocks,
        name = "Jungle Unlocked",
        display = TEXTURE.DATA_TEXTURES_MENU_DEATHMATCH5_0,
        TileY = 0,
        TileX = 1,
        priority = PRIORITY.WORLD
    },
    [Spel2AP.world_unlocks.Volcana] = {
        type = Spel2AP.world_unlocks,
        name = "Volcana Unlocked",
        display = TEXTURE.DATA_TEXTURES_MENU_DEATHMATCH5_0,
        TileY = 0,
        TileX = 2,
        priority = PRIORITY.WORLD
    },
    [Spel2AP.world_unlocks.Olmecs_Lair] = {
        type = Spel2AP.world_unlocks,
        name = "Olmec's Lair Unlocked",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_MONS_BIG_0,
        TileY = 0,
        TileX = 1,
        priority = PRIORITY.WORLD
    },
    [Spel2AP.world_unlocks.Tide_Pool] = {
        type = Spel2AP.world_unlocks,
        name = "Tide Pool Unlocked",
        display = TEXTURE.DATA_TEXTURES_MENU_DEATHMATCH5_0,
        TileY = 0,
        TileX = 3,
        priority = PRIORITY.WORLD
    },
    [Spel2AP.world_unlocks.Temple] = {
        type = Spel2AP.world_unlocks,
        name = "Temple Unlocked",
        display = TEXTURE.DATA_TEXTURES_MENU_DEATHMATCH5_0,
        TileY = 1,
        TileX = 0,
        priority = PRIORITY.WORLD
    },
    [Spel2AP.world_unlocks.Ice_Caves] = {
        type = Spel2AP.world_unlocks,
        name = "Ice Caves Unlocked",
        display = TEXTURE.DATA_TEXTURES_MENU_DEATHMATCH5_0,
        TileY = 1,
        TileX = 1,
        priority = PRIORITY.WORLD
    },
    [Spel2AP.world_unlocks.Neo_Babylon] = {
        type = Spel2AP.world_unlocks,
        name = "Neo Babylon Unlocked",
        display = TEXTURE.DATA_TEXTURES_MENU_DEATHMATCH5_0,
        TileY = 1,
        TileX = 2,
        priority = PRIORITY.WORLD
    },
    [Spel2AP.world_unlocks.Sunken_City] = {
        type = Spel2AP.world_unlocks,
        name = "Sunken City Unlocked",
        display = TEXTURE.DATA_TEXTURES_MENU_DEATHMATCH5_0,
        TileY = 1,
        TileX = 3,
        priority = PRIORITY.WORLD
    },
    [Spel2AP.world_unlocks.Cosmic_Ocean] = {
        type = Spel2AP.world_unlocks,
        name = "Cosmic Ocean Unlocked",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileX = 0,
        TileY = 0,
        priority = PRIORITY.WORLD
    },
    [Spel2AP.shortcuts.Progressive] = {
        type = Spel2AP.shortcuts,
        name = "Progressive Shortcut",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileX = 0,
        TileY = 0,
        priority = PRIORITY.SHORTCUT
    },
    [Spel2AP.shortcuts.Jungle] = {
        type = Spel2AP.shortcuts,
        name = "Jungle Shortcut",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileX = 0,
        TileY = 0,
        priority = PRIORITY.SHORTCUT
    },
    [Spel2AP.shortcuts.Volcana] = {
        type = Spel2AP.shortcuts,
        name = "Volcana Shortcut",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileX = 0,
        TileY = 0,
        priority = PRIORITY.SHORTCUT
    },
    [Spel2AP.shortcuts.Olmecs_Lair] = {
        type = Spel2AP.shortcuts,
        name = "Olmec's Lair Shortcut",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileX = 0,
        TileY = 0,
        priority = PRIORITY.SHORTCUT
    },
    [Spel2AP.shortcuts.Tide_Pool] = {
        type = Spel2AP.shortcuts,
        name = "Tide Pool Shortcut",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileX = 0,
        TileY = 0,
        priority = PRIORITY.SHORTCUT
    },
    [Spel2AP.shortcuts.Temple] = {
        type = Spel2AP.shortcuts,
        name = "Temple Shortcut",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileX = 0,
        TileY = 0,
        priority = PRIORITY.SHORTCUT
    },
    [Spel2AP.shortcuts.Ice_Caves] = {
        type = Spel2AP.shortcuts,
        name = "Ice Caves Shortcut",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileX = 0,
        TileY = 0,
        priority = PRIORITY.SHORTCUT
    },
    [Spel2AP.shortcuts.Neo_Babylon] = {
        type = Spel2AP.shortcuts,
        name = "Neo Babylon Shortcut",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileX = 0,
        TileY = 0,
        priority = PRIORITY.SHORTCUT
    },
    [Spel2AP.shortcuts.Sunken_City] = {
        type = Spel2AP.shortcuts,
        name = "Sunken City Shortcut",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileX = 0,
        TileY = 0,
        priority = PRIORITY.SHORTCUT
    },
    [Spel2AP.traps.Poison] = {
        type = Spel2AP.traps,
        name = "Poison Trap",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 14,
        TileX = 3,
        priority = PRIORITY.TRAP
    },
    [Spel2AP.traps.Curse] = {
        type = Spel2AP.traps,
        name = "Curse Trap",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 15,
        TileX = 4,
        priority = PRIORITY.TRAP
    },
    [Spel2AP.traps.Ghost] = {
        type = Spel2AP.traps,
        name = "Ghost Trap",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_PEOPLE_0,
        TileY = 3,
        TileX = 3,
        priority = PRIORITY.TRAP
    },
    [Spel2AP.traps.Stun] = {
        type = Spel2AP.traps,
        name = "Stun Trap",
        display = TEXTURE.DATA_TEXTURES_CHAR_YELLOW_0,
        TileY = 13,
        TileX = 4,
        priority = PRIORITY.TRAP
    },
    [Spel2AP.traps.Loose_Bombs] = {
        type = Spel2AP.traps,
        name = "Loose Bombs Trap",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 6,
        TileX = 2,
        priority = PRIORITY.TRAP
    },
    [Spel2AP.traps.Blindness] = {
        type = Spel2AP.traps,
        name = "Blindness Trap",
        display = TEXTURE.DATA_TEXTURES_FX_SMALL3_0,
        TileY = 6,
        TileX = 0,
        priority = PRIORITY.TRAP
    },
    [Spel2AP.traps.Amnesia] = {
        type = Spel2AP.traps,
        name = "Amnesia Trap",
        display = TEXTURE.DATA_TEXTURES_FX_SMALL_0,
        TileY = 3,
        TileX = 3,
        priority = PRIORITY.TRAP
    },
    [Spel2AP.traps.Angry_Shopkeepers] = {
        type = Spel2AP.traps,
        name = "Angry Shopkeepers Trap",
        display = TEXTURE.DATA_TEXTURES_JOURNAL_ENTRY_PEOPLE_0,
        TileY = 2,
        TileX = 2,
        priority = PRIORITY.TRAP
    },
    [Spel2AP.traps.Punish_Ball] = {
        type = Spel2AP.traps,
        name = "Punish Ball Trap",
        display = TEXTURE.DATA_TEXTURES_ITEMS_0,
        TileY = 6,
        TileX = 11,
        priority = PRIORITY.TRAP
    }
}

AP_Goal = {
    EASY = 0,
    HARD = 1,
    CO = 2
}

AP_Shortcut_mode = {
    OFF = 0,
    PROGRESSIVE = 1,
    INDIVIDUAL = 2
}

ItemCode_to_Index = {
    [Spel2AP.upgrades.Ankh]             = 19, [Spel2AP.locked_items.Ankh]             = 19,
    [Spel2AP.upgrades.Camera]           = 34, [Spel2AP.locked_items.Camera]           = 34,
    [Spel2AP.upgrades.Cape]             = 23, [Spel2AP.locked_items.Cape]             = 23,
    [Spel2AP.upgrades.Climbing_Gloves]  = 6,  [Spel2AP.locked_items.Climbing_Gloves]  = 6,
    [Spel2AP.upgrades.Clone_Gun]        = 32, [Spel2AP.locked_items.Clone_Gun]        = 32,
    [Spel2AP.upgrades.Compass]          = 10, [Spel2AP.locked_items.Compass]          = 10,
    [Spel2AP.upgrades.Eggplant]         = 51, [Spel2AP.locked_items.Eggplant]         = 51,
    [Spel2AP.upgrades.Eggplant_Crown]   = 17, [Spel2AP.locked_items.Eggplant_Crown]   = 17,
    [Spel2AP.upgrades.Elixir]           = 53, [Spel2AP.locked_items.Elixir]           = 53,
    [Spel2AP.upgrades.Four_Leaf_Clover] = 54, [Spel2AP.locked_items.Four_Leaf_Clover] = 54,
    [Spel2AP.upgrades.Freeze_Ray]       = 31, [Spel2AP.locked_items.Freeze_Ray]       = 31,
    [Spel2AP.upgrades.Hoverpack]        = 27, [Spel2AP.locked_items.Hoverpack]        = 27,
    [Spel2AP.upgrades.Jetpack]          = 25, [Spel2AP.locked_items.Jetpack]          = 25,
    [Spel2AP.upgrades.Kapala]           = 14, [Spel2AP.locked_items.Kapala]           = 14,
    [Spel2AP.upgrades.Machete]          = 38, [Spel2AP.locked_items.Machete]          = 38,
    [Spel2AP.upgrades.Mattock]          = 36, [Spel2AP.locked_items.Mattock]          = 36,
    [Spel2AP.upgrades.Paste]            = 4,  [Spel2AP.locked_items.Paste]            = 4,
    [Spel2AP.upgrades.Pitchers_Mitt]    = 7,  [Spel2AP.locked_items.Pitchers_Mitt]    = 7,
    [Spel2AP.upgrades.Plasma_Cannon]    = 41, [Spel2AP.locked_items.Plasma_Cannon]    = 41,
    [Spel2AP.upgrades.Powerpack]        = 28, [Spel2AP.locked_items.Powerpack]        = 28,
    [Spel2AP.upgrades.Shield]           = 46, [Spel2AP.locked_items.Shield]           = 46,
    [Spel2AP.upgrades.Skeleton_Key]     = 21, [Spel2AP.locked_items.Skeleton_Key]     = 21,
    [Spel2AP.upgrades.Spectacles]       = 5,  [Spel2AP.locked_items.Spectacles]       = 5,
    [Spel2AP.upgrades.Spike_Shoes]      = 9,  [Spel2AP.locked_items.Spike_Shoes]      = 9,
    [Spel2AP.upgrades.Spring_Shoes]     = 8,  [Spel2AP.locked_items.Spring_Shoes]     = 8,
    [Spel2AP.upgrades.Telepack]         = 26, [Spel2AP.locked_items.Telepack]         = 26,
    [Spel2AP.upgrades.Teleporter]       = 35, [Spel2AP.locked_items.Teleporter]       = 35,
    [Spel2AP.upgrades.True_Crown]       = 18, [Spel2AP.locked_items.True_Crown]       = 18,
    [Spel2AP.upgrades.Vlads_Cape]       = 24, [Spel2AP.locked_items.Vlads_Cape]       = 24,
    [Spel2AP.upgrades.Webgun]           = 29, [Spel2AP.locked_items.Webgun]           = 29,

    [Spel2AP.upgrades.Alien_Compass]     = 11, [Spel2AP.locked_items.Alien_Compass]     = 11,
    [Spel2AP.upgrades.Arrow_Of_Light]    = 44, [Spel2AP.locked_items.Arrow_Of_Light]    = 44,
    [Spel2AP.upgrades.Crown]             = 16, [Spel2AP.locked_items.Crown]             = 16,
    [Spel2AP.upgrades.Excalibur]         = 39, [Spel2AP.locked_items.Excalibur]         = 39,
    [Spel2AP.upgrades.Hedjet]            = 15, [Spel2AP.locked_items.Hedjet]            = 15,
    [Spel2AP.upgrades.Hou_Yis_Bow]       = 43, [Spel2AP.locked_items.Hou_Yis_Bow]       = 43,
    [Spel2AP.upgrades.Scepter]           = 42, [Spel2AP.locked_items.Scepter]           = 42,
    [Spel2AP.upgrades.Tablet_Of_Destiny] = 20, [Spel2AP.locked_items.Tablet_Of_Destiny] = 20,
    [Spel2AP.upgrades.Udjat_Eye]         = 13, [Spel2AP.locked_items.Udjat_Eye]         = 13,
    [Spel2AP.upgrades.Ushabti]           = 50, [Spel2AP.locked_items.Ushabti]           = 50,
}

Journal_to_ItemEnt = {
    [4]  = { type = ENT_TYPE.ITEM_PICKUP_PASTE,                     lock = Spel2AP.locked_items.Paste,              powerup = ENT_TYPE.ITEM_POWERUP_PASTE },
    [5]  = { type = ENT_TYPE.ITEM_PICKUP_SPECTACLES,                lock = Spel2AP.locked_items.Spectacles,         powerup = ENT_TYPE.ITEM_POWERUP_SPECTACLES },
    [6]  = { type = ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES,            lock = Spel2AP.locked_items.Climbing_Gloves,    powerup = ENT_TYPE.ITEM_POWERUP_CLIMBING_GLOVES },
    [7]  = { type = ENT_TYPE.ITEM_PICKUP_PITCHERSMITT,              lock = Spel2AP.locked_items.Pitchers_Mitt,      powerup = ENT_TYPE.ITEM_POWERUP_PITCHERSMITT },
    [8]  = { type = ENT_TYPE.ITEM_PICKUP_SPRINGSHOES,               lock = Spel2AP.locked_items.Spring_Shoes,       powerup = ENT_TYPE.ITEM_POWERUP_SPRING_SHOES },
    [9]  = { type = ENT_TYPE.ITEM_PICKUP_SPIKESHOES,                lock = Spel2AP.locked_items.Spike_Shoes,        powerup = ENT_TYPE.ITEM_POWERUP_SPIKE_SHOES },
    [10] = { type = ENT_TYPE.ITEM_PICKUP_COMPASS,                   lock = Spel2AP.locked_items.Compass,            powerup = ENT_TYPE.ITEM_POWERUP_COMPASS },
    [11] = { type = ENT_TYPE.ITEM_PICKUP_SPECIALCOMPASS,            lock = Spel2AP.locked_items.Alien_Compass,      powerup = ENT_TYPE.ITEM_POWERUP_SPECIALCOMPASS },
    [13] = { type = ENT_TYPE.ITEM_PICKUP_UDJATEYE,                  lock = Spel2AP.locked_items.Udjat_Eye,          powerup = ENT_TYPE.ITEM_POWERUP_UDJATEYE },
    [14] = { type = ENT_TYPE.ITEM_PICKUP_KAPALA,                    lock = Spel2AP.locked_items.Kapala,             powerup = ENT_TYPE.ITEM_POWERUP_KAPALA },
    [15] = { type = ENT_TYPE.ITEM_PICKUP_HEDJET,                    lock = Spel2AP.locked_items.Hedjet,             powerup = ENT_TYPE.ITEM_POWERUP_HEDJET },
    [16] = { type = ENT_TYPE.ITEM_PICKUP_CROWN,                     lock = Spel2AP.locked_items.Crown,              powerup = ENT_TYPE.ITEM_POWERUP_CROWN },
    [17] = { type = ENT_TYPE.ITEM_PICKUP_EGGPLANTCROWN,             lock = Spel2AP.locked_items.Eggplant_Crown,     powerup = ENT_TYPE.ITEM_POWERUP_EGGPLANTCROWN },
    [18] = { type = ENT_TYPE.ITEM_PICKUP_TRUECROWN,                 lock = Spel2AP.locked_items.True_Crown,         powerup = ENT_TYPE.ITEM_POWERUP_TRUECROWN },
    [19] = { type = ENT_TYPE.ITEM_PICKUP_ANKH,                      lock = Spel2AP.locked_items.Ankh,               powerup = ENT_TYPE.ITEM_POWERUP_ANKH },
    [20] = { type = ENT_TYPE.ITEM_PICKUP_TABLETOFDESTINY,           lock = Spel2AP.locked_items.Tablet_Of_Destiny,  powerup = ENT_TYPE.ITEM_POWERUP_TABLETOFDESTINY },
    [21] = { type = ENT_TYPE.ITEM_PICKUP_SKELETON_KEY,              lock = Spel2AP.locked_items.Skeleton_Key,       powerup = ENT_TYPE.ITEM_POWERUP_SKELETON_KEY },
    [23] = { type = ENT_TYPE.ITEM_CAPE,                             lock = Spel2AP.locked_items.Cape },
    [24] = { type = ENT_TYPE.ITEM_VLADS_CAPE,                       lock = Spel2AP.locked_items.Vlads_Cape },
    [25] = { type = ENT_TYPE.ITEM_JETPACK,                          lock = Spel2AP.locked_items.Jetpack },
    [26] = { type = ENT_TYPE.ITEM_TELEPORTER_BACKPACK,              lock = Spel2AP.locked_items.Telepack },
    [27] = { type = ENT_TYPE.ITEM_HOVERPACK,                        lock = Spel2AP.locked_items.Hoverpack },
    [28] = { type = ENT_TYPE.ITEM_POWERPACK,                        lock = Spel2AP.locked_items.Powerpack },
    [29] = { type = ENT_TYPE.ITEM_WEBGUN,                           lock = Spel2AP.locked_items.Webgun },
    [31] = { type = ENT_TYPE.ITEM_FREEZERAY,                        lock = Spel2AP.locked_items.Freeze_Ray },
    [32] = { type = ENT_TYPE.ITEM_CLONEGUN,                         lock = Spel2AP.locked_items.Clone_Gun },
    [34] = { type = ENT_TYPE.ITEM_CAMERA,                           lock = Spel2AP.locked_items.Camera },
    [35] = { type = ENT_TYPE.ITEM_TELEPORTER,                       lock = Spel2AP.locked_items.Teleporter },
    [36] = { type = ENT_TYPE.ITEM_MATTOCK,                          lock = Spel2AP.locked_items.Mattock },
    [38] = { type = ENT_TYPE.ITEM_MACHETE,                          lock = Spel2AP.locked_items.Machete },
    [39] = { type = ENT_TYPE.ITEM_EXCALIBUR,                        lock = Spel2AP.locked_items.Excalibur },
    [41] = { type = ENT_TYPE.ITEM_PLASMACANNON,                     lock = Spel2AP.locked_items.Plasma_Cannon },
    [42] = { type = ENT_TYPE.ITEM_SCEPTER,                          lock = Spel2AP.locked_items.Scepter },
    [43] = { type = ENT_TYPE.ITEM_HOUYIBOW,                         lock = Spel2AP.locked_items.Hou_Yis_Bow },
    [44] = { type = ENT_TYPE.ITEM_LIGHT_ARROW,                      lock = Spel2AP.locked_items.Arrow_Of_Light },
    [46] = { type = ENT_TYPE.ITEM_METAL_SHIELD,                     lock = Spel2AP.locked_items.Shield },
    [50] = { type = ENT_TYPE.ITEM_USHABTI,                          lock = Spel2AP.locked_items.Ushabti },
    [51] = { type = ENT_TYPE.ITEM_EGGPLANT,                         lock = Spel2AP.locked_items.Eggplant },
    [53] = { type = ENT_TYPE.ITEM_PICKUP_ELIXIR,                    lock = Spel2AP.locked_items.Elixir },
    [54] = { type = ENT_TYPE.ITEM_PICKUP_CLOVER,                    lock = Spel2AP.locked_items.Four_Leaf_Clover },
    [123] = { type = ENT_TYPE.ITEM_PURCHASABLE_CAPE,                lock = Spel2AP.locked_items.Cape },
    [126] = { type = ENT_TYPE.ITEM_PURCHASABLE_TELEPORTER_BACKPACK, lock = Spel2AP.locked_items.Telepack },
    [127] = { type = ENT_TYPE.ITEM_PURCHASABLE_HOVERPACK,           lock = Spel2AP.locked_items.Hoverpack },
    [128] = { type = ENT_TYPE.ITEM_PURCHASABLE_POWERPACK,           lock = Spel2AP.locked_items.Powerpack },
    [125] = { type = ENT_TYPE.ITEM_PURCHASABLE_JETPACK,             lock = Spel2AP.locked_items.Jetpack },
}

default_dice_prizes = {
    ENT_TYPE.ITEM_PICKUP_BOMBBAG,
    ENT_TYPE.ITEM_PICKUP_BOMBBOX,
    ENT_TYPE.ITEM_PICKUP_ROPEPILE,
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
    ENT_TYPE.ITEM_BOOMERANG,
    ENT_TYPE.ITEM_CROSSBOW,
    ENT_TYPE.ITEM_SHOTGUN,
    ENT_TYPE.ITEM_FREEZERAY,
    ENT_TYPE.ITEM_WEBGUN,
    ENT_TYPE.ITEM_CAMERA,
    ENT_TYPE.ITEM_MATTOCK,
    ENT_TYPE.ITEM_PURCHASABLE_JETPACK,
    ENT_TYPE.ITEM_PURCHASABLE_HOVERPACK,
    ENT_TYPE.ITEM_TELEPORTER,
    ENT_TYPE.ITEM_PURCHASABLE_TELEPORTER_BACKPACK,
    ENT_TYPE.ITEM_PURCHASABLE_POWERPACK
}

obnoxious_journal_entries = become_lookup_table
({
    Spel2AP.locations.bestiary.Magmar,
    Spel2AP.locations.bestiary.Lavamander,
    Spel2AP.locations.bestiary.Mech_Rider,
    Spel2AP.locations.bestiary.Queen_Bee,
    Spel2AP.locations.bestiary.Scorpion,
    Spel2AP.locations.item.True_Crown,
    Spel2AP.locations.people.Caveman_Shopkeeper
})

hard_journal_entries = become_lookup_table
({
    Spel2AP.locations.place.Tiamats_Throne,
    Spel2AP.locations.place.Sunken_City,
    Spel2AP.locations.place.Eggplant_World,
    Spel2AP.locations.place.Hunduns_Hideaway,
    Spel2AP.locations.people.Dirk_Yamaoka,
    Spel2AP.locations.people.Guy_Spelunky,
    Spel2AP.locations.people.Eggplant_King,
    Spel2AP.locations.bestiary.Tiamat,
    Spel2AP.locations.bestiary.Tadpole,
    Spel2AP.locations.bestiary.Frog,
    Spel2AP.locations.bestiary.Fire_Frog,
    Spel2AP.locations.bestiary.Goliath_Frog,
    Spel2AP.locations.bestiary.Grub,
    Spel2AP.locations.bestiary.Giant_Fly,
    Spel2AP.locations.bestiary.Hundun,
    Spel2AP.locations.bestiary.Eggplant_Minister,
    Spel2AP.locations.bestiary.Eggplup,
    Spel2AP.locations.trap.Frog_Trap,
    Spel2AP.locations.trap.Sticky_Trap,
    Spel2AP.locations.trap.Bone_Drop,
    Spel2AP.locations.trap.Egg_Sac,
})

co_journal_entries = become_lookup_table
({
    Spel2AP.locations.place.Cosmic_Ocean,
    Spel2AP.locations.people.Classic_Guy,
    Spel2AP.locations.bestiary.Celestial_Jelly,
})

unrestricted_items = become_lookup_table
({
    ENT_TYPE.ITEM_PICKUP_ROPEPILE,
    ENT_TYPE.ITEM_PICKUP_BOMBBAG,
    ENT_TYPE.ITEM_PICKUP_BOMBBOX,
    ENT_TYPE.ITEM_PICKUP_PARACHUTE,
    ENT_TYPE.ITEM_SHOTGUN,
    ENT_TYPE.ITEM_CROSSBOW,
    ENT_TYPE.ITEM_BOOMERANG,
    ENT_TYPE.ITEM_PICKUP_ROYALJELLY,
    ENT_TYPE.ITEM_WOODEN_SHIELD,
})

deathlink_reasons = {
    [CAUSE_OF_DEATH.DEATH] = "a sudden heart attack",
    [CAUSE_OF_DEATH.ENTITY] = "not managing to dodge danger",
    [CAUSE_OF_DEATH.LONG_FALL] = "breaking every bone in their body",
    [CAUSE_OF_DEATH.STILL_FALLING] = "finding a VERY big hole",
    [CAUSE_OF_DEATH.MISSED] = "teleporting into terrain",
    [CAUSE_OF_DEATH.POISONED] = "not curing their poison",
}

shortcut_door_data = {
    [1] = {26, 84, 2, THEME.JUNGLE,       TEXTURE.DATA_TEXTURES_FLOOR_JUNGLE_1,   Spel2AP.world_unlocks.Jungle,      Spel2AP.shortcuts.Jungle},
    [2] = {23, 84, 2, THEME.VOLCANA,      TEXTURE.DATA_TEXTURES_FLOOR_VOLCANO_2,  Spel2AP.world_unlocks.Volcana,     Spel2AP.shortcuts.Volcana},
    [3] = {20, 84, 3, THEME.OLMEC,        TEXTURE.DATA_TEXTURES_DECO_JUNGLE_2,    Spel2AP.world_unlocks.Olmecs_Lair, Spel2AP.shortcuts.Olmecs_Lair},
    [4] = {26, 87, 4, THEME.TIDE_POOL,    TEXTURE.DATA_TEXTURES_FLOOR_TIDEPOOL_3, Spel2AP.world_unlocks.Tide_Pool,   Spel2AP.shortcuts.Tide_Pool},
    [5] = {23, 87, 4, THEME.TEMPLE,       TEXTURE.DATA_TEXTURES_FLOOR_TEMPLE_1,   Spel2AP.world_unlocks.Temple,      Spel2AP.shortcuts.Temple},
    [6] = {20, 87, 5, THEME.ICE_CAVES,    TEXTURE.DATA_TEXTURES_FLOOR_ICE_1,      Spel2AP.world_unlocks.Ice_Caves,   Spel2AP.shortcuts.Ice_Caves},
    [7] = {26, 90, 6, THEME.NEO_BABYLON,  TEXTURE.DATA_TEXTURES_FLOOR_BABYLON_1,  Spel2AP.world_unlocks.Neo_Babylon, Spel2AP.shortcuts.Neo_Babylon},
    [8] = {23, 90, 7, THEME.SUNKEN_CITY,  TEXTURE.DATA_TEXTURES_FLOOR_SUNKEN_3,   Spel2AP.world_unlocks.Sunken_City, Spel2AP.shortcuts.Sunken_City},
    [9] = {20, 90, 7, THEME.COSMIC_OCEAN, TEXTURE.DATA_TEXTURES_FLOOR_CAVE_2},
}

function update_locked_characters()
    for locationID, _ in pairs(ap_save.checked_locations) do
        local starterEntity = starter_lookup[locationID]
        if starterEntity == nil then
            goto continue
        end
        for i = #locked_starters, 1, -1 do
            if locked_starters[i] == starterEntity then
                table.remove(locked_starters, i)
                break
            end
        end
        ::continue::
    end
end