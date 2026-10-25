from typing import NamedTuple, Optional
from BaseClasses import Location
from .enums import MAIN_MENU_STRING, WORLD_2_STRING, Spelunky2Goal, JournalName, WorldName, LocationName

#####
# HUGE thanks to Cloiss for a lot of the logic changes in here to make more sense
#####


class Spelunky2Location(Location):
    game = "Spelunky 2"


class Spelunky2LocationData(NamedTuple):
    address: int
    region: str
    goal: Optional[int] = Spelunky2Goal.EASY


place_entries = {
    JournalName.DWELLING.value:        Spelunky2LocationData(1001,  WorldName.DWELLING),
    JournalName.JUNGLE.value:          Spelunky2LocationData(1002,  WorldName.JUNGLE),
    JournalName.VOLCANA.value:         Spelunky2LocationData(1003,  WorldName.VOLCANA),
    JournalName.OLMECS_LAIR.value:     Spelunky2LocationData(1004,  WorldName.OLMECS_LAIR),
    JournalName.TIDE_POOL.value:       Spelunky2LocationData(1005,  WorldName.TIDE_POOL),
    JournalName.ABZU.value:            Spelunky2LocationData(1006,  LocationName.ABZU),
    JournalName.TEMPLE.value:          Spelunky2LocationData(1007,  WorldName.TEMPLE),
    JournalName.CITY_OF_GOLD.value:    Spelunky2LocationData(1008,  LocationName.CITY_OF_GOLD),
    JournalName.DUAT.value:            Spelunky2LocationData(1009,  LocationName.DUAT),
    JournalName.ICE_CAVES.value:       Spelunky2LocationData(1010, WorldName.ICE_CAVES),
    JournalName.NEO_BABYLON.value:     Spelunky2LocationData(1011, WorldName.NEO_BABYLON),
    JournalName.TIAMAT_THRONE.value:   Spelunky2LocationData(1012, WorldName.SUNKEN_CITY, Spelunky2Goal.HARD),
    JournalName.SUNKEN_CITY.value:     Spelunky2LocationData(1013, WorldName.SUNKEN_CITY, Spelunky2Goal.HARD),
    JournalName.EGGPLANT_WORLD.value:  Spelunky2LocationData(1014, WorldName.EGGPLANT, Spelunky2Goal.HARD),
    JournalName.HUNDUN_HIDEAWAY.value: Spelunky2LocationData(1015, WorldName.SUNKEN_CITY, Spelunky2Goal.HARD),
    JournalName.COSMIC_OCEAN.value:    Spelunky2LocationData(1016, WorldName.COSMIC_OCEAN, Spelunky2Goal.CO),
}

people_entries = {
    JournalName.ANA_SPELUNKY.value:      Spelunky2LocationData(2001, LocationName.VLADS_CASTLE),
    JournalName.MARGARET_TUNNEL.value:   Spelunky2LocationData(2002, LocationName.VLADS_CASTLE),
    JournalName.COLIN_NORTHWARD.value:   Spelunky2LocationData(2003, LocationName.VLADS_CASTLE),
    JournalName.ROFFY_D_SLOTH.value:     Spelunky2LocationData(2004, LocationName.VLADS_CASTLE),

    JournalName.ALTO_SINGH.value:         Spelunky2LocationData(2005, WorldName.DWELLING),
    JournalName.LIZ_MUTTON.value:         Spelunky2LocationData(2006, WorldName.JUNGLE),
    JournalName.NEKKA_THE_EAGLE.value:    Spelunky2LocationData(2007, LocationName.BLACK_MARKET),
    JournalName.LISE_PROJECT.value:       Spelunky2LocationData(2008, WorldName.VOLCANA),
    JournalName.COCO_VON_DIAMONDS.value:  Spelunky2LocationData(2009, LocationName.VLADS_CASTLE),
    JournalName.MANFRED_TUNNEL.value:     Spelunky2LocationData(2010, WorldName.OLMECS_LAIR),
    JournalName.LITTLE_JAY.value:         Spelunky2LocationData(2011, WorldName.TIDE_POOL),
    JournalName.TINA_FLAN.value:          Spelunky2LocationData(2012, LocationName.ABZU),
    JournalName.VALERIE_CRUMP.value:      Spelunky2LocationData(2013, WorldName.TEMPLE),
    JournalName.AU.value:                 Spelunky2LocationData(2014, LocationName.CITY_OF_GOLD),
    JournalName.DEMI_VON_DIAMONDS.value:  Spelunky2LocationData(2015, WorldName.ICE_CAVES),
    JournalName.PILOT.value:              Spelunky2LocationData(2016, LocationName.MOTHERSHIP),
    JournalName.PRINCESS_AIRYN.value:     Spelunky2LocationData(2017, WorldName.NEO_BABYLON),
    JournalName.DIRK_YAMAOKA.value:       Spelunky2LocationData(2018, WorldName.SUNKEN_CITY, Spelunky2Goal.HARD),
    JournalName.GUY_SPELUNKY.value:       Spelunky2LocationData(2019, WorldName.NEO_BABYLON, Spelunky2Goal.HARD),
    JournalName.CLASSIC_GUY.value:        Spelunky2LocationData(2020, WorldName.SUNKEN_CITY, Spelunky2Goal.CO),
    JournalName.TERRA_TUNNEL.value:       Spelunky2LocationData(2021, WORLD_2_STRING),
    JournalName.HIRED_HAND.value:         Spelunky2LocationData(2022, WorldName.DWELLING),
    JournalName.EGGPLANT_CHILD.value:     Spelunky2LocationData(2023, WorldName.ICE_CAVES),
    JournalName.SHOPKEEPER.value:         Spelunky2LocationData(2024, WorldName.DWELLING),
    JournalName.TUN.value:                Spelunky2LocationData(2025, WORLD_2_STRING),
    JournalName.YANG.value:               Spelunky2LocationData(2026, WorldName.DWELLING),
    JournalName.MADAME_TUSK.value:        Spelunky2LocationData(2027, WorldName.TIDE_POOL),
    JournalName.TUSK_BODYGUARD.value:     Spelunky2LocationData(2028, WorldName.TIDE_POOL),
    JournalName.WADDLER.value:            Spelunky2LocationData(2029, WorldName.OLMECS_LAIR),
    JournalName.CAVEMAN_SHOPKEEPER.value: Spelunky2LocationData(2030, WorldName.TIDE_POOL),
    JournalName.GHIST_SHOPKEEPER.value:   Spelunky2LocationData(2031, WorldName.DWELLING),
    JournalName.VAN_HORSING.value:        Spelunky2LocationData(2032, WorldName.VOLCANA),
    JournalName.PARSLEY.value:            Spelunky2LocationData(2033, WorldName.JUNGLE),
    JournalName.PARSNIP.value:            Spelunky2LocationData(2034, WorldName.JUNGLE),
    JournalName.PARMESAN.value:           Spelunky2LocationData(2035, WorldName.JUNGLE),
    JournalName.SPARROW.value:            Spelunky2LocationData(2036, WORLD_2_STRING),
    JournalName.BEG.value:                Spelunky2LocationData(2037, WORLD_2_STRING),
    JournalName.EGGPLANT_KING.value:      Spelunky2LocationData(2038, WorldName.EGGPLANT, Spelunky2Goal.HARD),
}

bestiary_entries = {
    # Dwelling
    JournalName.SNAKE.value:         Spelunky2LocationData(3001, WorldName.DWELLING),
    JournalName.SPIDER.value:        Spelunky2LocationData(3002, WorldName.DWELLING),
    JournalName.BAT.value:           Spelunky2LocationData(3003, WorldName.DWELLING),
    JournalName.CAVEMAN.value:       Spelunky2LocationData(3004, WorldName.DWELLING),
    JournalName.SKELETON.value:      Spelunky2LocationData(3005, WorldName.DWELLING),
    JournalName.HORNED_LIZARD.value: Spelunky2LocationData(3006, WorldName.DWELLING),
    JournalName.CAVE_MOLE.value:     Spelunky2LocationData(3007, WorldName.DWELLING),
    JournalName.QUILLBACK.value:     Spelunky2LocationData(3008, WorldName.DWELLING),

    # Jungle
    JournalName.MANTRAP.value:       Spelunky2LocationData(3009, WorldName.JUNGLE),
    JournalName.TIKI_MAN.value:      Spelunky2LocationData(3010, WorldName.JUNGLE),
    JournalName.WITCH_DOCTOR.value:  Spelunky2LocationData(3011, WorldName.JUNGLE),
    JournalName.MOSQUITO.value:      Spelunky2LocationData(3012, WorldName.JUNGLE),
    JournalName.MONKEY.value:        Spelunky2LocationData(3013, WorldName.JUNGLE),
    JournalName.HANG_SPIDER.value:   Spelunky2LocationData(3014, WorldName.JUNGLE),
    JournalName.GIANT_SPIDER.value:  Spelunky2LocationData(3015, WorldName.JUNGLE),

    # Volcana
    JournalName.MAGMAR.value:        Spelunky2LocationData(3016, WorldName.VOLCANA),
    JournalName.ROBOT.value:         Spelunky2LocationData(3017, WorldName.VOLCANA),
    JournalName.FIRE_BUG.value:      Spelunky2LocationData(3018, WorldName.VOLCANA),
    JournalName.IMP.value:           Spelunky2LocationData(3019, WorldName.VOLCANA),
    JournalName.LAVAMANDER.value:    Spelunky2LocationData(3020, WorldName.VOLCANA),
    JournalName.VAMPIRE.value:       Spelunky2LocationData(3021, LocationName.VLADS_CASTLE),
    JournalName.VLAD.value:          Spelunky2LocationData(3022, LocationName.VLADS_CASTLE),

    # Olmec's Lair
    JournalName.OLMEC.value:         Spelunky2LocationData(3023, WorldName.OLMECS_LAIR),

    # Tide Pool
    JournalName.JIANGSHI.value:           Spelunky2LocationData(3024, WorldName.TIDE_POOL),
    JournalName.JIANGSHI_ASSASSIN.value:  Spelunky2LocationData(3025, WorldName.TIDE_POOL),
    JournalName.FLYING_FISH.value:        Spelunky2LocationData(3026, WorldName.TIDE_POOL),
    JournalName.OCTOPY.value:             Spelunky2LocationData(3027, WorldName.TIDE_POOL),
    JournalName.HERMIT_CRAB.value:        Spelunky2LocationData(3028, WorldName.TIDE_POOL),
    JournalName.PANGXIE.value:            Spelunky2LocationData(3029, WorldName.TIDE_POOL),
    JournalName.GREAT_HUMPHEAD.value:     Spelunky2LocationData(3030, WorldName.TIDE_POOL),
    JournalName.KINGU.value:              Spelunky2LocationData(3031, LocationName.ABZU),

    # Temple
    JournalName.CROCMAN.value:       Spelunky2LocationData(3032, WorldName.TEMPLE),
    JournalName.COBRA.value:         Spelunky2LocationData(3033, WorldName.TEMPLE),
    JournalName.MUMMY.value:         Spelunky2LocationData(3034, WorldName.TEMPLE),
    JournalName.SORCERESS.value:     Spelunky2LocationData(3035, WorldName.TEMPLE),
    JournalName.CAT_MUMMY.value:     Spelunky2LocationData(3036, WorldName.TEMPLE),
    JournalName.NECROMANCER.value:   Spelunky2LocationData(3037, WorldName.TEMPLE),
    JournalName.ANUBIS.value:        Spelunky2LocationData(3038, WorldName.TEMPLE),
    JournalName.AMMIT.value:         Spelunky2LocationData(3039, LocationName.DUAT),
    JournalName.APEP.value:          Spelunky2LocationData(3040, LocationName.DUAT),
    JournalName.ANUBIS_II.value:     Spelunky2LocationData(3041, LocationName.DUAT),
    JournalName.OSIRIS.value:        Spelunky2LocationData(3042, LocationName.DUAT),

    # Ice Caves
    JournalName.UFO.value:           Spelunky2LocationData(3043, WorldName.ICE_CAVES),
    JournalName.ALIEN.value:         Spelunky2LocationData(3044, WorldName.ICE_CAVES),
    JournalName.YETI.value:          Spelunky2LocationData(3045, WorldName.ICE_CAVES),
    JournalName.YETI_KING.value:     Spelunky2LocationData(3046, WorldName.ICE_CAVES),
    JournalName.YETI_QUEEN.value:    Spelunky2LocationData(3047, WorldName.ICE_CAVES),
    JournalName.ALIEN_QUEEN_LAMAHU.value: Spelunky2LocationData(3048, LocationName.MOTHERSHIP),
    JournalName.PROTO_SHOPKEEPER.value:   Spelunky2LocationData(3049, LocationName.MOTHERSHIP),

    # Neo Babylon
    JournalName.OLMITE.value:        Spelunky2LocationData(3050, WorldName.NEO_BABYLON),
    JournalName.LAMASSU.value:       Spelunky2LocationData(3051, WorldName.NEO_BABYLON),
    JournalName.TIAMAT.value:        Spelunky2LocationData(3052, WorldName.NEO_BABYLON, Spelunky2Goal.HARD),

    # Sunken City
    JournalName.TADPOLE.value:       Spelunky2LocationData(3053, WorldName.SUNKEN_CITY, Spelunky2Goal.HARD),
    JournalName.FROG.value:          Spelunky2LocationData(3054, WorldName.SUNKEN_CITY, Spelunky2Goal.HARD),
    JournalName.FIRE_FROG.value:     Spelunky2LocationData(3055, WorldName.SUNKEN_CITY, Spelunky2Goal.HARD),
    JournalName.GOLIATH_FROG.value:  Spelunky2LocationData(3056, WorldName.SUNKEN_CITY, Spelunky2Goal.HARD),
    JournalName.GRUB.value:          Spelunky2LocationData(3057, WorldName.SUNKEN_CITY, Spelunky2Goal.HARD),
    JournalName.GIANT_FLY.value:     Spelunky2LocationData(3058, WorldName.SUNKEN_CITY, Spelunky2Goal.HARD),
    JournalName.HUNDUN.value:        Spelunky2LocationData(3059, WorldName.SUNKEN_CITY, Spelunky2Goal.HARD),
    JournalName.EGGPLANT_MINISTER.value: Spelunky2LocationData(3060, WorldName.EGGPLANT, Spelunky2Goal.HARD),
    JournalName.EGGPLUP.value:       Spelunky2LocationData(3061, WorldName.EGGPLANT, Spelunky2Goal.HARD),

    # Cosmic Ocean
    JournalName.CELESTIAL_JELLY.value: Spelunky2LocationData(3062, WorldName.COSMIC_OCEAN, Spelunky2Goal.CO),

    # Miscellaneous
    JournalName.SCORPION.value:      Spelunky2LocationData(3063, WORLD_2_STRING),
    JournalName.BEE.value:           Spelunky2LocationData(3064, WorldName.TEMPLE),
    JournalName.QUEEN_BEE.value:     Spelunky2LocationData(3065, WorldName.JUNGLE),
    JournalName.SCARAB.value:        Spelunky2LocationData(3066, WorldName.DWELLING),
    JournalName.GOLDEN_MONKEY.value: Spelunky2LocationData(3067, WORLD_2_STRING),
    JournalName.LEPRECHAUN.value:    Spelunky2LocationData(3068, WORLD_2_STRING),
    JournalName.MONTY.value:         Spelunky2LocationData(3069, WorldName.DWELLING),
    JournalName.PERCY.value:         Spelunky2LocationData(3070, WorldName.DWELLING),
    JournalName.POOCHI.value:        Spelunky2LocationData(3071, WorldName.DWELLING),
    JournalName.GHIST.value:         Spelunky2LocationData(3072, WorldName.TIDE_POOL),
    JournalName.GHOST.value:         Spelunky2LocationData(3073, WorldName.DWELLING),
    JournalName.CAVE_TURKEY.value:   Spelunky2LocationData(3074, WorldName.DWELLING),
    JournalName.ROCK_DOG.value:      Spelunky2LocationData(3075, WorldName.VOLCANA),
    JournalName.AXOLOTL.value:       Spelunky2LocationData(3076, WorldName.TIDE_POOL),
    JournalName.QILIN.value:         Spelunky2LocationData(3077, WorldName.NEO_BABYLON),
    JournalName.MECH_RIDER.value:    Spelunky2LocationData(3078, WorldName.ICE_CAVES),
}

item_entries = {
    JournalName.ROPE_PILE.value:         Spelunky2LocationData(4001, WorldName.DWELLING),
    JournalName.BOMB_BAG.value:          Spelunky2LocationData(4002, WorldName.DWELLING),
    JournalName.BOMB_BOX.value:          Spelunky2LocationData(4003, WorldName.DWELLING),
    JournalName.PASTE.value:             Spelunky2LocationData(4004, WorldName.JUNGLE),
    JournalName.SPECTACLES.value:        Spelunky2LocationData(4005, LocationName.BLACK_MARKET),
    JournalName.CLIMBING_GLOVES.value:   Spelunky2LocationData(4006, LocationName.BLACK_MARKET),
    JournalName.PITCHERS_MITT.value:     Spelunky2LocationData(4007, LocationName.BLACK_MARKET),
    JournalName.SPRING_SHOES.value:      Spelunky2LocationData(4008, LocationName.BLACK_MARKET),
    JournalName.SPIKE_SHOES.value:       Spelunky2LocationData(4009, WorldName.ICE_CAVES),
    JournalName.COMPASS.value:           Spelunky2LocationData(4010, WorldName.ICE_CAVES),
    JournalName.ALIEN_COMPASS.value:     Spelunky2LocationData(4011, LocationName.VLADS_CASTLE),
    JournalName.PARACHUTE.value:         Spelunky2LocationData(4012, WorldName.OLMECS_LAIR),
    JournalName.UDJAT_EYE.value:         Spelunky2LocationData(4013, WorldName.DWELLING),
    JournalName.KAPALA.value:            Spelunky2LocationData(4014, WorldName.NEO_BABYLON),
    JournalName.HEDJET.value:            Spelunky2LocationData(4015, LocationName.BLACK_MARKET),
    JournalName.CROWN.value:             Spelunky2LocationData(4016, LocationName.VLADS_CASTLE),
    JournalName.EGGPLANT_CROWN.value:    Spelunky2LocationData(4017, WorldName.EGGPLANT, Spelunky2Goal.HARD),
    JournalName.TRUE_CROWN.value:        Spelunky2LocationData(4018, WorldName.ICE_CAVES),
    JournalName.ANKH.value:              Spelunky2LocationData(4019, WorldName.OLMECS_LAIR),
    JournalName.TABLET_OF_DESTINY.value: Spelunky2LocationData(4020, MAIN_MENU_STRING),
    JournalName.SKELETON_KEY.value:      Spelunky2LocationData(4021, WORLD_2_STRING),
    JournalName.ROYAL_JELLY.value:       Spelunky2LocationData(4022, WorldName.JUNGLE),
    JournalName.CAPE.value:              Spelunky2LocationData(4023, LocationName.VLADS_CASTLE),
    JournalName.VLADS_CAPE.value:        Spelunky2LocationData(4024, LocationName.VLADS_CASTLE),
    JournalName.JETPACK.value:           Spelunky2LocationData(4025, LocationName.DUAT),
    JournalName.TELEPACK.value:          Spelunky2LocationData(4026, LocationName.BLACK_MARKET),
    JournalName.HOVERPACK.value:         Spelunky2LocationData(4027, LocationName.BLACK_MARKET),
    JournalName.POWERPACK.value:         Spelunky2LocationData(4028, LocationName.BLACK_MARKET),
    JournalName.WEBGUN.value:            Spelunky2LocationData(4029, LocationName.BLACK_MARKET),

    JournalName.SHOTGUN.value:           Spelunky2LocationData(4030, WorldName.DWELLING),

    JournalName.FREEZE_RAY.value:        Spelunky2LocationData(4031, LocationName.BLACK_MARKET),
    JournalName.CLONE_GUN.value:         Spelunky2LocationData(4032, WorldName.TIDE_POOL),
    JournalName.CROSSBOW.value:          Spelunky2LocationData(4033, WorldName.DWELLING),
    JournalName.CAMERA.value:            Spelunky2LocationData(4034, WorldName.TIDE_POOL),
    JournalName.TELEPORTER.value:        Spelunky2LocationData(4035, LocationName.BLACK_MARKET),
    JournalName.MATTOCK.value:           Spelunky2LocationData(4036, WORLD_2_STRING),
    JournalName.BOOMERANG.value:         Spelunky2LocationData(4037, WorldName.JUNGLE),
    JournalName.MACHETE.value:           Spelunky2LocationData(4038, LocationName.BLACK_MARKET),
    JournalName.EXCALIBUR.value:         Spelunky2LocationData(4039, WorldName.TIDE_POOL),
    JournalName.BROKEN_SWORD.value:      Spelunky2LocationData(4040, WorldName.TIDE_POOL),
    JournalName.PLASMA_CANNON.value:     Spelunky2LocationData(4041, LocationName.MOTHERSHIP),
    JournalName.SCEPTER.value:           Spelunky2LocationData(4042, WorldName.TEMPLE),
    JournalName.HOU_YI_BOW.value:        Spelunky2LocationData(4043, WORLD_2_STRING),
    JournalName.ARROW_OF_LIGHT.value:    Spelunky2LocationData(4044, WorldName.SUNKEN_CITY, Spelunky2Goal.HARD),
    JournalName.WOODEN_SHIELD.value:     Spelunky2LocationData(4045, WorldName.JUNGLE),
    JournalName.METAL_SHIELD.value:      Spelunky2LocationData(4046, WorldName.TIDE_POOL),
    JournalName.IDOL.value:              Spelunky2LocationData(4047, WorldName.DWELLING),
    JournalName.THE_TUSK_IDOL.value:     Spelunky2LocationData(4048, WorldName.TIDE_POOL),
    JournalName.CURSE_POT.value:         Spelunky2LocationData(4049, WorldName.DWELLING),
    JournalName.USHABTI.value:           Spelunky2LocationData(4050, WorldName.NEO_BABYLON),
    JournalName.EGGPLANT.value:          Spelunky2LocationData(4051, WorldName.TIDE_POOL),
    JournalName.COOKED_TURKEY.value:     Spelunky2LocationData(4052, WorldName.DWELLING),
    JournalName.ELIXIR.value:            Spelunky2LocationData(4053, WorldName.TEMPLE),
    JournalName.FOUR_LEAF_CLOVER.value:  Spelunky2LocationData(4054, WORLD_2_STRING),
}

trap_entries = {
    JournalName.SPIKES.value:            Spelunky2LocationData(5001, WorldName.DWELLING),
    JournalName.ARROW_TRAP.value:        Spelunky2LocationData(5002, WorldName.DWELLING),
    JournalName.TOTEM_TRAP.value:        Spelunky2LocationData(5003, WorldName.DWELLING),
    JournalName.LOG_TRAP.value:          Spelunky2LocationData(5004, WorldName.DWELLING),
    JournalName.SPEAR_TRAP.value:        Spelunky2LocationData(5005, WorldName.JUNGLE),
    JournalName.THORNY_VINE.value:       Spelunky2LocationData(5006, WorldName.JUNGLE),
    JournalName.BEAR_TRAP.value:         Spelunky2LocationData(5007, WorldName.JUNGLE),
    JournalName.POWDER_BOX.value:        Spelunky2LocationData(5008, WorldName.VOLCANA),
    JournalName.FALLING_PLATFORM.value:  Spelunky2LocationData(5009, WorldName.VOLCANA),
    JournalName.SPIKEBALL.value:         Spelunky2LocationData(5010, WorldName.VOLCANA),
    JournalName.LION_TRAP.value:         Spelunky2LocationData(5011, WorldName.TIDE_POOL),
    JournalName.GIANT_CLAM.value:        Spelunky2LocationData(5012, WorldName.TIDE_POOL),
    JournalName.SLIDING_WALL.value:      Spelunky2LocationData(5013, WorldName.TIDE_POOL),
    JournalName.CRUSH_TRAP.value:        Spelunky2LocationData(5014, WorldName.TEMPLE),
    JournalName.GIANT_CRUSH_TRAP.value:  Spelunky2LocationData(5015, WorldName.TEMPLE),
    JournalName.BOULDER.value:           Spelunky2LocationData(5016, WorldName.ICE_CAVES),
    JournalName.SPRING_TRAP.value:       Spelunky2LocationData(5017, WorldName.ICE_CAVES),
    JournalName.LANDMINE.value:          Spelunky2LocationData(5018, WorldName.ICE_CAVES),
    JournalName.LASER_TRAP.value:        Spelunky2LocationData(5019, WorldName.NEO_BABYLON),
    JournalName.SPARK_TRAP.value:        Spelunky2LocationData(5020, WorldName.NEO_BABYLON),
    JournalName.FROG_TRAP.value:         Spelunky2LocationData(5021, WorldName.SUNKEN_CITY, Spelunky2Goal.HARD),
    JournalName.STICKY_TRAP.value:       Spelunky2LocationData(5022, WorldName.SUNKEN_CITY, Spelunky2Goal.HARD),
    JournalName.BONE_DROP.value:         Spelunky2LocationData(5023, WorldName.SUNKEN_CITY, Spelunky2Goal.HARD),
    JournalName.EGG_SAC.value:           Spelunky2LocationData(5024, WorldName.SUNKEN_CITY, Spelunky2Goal.HARD),
}

location_data_table = {

    **place_entries,
    **people_entries,
    **bestiary_entries,
    **item_entries,
    **trap_entries,
}
