from typing import TYPE_CHECKING
from . import powerup_options, locked_items

from BaseClasses import CollectionState
from worlds.generic.Rules import set_rule

if TYPE_CHECKING:
    from . import Spelunky2World

def has_or_unrestricted(world, state, player, item_name: str) -> bool:
    """
    Returns True if the item is in the player's possession OR
    is not in the AP-locked 'restricted_items' set (meaning it's free in-game).
    """
    return (item_name not in world.options.restricted_items.value) or state.has(item_name, player)

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
    set_rule(world.get_entrance("Jungle -> Black Market"), lambda state: has_or_unrestricted(world, state, player, "Udjat Eye"))  # TODO Udjat Skip setting
    set_rule(world.get_entrance("Volcana -> Vlad's Castle"), lambda state: has_or_unrestricted(world, state, player, "Udjat Eye"))  # TODO Udjat Skip setting
    set_rule(world.get_entrance("Tide Pool -> Abzu"), lambda state: has_or_unrestricted(world, state, player, "Ankh"))  # TODO Deathskip setting
    set_rule(world.get_entrance("Temple -> City of Gold"), lambda state: has_royalty(world, state, player) and has_or_unrestricted(world, state, player, "Scepter"))
    set_rule(world.get_entrance("City of Gold -> Duat"), lambda state: has_or_unrestricted(world, state, player, "Ankh"))
    set_rule(world.get_entrance("Ice Caves -> Mothership"), lambda state: can_access_mothership(state, player))

    # People Entries
    set_rule(world.get_location("Eggplant Child Journal Entry"), lambda state: has_or_unrestricted(world, state, player, "Eggplant"))

    # Bestiary Entries
    set_rule(world.get_location("Qilin Journal Entry"), lambda state: can_obtain_qilin(world, state, player))

    # Item Entries
    set_rule(world.get_location("Alien Compass Journal Entry"), lambda state: can_obtain_alien_compass(state, player))
    set_rule(world.get_location("Udjat Eye Journal Entry"), lambda state: has_or_unrestricted(world, state, player, "Udjat Eye"))
    set_rule(world.get_location("Hedjet Journal Entry"), lambda state: has_or_unrestricted(world, state, player, "Hedjet"))
    set_rule(world.get_location("Crown Journal Entry"), lambda state: has_or_unrestricted(world, state, player, "Crown"))
    set_rule(world.get_location("Ankh Journal Entry"), lambda state: has_or_unrestricted(world, state, player, "Ankh"))
    set_rule(world.get_location("Tablet of Destiny Journal Entry"), lambda state: can_obtain_tablet(world, state, player))
    set_rule(world.get_location("Excalibur Journal Entry"), lambda state: has_royalty(world, state, player) and has_or_unrestricted(world, state, player, "Excalibur"))
    set_rule(world.get_location("Scepter Journal Entry"), lambda state: has_or_unrestricted(world, state, player, "Scepter"))
    set_rule(world.get_location("Hou Yi's Bow Journal Entry"), lambda state: has_or_unrestricted(world, state, player, "Hou Yi's Bow"))
    set_rule(world.get_location("Ushabti Journal Entry"), lambda state: has_or_unrestricted(world, state, player, "Ushabti"))
    set_rule(world.get_location("Eggplant Journal Entry"), lambda state: has_or_unrestricted(world, state, player, "Eggplant"))


def set_sunken_city_rules(world: "Spelunky2World", player: int):

    # Entrance Rules
    set_rule(world.get_entrance("Neo Babylon -> Sunken City"), lambda state: can_access_sunken_city(world, state, player))
    set_rule(world.get_entrance("Sunken City -> Eggplant World"), lambda state: has_or_unrestricted(world, state, player, "Eggplant"))
    set_rule(world.get_location("Arrow of Light Journal Entry"), lambda state: can_access_sunken_city(world, state, player))


def set_cosmic_ocean_rules(world: "Spelunky2World", player: int):
    set_rule(world.get_entrance("Sunken City -> Cosmic Ocean"), lambda state: can_access_cosmic_ocean(world, state, player))


def has_royalty(world: "Spelunky2World", state: CollectionState, player: int):
    return (has_or_unrestricted(world, state, player, "Udjat Eye")
            and (state.has_all(["Jungle"], player) and has_or_unrestricted(world, state, player, "Hedjet")
                 or state.has_all(["Volcana"], player) and has_or_unrestricted(world, state, player, "Crown")
                 or (state.has("Progressive World Unlock", player)
                     and (has_or_unrestricted(world, state, player, "Hedjet")
                          or has_or_unrestricted(world, state, player, "Crown")))))


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
def can_obtain_tablet(world: "Spelunky2World", state: CollectionState, player: int) -> bool:
    return (has_or_unrestricted(world, state, player, "Tablet of Destiny")
            and (state.can_reach("Duat", "Region", player)
                 or (state.can_reach("Abzu", "Region", player)
                     and state.can_reach("Excalibur Journal Entry", "Location", player))))

def can_obtain_qilin(world: "Spelunky2World", state: CollectionState, player: int) -> bool:
    return (can_obtain_tablet(world, state, player)
            and has_or_unrestricted(world, state, player, "Ushabti"))

# TODO Qilin Skip settings
def can_access_sunken_city(world: "Spelunky2World", state: CollectionState, player: int) -> bool:
    return can_obtain_qilin(world, state, player) and (state.has("Sunken City", player) or state.has("Progressive World Unlock", player, 6))


def can_access_cosmic_ocean(world: "Spelunky2World", state: CollectionState, player: int) -> bool:
    return (has_or_unrestricted(world, state, player, "Hou Yi's Bow")
            and state.has("Arrow of Light", player)
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
                set_rule(loc, lambda state, name=item_name: has_or_unrestricted(world, state, player, name))
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
                set_rule(loc, lambda state, name=item_name: has_or_unrestricted(world, state, player, name))
            except KeyError:
                pass
