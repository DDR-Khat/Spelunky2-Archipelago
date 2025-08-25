from . import item_options, locked_items, powerup_options, equip_options, quest_items
from Options import Toggle, DefaultOnToggle, Range, Choice, PerGameCommonOptions, DeathLink, ItemSet
from dataclasses import dataclass


def format_options(options, row_length=10):
    """Formats a list of options into a multi-line string, with each line
    containing 'row_length' options separated by '|'.
    """
    lines = []
    # Convert the options to a list to ensure order
    options_list = list(options)
    for i in range(0, len(options_list), row_length):
        row = " | ".join(options_list[i:i + row_length])
        lines.append(f"- {row}")
    return "\n".join(lines)


item_options_text = format_options(sorted(item_options))
locked_items_text = format_options(sorted(locked_items))


class Goal(Choice):
    """When is your world considered finished.
    Easy: Requires completing the "normal" ending by reaching 6-4 and defeating Tiamat
    Hard: Requires completing the "hard" ending by reaching 7-4 and defeating Hundun
    CO: Requires reaching a specified level in Cosmic Ocean"""
    display_name = "Goal"
    option_easy = 0
    option_hard = 1
    option_co = 2
    default = 0


class GoalLevel(Range):
    """Which level in Cosmic Ocean are you required to clear to consider your game as beaten.
    This option can be ignored if your goal is not set to \"CO\""""
    display_name = "Cosmic Ocean Goal Level"
    range_start = 10
    range_end = 99
    default = 30


class ProgressiveWorlds(DefaultOnToggle):
    """Whether new worlds should be unlocked individually or progressively."""
    display_name = "Progressive Worlds"


"""
# Not implemented yet
class ProgressiveShortcuts(DefaultOnToggle):
    \"""Whether new shortcuts should be unlocked individually or progressively.\"""
    display_name = "Progressive Shortcuts"
"""

class IncreaseStartingWallet(Toggle):
    """Should treasure (gold/emerald/sapphire/ruby/diamond) you receive from other players
    increase the amount of gold you begin with after death."""
    display_name = "Increase Starting Wallet"


class StartingHealth(Range):
    """How much Health should you initially start with."""
    display_name = "Starting Health"
    range_start = 1
    range_end = 10
    default = 4


class HealthUpgrades(Range):
    """Increases how much health you will begin with after death."""
    display_name = "Progressive Health"
    range_start = 0
    range_end = 30
    default = 10


class StartingBombs(Range):
    """How many Bombs should you initially start with."""
    display_name = "Starting Bombs"
    range_start = 0
    range_end = 10
    default = 4


class BombUpgrades(Range):
    """Increases how many bombs you will begin with after death."""
    display_name = "Starting Bombs Upgrades"
    range_start = 0
    range_end = 30
    default = 5


class StartingRopes(Range):
    """How many Ropes should you initially start with."""
    display_name = "Starting Ropes"
    range_start = 0
    range_end = 10
    default = 4


class RopeUpgrades(Range):
    """Increases how many ropes you will begin with after death."""
    display_name = "Starting Rope Upgrades"
    range_start = 0
    range_end = 20
    default = 0


class RestrictedItems(ItemSet):
    __doc__ = f"""Items that are added to the multi-world as progressive and must be found in the multi-world before they can be obtained in the game
Options: 
{locked_items_text}"""
    display_name = "Restricted Items"
    valid_keys = locked_items
    default = locked_items


class ItemUpgrades(ItemSet):
    __doc__ = f"""Add the following useful items in the multi-world item pool which are kept on death, AFTER obtaining it's journal entry.
Options: 
{item_options_text}"""
    display_name = "Item Upgrades"
    valid_keys = item_options
    default = powerup_options - {"True Crown", "Eggplant Crown"}


class WaddlerUpgrades(ItemSet):
    __doc__ = f"""Add the following useful items in the multi-world item pool which are added to Waddler's storage between runs, AFTER obtaining it's journal entry.
Options (any selected here override options in item_upgrades):
{locked_items_text}"""
    display_name = "Waddler Items"
    valid_keys = locked_items
    default = equip_options - {"True Crown", "Eggplant Crown"}


class DeathLinkBypassesAnkh(Toggle):
    """Sets whether deaths sent through Death Link will trigger the Ankh, or ignore it."""
    display_name = "Death Link Ankh Handling"


class RopePileWeight(Range):
    """Sets the likelihood of a filler item being a Rope Pile relative to others."""
    display_name = "Rope Pile Weight"
    range_start = 0
    range_end = 100
    default = 13


class BombBagWeight(Range):
    """Sets the likelihood of a filler item being a Bomb Bag relative to others."""
    display_name = "Bomb Bag Weight"
    range_start = 0
    range_end = 100
    default = 13


class BombBoxWeight(Range):
    """Sets the likelihood of a filler item being a Bomb Box relative to others."""
    display_name = "Bomb Box Weight"
    range_start = 0
    range_end = 100
    default = 5


class CookedTurkeyWeight(Range):
    """Sets the likelihood of a filler item being a Cooked Turkey relative to others."""
    display_name = "Cooked Turkey Weight"
    range_start = 0
    range_end = 100
    default = 18


class RoyalJellyWeight(Range):
    """Sets the likelihood of a filler item being a Royal Jelly relative to others."""
    display_name = "Royal Jelly Weight"
    range_start = 0
    range_end = 100
    default = 5


class GoldBarWeight(Range):
    """Sets the likelihood of a filler item being a Gold Bar relative to others."""
    display_name = "Gold Bar Weight"
    range_start = 0
    range_end = 100
    default = 20


class EmeraldGemWeight(Range):
    """Sets the likelihood of a filler item being an Emerald relative to others."""
    display_name = "Emerald Gem Weight"
    range_start = 0
    range_end = 100
    default = 10


class SapphireGemWeight(Range):
    """Sets the likelihood of a filler item being a Sapphire relative to others."""
    display_name = "Sapphire Gem Weight"
    range_start = 0
    range_end = 100
    default = 8


class RubyGemWeight(Range):
    """Sets the likelihood of a filler item being a Ruby relative to others."""
    display_name = "Ruby Gem Weight"
    range_start = 0
    range_end = 100
    default = 6


class DiamondGemWeight(Range):
    """Sets the likelihood of a filler item being a Diamond relative to others."""
    display_name = "Diamond Gem Weight"
    range_start = 0
    range_end = 100
    default = 2


class EnableTraps(Toggle):
    """Whether traps should be included in the item pool."""
    display_name = "Enable Traps"


class TrapWeight(Range):
    """Determines the percentage of filler items that will be replaced by traps."""
    display_name = "Trap Percentage"
    range_start = 5
    range_end = 30
    default = 15


class PoisonTrapChance(Range):
    """Sets the likelihood of a trap being a Poison Trap relative to other traps.
    Poison Traps will instantly poison the player."""
    display_name = "Poison Trap Weight"
    range_start = 0
    range_end = 100
    default = 15


class CurseTrapChance(Range):
    """Sets the likelihood of a trap being a Curse Trap relative to other traps.
    Curse Traps will instantly curse the player."""
    display_name = "Curse Trap Weight"
    range_start = 0
    range_end = 100
    default = 5


class GhostTrapChance(Range):
    """Sets the likelihood of a trap being a Ghost Trap relative to other traps.
    Ghost Traps will immediately spawn the ghost (or Jelly if in Cosmic Ocean)."""
    display_name = "Ghost Trap Weight"
    range_start = 0
    range_end = 100
    default = 10


class StunTrapChance(Range):
    """Sets the likelihood of a trap being a Stun Trap relative to other traps.
    Stun Traps wll stun the player for 1 second."""
    display_name = "Stun Trap Weight"
    range_start = 0
    range_end = 100
    default = 25


class LooseBombsTrapChance(Range):
    """Sets the likelihood of a trap being a Loose Bombs Trap relative to other traps.
    Loose Bombs Traps will spawn 1 lit bomb at the player's feet every second for 5 seconds."""
    display_name = "Loose Bombs Trap Weight"
    range_start = 0
    range_end = 100
    default = 15


class BlindnessTrapChance(Range):
    """Sets the likelihood of a trap being a Blindness Trap relative to other traps.
    Blindness traps will trigger a darkness effect similar to the \"I can't see a thing!\" level
    feeling for the current level."""
    display_name = "Blindness Trap Weight"
    range_start = 0
    range_end = 100
    default = 20


class PunishBallTrapChance(Range):
    """Sets the likelihood of a trap being a Punish Ball Trap relative to other traps.
    Punish Ball Traps will attach a ball and chain to the player for 3 levels."""
    display_name = "Punish Ball Trap Weight"
    range_start = 0
    range_end = 100
    default = 10


@dataclass
class Spelunky2Options(PerGameCommonOptions):
    goal: Goal
    goal_level: GoalLevel
    starting_wallet: IncreaseStartingWallet
    progressive_worlds: ProgressiveWorlds
    starting_health: StartingHealth
    health_upgrades: HealthUpgrades
    starting_bombs: StartingBombs
    bomb_upgrades: BombUpgrades
    starting_ropes: StartingRopes
    rope_upgrades: RopeUpgrades
    restricted_items: RestrictedItems
    item_upgrades: ItemUpgrades
    waddler_upgrades: WaddlerUpgrades
    # progressive_shortcuts: ProgressiveShortcuts - Not implemented yet
    rope_pile_weight: RopePileWeight
    bomb_bag_weight: BombBagWeight
    bomb_box_weight: BombBoxWeight
    cooked_turkey_weight: CookedTurkeyWeight
    royal_jelly_weight: RoyalJellyWeight
    gold_bar_weight: GoldBarWeight
    emerald_gem_weight: EmeraldGemWeight
    sapphire_gem_weight: SapphireGemWeight
    ruby_gem_weight: RubyGemWeight
    diamond_gem_weight: DiamondGemWeight
    enable_traps: EnableTraps
    trap_weight: TrapWeight
    poison_weight: PoisonTrapChance
    curse_weight: CurseTrapChance
    ghost_weight: GhostTrapChance
    stun_weight: StunTrapChance
    bomb_weight: LooseBombsTrapChance
    blind_weight: BlindnessTrapChance
    punish_weight: PunishBallTrapChance
    death_link: DeathLink
    bypass_ankh: DeathLinkBypassesAnkh
