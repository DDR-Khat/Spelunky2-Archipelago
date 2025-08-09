from Options import Toggle, DefaultOnToggle, Range, Choice, PerGameCommonOptions, DeathLink, Set
from dataclasses import dataclass

# Item Master List
item_options = frozenset({"Cape", "Climbing Gloves", "Clover", "Crown", "Hedjet", "Hoverpack", "Jetpack", "Kapala", "Paste", "Pitchers Mitt", "Powerpack", "Skeleton Key", "Spectacles", "Spike Shoes", "Spring Shoes", "Telepack", "Teleporter", "VladCape"})
sorted_item_options = ", ".join(sorted(item_options))

class Goal(Choice):
    """When is your world considered finished.
    Tiamat: Requires completing the "normal" ending by reaching 6-4 and defeating Tiamat
    Hundun: Requires completing the "hard" ending by reaching 7-4 and defeating Hundun
    Cosmic Ocean: Requires reaching a specified level in Cosmic Ocean"""
    display_name = "Goal"
    option_tiamat = 0
    option_hundun = 1
    option_cosmic_ocean = 2
    default = 0


class GoalLevel(Range):
    """Which level in Cosmic Ocean are you required to clear to consider your game as beaten.
    This option can be ignored if your goal is not set to \"Cosmic Ocean\""""
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

class StartingHealth(Range):
    """How much Health should you initially start with."""
    display_name = "Starting Health"
    range_start = 1
    range_end = 8
    default = 4

class ProgressiveHealth(Range):
    """How many Starting Health upgrades are added to the multi-world"""
    display_name = "Progressive Health"
    range_start = 0
    range_end = 20
    default = 0

class StartingBombs(Range):
    """How many Bombs should you initially start with."""
    display_name = "Starting Bombs"
    range_start = 0
    range_end = 10
    default = 4

class ProgressiveBombs(Range):
    """If you set this above 0 then all bomb bags in the multi-world become Starting Bomb upgrades
	Which will instead increase how many bombs you will start a run with"""
    display_name = "Progressive Bombs"
    range_start = 0
    range_end = 20
    default = 0

class StartingRopes(Range):
    """How many Ropes should you initially start with."""
    display_name = "Starting Ropes"
    range_start = 0
    range_end = 10
    default = 4

class ProgressiveRopes(Range):
    """If you set this above 0 then all rope piles in the multi-world become Starting rope pile upgrades
	Which will instead increase how many ropes you will start a run with"""
    display_name = "Progressive Ropes"
    range_start = 0
    range_end = 20
    default = 0

class LockedItems(Set):
    """A list of items that must be received from the multi-world before being obtainable in the game
    Valid options: {sorted_item_options}"""
    display_name = "Locked Items"
    default = item_options

class ProgressiveItems(Set):
    """Add the following items as progressive in the multi-world item pool which are kept on death
    Valid options: {sorted_item_options}"""
    display_name = "Progressive Items"
    default = set()

class ProgressiveWaddler(Set):
    """Add the following items as progressive in the multi-world item pool which are added to Waddler's storage between runs
    Options set here override Progressive Items
    Valid options: {sorted_item_options}"""
    display_name = "Progressive Waddler"
    default = item_options

class DeathLinkBypassesAnkh(Toggle):
    """Sets whether deaths sent through Death Link will trigger the Ankh, or ignore it."""
    display_name = "Death Link Ankh Handling"


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
    progressive_worlds: ProgressiveWorlds
    starting_health: StartingHealth
    progressive_health: ProgressiveHealth
    starting_bombs: StartingBombs
    progressive_bombs: ProgressiveBombs
    starting_ropes: StartingRopes
    progressive_ropes: ProgressiveRopes
    locked_items: LockedItems
    progressive_items: ProgressiveItems
    progressive_waddler: ProgressiveWaddler
    # progressive_shortcuts: ProgressiveShortcuts - Not implemented yet
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
