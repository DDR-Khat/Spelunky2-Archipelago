from typing import TYPE_CHECKING
from . import powerup_options, locked_items

from BaseClasses import CollectionState
from worlds.generic.Rules import set_rule

if TYPE_CHECKING:
    from . import Spelunky2World


def set_common_rules(world: "Spelunky2World", player: int):

    # Primary Regions -- note starting from shortcuts is not currently in logic. When this is added, it might break certain entries (e.g. The Tusk Idol and chain requirements)
    set_rule(world.get_entrance("Menu -> Dwelling"), lambda state: True)
    # set_rule(world.get_entrance("Menu -> Olmec's Lair"), lambda state: state.has("Olmec's Lair Shortcut", player) or state.has("Progressive Shortcut", player, 2)) - Not implemented yet
    # set_rule(world.get_entrance("Menu -> Ice Caves"), lambda state: state.has("Ice Caves Shortcut", player) or state.has("Progressive Shortcut", player, 3)) - Not implemented yet
    set_rule(world.get_entrance("Dwelling -> Jungle"), lambda state: state.has("Jungle", player) or state.has("Progressive World Unlock", player))
    set_rule(world.get_entrance("Dwelling -> Volcana"), lambda state: state.has("Volcana", player) or state.has("Progressive World Unlock", player))
    set_rule(world.get_entrance("Jungle -> Olmec's Lair"), lambda state: state.has("Olmec's Lair", player) or state.has("Progressive World Unlock", player, 2))
    set_rule(world.get_entrance("Volcana -> Olmec's Lair"), lambda state: state.has("Olmec's Lair", player) or state.has("Progressive World Unlock", player, 2))
    set_rule(world.get_entrance("Olmec's Lair -> Tide Pool"), lambda state: state.has("Tide Pool", player) or state.has("Progressive World Unlock", player, 3))
    set_rule(world.get_entrance("Olmec's Lair -> Temple"), lambda state: state.has("Temple", player) or state.has("Progressive World Unlock", player, 3))
    set_rule(world.get_entrance("Tide Pool -> Ice Caves"), lambda state: state.has("Ice Caves", player) or state.has("Progressive World Unlock", player, 4))
    set_rule(world.get_entrance("Temple -> Ice Caves"), lambda state: state.has("Ice Caves", player) or state.has("Progressive World Unlock", player, 4))
    set_rule(world.get_entrance("Ice Caves -> Neo Babylon"), lambda state: state.has("Neo Babylon", player) or state.has("Progressive World Unlock", player, 5))

    # Secondary Regions
    set_rule(world.get_entrance("Dwelling -> Any World 2"), lambda state: has_world_2(state, player))
    set_rule(world.get_entrance("Jungle -> Black Market"), lambda state: state.has("Udjat Eye", player))  # TODO Udjat Skip setting
    set_rule(world.get_entrance("Volcana -> Vlad's Castle"), lambda state: state.has("Udjat Eye", player))  # TODO Udjat Skip setting
    set_rule(world.get_entrance("Tide Pool -> Abzu"), lambda state: state.has("Ankh", player))  # TODO Deathskip setting
    set_rule(world.get_entrance("Temple -> City of Gold"), lambda state: has_royalty(state, player) and state.has("Scepter", player))
    set_rule(world.get_entrance("City of Gold -> Duat"), lambda state: state.has("Ankh", player))
    set_rule(world.get_entrance("Ice Caves -> Mothership"), lambda state: can_access_mothership(state, player))

    # People Entries
    set_rule(world.get_location("Eggplant Child Journal Entry"), lambda state: state.has("Eggplant", player))

    # Bestiary Entries
    set_rule(world.get_location("Qilin Journal Entry"), lambda state: can_obtain_qilin(state, player))

    # Item Entries
    set_rule(world.get_location("Alien Compass Journal Entry"), lambda state: can_obtain_alien_compass(state, player))
    set_rule(world.get_location("Udjat Eye Journal Entry"), lambda state: state.has("Udjat Eye", player))
    set_rule(world.get_location("Hedjet Journal Entry"), lambda state: state.has("Hedjet", player))
    set_rule(world.get_location("Crown Journal Entry"), lambda state: state.has("Crown", player))
    set_rule(world.get_location("Ankh Journal Entry"), lambda state: state.has("Ankh", player))
    set_rule(world.get_location("Tablet of Destiny Journal Entry"), lambda state: can_obtain_tablet(state, player))
    set_rule(world.get_location("Excalibur Journal Entry"), lambda state: has_royalty(state, player) and state.has("Excalibur", player))
    set_rule(world.get_location("Scepter Journal Entry"), lambda state: state.has("Scepter", player))
    set_rule(world.get_location("Hou Yi's Bow Journal Entry"), lambda state: state.has("Hou Yi's Bow", player))
    set_rule(world.get_location("Ushabti Journal Entry"), lambda state: state.has("Ushabti", player))
    set_rule(world.get_location("Eggplant Journal Entry"), lambda state: state.has("Eggplant", player))


def set_sunken_city_rules(world: "Spelunky2World", player: int):

    # Entrance Rules
    set_rule(world.get_entrance("Neo Babylon -> Sunken City"), lambda state: can_access_sunken_city(state, player))
    set_rule(world.get_entrance("Sunken City -> Eggplant World"), lambda state: state.has("Eggplant", player))
    set_rule(world.get_location("Arrow of Light Journal Entry"), lambda state: can_access_sunken_city(state, player))


def set_cosmic_ocean_rules(world: "Spelunky2World", player: int):
    set_rule(world.get_entrance("Sunken City -> Cosmic Ocean"), lambda state: can_access_cosmic_ocean(state, player))


def has_royalty(state: CollectionState, player: int):
    return (state.has("Udjat Eye", player)
            and (state.has_all(["Jungle", "Hedjet"], player)
                 or state.has_all(["Volcana", "Crown"], player)
                 or (state.has("Progressive World Unlock", player) and state.has_any(["Hedjet", "Crown"], player))))


def has_weapon(state: CollectionState, player: int) -> bool:  # Currently unused
    return (state.has_all(["Tide Pool", "Excalibur"], player)
            or state.has_all(["Temple", "Scepter"], player)
            or (state.has("Progressive World Unlock", player, 3) and state.has_any(["Excalibur", "Scepter"], player)))


def has_world_2(state: CollectionState, player: int) -> bool:
    return state.has_any(["Jungle", "Volcana"], player) or state.has("Progressive World Unlock", player)


def has_world_4(state: CollectionState, player: int) -> bool:  # Currently unused
    return state.has_any(["Tide Pool", "Temple"], player) or state.has("Progressive World Unlock", player, 3)


def can_obtain_alien_compass(state: CollectionState, player: int) -> bool:
    return (state.has_all(["Volcana", "Olmec's Lair", "Temple"], player) and state.can_reach("Vlad's Castle", "Region", player)
            or state.has("Progressive World Unlock", player, 3))  # Vlad's Castle requirement handled by the Regions logic

# TODO Alien Compass Skip settings (Mothership can be found with various mobility items or even with nothing but bombs/landmines), currently identical to can_obtain_alien_compass
def can_access_mothership(state: CollectionState, player: int) -> bool:
    return can_obtain_alien_compass(state, player)  # or state.has("Progressive Compass", player, 2) -- not valid, as Alien Compass is only given at start if you already have the journal entry

# TODO Excalibur Skip settings
def can_obtain_tablet(state: CollectionState, player: int) -> bool:
    return (state.has("Tablet of Destiny", player) and
            (state.can_reach("Duat", "Region", player) or
             (state.can_reach("Abzu", "Region", player) and state.can_reach("Excalibur Journal Entry", "Location", player))))


def can_obtain_qilin(state: CollectionState, player: int) -> bool:
    return can_obtain_tablet(state, player) and state.has("Ushabti", player)

# TODO Qilin Skip settings
def can_access_sunken_city(state: CollectionState, player: int) -> bool:
    return can_obtain_qilin(state, player) and (state.has("Sunken City", player) or state.has("Progressive World Unlock", player, 6))


def can_access_cosmic_ocean(state: CollectionState, player: int) -> bool:
    return (state.has_all(["Hou Yi's Bow", "Arrow of Light"], player)
            and (state.has("Cosmic Ocean", player) or state.has("Progressive World Unlock", player, 7)))


def get_upgrade_item_name(item_name: str) -> str:
    return f"{item_name} Upgrade"


def get_waddler_item_name(item_name: str) -> str:
    return f"{item_name} Waddler Upgrade"


def set_starter_upgrade_rules(world: "Spelunky2World", player: int):
    """Ensure starter upgrades require their locked/quest counterpart first."""

    # Set rules for all possible Waddler upgrades.
    # We iterate over locked_items because the user can select any of these for Waddler storage.
    waddler_items_selected = world.options.waddler_upgrades.value
    for item_name in locked_items:
        if item_name in waddler_items_selected:
            waddler_name = get_waddler_item_name(item_name)
            try:
                loc = world.get_location(waddler_name)
                # Waddler items require their locked item counterpart
                set_rule(loc, lambda state, name=item_name: state.has(name, player))
            except KeyError:
                pass

    # Set rules for all powerup upgrades that were NOT selected as Waddler items.
    item_upgrades_selected = world.options.item_upgrades.value
    for item_name in powerup_options:
        if item_name not in waddler_items_selected and item_name in item_upgrades_selected:
            upgrade_name = get_upgrade_item_name(item_name)
            try:
                loc = world.get_location(upgrade_name)
                # Upgrades require their locked item counterpart
                set_rule(loc, lambda state, name=item_name: state.has(name, player))
            except KeyError:
                pass
