from typing import Optional, List, NamedTuple


class Spelunky2RegionData(NamedTuple):
    exits: Optional[List[str]] = None


region_data_table = {
    # Primary Regions
    "Menu": Spelunky2RegionData(["Dwelling"]),  # Add connections to Olmec's Lair and Ice Caves when shortcuts are added
    "Dwelling": Spelunky2RegionData(["Jungle", "Volcana", "Any World 2"]),
    "Jungle": Spelunky2RegionData(["Olmec's Lair", "Black Market"]),
    "Volcana": Spelunky2RegionData(["Olmec's Lair", "Vlad's Castle"]),
    "Olmec's Lair": Spelunky2RegionData(["Tide Pool", "Temple"]),
    "Tide Pool": Spelunky2RegionData(["Ice Caves", "Abzu"]),
    "Temple": Spelunky2RegionData(["Ice Caves", "City of Gold"]),
    "Ice Caves": Spelunky2RegionData(["Neo Babylon", "Mothership"]),
    "Neo Babylon": Spelunky2RegionData(["Sunken City"]),
    "Sunken City": Spelunky2RegionData(["Cosmic Ocean", "Eggplant World"]),
    "Cosmic Ocean": Spelunky2RegionData(),

    # Secondary Regions
    "Any World 2": Spelunky2RegionData(),
    "Black Market": Spelunky2RegionData(),
    "Vlad's Castle": Spelunky2RegionData(),
    "Abzu": Spelunky2RegionData(),
    "City of Gold": Spelunky2RegionData(["Duat"]),
    "Duat": Spelunky2RegionData(),
    "Mothership": Spelunky2RegionData(),
    "Eggplant World": Spelunky2RegionData()
}
