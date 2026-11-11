from logging import warning
from typing import TYPE_CHECKING
from .enums import WorldName, RuleNames, ItemName, LocationName, JournalName, JOURNAL_SUFFIX, QilinMode
from .Items import locked_items

from BaseClasses import CollectionState
from worlds.generic.Rules import set_rule

if TYPE_CHECKING:
    from . import Spelunky2World


def has_or_unrestricted(world, state, player, item_name: str) -> bool:
    """
    Returns True if the item is in the player's possession OR
    is not in the AP-locked 'restricted_items' set (meaning it's free in-game).
    """
    return (item_name not in world.options.restricted_items) or state.has(item_name, player)


def set_common_rules(world: "Spelunky2World", player: int):
    set_item_rules(world, player)
    set_rule(world.get_entrance(RuleNames.MENU_TO_DWELLING), lambda state: True)

    if world.options.death_link.value:
        set_rule(world.get_location(JournalName.GHOST),
                 lambda state: has_or_unrestricted(world, state, player, ItemName.ANKH))
        set_rule(world.get_location(JournalName.SPIKES),
                 lambda state:
                 (
                         has_or_unrestricted(world, state, player, ItemName.ANKH)
                         or
                         has_or_unrestricted(world, state, player, ItemName.TELEPACK)
                 ))

    set_rule(world.get_entrance(RuleNames.DWELLING_TO_JUNGLE),
             lambda state: has_jungle(state, player))
    set_rule(world.get_entrance(RuleNames.DWELLING_TO_VOLCANA),
             lambda state: has_volcana(state, player))
    set_rule(world.get_entrance(RuleNames.JUNGLE_TO_OLMEC),
             lambda state: state.has(WorldName.OLMECS_LAIR, player) or state.has(WorldName.PROGRESSIVE, player, 2))
    set_rule(world.get_entrance(RuleNames.VOLCANA_TO_OLMEC),
             lambda state: state.has(WorldName.OLMECS_LAIR, player) or state.has(WorldName.PROGRESSIVE, player, 2))
    set_rule(world.get_entrance(RuleNames.OLMEC_TO_TIDE_POOL),
             lambda state: state.has(WorldName.TIDE_POOL, player) or state.has(WorldName.PROGRESSIVE, player, 3))
    set_rule(world.get_entrance(RuleNames.OLMEC_TO_TEMPLE),
             lambda state: state.has(WorldName.TEMPLE, player) or state.has(WorldName.PROGRESSIVE, player, 3))
    set_rule(world.get_entrance(RuleNames.TIDEPOOL_TO_ICE_CAVES),
             lambda state: state.has(WorldName.ICE_CAVES, player) or state.has(WorldName.PROGRESSIVE, player, 4))
    set_rule(world.get_entrance(RuleNames.TEMPLE_TO_ICE_CAVES),
             lambda state: state.has(WorldName.ICE_CAVES, player) or state.has(WorldName.PROGRESSIVE, player, 4))
    set_rule(world.get_entrance(RuleNames.ICE_CAVES_TO_NEO_BABYLON),
             lambda state: state.has(WorldName.NEO_BABYLON, player) or state.has(WorldName.PROGRESSIVE, player, 5))

    # Secondary Regions
    set_rule(world.get_entrance(RuleNames.DWELLING_TO_ANY_WORLD_2),
             lambda state: has_world_2(state, player))
    set_rule(world.get_entrance(RuleNames.JUNGLE_TO_BLACK_MARKET),
             lambda state:
             (
                     has_or_unrestricted(world, state, player, ItemName.UDJAT_EYE)
                     or
                     world.options.can_udjat_skip
             ))
    set_rule(world.get_entrance(RuleNames.VOLCANA_TO_VLADS_CASTLE),
             lambda state:
             (
                     has_or_unrestricted(world, state, player, ItemName.UDJAT_EYE)
                     or
                     world.options.can_udjat_skip
             ))
    set_rule(world.get_entrance(RuleNames.TIDEPOOL_TO_ABZU),
             lambda state:
             (
                     has_or_unrestricted(world, state, player, ItemName.ANKH)
                     or
                     world.options.can_ankh_skip
             ))
    set_rule(world.get_entrance(RuleNames.TEMPLE_TO_CITY_OF_GOLD),
             lambda state:
             has_royalty(world, state, player)
             and
             has_or_unrestricted(world, state, player, ItemName.SCEPTER))
    set_rule(world.get_entrance(RuleNames.CITY_OF_GOLD_TO_DUAT),
             lambda state: has_or_unrestricted(world, state, player, ItemName.ANKH))
    set_rule(world.get_entrance(RuleNames.ICE_CAVES_TO_MOTHERSHIP),
             lambda state: can_access_mothership(world, state, player))

    # People Entries
    set_rule(world.get_location(JournalName.EGGPLANT_CHILD),
             lambda state:
             (
                     has_or_unrestricted(world, state, player, ItemName.EGGPLANT)
                     and
                     state.has(WorldName.ICE_CAVES, player) or state.has(WorldName.PROGRESSIVE, player, 4)
             ))
    # Bestiary Entries
    set_rule(world.get_location(JournalName.QILIN),
             lambda state: can_obtain_qilin(world, state, player))
    # Item Entries
    set_rule(world.get_location(JournalName.ALIEN_COMPASS),
             lambda state: can_obtain_alien_compass(state, player))
    set_rule(world.get_location(JournalName.UDJAT_EYE),
             lambda state: has_or_unrestricted(world, state, player, ItemName.UDJAT_EYE))
    set_rule(world.get_location(JournalName.HEDJET),
             lambda state: has_or_unrestricted(world, state, player, ItemName.HEDJET))
    set_rule(world.get_location(JournalName.CROWN),
             lambda state: has_or_unrestricted(world, state, player, ItemName.CROWN))
    set_rule(world.get_location(JournalName.ANKH),
             lambda state: has_or_unrestricted(world, state, player, ItemName.ANKH))
    set_rule(world.get_location(JournalName.TABLET_OF_DESTINY),
             lambda state: can_obtain_tablet(world, state, player))
    set_rule(world.get_location(JournalName.EXCALIBUR),
             lambda state:
             has_royalty(world, state, player)
             and
             has_or_unrestricted(world, state, player, ItemName.EXCALIBUR))
    set_rule(world.get_location(JournalName.BROKEN_SWORD),
             lambda state:
             (
                     has_or_unrestricted(world, state, player, ItemName.EXCALIBUR)
                     and
                     has_or_unrestricted(world, state, player, ItemName.CLONE_GUN)
             ))
    set_rule(world.get_location(JournalName.SCEPTER),
             lambda state: has_or_unrestricted(world, state, player, ItemName.SCEPTER))
    set_rule(world.get_location(JournalName.HOU_YI_BOW),
             lambda state: has_or_unrestricted(world, state, player, ItemName.HOU_YI_BOW))
    set_rule(world.get_location(JournalName.USHABTI),
             lambda state: has_or_unrestricted(world, state, player, ItemName.USHABTI))
    set_rule(world.get_location(JournalName.EGGPLANT),
             lambda state:
             (
                     has_or_unrestricted(world, state, player, ItemName.EGGPLANT)
                     and
                     state.has(WorldName.TIDE_POOL, player) or state.has(WorldName.PROGRESSIVE, player, 3)
             ))


def set_sunken_city_rules(world: "Spelunky2World", player: int):
    # Entrance Rules
    set_rule(world.get_entrance(RuleNames.NEO_BABYLON_TO_SUNKEN_CITY),
             lambda state: can_access_sunken_city(world, state, player))
    set_rule(world.get_entrance(RuleNames.SUNKEN_CITY_TO_EGGPLANT_WORLD),
             lambda state: has_or_unrestricted(world, state, player, ItemName.EGGPLANT))
    set_rule(world.get_location(JournalName.ARROW_OF_LIGHT),
             lambda state: can_access_sunken_city(world, state, player))


def set_cosmic_ocean_rules(world: "Spelunky2World", player: int):
    set_rule(world.get_entrance(RuleNames.SUNKEN_CITY_TO_COSMIC_OCEAN),
             lambda state: can_access_cosmic_ocean(world, state, player))


def has_royalty(world: "Spelunky2World", state: CollectionState, player: int):
    return (
            has_or_unrestricted(world, state, player, ItemName.UDJAT_EYE)
            and
            ((
                     has_jungle(state, player)
                     and
                     has_or_unrestricted(world, state, player, ItemName.HEDJET)
             )
             or
             (
                     has_volcana(state, player)
                     and
                     has_or_unrestricted(world, state, player, ItemName.CROWN)
             ))
    )


def has_jungle(state: CollectionState, player: int) -> bool:
    return state.has(WorldName.JUNGLE, player) or state.has(WorldName.PROGRESSIVE, player)


def has_volcana(state: CollectionState, player: int) -> bool:
    return state.has(WorldName.VOLCANA, player) or state.has(WorldName.PROGRESSIVE, player)


def has_cosmic(state: CollectionState, player: int) -> bool:
    return state.has(WorldName.COSMIC_OCEAN, player) or state.has(WorldName.PROGRESSIVE, player, 7)


def has_world_2(state: CollectionState, player: int) -> bool:
    return has_jungle(state, player) or has_volcana(state, player)


def can_obtain_alien_compass(state: CollectionState, player: int) -> bool:
    return (
            (
                    state.has_all([WorldName.VOLCANA, WorldName.OLMECS_LAIR, WorldName.TEMPLE], player)
                    or
                    state.has(WorldName.PROGRESSIVE, player, 3)
            )
            and
            state.can_reach(LocationName.VLADS_CASTLE, "Region", player)
    )


def can_access_mothership(world: "Spelunky2World", state: CollectionState, player: int) -> bool:
    return (
            can_obtain_alien_compass(state, player)
            or world.options.can_mothership_skip
    )


def can_obtain_tablet(world: "Spelunky2World", state: CollectionState, player: int) -> bool:
    return (
            has_or_unrestricted(world, state, player, ItemName.ANKH)
            and
            has_or_unrestricted(world, state, player, ItemName.TABLET_OF_DESTINY)
            and (
                    state.can_reach(LocationName.DUAT, "Region", player)
                    or (
                            state.can_reach(LocationName.ABZU, "Region", player)
                            and
                            (
                                    state.can_reach(JournalName.EXCALIBUR, "Location", player)
                                    or world.options.can_kingu_skip
                            )
                    )
            )
    )


def can_obtain_qilin(world: "Spelunky2World", state: CollectionState, player: int) -> bool:
    return (
            can_obtain_tablet(world, state, player)
            and has_or_unrestricted(world, state, player, ItemName.USHABTI)
    )


def can_access_sunken_city(world: "Spelunky2World", state: CollectionState, player: int) -> bool:
    return (
            (
                    state.has(WorldName.SUNKEN_CITY, player) or state.has(WorldName.PROGRESSIVE, player, 6)
            )
            and
            (
                    can_obtain_qilin(world, state, player) or can_qilin_skip(world, state, player)
            )
    )


def has_climbing_vlad(world: "Spelunky2World", state: CollectionState, player: int) -> bool:
    return (
            has_or_unrestricted(world, state, player, ItemName.VLADS_CAPE)
            and
            has_or_unrestricted(world, state, player, ItemName.CLIMBING_GLOVES)
    )


def can_qilin_skip(world: "Spelunky2World", state: CollectionState, player: int) -> bool:
    if world.options.qilin_skip_logic == QilinMode.OFF:
        return False
    elif world.options.qilin_skip_logic == QilinMode.BUBBLE:
        return True
    elif world.options.qilin_skip_logic == QilinMode.JP:
        return has_or_unrestricted(world, state, player, ItemName.JETPACK)
    elif world.options.qilin_skip_logic == QilinMode.VLAD:
        return has_climbing_vlad(world, state, player)
    else:
        return has_or_unrestricted(world, state, player, ItemName.JETPACK) or has_climbing_vlad(world, state, player)


def can_access_cosmic_ocean(world: "Spelunky2World", state: CollectionState, player: int) -> bool:
    return (
            has_or_unrestricted(world, state, player, ItemName.HOU_YI_BOW)
            and has_or_unrestricted(world, state, player, ItemName.ARROW_OF_LIGHT)
            and has_cosmic(state, player)
            and can_access_sunken_city(world, state, player)
    )


def set_item_rules(world: "Spelunky2World", player: int):
    for item_name in locked_items:
        try:
            set_rule(world.get_location(f"{item_name}{JOURNAL_SUFFIX}"),
                     lambda state, name=ItemName(item_name).value: has_or_unrestricted(world, state, player, name))
        except KeyError:
            warning(f"[Spelunky2 - set_item_rules] ERROR! No match for '{item_name}' (May end up with impossible seed)")
            pass
