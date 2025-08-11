from typing import List, Mapping, Any, Dict

from worlds.AutoWorld import World, WebWorld
from BaseClasses import MultiWorld, Tutorial, ItemClassification, Region

from .Items import (Spelunky2Item, filler_items, traps, filler_weights, trap_weights,
                    characters, locked_items, starter_items, quest_items, permanent_upgrades, world_unlocks)
from .Locations import Spelunky2Location, location_data_table
from .Options import Spelunky2Options
from .Regions import region_data_table
from .Rules import set_common_rules, set_sunken_city_rules, set_cosmic_ocean_rules, set_starter_upgrade_rules


class Spelunky2WebWorld(WebWorld):
    theme = "stone"

    setup_en = Tutorial(
        tutorial_name="Setup Guide",
        description="A guide to setting up Spelunky 2",
        language="English",
        file_name="setup_en.md",
        link="setup/en",
        authors=["Eszenn", "DDRKhat"]
    )
    tutorials = [setup_en]


class Spelunky2World(World):
    """Spelunky 2 is an extremely difficult roguelike platformer where your progression is gated by multiworld unlocks.
    Your ultimate goal is to complete one of the game's various paths. Your primary objective is to complete 'checks' by
    discovering new journal entries, which sends an item from the multiworld into the item pool. The rewards you receive
    can range from simple 'filler' items to world unlocks that allow you to progress, as well as key quest-chain items
    like the Udjat Eye and Hou Yi's Bow. These critical items must be received from the multiworld before you can obtain
    them in-game."""

    game = "Spelunky 2"
    web = Spelunky2WebWorld()
    options = Spelunky2Options
    options_dataclass = Spelunky2Options
    filler_count = 0
    trap_count = 0

    item_data_table = {
        **filler_items,
        **characters,
        **locked_items,
        **starter_items,
        **quest_items,
        **permanent_upgrades,
        **world_unlocks,
        **traps
    }

    item_name_to_id = {name: data.code for name, data in item_data_table.items()}
    location_name_to_id = {name: data.address for name, data in location_data_table.items()}

    def __init__(self, multiworld: MultiWorld, player: int):
        super().__init__(multiworld, player)
        self.filler_weights = filler_weights.copy()
        self.trap_weights = trap_weights.copy()

    def generate_early(self) -> None:
        pass

    def create_regions(self) -> None:
        exclude_regions = []

        if self.options.goal == 0:
            exclude_regions.append("Sunken City")

        if self.options.goal != 2:
            exclude_regions.append("Cosmic Ocean")

        for region_name in region_data_table.keys():
            if region_name in exclude_regions:
                continue

            region = Region(region_name, self.player, self.multiworld)
            self.multiworld.regions.append(region)

        for region_name, region_data in region_data_table.items():
            if region_name in exclude_regions:
                continue

            region = self.get_region(region_name)
            if region_data.exits is not None:
                for region_exit in region_data.exits:
                    if region_exit in exclude_regions:
                        continue
                    connecting_region = self.get_region(region_exit)
                    region.connect(connecting_region)

            region.add_locations({location_name: self.location_name_to_id[location_name]
                                  for location_name, location_data in location_data_table.items()
                                  if location_data.region == region_name}, Spelunky2Location)

        if self.options.goal == 1:
            goal_region = self.get_region("Sunken City")
        elif self.options.goal == 2:
            goal_region = self.get_region("Cosmic Ocean")
        else:
            goal_region = self.get_region("Neo Babylon")

        goal_location = Spelunky2Location(self.player, "Victory", None, goal_region)
        goal_location.place_locked_item(Spelunky2Item("Victory", ItemClassification.progression, None, self.player))
        self.multiworld.completion_condition[self.player] = lambda state: state.has("Victory", self.player)
        goal_region.locations.append(goal_location)

    def create_item(self, name: str) -> "Spelunky2Item":
        data = self.item_data_table[name]
        return Spelunky2Item(name, data.classification, data.code, self.player)

    def create_items(self) -> None:
        spelunky2_item_pool = []

        if self.options.progressive_worlds:
            unlock_count = 5
            if self.options.goal > 0:
                unlock_count += 1
            if self.options.goal > 1:
                unlock_count += 1
            for _ in range(unlock_count):
                spelunky2_item_pool.append(self.create_item("Progressive World Unlock"))
        else:
            individual_worlds = ["Jungle", "Volcana", "Olmec's Lair", "Tide Pool", "Temple", "Ice Caves", "Neo Babylon"]
            if self.options.goal > 0:
                individual_worlds.append("Sunken City")
            if self.options.goal > 1:
                individual_worlds.append("Cosmic Ocean")
            spelunky2_item_pool.extend([self.create_item(world) for world in individual_worlds])

        quest_item_names = list(quest_items.keys())

        if self.options.goal.value == 0:
            item_count = 1
        else:
            item_count = len(quest_item_names) - (0 if self.options.goal.value == 2 else 2)

        for i in range(item_count):
            item_name = quest_item_names[i]
            spelunky2_item_pool.append(self.create_item(item_name))

        for item_name in self.options.restricted_items.value:
            spelunky2_item_pool.append(self.create_item(item_name))

        waddler_set = set(self.options.waddler_upgrades.value)

        for base_item_name in waddler_set:
            upgrade_name = base_item_name + " Upgrade"
            if upgrade_name in starter_items:
                spelunky2_item_pool.append(self.create_item(upgrade_name))

        for base_item_name in self.options.item_upgrades.value:
            if base_item_name not in waddler_set:
                upgrade_name = base_item_name + " Upgrade"
                if upgrade_name in starter_items:
                    spelunky2_item_pool.append(self.create_item(upgrade_name))

        for _ in range(self.options.health_upgrades.value):
            spelunky2_item_pool.append(self.create_item("Health Upgrade"))
        for _ in range(self.options.bomb_upgrades.value):
            spelunky2_item_pool.append(self.create_item("Bomb Upgrade"))
        for _ in range(self.options.rope_upgrades.value):
            spelunky2_item_pool.append(self.create_item("Rope Upgrade"))

        if self.options.goal.value == 2:
            for _ in range(int(self.options.goal_level.value / 10)):
                spelunky2_item_pool.append(self.create_item("Cosmic Ocean Checkpoint"))

        for char_name in characters:
            spelunky2_item_pool.append(self.create_item(char_name))

        locations_count = len(self.multiworld.get_unfilled_locations(self.player))
        self.filler_count = locations_count - len(spelunky2_item_pool)

        self.filler_weights["Rope Pile"] = self.options.rope_pile_weight.value
        self.filler_weights["Bomb Bag"] = self.options.bomb_bag_weight.value
        self.filler_weights["Bomb Box"] = self.options.bomb_box_weight.value
        self.filler_weights["Cooked Turkey"] = self.options.cooked_turkey_weight.value
        self.filler_weights["Royal Jelly"] = self.options.royal_jelly_weight.value
        self.filler_weights["Gold Bar"] = self.options.gold_bar_weight.value
        self.filler_weights["Emerald Gem"] = self.options.emerald_gem_weight.value
        self.filler_weights["Sapphire Gem"] = self.options.sapphire_gem_weight.value
        self.filler_weights["Ruby Gem"] = self.options.ruby_gem_weight.value
        self.filler_weights["Diamond Gem"] = self.options.diamond_gem_weight.value

        if self.options.enable_traps:
            self.trap_count = int(self.filler_count * (self.options.trap_weight.value / 100))
            self.filler_count -= self.trap_count

            self.trap_weights["Poison Trap"] = self.options.poison_weight.value
            self.trap_weights["Curse Trap"] = self.options.curse_weight.value
            self.trap_weights["Ghost Trap"] = self.options.ghost_weight.value
            self.trap_weights["Stun Trap"] = self.options.stun_weight.value
            self.trap_weights["Loose Bombs Trap"] = self.options.bomb_weight.value
            self.trap_weights["Blindness Trap"] = self.options.blind_weight.value
            self.trap_weights["Punish Ball Trap"] = self.options.punish_weight.value

            for _ in range(self.trap_count):
                spelunky2_item_pool.append(self.create_trap())

        for _ in range(self.filler_count):
            spelunky2_item_pool.append(self.create_filler())

        self.multiworld.itempool.extend(spelunky2_item_pool)

    def create_filler(self) -> "Spelunky2Item":
        return self.create_item(
            self.random.choices(list(self.filler_weights.keys()), list(self.filler_weights.values()))[0])

    def create_trap(self) -> "Spelunky2Item":
        return self.create_item(
            self.random.choices(list(self.trap_weights.keys()), list(self.trap_weights.values()))[0])

    def set_rules(self) -> None:
        set_common_rules(self, self.player)

        if self.options.goal != 0:
            set_sunken_city_rules(self, self.player)

        if self.options.goal == 2:
            set_cosmic_ocean_rules(self, self.player)

        # Add the rule-setter for starter item upgrades
        set_starter_upgrade_rules(self, self.player)

    def fill_slot_data(self) -> Mapping[str, Any]:
        slot_data = {
            "goal": self.options.goal.value,
            "progressive_worlds": bool(self.options.progressive_worlds.value),
            "starting_health": self.options.starting_health.value,
            "starting_bombs": self.options.starting_bombs.value,
            "starting_ropes": self.options.starting_ropes.value,
            "health_upgrades": self.options.health_upgrades.value,
            "bomb_upgrades": self.options.bomb_upgrades.value,
            "rope_upgrades": self.options.rope_upgrades.value,
            "restricted_items": list(self.options.restricted_items.value),
            "item_upgrades": list(self.options.item_upgrades.value),
            "waddler_upgrades": list(self.options.waddler_upgrades.value),
            "death_link": self.options.death_link.value > 0,
        }

        if self.options.goal.value == 2:
            slot_data["goal_level"] = self.options.goal_level.value

        if slot_data["death_link"]:
            slot_data["bypass_ankh"] = bool(self.options.bypass_ankh.value)

        return slot_data
