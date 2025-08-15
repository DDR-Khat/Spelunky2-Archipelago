from enum import IntEnum

"""
This file contains Python enums for all Spelunky 2 item codes.
It is generated based on the item data and logic found in the
Spelunky 2 Archipelago world files.
"""

class Spelunky2ItemCode(IntEnum):
    """
    Main enum for all Spelunky 2 item codes, organized into nested categories.
    """

    class FillerItems(IntEnum):
        """Standard filler items."""
        Rope_Pile = 1
        Bomb_Bag = 2
        Bomb_Box = 3
        Cooked_Turkey = 4
        Royal_Jelly = 5
        Gold_Bar = 6
        Emerald_Gem = 7
        Sapphire_Gem = 8
        Ruby_Gem = 9
        Diamond_Gem = 10

    class Characters(IntEnum):
        """Unlockable characters."""
        Ana_Spelunky = 101
        Margaret_Tunnel = 102
        Colin_Northward = 103
        Roffy_D_Sloth = 104
        Alto_Singh = 104
        Liz_Mutton = 105
        Nekka_the_Eagle = 106
        LISE_Project = 107
        Coco_Von_Diamonds = 108
        Manfred_Tunnel = 109
        Little_Jay = 110
        Tina_Flan = 111
        Valerie_Crump = 112
        Au = 113
        Demi_Von_Diamonds = 114
        Pilot = 115
        Princess_Airyn = 116
        Dirk_Yamaoka = 117
        Guy_Spelunky = 118
        Classic_Guy = 119

    class LockedItems(IntEnum):
        """
        The 30 standard items that can be found in a world,
        including powerups and equips.
        """
        Ankh = 201
        Camera = 202
        Cape = 203
        Climbing_Gloves = 204
        Clone_Gun = 205
        Compass = 206
        Eggplant = 207
        Eggplant_Crown = 208
        Elixir = 209
        Four_Leaf_Clover = 210
        Freeze_Ray = 211
        Hoverpack = 212
        Jetpack = 213
        Kapala = 214
        Machete = 215
        Mattock = 216
        Paste = 217
        Pitchers_Mitt = 218
        Plasma_Cannon = 219
        Powerpack = 220
        Shield = 221
        Skeleton_Key = 222
        Spectacles = 223
        Spike_Shoes = 224
        Spring_Shoes = 225
        Telepack = 226
        Teleporter = 227
        True_Crown = 228
        Vlads_Cape = 229
        Webgun = 230

    class QuestItems(IntEnum):
        """Items required for quest progression."""
        Alien_Compass = 301
        Arrow_of_Light = 302
        Crown = 303
        Excalibur = 304
        Hedjet = 305
        Hou_Yis_Bow = 306
        Scepter = 307
        Tablet_of_Destiny = 308
        Udjat_Eye = 309
        Ushabti = 310

    class Upgrades(IntEnum):
        """Permanent item upgrades."""
        Ankh_Upgrade = 401
        Climbing_Gloves_Upgrade = 402
        Compass_Upgrade = 403
        Eggplant_Crown_Upgrade = 404
        Elixir_Upgrade = 405
        Four_Leaf_Clover_Upgrade = 406
        Kapala_Upgrade = 407
        Paste_Upgrade = 408
        Pitchers_Mitt_Upgrade = 409
        Skeleton_Key_Upgrade = 410
        Spectacles_Upgrade = 411
        Spike_Shoes_Upgrade = 412
        Spring_Shoes_Upgrade = 413
        True_Crown_Upgrade = 414

    class PermanentUpgrades(IntEnum):
        """Permanent health, bomb, and rope upgrades."""
        Health_Upgrade = 501
        Bomb_Upgrade = 502
        Rope_Upgrade = 503

    class WaddlerUpgrades(IntEnum):
        """Waddler upgrades for various items."""
        Ankh_Waddler_Upgrade = 601
        Camera_Waddler_Upgrade = 602
        Cape_Waddler_Upgrade = 603
        Climbing_Gloves_Waddler_Upgrade = 604
        Clone_Gun_Waddler_Upgrade = 605
        Compass_Waddler_Upgrade = 606
        Eggplant_Waddler_Upgrade = 607
        Eggplant_Crown_Waddler_Upgrade = 608
        Elixir_Waddler_Upgrade = 609
        Four_Leaf_Clover_Waddler_Upgrade = 610
        Freeze_Ray_Waddler_Upgrade = 611
        Hoverpack_Waddler_Upgrade = 612
        Jetpack_Waddler_Upgrade = 613
        Kapala_Waddler_Upgrade = 614
        Machete_Waddler_Upgrade = 615
        Mattock_Waddler_Upgrade = 616
        Paste_Waddler_Upgrade = 617
        Pitchers_Mitt_Waddler_Upgrade = 618
        Plasma_Cannon_Waddler_Upgrade = 619
        Powerpack_Waddler_Upgrade = 620
        Shield_Waddler_Upgrade = 621
        Skeleton_Key_Waddler_Upgrade = 622
        Spectacles_Waddler_Upgrade = 623
        Spike_Shoes_Waddler_Upgrade = 624
        Spring_Shoes_Waddler_Upgrade = 625
        Telepack_Waddler_Upgrade = 626
        Teleporter_Waddler_Upgrade = 627
        True_Crown_Waddler_Upgrade = 628
        Vlads_Cape_Waddler_Upgrade = 629
        Webgun_Waddler_Upgrade = 630

    class WorldUnlocks(IntEnum):
        """Item codes for unlocking worlds."""
        Progressive_World_Unlock = 701
        Jungle = 702
        Volcana = 703
        Olmecs_Lair = 704
        Tide_Pool = 705
        Temple = 706
        Ice_Caves = 707
        Neo_Babylon = 708
        Sunken_City = 709

    class Shortcuts(IntEnum):
        """Item codes for shortcuts."""
        Progressive_Shortcut = 751
        Olmecs_Lair_Shortcut = 752
        Ice_Caves_Shortcut = 753

    class Traps(IntEnum):
        """Item codes for traps, including the commented-out ones."""
        Poison_Trap = 801
        Curse_Trap = 802
        Freeze_Trap = 803
        Web_Trap = 804
        No_Bombs_Trap = 805
        Blindness_Trap = 806
        Amnesia_Trap = 807
        Angry_Shopkeepers_Trap = 808
        Punish_Ball_Trap = 809

