from typing import Optional, NamedTuple
from BaseClasses import Item, ItemClassification


class Spelunky2Item(Item):
    game = "Spelunky 2"


class Spelunky2ItemData(NamedTuple):
    code: int
    classification: Optional[ItemClassification] = ItemClassification.filler
    amount: Optional[int] = 1


filler_items = {
    "Rope Pile":                    Spelunky2ItemData(1),
    "Bomb Bag":                     Spelunky2ItemData(2),
    "Bomb Box":                     Spelunky2ItemData(3),
    "Cooked Turkey":                Spelunky2ItemData(4),
    "Royal Jelly":                  Spelunky2ItemData(5),
    "Gold Bar":                     Spelunky2ItemData(6),
    "Emerald Gem":                  Spelunky2ItemData(7),
    "Sapphire Gem":                 Spelunky2ItemData(8),
    "Ruby Gem":                     Spelunky2ItemData(9),
    "Diamond Gem":                  Spelunky2ItemData(10),
}

characters = {  # 4 Characters randomly chosen, Ana/Margaret/Colin/Roffy will be found where non-starters exist
    "Ana Spelunky":                 Spelunky2ItemData(101),
    "Margaret Tunnel":              Spelunky2ItemData(102),
    "Colin Northward":              Spelunky2ItemData(103),
    "Roffy D. Sloth":               Spelunky2ItemData(103),
    "Alto Singh":                   Spelunky2ItemData(104),
    "Liz Mutton":                   Spelunky2ItemData(105),
    "Nekka the Eagle":              Spelunky2ItemData(106),
    "LISE Project":                 Spelunky2ItemData(107),
    "Coco Von Diamonds":            Spelunky2ItemData(108),
    "Manfred Tunnel":               Spelunky2ItemData(109),
    "Little Jay":                   Spelunky2ItemData(110),
    "Tina Flan":                    Spelunky2ItemData(111),
    "Valerie Crump":                Spelunky2ItemData(112),
    "Au":                           Spelunky2ItemData(113),
    "Demi Von Diamonds":            Spelunky2ItemData(114),
    "Pilot":                        Spelunky2ItemData(115),
    "Princess Airyn":               Spelunky2ItemData(116),
    "Dirk Yamaoka":                 Spelunky2ItemData(117),
    "Guy Spelunky":                 Spelunky2ItemData(118),
    "Classic Guy":                  Spelunky2ItemData(119)
}

locked_items = {
    "Alien Compass":                Spelunky2ItemData(201, ItemClassification.progression),
    "Climbing Gloves":              Spelunky2ItemData(202, ItemClassification.progression),
    "Camera":                       Spelunky2ItemData(203, ItemClassification.progression),
    "Cape":                         Spelunky2ItemData(204, ItemClassification.progression),
    "Clone Gun":                    Spelunky2ItemData(205, ItemClassification.progression),
    "Compass":                      Spelunky2ItemData(206, ItemClassification.progression),
    "Eggplant":                     Spelunky2ItemData(207, ItemClassification.progression),
    "Eggplant Crown":               Spelunky2ItemData(208, ItemClassification.progression),
    "Elixir":                       Spelunky2ItemData(209, ItemClassification.progression),
    "Four-Leaf Clover":             Spelunky2ItemData(210, ItemClassification.progression),
    "Freeze Ray":                   Spelunky2ItemData(211, ItemClassification.progression),
    "Hoverpack":                    Spelunky2ItemData(212, ItemClassification.progression),
    "Jetpack":                      Spelunky2ItemData(213, ItemClassification.progression),
    "Kapala":                       Spelunky2ItemData(214, ItemClassification.progression),
    "Machete":                      Spelunky2ItemData(215, ItemClassification.progression),
    "Mattock":                      Spelunky2ItemData(216, ItemClassification.progression),
    "Paste":                        Spelunky2ItemData(217, ItemClassification.progression),
    "Pitcher's Mitt":               Spelunky2ItemData(218, ItemClassification.progression),
    "Plasma Cannon":                Spelunky2ItemData(219, ItemClassification.progression),
    "Powerpack":                    Spelunky2ItemData(220, ItemClassification.progression),
    "Royal Jelly":                  Spelunky2ItemData(221, ItemClassification.progression),
    "Shield":                       Spelunky2ItemData(222, ItemClassification.progression),
    "Skeleton Key":                 Spelunky2ItemData(223, ItemClassification.progression),
    "Spectacles":                   Spelunky2ItemData(224, ItemClassification.progression),
    "Spike Shoes":                  Spelunky2ItemData(225, ItemClassification.progression),
    "Spring Shoes":                 Spelunky2ItemData(226, ItemClassification.progression),
    "Telepack":                     Spelunky2ItemData(227, ItemClassification.progression),
    "True Crown":                   Spelunky2ItemData(228, ItemClassification.progression),
    "Vlad's Cape":                  Spelunky2ItemData(229, ItemClassification.progression),
    "Webgun":                       Spelunky2ItemData(230, ItemClassification.progression),
}

starter_items = {  # These items must be unlocked first from locked_items or quest_items
    "Alien Compass Upgrade":        Spelunky2ItemData(301, ItemClassification.useful),
    "Climbing Gloves Upgrade":      Spelunky2ItemData(302, ItemClassification.useful),
    "Camera Upgrade":               Spelunky2ItemData(303, ItemClassification.useful),
    "Cape Upgrade":                 Spelunky2ItemData(304, ItemClassification.useful),
    "Clone Gun Upgrade":            Spelunky2ItemData(305, ItemClassification.useful),
    "Compass Upgrade":              Spelunky2ItemData(306, ItemClassification.useful),
    "Eggplant Upgrade":             Spelunky2ItemData(307, ItemClassification.useful),
    "Eggplant Crown Upgrade":       Spelunky2ItemData(308, ItemClassification.useful),
    "Elixir Upgrade":               Spelunky2ItemData(309, ItemClassification.useful),
    "Four-Leaf Clover Upgrade":     Spelunky2ItemData(310, ItemClassification.useful),
    "Freeze Ray Upgrade":           Spelunky2ItemData(311, ItemClassification.useful),
    "Hoverpack Upgrade":            Spelunky2ItemData(312, ItemClassification.useful),
    "Jetpack Upgrade":              Spelunky2ItemData(313, ItemClassification.useful),
    "Kapala Upgrade":               Spelunky2ItemData(314, ItemClassification.useful),
    "Machete Upgrade":              Spelunky2ItemData(315, ItemClassification.useful),
    "Mattock Upgrade":              Spelunky2ItemData(316, ItemClassification.useful),
    "Paste Upgrade":                Spelunky2ItemData(317, ItemClassification.useful),
    "Pitcher's Mitt Upgrade":       Spelunky2ItemData(318, ItemClassification.useful),
    "Plasma Cannon Upgrade":        Spelunky2ItemData(319, ItemClassification.useful),
    "Powerpack Upgrade":            Spelunky2ItemData(320, ItemClassification.useful),
    "Royal Jelly Upgrade":          Spelunky2ItemData(321, ItemClassification.useful),
    "Shield Upgrade":               Spelunky2ItemData(322, ItemClassification.useful),
    "Skeleton Key Upgrade":         Spelunky2ItemData(323, ItemClassification.useful),
    "Spectacles Upgrade":           Spelunky2ItemData(324, ItemClassification.useful),
    "Spike Shoes Upgrade":          Spelunky2ItemData(325, ItemClassification.useful),
    "Spring Shoes Upgrade":         Spelunky2ItemData(326, ItemClassification.useful),
    "Telepack Upgrade":             Spelunky2ItemData(327, ItemClassification.useful),
    "True Crown Upgrade":           Spelunky2ItemData(328, ItemClassification.useful),
    "Vlad's Cape Upgrade":          Spelunky2ItemData(329, ItemClassification.useful),
    "Webgun Upgrade":               Spelunky2ItemData(330, ItemClassification.useful),
    "Udjat Eye Upgrade":            Spelunky2ItemData(331, ItemClassification.useful),
    "Crown Upgrade":                Spelunky2ItemData(332, ItemClassification.useful),
    "Hedjet Upgrade":               Spelunky2ItemData(333, ItemClassification.useful),
    "Ankh Upgrade":                 Spelunky2ItemData(334, ItemClassification.useful),
    "Excalibur Upgrade":            Spelunky2ItemData(335, ItemClassification.useful),
    "Sceptor Upgrade":              Spelunky2ItemData(336, ItemClassification.useful),
    "Ushabti Upgrade":              Spelunky2ItemData(347, ItemClassification.useful),
    "Hou Yi's Bow Upgrade":         Spelunky2ItemData(338, ItemClassification.useful),
    "Tablet of Destiny Upgrade":    Spelunky2ItemData(339, ItemClassification.useful),
}

quest_items = {
    "Udjat Eye":                    Spelunky2ItemData(401, ItemClassification.progression),
    "Crown":                        Spelunky2ItemData(402, ItemClassification.progression),
    "Hedjet":                       Spelunky2ItemData(403, ItemClassification.progression),
    "Ankh":                         Spelunky2ItemData(404, ItemClassification.progression),
    "Excalibur":                    Spelunky2ItemData(405, ItemClassification.progression),
    "Sceptor":                      Spelunky2ItemData(406, ItemClassification.progression),
    "Tablet of Destiny":            Spelunky2ItemData(407, ItemClassification.progression),
    "Ushabti":                      Spelunky2ItemData(408, ItemClassification.progression),
    "Hou Yi's Bow":                 Spelunky2ItemData(409, ItemClassification.progression),
    "Arrow of Light":               Spelunky2ItemData(410, ItemClassification.progression),
}

permanent_upgrades = {
    "Health Upgrade":               Spelunky2ItemData(501, ItemClassification.useful, 0),
    "Bomb Upgrade":                 Spelunky2ItemData(502, ItemClassification.useful, 0),
    "Rope Upgrade":                 Spelunky2ItemData(503, ItemClassification.useful, 0),
    "Cosmic Ocean Checkpoint":      Spelunky2ItemData(504, ItemClassification.useful, 0),  # Count set by player settings
}

shortcuts = {  # TODO: Maybe add more shortcuts by editing the Camp to allow specific world selection from camp
    # "Progressive Shortcut":       Spelunky2ItemData(601, ItemClassification.helpful),
    # "Dwelling Shortcut":          Spelunky2ItemData(602, ItemClassification.helpful),
    # "Jungle Shortcut":            Spelunky2ItemData(603, ItemClassification.helpful),
    # "Volcana Shortcut":           Spelunky2ItemData(604, ItemClassification.helpful),
    # "Olmec's Lair Shortcut":      Spelunky2ItemData(605, ItemClassification.helpful),
    # "Tide Pool Shortcut":         Spelunky2ItemData(606, ItemClassification.helpful),
    # "Temple Shortcut":            Spelunky2ItemData(607, ItemClassification.helpful),
    # "Ice Caves Shortcut":         Spelunky2ItemData(608, ItemClassification.helpful),
    # "Neo Babylon":                Spelunky2ItemData(609, ItemClassification.helpful),
    # "Sunken City":                Spelunky2ItemData(610, ItemClassification.helpful),
}

world_unlocks = {
    "Progressive World Unlock":     Spelunky2ItemData(701, ItemClassification.progression, 0),  # Count set by goal
    "Jungle":                       Spelunky2ItemData(702, ItemClassification.progression, 0),
    "Volcana":                      Spelunky2ItemData(703, ItemClassification.progression, 0),
    "Olmec's Lair":                 Spelunky2ItemData(704, ItemClassification.progression, 0),
    "Tide Pool":                    Spelunky2ItemData(705, ItemClassification.progression, 0),
    "Temple":                       Spelunky2ItemData(706, ItemClassification.progression, 0),
    "Ice Caves":                    Spelunky2ItemData(707, ItemClassification.progression, 0),
    "Neo Babylon":                  Spelunky2ItemData(708, ItemClassification.progression, 0),
    "Sunken City":                  Spelunky2ItemData(709, ItemClassification.progression, 0),
    "Cosmic Ocean":                 Spelunky2ItemData(710, ItemClassification.progression, 0),
}

traps = {
    "Poison Trap":                  Spelunky2ItemData(801, ItemClassification.trap, 0),
    "Curse Trap":                   Spelunky2ItemData(802, ItemClassification.trap, 0),
    "Ghost Trap":                   Spelunky2ItemData(803, ItemClassification.trap, 0),
    "Stun Trap":                    Spelunky2ItemData(804, ItemClassification.trap, 0),
    "Loose Bombs Trap":             Spelunky2ItemData(805, ItemClassification.trap, 0),
    "Blindness Trap":               Spelunky2ItemData(806, ItemClassification.trap, 0),
    # "Amnesia Trap":               Spelunky2ItemData(807, ItemClassification.trap, 0),
    # "Angry Shopkeepers Trap":     Spelunky2ItemData(808, ItemClassification.trap, 0),
    "Punish Ball Trap":             Spelunky2ItemData(809, ItemClassification.trap, 0)
}

# Populate further with locked_items, starter_items and quest_items inside __init.py__ based on Options
item_data_table = {
    **filler_items,
    **characters,
    # **shortcuts,
    **traps
}

filler_weights = {
    "Rope Pile":                0,
    "Bomb Bag":                 0,
    "Bomb Box":                 0,
    "Cooked Turkey":            0,
    "Royal Jelly":              0,
    "Gold Bar":                 0,
    "Emerald Gem":              0,
    "Sapphire Gem":             0,
    "Ruby Gem":                 0,
    "Diamond Gem":              0,
}

trap_weights = {
    "Poison Trap":              0,
    "Curse Trap":               0,
    "Ghost Trap":               0,
    "Stun Trap":                0,
    "Loose Bombs Trap":         0,
    "Blindness Trap":           0,
    # "Amnesia Trap":           0,
    # "Angry Shopkeepers Trap": 0,
    "Punish Ball Trap":         0
}
