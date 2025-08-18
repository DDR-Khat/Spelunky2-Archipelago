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
        Ankh = 301
        Camera = 302
        Cape = 303
        Climbing_Gloves = 304
        Clone_Gun = 305
        Compass = 306
        Eggplant = 307
        Eggplant_Crown = 308
        Elixir = 309
        Four_Leaf_Clover = 310
        Freeze_Ray = 311
        Hoverpack = 312
        Jetpack = 313
        Kapala = 314
        Machete = 315
        Mattock = 316
        Paste = 317
        Pitchers_Mitt = 318
        Plasma_Cannon = 319
        Powerpack = 320
        Shield = 321
        Skeleton_Key = 322
        Spectacles = 323
        Spike_Shoes = 324
        Spring_Shoes = 325
        Telepack = 326
        Teleporter = 327
        True_Crown = 328
        Vlads_Cape = 329
        Webgun = 330

    class WaddlerUpgrades(IntEnum):
        """Waddler upgrades for locked items."""
        Alien_Compass = 401
        Ankh = 402
        Arrow_of_Light = 403
        Camera = 404
        Cape = 405
        Climbing_Gloves = 406
        Clone_Gun = 407
        Compass = 408
        Crown = 409
        Eggplant = 410
        Eggplant_Crown = 411
        Elixir = 412
        Excalibur = 413
        Four_Leaf_Clover = 414
        Freeze_Ray = 415
        Hedjet = 416
        Hoverpack = 417
        Hou_Yis_Bow = 418
        Jetpack = 419
        Kapala = 420
        Machete = 421
        Mattock = 422
        Paste = 423
        Pitchers_Mitt = 424
        Plasma_Cannon = 425
        Powerpack = 426
        Scepter = 427
        Shield = 428
        Skeleton_Key = 429
        Spectacles = 430
        Spike_Shoes = 431
        Spring_Shoes = 432
        Tablet_of_Destiny = 433
        Telepack = 434
        Teleporter = 435
        True_Crown = 436
        Udjat_Eye = 437
        Ushabti = 438
        Vlads_Cape = 439
        Webgun = 440

    class PermanentUpgrades(IntEnum):
        """Permanent health, bomb, rope upgrades, and checkpoints."""
        Health = 501
        Bomb = 502
        Rope = 503
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
        Progressive = 601
        Dwelling = 602
        Jungle = 603
        Volcana = 604
        Olmecs_Lair = 605
        Tide_Pool = 606
        Temple = 607
        Ice_Caves = 608
        Neo_Babylon = 609
        Sunken_City = 610

    class Traps(IntEnum):
        """Trap codes"""
        Poison = 801
        Curse = 802
        Ghost = 803
        Stun = 804
        Loose_Bombs = 805
        Blindness = 806
        Amnesia = 807
        Angry_Shopkeepers = 808
        Punish_Ball = 809
