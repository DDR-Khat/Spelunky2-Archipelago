from enum import IntEnum, StrEnum

JOURNAL_SUFFIX = " Journal Entry"
UPGRADE_SUFFIX = " Upgrade"
SHORTCUT_SUFFIX = " Shortcut"
VICTORY_STRING = "Victory"
WORLD_2_STRING = "Any World 2"
MENU_STRING = "Menu"

class Spelunky2Goal(IntEnum):
    EASY = 0
    HARD = 1
    CO = 2


class WorldName(StrEnum):
    # Worlds
    DWELLING = "Dwelling"
    JUNGLE = "Jungle"
    VOLCANA = "Volcana"
    OLMECS_LAIR = "Olmec's Lair"
    TIDE_POOL = "Tide Pool"
    TEMPLE = "Temple"
    ICE_CAVES = "Ice Caves"
    NEO_BABYLON = "Neo Babylon"
    SUNKEN_CITY = "Sunken City"
    COSMIC_OCEAN = "Cosmic Ocean"
    EGGPLANT = "Eggplant World"
    PROGRESSIVE = "Progressive World Unlock"
    

class ShortcutName(StrEnum):
    # Shortcuts
    PROGRESSIVE = "Progressive" + SHORTCUT_SUFFIX
    DWELLING = WorldName.DWELLING.value + SHORTCUT_SUFFIX
    JUNGLE = WorldName.JUNGLE.value + SHORTCUT_SUFFIX
    VOLCANA = WorldName.VOLCANA.value + SHORTCUT_SUFFIX
    OLMECS_LAIR = WorldName.OLMECS_LAIR.value + SHORTCUT_SUFFIX
    TIDE_POOL = WorldName.TIDE_POOL.value + SHORTCUT_SUFFIX
    TEMPLE = WorldName.TEMPLE.value + SHORTCUT_SUFFIX
    ICE_CAVES = WorldName.ICE_CAVES.value + SHORTCUT_SUFFIX
    NEO_BABYLON = WorldName.NEO_BABYLON.value + SHORTCUT_SUFFIX
    SUNKEN_CITY = WorldName.SUNKEN_CITY.value + SHORTCUT_SUFFIX


class ItemName(StrEnum):
    # Filler Items
    ROPE_PILE = "Rope Pile"
    BOMB_BAG = "Bomb Bag"
    BOMB_BOX = "Bomb Box"
    COOKED_TURKEY = "Cooked Turkey"
    ROYAL_JELLY = "Royal Jelly"
    GOLD_BAR = "Gold Bar"
    EMERALD_GEM = "Emerald Gem"
    SAPPHIRE_GEM = "Sapphire Gem"
    RUBY_GEM = "Ruby Gem"
    DIAMOND_GEM = "Diamond Gem"

    # Quest Items
    ALIEN_COMPASS = "Alien Compass"
    ARROW_OF_LIGHT = "Arrow of Light"
    CROWN = "Crown"
    HEDJET = "Hedjet"
    EGGPLANT_CROWN = "Eggplant Crown"
    EGGPLANT_CHILD = "Eggplant Child"
    TRUE_CROWN = "True Crown"
    CROSSBOW = "Crossbow"
    HOU_YI_BOW = "Hou Yi's Bow"
    UDJAT_EYE = "Udjat Eye"
    ANKH = "Ankh"
    TABLET_OF_DESTINY = "Tablet of Destiny"
    EXCALIBUR = "Excalibur"

    # Powerups
    ELIXIR = "Elixir"
    FOUR_LEAF_CLOVER = "Four-Leaf Clover"
    KAPALA = "Kapala"
    SPECTACLES = "Spectacles"

    # Equipment
    CAMERA = "Camera"
    CLONE_GUN = "Clone Gun"
    EGGPLANT = "Eggplant"
    FREEZE_RAY = "Freeze Ray"
    MACHETE = "Machete"
    MATTOCK = "Mattock"
    PLASMA_CANNON = "Plasma Cannon"
    SHIELD = "Shield"
    TELEPACK = "Telepack"
    WEBGUN = "Webgun"

    # Quest items (extras)
    SCEPTER = "Scepter"
    USHABTI = "Ushabti"

    # Upgrades
    COMPASS = "Compass"
    CLIMBING_GLOVES = "Climbing Gloves"
    SPRING_SHOES = "Spring Shoes"
    SPIKE_SHOES = "Spike Shoes"
    JETPACK = "Jetpack"
    HOVERPACK = "Hoverpack"
    POWERPACK = "Powerpack"
    TELEPORTER = "Teleporter"
    PARACHUTE = "Parachute"
    CAPE = "Cape"
    VLADS_CAPE = "Vlad's Cape"
    PITCHERS_MITT = "Pitcher's Mitt"
    SKELETON_KEY = "Skeleton Key"
    PASTE = "Paste"

    # Permanent Upgrades
    HEALTH_UPGRADE = "Health" + UPGRADE_SUFFIX
    BOMB_UPGRADE = "Bomb" + UPGRADE_SUFFIX
    ROPE_UPGRADE = "Rope" + UPGRADE_SUFFIX
    COSMIC_OCEAN_CP = "Cosmic Ocean Checkpoint"

    # AP Traps
    POISON_TRAP = "Poison Trap"
    CURSE_TRAP = "Curse Trap"
    GHOST_TRAP = "Ghost Trap"
    STUN_TRAP = "Stun Trap"
    LOOSE_BOMBS_TRAP = "Loose Bombs Trap"
    BLINDNESS_TRAP = "Blindness Trap"
    AMNESIA_TRAP = "Amnesia Trap"
    ANGRY_SHOPKEEPERS_TRAP = "Angry Shopkeepers Trap"
    PUNISH_BALL_TRAP = "Punish Ball Trap"

    # Characters
    ANA_SPELUNKY = "Ana Spelunky"
    ALTO_SINGH = "Alto Singh"
    LISE_PROJECT = "Lise Project"
    TINA_FLAN = "Tina Flan"
    DEMI_VON_DIAMONDS = "Demi Von Diamonds"
    PILOT = "Pilot"
    PRINCESS_AIRYN = "Princess Airyn"
    TERRA_TUNNEL = "Terra Tunnel"
    HIRED_HAND = "Hired Hand"
    MARGARET_TUNNEL = "Margaret Tunnel"
    COLIN_NORTHWARD = "Colin Northward"
    ROFFY_D_SLOTH = "Roffy D. Sloth"
    LIZ_MUTTON = "Liz Mutton"
    NEKKA_THE_EAGLE = "Nekka the Eagle"
    LISE_SYSTEM = "Lise System"
    COCO_VON_DIAMONDS = "Coco Von Diamonds"
    MANFRED_TUNNEL = "Manfred Tunnel"
    LITTLE_JAY = "Little Jay"
    TIJERINA_SPINK = "Tijerina Spink"
    VALERIE_CRUMP = "Valerie Crump"
    AU = "Au"
    DIRK_YAMAOKA = "Dirk Yamaoka"
    GUY_SPELUNKY = "Guy Spelunky"
    CLASSIC_GUY = "Classic Guy"
    HIRELING = "Hireling"


class LocationName(StrEnum):
    BLACK_MARKET = "Black Market"
    VLADS_CASTLE = "Vlad's Castle"
    ABZU = "Abzu"
    CITY_OF_GOLD = "City of Gold"
    DUAT = "Duat"
    MOTHERSHIP = "Mothership"
    TIAMAT_THRONE = "Tiamat's Throne"
    HUNDUN_HIDEAWAY = "Hundun's Hideaway"


class JournalName(StrEnum):
    DWELLING = WorldName.DWELLING.value + JOURNAL_SUFFIX
    JUNGLE = WorldName.JUNGLE.value + JOURNAL_SUFFIX
    VOLCANA = WorldName.VOLCANA.value + JOURNAL_SUFFIX
    OLMECS_LAIR = WorldName.OLMECS_LAIR.value + JOURNAL_SUFFIX
    TIDE_POOL = WorldName.TIDE_POOL.value + JOURNAL_SUFFIX
    ABZU = LocationName.ABZU.value + JOURNAL_SUFFIX
    TEMPLE = WorldName.TEMPLE.value + JOURNAL_SUFFIX
    CITY_OF_GOLD = LocationName.CITY_OF_GOLD.value + JOURNAL_SUFFIX
    DUAT = LocationName.DUAT.value + JOURNAL_SUFFIX
    ICE_CAVES = WorldName.ICE_CAVES.value + JOURNAL_SUFFIX
    NEO_BABYLON = WorldName.NEO_BABYLON.value + JOURNAL_SUFFIX
    TIAMAT_THRONE = LocationName.TIAMAT_THRONE + JOURNAL_SUFFIX
    SUNKEN_CITY = WorldName.SUNKEN_CITY.value + JOURNAL_SUFFIX
    EGGPLANT_WORLD = WorldName.EGGPLANT.value + JOURNAL_SUFFIX
    HUNDUN_HIDEAWAY = LocationName.HUNDUN_HIDEAWAY + JOURNAL_SUFFIX
    COSMIC_OCEAN = WorldName.COSMIC_OCEAN.value + JOURNAL_SUFFIX
    ALTO_SINGH = ItemName.ALTO_SINGH.value + JOURNAL_SUFFIX
    LIZ_MUTTON = ItemName.LIZ_MUTTON.value + JOURNAL_SUFFIX
    NEKKA_THE_EAGLE = ItemName.NEKKA_THE_EAGLE.value + JOURNAL_SUFFIX
    LISE_PROJECT = ItemName.LISE_PROJECT.value + JOURNAL_SUFFIX
    COCO_VON_DIAMONDS = ItemName.COCO_VON_DIAMONDS.value + JOURNAL_SUFFIX
    MANFRED_TUNNEL = ItemName.MANFRED_TUNNEL.value + JOURNAL_SUFFIX
    LITTLE_JAY = ItemName.LITTLE_JAY.value + JOURNAL_SUFFIX
    TINA_FLAN = ItemName.TINA_FLAN.value + JOURNAL_SUFFIX
    VALERIE_CRUMP = ItemName.VALERIE_CRUMP.value + JOURNAL_SUFFIX
    AU = ItemName.AU.value + JOURNAL_SUFFIX
    DEMI_VON_DIAMONDS = ItemName.DEMI_VON_DIAMONDS.value + JOURNAL_SUFFIX
    PILOT = ItemName.PILOT.value + JOURNAL_SUFFIX
    PRINCESS_AIRYN = ItemName.PRINCESS_AIRYN.value + JOURNAL_SUFFIX
    DIRK_YAMAOKA = ItemName.DIRK_YAMAOKA.value + JOURNAL_SUFFIX
    GUY_SPELUNKY = ItemName.GUY_SPELUNKY.value + JOURNAL_SUFFIX
    CLASSIC_GUY = ItemName.CLASSIC_GUY.value + JOURNAL_SUFFIX
    TERRA_TUNNEL = ItemName.TERRA_TUNNEL.value + JOURNAL_SUFFIX
    HIRED_HAND = ItemName.HIRED_HAND.value + JOURNAL_SUFFIX
    EGGPLANT_CHILD = ItemName.EGGPLANT_CHILD.value + JOURNAL_SUFFIX
    SHOPKEEPER = "Shopkeeper" + JOURNAL_SUFFIX
    TUN = "Tun" + JOURNAL_SUFFIX
    YANG = "Yang" + JOURNAL_SUFFIX
    MADAME_TUSK = "Madame Tusk" + JOURNAL_SUFFIX
    TUSK_BODYGUARD = "Tusk's Bodyguard" + JOURNAL_SUFFIX
    WADDLER = "Waddler" + JOURNAL_SUFFIX
    CAVEMAN_SHOPKEEPER = "Caveman Shopkeeper" + JOURNAL_SUFFIX
    GHIST_SHOPKEEPER = "Ghist Shopkeeper" + JOURNAL_SUFFIX
    VAN_HORSING = "Van Horsing" + JOURNAL_SUFFIX
    PARSLEY = "Parsley" + JOURNAL_SUFFIX
    PARSNIP = "Parsnip" + JOURNAL_SUFFIX
    PARMESAN = "Parmesan" + JOURNAL_SUFFIX
    SPARROW = "Sparrow" + JOURNAL_SUFFIX
    BEG = "Beg" + JOURNAL_SUFFIX
    EGGPLANT_KING = "Eggplant King" + JOURNAL_SUFFIX
    SNAKE = "Snake" + JOURNAL_SUFFIX
    SPIDER = "Spider" + JOURNAL_SUFFIX
    BAT = "Bat" + JOURNAL_SUFFIX
    CAVEMAN = "Caveman" + JOURNAL_SUFFIX
    SKELETON = "Skeleton" + JOURNAL_SUFFIX
    HORNED_LIZARD = "Horned Lizard" + JOURNAL_SUFFIX
    CAVE_MOLE = "Cave Mole" + JOURNAL_SUFFIX
    QUILLBACK = "Quillback" + JOURNAL_SUFFIX
    MANTRAP = "Mantrap" + JOURNAL_SUFFIX
    TIKI_MAN = "Tiki Man" + JOURNAL_SUFFIX
    WITCH_DOCTOR = "Witch Doctor" + JOURNAL_SUFFIX
    MOSQUITO = "Mosquito" + JOURNAL_SUFFIX
    MONKEY = "Monkey" + JOURNAL_SUFFIX
    HANG_SPIDER = "Hang Spider" + JOURNAL_SUFFIX
    GIANT_SPIDER = "Giant Spider" + JOURNAL_SUFFIX
    MAGMAR = "Magmar" + JOURNAL_SUFFIX
    ROBOT = "Robot" + JOURNAL_SUFFIX
    FIRE_BUG = "Fire Bug" + JOURNAL_SUFFIX
    IMP = "Imp" + JOURNAL_SUFFIX
    LAVAMANDER = "Lavamander" + JOURNAL_SUFFIX
    VAMPIRE = "Vampire" + JOURNAL_SUFFIX
    VLAD = "Vlad" + JOURNAL_SUFFIX
    OLMEC = "Olmec" + JOURNAL_SUFFIX
    JIANGSHI = "Jiangshi" + JOURNAL_SUFFIX
    JIANGSHI_ASSASSIN = "Jiangshi Assassin" + JOURNAL_SUFFIX
    FLYING_FISH = "Flying Fish" + JOURNAL_SUFFIX
    OCTOPY = "Octopy" + JOURNAL_SUFFIX
    HERMIT_CRAB = "Hermit Crab" + JOURNAL_SUFFIX
    PANGXIE = "Pangxie" + JOURNAL_SUFFIX
    GREAT_HUMPHEAD = "Great Humphead" + JOURNAL_SUFFIX
    KINGU = "Kingu" + JOURNAL_SUFFIX
    CROCMAN = "Crocman" + JOURNAL_SUFFIX
    COBRA = "Cobra" + JOURNAL_SUFFIX
    MUMMY = "Mummy" + JOURNAL_SUFFIX
    SORCERESS = "Sorceress" + JOURNAL_SUFFIX
    CAT_MUMMY = "Cat Mummy" + JOURNAL_SUFFIX
    NECROMANCER = "Necromancer" + JOURNAL_SUFFIX
    ANUBIS = "Anubis" + JOURNAL_SUFFIX
    AMMIT = "Ammit" + JOURNAL_SUFFIX
    APEP = "Apep" + JOURNAL_SUFFIX
    ANUBIS_II = "Anubis II" + JOURNAL_SUFFIX
    OSIRIS = "Osiris" + JOURNAL_SUFFIX
    UFO = "UFO" + JOURNAL_SUFFIX
    ALIEN = "Alien" + JOURNAL_SUFFIX
    YETI = "Yeti" + JOURNAL_SUFFIX
    YETI_KING = "Yeti King" + JOURNAL_SUFFIX
    YETI_QUEEN = "Yeti Queen" + JOURNAL_SUFFIX
    ALIEN_QUEEN_LAMAHU = "Alien Queen Lamahu" + JOURNAL_SUFFIX
    PROTO_SHOPKEEPER = "Proto Shopkeeper" + JOURNAL_SUFFIX
    OLMITE = "Olmite" + JOURNAL_SUFFIX
    LAMASSU = "Lamassu" + JOURNAL_SUFFIX
    TIAMAT = "Tiamat" + JOURNAL_SUFFIX
    TADPOLE = "Tadpole" + JOURNAL_SUFFIX
    FROG = "Frog" + JOURNAL_SUFFIX
    FIRE_FROG = "Fire Frog" + JOURNAL_SUFFIX
    GOLIATH_FROG = "Goliath Frog" + JOURNAL_SUFFIX
    GRUB = "Grub" + JOURNAL_SUFFIX
    GIANT_FLY = "Giant Fly" + JOURNAL_SUFFIX
    HUNDUN = "Hundun" + JOURNAL_SUFFIX
    EGGPLANT_MINISTER = "Eggplant Minister" + JOURNAL_SUFFIX
    EGGPLUP = "Eggplup" + JOURNAL_SUFFIX
    CELESTIAL_JELLY = "Celestial Jelly" + JOURNAL_SUFFIX
    SCORPION = "Scorpion" + JOURNAL_SUFFIX
    BEE = "Bee" + JOURNAL_SUFFIX
    QUEEN_BEE = "Queen Bee" + JOURNAL_SUFFIX
    SCARAB = "Scarab" + JOURNAL_SUFFIX
    GOLDEN_MONKEY = "Golden Monkey" + JOURNAL_SUFFIX
    LEPRECHAUN = "Leprechaun" + JOURNAL_SUFFIX
    MONTY = "Monty" + JOURNAL_SUFFIX
    PERCY = "Percy" + JOURNAL_SUFFIX
    POOCHI = "Poochi" + JOURNAL_SUFFIX
    GHIST = "Ghist" + JOURNAL_SUFFIX
    GHOST = "Ghost" + JOURNAL_SUFFIX
    CAVE_TURKEY = "Cave Turkey" + JOURNAL_SUFFIX
    ROCK_DOG = "Rock Dog" + JOURNAL_SUFFIX
    AXOLOTL = "Axolotl" + JOURNAL_SUFFIX
    QILIN = "Qilin" + JOURNAL_SUFFIX
    MECH_RIDER = "Mech Rider" + JOURNAL_SUFFIX
    ROPE_PILE = ItemName.ROPE_PILE.value + JOURNAL_SUFFIX
    BOMB_BAG = ItemName.BOMB_BAG.value + JOURNAL_SUFFIX
    BOMB_BOX = ItemName.BOMB_BOX.value + JOURNAL_SUFFIX
    PASTE = ItemName.PASTE.value + JOURNAL_SUFFIX
    SPECTACLES = ItemName.SPECTACLES.value + JOURNAL_SUFFIX
    CLIMBING_GLOVES = ItemName.CLIMBING_GLOVES.value + JOURNAL_SUFFIX
    PITCHERS_MITT = ItemName.PITCHERS_MITT.value + JOURNAL_SUFFIX
    SPRING_SHOES = ItemName.SPRING_SHOES.value + JOURNAL_SUFFIX
    SPIKE_SHOES = ItemName.SPIKE_SHOES.value + JOURNAL_SUFFIX
    COMPASS = ItemName.COMPASS.value + JOURNAL_SUFFIX
    ALIEN_COMPASS = ItemName.ALIEN_COMPASS.value + JOURNAL_SUFFIX
    PARACHUTE = ItemName.PARACHUTE.value + JOURNAL_SUFFIX
    UDJAT_EYE = ItemName.UDJAT_EYE.value + JOURNAL_SUFFIX
    KAPALA = ItemName.KAPALA.value + JOURNAL_SUFFIX
    HEDJET = ItemName.HEDJET.value + JOURNAL_SUFFIX
    CROWN = ItemName.CROWN.value + JOURNAL_SUFFIX
    EGGPLANT_CROWN = ItemName.EGGPLANT_CROWN.value + JOURNAL_SUFFIX
    TRUE_CROWN = ItemName.TRUE_CROWN.value + JOURNAL_SUFFIX
    ANKH = ItemName.ANKH.value + JOURNAL_SUFFIX
    TABLET_OF_DESTINY = ItemName.TABLET_OF_DESTINY.value + JOURNAL_SUFFIX
    SKELETON_KEY = ItemName.SKELETON_KEY.value + JOURNAL_SUFFIX
    ROYAL_JELLY = ItemName.ROYAL_JELLY.value + JOURNAL_SUFFIX
    CAPE = ItemName.CAPE.value + JOURNAL_SUFFIX
    VLADS_CAPE = ItemName.VLADS_CAPE.value + JOURNAL_SUFFIX
    JETPACK = ItemName.JETPACK.value + JOURNAL_SUFFIX
    TELEPACK = ItemName.TELEPACK.value + JOURNAL_SUFFIX
    HOVERPACK = ItemName.HOVERPACK.value + JOURNAL_SUFFIX
    POWERPACK = ItemName.POWERPACK.value + JOURNAL_SUFFIX
    WEBGUN = ItemName.WEBGUN.value + JOURNAL_SUFFIX
    SHOTGUN = "Shotgun" + JOURNAL_SUFFIX
    FREEZE_RAY = ItemName.FREEZE_RAY.value + JOURNAL_SUFFIX
    CLONE_GUN = ItemName.CLONE_GUN.value + JOURNAL_SUFFIX
    CROSSBOW = ItemName.CROSSBOW.value + JOURNAL_SUFFIX
    CAMERA = ItemName.CAMERA.value + JOURNAL_SUFFIX
    TELEPORTER = ItemName.TELEPORTER.value + JOURNAL_SUFFIX
    MATTOCK = ItemName.MATTOCK.value + JOURNAL_SUFFIX
    BOOMERANG = "Boomerang" + JOURNAL_SUFFIX
    MACHETE = ItemName.MACHETE.value + JOURNAL_SUFFIX
    EXCALIBUR = ItemName.EXCALIBUR.value + JOURNAL_SUFFIX
    BROKEN_SWORD = "Broken Sword" + JOURNAL_SUFFIX
    PLASMA_CANNON = ItemName.PLASMA_CANNON.value + JOURNAL_SUFFIX
    SCEPTER = ItemName.SCEPTER.value + JOURNAL_SUFFIX
    HOU_YI_BOW = ItemName.HOU_YI_BOW.value + JOURNAL_SUFFIX
    ARROW_OF_LIGHT = ItemName.ARROW_OF_LIGHT.value + JOURNAL_SUFFIX
    WOODEN_SHIELD = "Wooden Shield" + JOURNAL_SUFFIX
    METAL_SHIELD = "Metal Shield" + JOURNAL_SUFFIX
    IDOL = "Idol" + JOURNAL_SUFFIX
    THE_TUSK_IDOL = "The Tusk Idol" + JOURNAL_SUFFIX
    CURSE_POT = "Curse Pot" + JOURNAL_SUFFIX
    USHABTI = ItemName.USHABTI.value + JOURNAL_SUFFIX
    EGGPLANT = ItemName.EGGPLANT.value + JOURNAL_SUFFIX
    COOKED_TURKEY = ItemName.COOKED_TURKEY.value + JOURNAL_SUFFIX
    ELIXIR = ItemName.ELIXIR.value + JOURNAL_SUFFIX
    FOUR_LEAF_CLOVER = ItemName.FOUR_LEAF_CLOVER.value + JOURNAL_SUFFIX
    SPIKES = "Spikes" + JOURNAL_SUFFIX
    ARROW_TRAP = "Arrow Trap" + JOURNAL_SUFFIX
    TOTEM_TRAP = "Totem Trap" + JOURNAL_SUFFIX
    LOG_TRAP = "Log Trap" + JOURNAL_SUFFIX
    SPEAR_TRAP = "Spear Trap" + JOURNAL_SUFFIX
    THORNY_VINE = "Thorny Vine" + JOURNAL_SUFFIX
    BEAR_TRAP = "Bear Trap" + JOURNAL_SUFFIX
    POWDER_BOX = "Powder Box" + JOURNAL_SUFFIX
    FALLING_PLATFORM = "Falling Platform" + JOURNAL_SUFFIX
    SPIKEBALL = "Spikeball" + JOURNAL_SUFFIX
    LION_TRAP = "Lion Trap" + JOURNAL_SUFFIX
    GIANT_CLAM = "Giant Clam" + JOURNAL_SUFFIX
    SLIDING_WALL = "Sliding Wall" + JOURNAL_SUFFIX
    CRUSH_TRAP = "Crush Trap" + JOURNAL_SUFFIX
    GIANT_CRUSH_TRAP = "Giant Crush Trap" + JOURNAL_SUFFIX
    BOULDER = "Boulder" + JOURNAL_SUFFIX
    SPRING_TRAP = "Spring Trap" + JOURNAL_SUFFIX
    LANDMINE = "Landmine" + JOURNAL_SUFFIX
    LASER_TRAP = "Laser Trap" + JOURNAL_SUFFIX
    SPARK_TRAP = "Spark Trap" + JOURNAL_SUFFIX
    FROG_TRAP = "Frog Trap" + JOURNAL_SUFFIX
    STICKY_TRAP = "Sticky Trap" + JOURNAL_SUFFIX
    BONE_DROP = "Bone Drop" + JOURNAL_SUFFIX
    EGG_SAC = "Egg Sac" + JOURNAL_SUFFIX


class RuleNames(StrEnum):
    MENU_TO_DWELLING = MENU_STRING + " -> " + WorldName.DWELLING.value
    MENU_TO_OLMECS_LAIR = MENU_STRING + " -> " + WorldName.OLMECS_LAIR.value
    MENU_TO_ICE_CAVES = MENU_STRING + " -> " + WorldName.ICE_CAVES.value
    DWELLING_TO_ANY_WORLD_2 = WorldName.DWELLING.value + " -> " + WORLD_2_STRING
    JUNGLE_TO_BLACK_MARKET = WorldName.JUNGLE.value + " -> " + LocationName.BLACK_MARKET.value
    VOLCANA_TO_VLADS_CASTLE = WorldName.VOLCANA.value + " -> " + LocationName.VLADS_CASTLE.value
    TEMPLE_TO_CITY_OF_GOLD = WorldName.TEMPLE.value + " -> " + LocationName.CITY_OF_GOLD.value
    CITY_OF_GOLD_TO_DUAT = LocationName.CITY_OF_GOLD.value + " -> " + LocationName.DUAT.value
    ICE_CAVES_TO_MOTHERSHIP = WorldName.ICE_CAVES.value + " -> " + LocationName.MOTHERSHIP.value
    NEO_BABYLON_TO_SUNKEN_CITY = WorldName.NEO_BABYLON.value + " -> " + WorldName.SUNKEN_CITY.value
    SUNKEN_CITY_TO_EGGPLANT_WORLD = WorldName.SUNKEN_CITY.value + " -> " + WorldName.EGGPLANT.value
    SUNKEN_CITY_TO_COSMIC_OCEAN = WorldName.SUNKEN_CITY.value + " -> " + WorldName.COSMIC_OCEAN.value