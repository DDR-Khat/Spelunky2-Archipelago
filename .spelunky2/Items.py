from typing import Optional, NamedTuple
from BaseClasses import Item, ItemClassification
from . import locked_items, item_options

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
    # "Ana Spelunky":                 Spelunky2ItemData(101),
    # "Margaret Tunnel":              Spelunky2ItemData(102),
    # "Colin Northward":              Spelunky2ItemData(103),
    # "Roffy D. Sloth":               Spelunky2ItemData(104),
    "Alto Singh":                   Spelunky2ItemData(105),
    "Liz Mutton":                   Spelunky2ItemData(106),
    "Nekka the Eagle":              Spelunky2ItemData(107),
    "LISE Project":                 Spelunky2ItemData(108),
    "Coco Von Diamonds":            Spelunky2ItemData(109),
    "Manfred Tunnel":               Spelunky2ItemData(110),
    "Little Jay":                   Spelunky2ItemData(111),
    "Tina Flan":                    Spelunky2ItemData(112),
    "Valerie Crump":                Spelunky2ItemData(113),
    "Au":                           Spelunky2ItemData(114),
    "Demi Von Diamonds":            Spelunky2ItemData(115),
    "Pilot":                        Spelunky2ItemData(116),
    "Princess Airyn":               Spelunky2ItemData(117),
    "Dirk Yamaoka":                 Spelunky2ItemData(118),
    "Guy Spelunky":                 Spelunky2ItemData(119),
    "Classic Guy":                  Spelunky2ItemData(120)
}

locked_items_dict = {}
item_code = 200
for item_name in locked_items:
    item_code += 1
    locked_items_dict[item_name] = Spelunky2ItemData(item_code, ItemClassification.progression)

upgrade_items_dict = {}
item_code = 300
for item_name in item_options:
    item_code += 1
    upgrade_items_dict[f"{item_name} Upgrade"] = Spelunky2ItemData(item_code, ItemClassification.useful)

waddler_items_dict = {}
item_code = 400
for item_name in locked_items:
    item_code += 1
    waddler_items_dict[f"{item_name} Waddler Upgrade"] = Spelunky2ItemData(item_code, ItemClassification.useful)

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
    **locked_items_dict,
    **upgrade_items_dict,
    **waddler_items_dict,
    **permanent_upgrades,
    **world_unlocks,
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
