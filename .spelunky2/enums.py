from enum import IntEnum, StrEnum

JOURNAL_SUFFIX = " Journal Entry"
UPGRADE_SUFFIX = " Upgrade"
SHORTCUT_SUFFIX = " Shortcut"
VICTORY_STRING = "Victory"
WORLD_2_STRING = "Any World 2"

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

    # Traps
    ARROW_TRAP = "Arrow Trap"
    LASER_TRAP = "Laser Trap"
    POISON_DART_TRAP = "Poison Dart Trap"
    CRUSH_TRAP = "Crush Trap"
    FALLING_PLATFORM = "Falling Platform"
    SPIKE_PIT = "Spike Pit"

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