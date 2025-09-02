from enum import IntEnum, StrEnum

JOURNAL_SUFFIX = " Journal Entry"
UPGRADE_SUFFIX = " Upgrade"
SHORTCUT_SUFFIX = " Shortcut"
VICTORY_STRING = "Victory"


class Spelunky2Goal(IntEnum):
    EASY = 0
    HARD = 1
    CO = 2


# -------------------------
# Base Item Names
# -------------------------


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
    EGGPLANT_WORLD = "Eggplant World"
    PROGRESSIVE_WORLD = "Progressive World Unlock"

    # Shortcuts
    PROGRESSIVE_SHORTCUT = "Progressive" + SHORTCUT_SUFFIX
    DWELLING_SHORTCUT = "Dwelling" + SHORTCUT_SUFFIX
    JUNGLE_SHORTCUT = "Jungle" + SHORTCUT_SUFFIX
    VOLCANA_SHORTCUT = "Volcana" + SHORTCUT_SUFFIX
    OLMECS_LAIR_SHORTCUT = "Olmec's Lair" + SHORTCUT_SUFFIX
    TIDE_POOL_SHORTCUT = "Tide Pool" + SHORTCUT_SUFFIX
    TEMPLE_SHORTCUT = "Temple" + SHORTCUT_SUFFIX
    ICE_CAVES_SHORTCUT = "Ice Caves" + SHORTCUT_SUFFIX
    NEO_BABYLON_SHORTCUT = "Neo Babylon" + SHORTCUT_SUFFIX
    SUNKEN_CITY_SHORTCUT = "Sunken City" + SHORTCUT_SUFFIX

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

# -------------------------
# Location Names
# -------------------------


class LocationName(StrEnum):
    # -------------------------
    # Journal Entries (from Locations.py order)
    # -------------------------
    MAGMAR_JOURNAL = "Magmar" + JOURNAL_SUFFIX
    LAVAMANDER_JOURNAL = "Lavamander" + JOURNAL_SUFFIX
    MECH_RIDER_JOURNAL = "Mech Rider" + JOURNAL_SUFFIX
    ROPE_PILE_JOURNAL = ItemName.ROPE_PILE.value + JOURNAL_SUFFIX
    BOMB_BAG_JOURNAL = ItemName.BOMB_BAG.value + JOURNAL_SUFFIX
    BOMB_BOX_JOURNAL = ItemName.BOMB_BOX.value + JOURNAL_SUFFIX
    COOKED_TURKEY_JOURNAL = ItemName.COOKED_TURKEY.value + JOURNAL_SUFFIX
    ROYAL_JELLY_JOURNAL = ItemName.ROYAL_JELLY.value + JOURNAL_SUFFIX
    GOLD_BAR_JOURNAL = ItemName.GOLD_BAR.value + JOURNAL_SUFFIX
    EMERALD_GEM_JOURNAL = ItemName.EMERALD_GEM.value + JOURNAL_SUFFIX
    SAPPHIRE_GEM_JOURNAL = ItemName.SAPPHIRE_GEM.value + JOURNAL_SUFFIX
    RUBY_GEM_JOURNAL = ItemName.RUBY_GEM.value + JOURNAL_SUFFIX
    DIAMOND_GEM_JOURNAL = ItemName.DIAMOND_GEM.value + JOURNAL_SUFFIX
    ALIEN_COMPASS_JOURNAL = ItemName.ALIEN_COMPASS.value + JOURNAL_SUFFIX
    ARROW_OF_LIGHT_JOURNAL = ItemName.ARROW_OF_LIGHT.value + JOURNAL_SUFFIX
    CROWN_JOURNAL = ItemName.CROWN.value + JOURNAL_SUFFIX
    HEDJET_JOURNAL = ItemName.HEDJET.value + JOURNAL_SUFFIX
    EGGPLANT_CROWN_JOURNAL = ItemName.EGGPLANT_CROWN.value + JOURNAL_SUFFIX
    EGGPLANT_CHILD_JOURNAL = ItemName.EGGPLANT_CHILD.value + JOURNAL_SUFFIX
    TRUE_CROWN_JOURNAL = ItemName.TRUE_CROWN.value + JOURNAL_SUFFIX
    CROSSBOW_JOURNAL = ItemName.CROSSBOW.value + JOURNAL_SUFFIX
    HOU_YI_BOW_JOURNAL = ItemName.HOU_YI_BOW.value + JOURNAL_SUFFIX
    UDJAT_EYE_JOURNAL = ItemName.UDJAT_EYE.value + JOURNAL_SUFFIX
    ANKH_JOURNAL = ItemName.ANKH.value + JOURNAL_SUFFIX
    TABLET_OF_DESTINY_JOURNAL = ItemName.TABLET_OF_DESTINY.value + JOURNAL_SUFFIX
    EXCALIBUR_JOURNAL = ItemName.EXCALIBUR.value + JOURNAL_SUFFIX
    COMPASS_JOURNAL = ItemName.COMPASS.value + JOURNAL_SUFFIX
    CLIMBING_GLOVES_JOURNAL = ItemName.CLIMBING_GLOVES.value + JOURNAL_SUFFIX
    SPRING_SHOES_JOURNAL = ItemName.SPRING_SHOES.value + JOURNAL_SUFFIX
    SPIKE_SHOES_JOURNAL = ItemName.SPIKE_SHOES.value + JOURNAL_SUFFIX
    JETPACK_JOURNAL = ItemName.JETPACK.value + JOURNAL_SUFFIX
    HOVERPACK_JOURNAL = ItemName.HOVERPACK.value + JOURNAL_SUFFIX
    POWERPACK_JOURNAL = ItemName.POWERPACK.value + JOURNAL_SUFFIX
    TELEPORTER_JOURNAL = ItemName.TELEPORTER.value + JOURNAL_SUFFIX
    PARACHUTE_JOURNAL = ItemName.PARACHUTE.value + JOURNAL_SUFFIX
    CAPE_JOURNAL = ItemName.CAPE.value + JOURNAL_SUFFIX
    VLADS_CAPE_JOURNAL = ItemName.VLADS_CAPE.value + JOURNAL_SUFFIX
    PITCHERS_MITT_JOURNAL = ItemName.PITCHERS_MITT.value + JOURNAL_SUFFIX
    SKELETON_KEY_JOURNAL = ItemName.SKELETON_KEY.value + JOURNAL_SUFFIX
    PASTE_JOURNAL = ItemName.PASTE.value + JOURNAL_SUFFIX
    HEALTH_UPGRADE_JOURNAL = ItemName.HEALTH_UPGRADE.value + JOURNAL_SUFFIX
    BOMB_UPGRADE_JOURNAL = ItemName.BOMB_UPGRADE.value + JOURNAL_SUFFIX
    ROPE_UPGRADE_JOURNAL = ItemName.ROPE_UPGRADE.value + JOURNAL_SUFFIX
    ANA_SPELUNKY_JOURNAL = ItemName.ANA_SPELUNKY.value + JOURNAL_SUFFIX
    MARGARET_TUNNEL_JOURNAL = ItemName.MARGARET_TUNNEL.value + JOURNAL_SUFFIX
    COLIN_NORTHWARD_JOURNAL = ItemName.COLIN_NORTHWARD.value + JOURNAL_SUFFIX
    ROFFY_D_SLOTH_JOURNAL = ItemName.ROFFY_D_SLOTH.value + JOURNAL_SUFFIX
    LIZ_MUTTON_JOURNAL = ItemName.LIZ_MUTTON.value + JOURNAL_SUFFIX
    NEKKA_THE_EAGLE_JOURNAL = ItemName.NEKKA_THE_EAGLE.value + JOURNAL_SUFFIX
    LISE_SYSTEM_JOURNAL = ItemName.LISE_SYSTEM.value + JOURNAL_SUFFIX
    COCO_VON_DIAMONDS_JOURNAL = ItemName.COCO_VON_DIAMONDS.value + JOURNAL_SUFFIX
    MANFRED_TUNNEL_JOURNAL = ItemName.MANFRED_TUNNEL.value + JOURNAL_SUFFIX
    LITTLE_JAY_JOURNAL = ItemName.LITTLE_JAY.value + JOURNAL_SUFFIX
    TIJERINA_SPINK_JOURNAL = ItemName.TIJERINA_SPINK.value + JOURNAL_SUFFIX
    VALERIE_CRUMP_JOURNAL = ItemName.VALERIE_CRUMP.value + JOURNAL_SUFFIX
    AU_JOURNAL = ItemName.AU.value + JOURNAL_SUFFIX
    DIRK_YAMAOKA_JOURNAL = ItemName.DIRK_YAMAOKA.value + JOURNAL_SUFFIX
    GUY_SPELUNKY_JOURNAL = ItemName.GUY_SPELUNKY.value + JOURNAL_SUFFIX
    CLASSIC_GUY_JOURNAL = ItemName.CLASSIC_GUY.value + JOURNAL_SUFFIX
    HIRELING_JOURNAL = ItemName.HIRELING.value + JOURNAL_SUFFIX
    # -------------------------
    # Non‑journal locations (from Locations.py order)
    # -------------------------
    DWELLING_1_1 = ItemName.DWELLING.value + " 1-1"
    DWELLING_1_2 = ItemName.DWELLING.value + " 1-2"
    DWELLING_1_3 = ItemName.DWELLING.value + " 1-3"
    DWELLING_1_4 = ItemName.DWELLING.value + " 1-4"

    JUNGLE_2_1 = ItemName.JUNGLE.value + " 2-1"
    JUNGLE_2_2 = ItemName.JUNGLE.value + " 2-2"

    VOLCANA_2_1 = ItemName.VOLCANA.value + " 2-1"
    VOLCANA_2_2 = ItemName.VOLCANA.value + " 2-2"

    OLMEC_LAIR = ItemName.OLMECS_LAIR.value

    TIDE_POOL_4_1 = ItemName.TIDE_POOL.value + " 4-1"
    TIDE_POOL_4_2 = ItemName.TIDE_POOL.value + " 4-2"

    TEMPLE_4_1 = ItemName.TEMPLE.value + " 4-1"
    TEMPLE_4_2 = ItemName.TEMPLE.value + " 4-2"

    ICE_CAVES = ItemName.ICE_CAVES.value

    NEO_BABYLON_6_1 = ItemName.NEO_BABYLON.value + " 6-1"
    NEO_BABYLON_6_2 = ItemName.NEO_BABYLON.value + " 6-2"

    SUNKEN_CITY = ItemName.SUNKEN_CITY.value
    COSMIC_OCEAN = ItemName.COSMIC_OCEAN.value
    EGGPLANT_WORLD = ItemName.EGGPLANT_WORLD.value

    BLACK_MARKET = "Black Market"
    VLADS_CASTLE = "Vlad's Castle"
    ABZU = "Abzu"
    CITY_OF_GOLD = "City of Gold"
    DUAT = "Duat"
    MOTHERSHIP = "Mothership"
    ANY_WORLD_2 = "Any World 2"


# -------------------------
# Region Names
# -------------------------


class RegionName(StrEnum):
    MENU = "Menu"
    DWELLING = ItemName.DWELLING.value
    JUNGLE = ItemName.JUNGLE.value
    VOLCANA = ItemName.VOLCANA.value
    OLMEC_LAIR = ItemName.OLMECS_LAIR.value
    TIDE_POOL = ItemName.TIDE_POOL.value
    TEMPLE = ItemName.TEMPLE.value
    ICE_CAVES = ItemName.ICE_CAVES.value
    NEO_BABYLON = ItemName.NEO_BABYLON.value
    SUNKEN_CITY = ItemName.SUNKEN_CITY.value
    COSMIC_OCEAN = ItemName.COSMIC_OCEAN.value
    EGGPLANT_WORLD = ItemName.EGGPLANT_WORLD.value
    BLACK_MARKET = LocationName.BLACK_MARKET.value
    VLADS_CASTLE = LocationName.VLADS_CASTLE.value
    ABZU = LocationName.ABZU.value
    CITY_OF_GOLD = LocationName.CITY_OF_GOLD.value
    DUAT = LocationName.DUAT.value
    MOTHERSHIP = LocationName.MOTHERSHIP.value
    ANY_WORLD_2 = LocationName.ANY_WORLD_2.value
