from enum import IntEnum

"""
This file contains Python enums for all Spelunky 2 item codes.
It is generated based on the item data and logic found in the
Spelunky 2 Archipelago world files.
"""

class Spelunky2ItemCode:
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
        """All locked items, including quest items."""
        Alien_Compass = 201
        Ankh = 202
        Arrow_of_Light = 203
        Camera = 204
        Cape = 205
        Climbing_Gloves = 206
        Clone_Gun = 207
        Compass = 208
        Crown = 209
        Eggplant = 210
        Eggplant_Crown = 211
        Elixir = 212
        Excalibur = 213
        Four_Leaf_Clover = 214
        Freeze_Ray = 215
        Hedjet = 216
        Hoverpack = 217
        Hou_Yis_Bow = 218
        Jetpack = 219
        Kapala = 220
        Machete = 221
        Mattock = 222
        Paste = 223
        Pitchers_Mitt = 224
        Plasma_Cannon = 225
        Powerpack = 226
        Scepter = 227
        Shield = 228
        Skeleton_Key = 229
        Spectacles = 230
        Spike_Shoes = 231
        Spring_Shoes = 232
        Tablet_of_Destiny = 233
        Telepack = 234
        Teleporter = 235
        True_Crown = 236
        Udjat_Eye = 237
        Ushabti = 238
        Vlads_Cape = 239
        Webgun = 240

    class Upgrades(IntEnum):
        """Upgrades for powerups and equips."""
        Ankh_Upgrade = 301
        Camera_Upgrade = 302
        Cape_Upgrade = 303
        Climbing_Gloves_Upgrade = 304
        Clone_Gun_Upgrade = 305
        Compass_Upgrade = 306
        Eggplant_Upgrade = 307
        Eggplant_Crown_Upgrade = 308
        Elixir_Upgrade = 309
        Four_Leaf_Clover_Upgrade = 310
        Freeze_Ray_Upgrade = 311
        Hoverpack_Upgrade = 312
        Jetpack_Upgrade = 313
        Kapala_Upgrade = 314
        Machete_Upgrade = 315
        Mattock_Upgrade = 316
        Paste_Upgrade = 317
        Pitchers_Mitt_Upgrade = 318
        Plasma_Cannon_Upgrade = 319
        Powerpack_Upgrade = 320
        Shield_Upgrade = 321
        Skeleton_Key_Upgrade = 322
        Spectacles_Upgrade = 323
        Spike_Shoes_Upgrade = 324
        Spring_Shoes_Upgrade = 325
        Telepack_Upgrade = 326
        Teleporter_Upgrade = 327
        True_Crown_Upgrade = 328
        Vlads_Cape_Upgrade = 329
        Webgun_Upgrade = 330

    class WaddlerUpgrades(IntEnum):
        """Waddler upgrades for locked items."""
        Alien_Compass_Waddler_Upgrade = 401
        Ankh_Waddler_Upgrade = 402
        Arrow_of_Light_Waddler_Upgrade = 403
        Camera_Waddler_Upgrade = 404
        Cape_Waddler_Upgrade = 405
        Climbing_Gloves_Waddler_Upgrade = 406
        Clone_Gun_Waddler_Upgrade = 407
        Compass_Waddler_Upgrade = 408
        Crown_Waddler_Upgrade = 409
        Eggplant_Waddler_Upgrade = 410
        Eggplant_Crown_Waddler_Upgrade = 411
        Elixir_Waddler_Upgrade = 412
        Excalibur_Waddler_Upgrade = 413
        Four_Leaf_Clover_Waddler_Upgrade = 414
        Freeze_Ray_Waddler_Upgrade = 415
        Hedjet_Waddler_Upgrade = 416
        Hoverpack_Waddler_Upgrade = 417
        Hou_Yis_Bow_Waddler_Upgrade = 418
        Jetpack_Waddler_Upgrade = 419
        Kapala_Waddler_Upgrade = 420
        Machete_Waddler_Upgrade = 421
        Mattock_Waddler_Upgrade = 422
        Paste_Waddler_Upgrade = 423
        Pitchers_Mitt_Waddler_Upgrade = 424
        Plasma_Cannon_Waddler_Upgrade = 425
        Powerpack_Waddler_Upgrade = 426
        Scepter_Waddler_Upgrade = 427
        Shield_Waddler_Upgrade = 428
        Skeleton_Key_Waddler_Upgrade = 429
        Spectacles_Waddler_Upgrade = 430
        Spike_Shoes_Waddler_Upgrade = 431
        Spring_Shoes_Waddler_Upgrade = 432
        Tablet_of_Destiny_Waddler_Upgrade = 433
        Telepack_Waddler_Upgrade = 434
        Teleporter_Waddler_Upgrade = 435
        True_Crown_Waddler_Upgrade = 436
        Udjat_Eye_Waddler_Upgrade = 437
        Ushabti_Waddler_Upgrade = 438
        Vlads_Cape_Waddler_Upgrade = 439
        Webgun_Waddler_Upgrade = 440

    class PermanentUpgrades(IntEnum):
        """Permanent health, bomb, rope upgrades, and checkpoints."""
        Health_Upgrade = 501
        Bomb_Upgrade = 502
        Rope_Upgrade = 503
        Cosmic_Ocean_Checkpoint = 504

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
        Cosmic_Ocean = 710

    class Shortcuts(IntEnum):
        """Shortcut codes"""
        Progressive_Shortcut = 601
        Dwelling_Shortcut = 602
        Jungle_Shortcut = 603
        Volcana_Shortcut = 604
        Olmecs_Lair_Shortcut = 605
        Tide_Pool_Shortcut = 606
        Temple_Shortcut = 607
        Ice_Caves_Shortcut = 608
        Neo_Babylon_Shortcut = 609
        Sunken_City_Shortcut = 610

    class Traps(IntEnum):
        """Trap codes"""
        Poison_Trap = 801
        Curse_Trap = 802
        Ghost_Trap = 803
        Stun_Trap = 804
        Loose_Bombs_Trap = 805
        Blindness_Trap = 806
        Amnesia_Trap = 807
        Angry_Shopkeepers_Trap = 808
        Punish_Ball_Trap = 809
