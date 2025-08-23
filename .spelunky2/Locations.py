from typing import NamedTuple, Optional
from BaseClasses import Location
from .enums import Spelunky2Goal

#####
# HUGE thanks to Cloiss for a lot of the logic changes in here to make more sense
#####

class Spelunky2Location(Location):
    game = "Spelunky 2"


class Spelunky2LocationData(NamedTuple):
    address: int
    region: str
    goal: Optional[int] = Spelunky2Goal.EASY


place_entries = {
    "Dwelling Journal Entry": Spelunky2LocationData(1, "Dwelling"),
    "Jungle Journal Entry": Spelunky2LocationData(2, "Jungle"),
    "Volcana Journal Entry": Spelunky2LocationData(3, "Volcana"),
    "Olmec's Lair Journal Entry": Spelunky2LocationData(4, "Olmec's Lair"),
    "Tide Pool Journal Entry": Spelunky2LocationData(5, "Tide Pool"),
    "Abzu Journal Entry": Spelunky2LocationData(6, "Abzu"),
    "Temple of Anubis Journal Entry": Spelunky2LocationData(7, "Temple"),
    "The City of Gold Journal Entry": Spelunky2LocationData(8, "City of Gold"),
    "Duat Journal Entry": Spelunky2LocationData(9, "Duat"),
    "Ice Caves Journal Entry": Spelunky2LocationData(10, "Ice Caves"),
    "Neo Babylon Journal Entry": Spelunky2LocationData(11, "Neo Babylon"),
    "Tiamat's Throne Journal Entry": Spelunky2LocationData(12, "Neo Babylon"),
    "Sunken City Journal Entry": Spelunky2LocationData(13, "Sunken City", Spelunky2Goal.HARD),
    "Eggplant World Journal Entry": Spelunky2LocationData(14, "Eggplant World", Spelunky2Goal.HARD),
    "Hundun's Hideaway Journal Entry": Spelunky2LocationData(15, "Sunken City", Spelunky2Goal.HARD),
    "Cosmic Ocean Journal Entry": Spelunky2LocationData(16, "Cosmic Ocean", Spelunky2Goal.CO)
}

people_entries = {
    # Excluding this until I figure out how they'll be implemented
    # "Ana Spelunky Journal Entry": Spelunky2LocationData(17, "Menu"),
    # "Margaret Tunnel Journal Entry": Spelunky2LocationData(18, "Menu"),
    # "Colin Northward Journal Entry": Spelunky2LocationData(19, "Menu"),
    # "Roffy D. Sloth Journal Entry": Spelunky2LocationData(20, "Menu"),
    "Alto Singh Journal Entry": Spelunky2LocationData(21, "Dwelling"),
    "Liz Mutton Journal Entry": Spelunky2LocationData(22, "Jungle"),
    "Nekka the Eagle Journal Entry": Spelunky2LocationData(23, "Black Market"),  # Reduced spawn rate until world 4 is entered
    "LISE Project Journal Entry": Spelunky2LocationData(24, "Volcana"),  # Reduced spawn rate until world 4 is entered
    "Coco Von Diamonds Journal Entry": Spelunky2LocationData(25, "Vlad's Castle"),
    "Manfred Tunnel Journal Entry": Spelunky2LocationData(26, "Olmec's Lair"),
    "Little Jay Journal Entry": Spelunky2LocationData(27, "Tide Pool"),  # Reduced spawn rate until a Tiamat win
    "Tina Flan Journal Entry": Spelunky2LocationData(28, "Abzu"),  # Reduced spawn rate until a Tiamat win
    "Valerie Crump Journal Entry": Spelunky2LocationData(29, "Temple"),
    "Au Journal Entry": Spelunky2LocationData(30, "City of Gold"),
    "Demi Von Diamonds Journal Entry": Spelunky2LocationData(31, "Ice Caves"),
    "Pilot Journal Entry": Spelunky2LocationData(32, "Mothership"),
    "Princess Airyn Journal Entry": Spelunky2LocationData(33, "Neo Babylon"),  # Reduced spawn rate until a Tiamat win without shortcuts
    "Dirk Yamaoka Journal Entry": Spelunky2LocationData(34, "Sunken City", Spelunky2Goal.HARD),
    "Guy Spelunky Journal Entry": Spelunky2LocationData(35, "Neo Babylon"),
    "Classic Guy Journal Entry": Spelunky2LocationData(36, "Sunken City", Spelunky2Goal.HARD),
    "Terra Tunnel Journal Entry": Spelunky2LocationData(37, "Any World 2"),  # Can be in either Jungle or Volcana
    "Hired Hand Journal Entry": Spelunky2LocationData(38, "Dwelling"),  # From Alto's coffin or a shop
    "Eggplant Child Journal Entry": Spelunky2LocationData(39, "Ice Caves"),
    "Shopkeeper Journal Entry": Spelunky2LocationData(40, "Dwelling"),
    "Tun Journal Entry": Spelunky2LocationData(41, "Any World 2"),  # Moon challenge - Can be met earlier in Dwelling
    "Yang Journal Entry": Spelunky2LocationData(42, "Dwelling"),  # Can also be met in Black Market or Tide Pool 4-3
    "Madame Tusk Journal Entry": Spelunky2LocationData(43, "Tide Pool"),  # Can also be met in Neo Babylon
    "Tusk's Bodyguard Journal Entry": Spelunky2LocationData(44, "Tide Pool"),  # Can also be met in Neo Babylon
    "Waddler Journal Entry": Spelunky2LocationData(45, "Olmec's Lair"),  # Can also be met in Ice Caves
    "Caveman Shopkeeper Journal Entry": Spelunky2LocationData(46, "Tide Pool"),  # Tide Pool 4-2 is the most consistent place to find Caveman Shopkeeper
    "Ghist Shopkeeper Journal Entry": Spelunky2LocationData(47, "Dwelling"),  # Can also be met in Eggplant World
    "Van Horsing Journal Entry": Spelunky2LocationData(48, "Volcana"),
    "Parsley Journal Entry": Spelunky2LocationData(49, "Jungle"),
    "Parsnip Journal Entry": Spelunky2LocationData(50, "Jungle"),
    "Parmesan Journal Entry": Spelunky2LocationData(51, "Jungle"),
    "Sparrow Journal Entry": Spelunky2LocationData(52, "Any World 2"),  # Can be in either Jungle or Volcana
    "Beg Journal Entry": Spelunky2LocationData(53, "Any World 2"),  # Depends on how many altars you encounter - Logic assumes you find 2 altars within the first 2 worlds
    "Eggplant King Journal Entry": Spelunky2LocationData(54, "Eggplant World", Spelunky2Goal.HARD),
}

bestiary_entries = {
    # Dwelling
    "Snake Journal Entry": Spelunky2LocationData(55, "Dwelling"),
    "Spider Journal Entry": Spelunky2LocationData(56, "Dwelling"),
    "Bat Journal Entry": Spelunky2LocationData(57, "Dwelling"),
    "Caveman Journal Entry": Spelunky2LocationData(58, "Dwelling"),
    "Skeleton Journal Entry": Spelunky2LocationData(59, "Dwelling"),
    "Horned Lizard Journal Entry": Spelunky2LocationData(60, "Dwelling"),
    "Cave Mole Journal Entry": Spelunky2LocationData(61, "Dwelling"),
    "Quillback Journal Entry": Spelunky2LocationData(62, "Dwelling"),

    # Jungle
    "Mantrap Journal Entry": Spelunky2LocationData(63, "Jungle"),
    "Tiki Man Journal Entry": Spelunky2LocationData(64, "Jungle"),
    "Witch Doctor Journal Entry": Spelunky2LocationData(65, "Jungle"),  # Also in Duat coffins and Sun Challenge
    "Mosquito Journal Entry": Spelunky2LocationData(66, "Jungle"),
    "Monkey Journal Entry": Spelunky2LocationData(67, "Jungle"),
    "Hang Spider Journal Entry": Spelunky2LocationData(68, "Jungle"),
    "Giant Spider Journal Entry": Spelunky2LocationData(69, "Jungle"),

    # Volcana
    "Magmar Journal Entry": Spelunky2LocationData(70, "Volcana"),
    "Robot Journal Entry": Spelunky2LocationData(71, "Volcana"),
    "Fire Bug Journal Entry": Spelunky2LocationData(72, "Volcana"),
    "Imp Journal Entry": Spelunky2LocationData(73, "Volcana"),
    "Lavamander Journal Entry": Spelunky2LocationData(74, "Volcana"),  # TODO: Can be very hard. Limit it somehow.
    "Vampire Journal Entry": Spelunky2LocationData(75, "Vlad's Castle"),  # Or earlier by altar.
    "Vlad Journal Entry": Spelunky2LocationData(76, "Vlad's Castle"),

    # Olmec's Lair
    "Olmec Journal Entry": Spelunky2LocationData(77, "Olmec's Lair"),

    # Tide Pool
    "Jiangshi Journal Entry": Spelunky2LocationData(78, "Tide Pool"),  # Also from destroying altars
    "Jiangshi Assassin Journal Entry": Spelunky2LocationData(79, "Tide Pool"),  # Also from destroying altars
    "Flying Fish Journal Entry": Spelunky2LocationData(80, "Tide Pool"),
    "Octopy Journal Entry": Spelunky2LocationData(81, "Tide Pool"),  # Also from Tiamat
    "Hermit Crab Journal Entry": Spelunky2LocationData(82, "Tide Pool"),  # Also from Tiamat
    "Pangxie Journal Entry": Spelunky2LocationData(83, "Tide Pool"),
    "Great Humphead Journal Entry": Spelunky2LocationData(84, "Tide Pool"),
    "Kingu Journal Entry": Spelunky2LocationData(85, "Abzu"),

    # Temple
    "Crocman Journal Entry": Spelunky2LocationData(86, "Temple"),
    "Cobra Journal Entry": Spelunky2LocationData(87, "Temple"),  # Also found in pots
    "Mummy Journal Entry": Spelunky2LocationData(88, "Temple"),
    "Sorceress Journal Entry": Spelunky2LocationData(89, "Temple"),  # Also in Duat coffins and Sun Challenge
    "Cat Mummy Journal Entry": Spelunky2LocationData(90, "Temple"),
    "Necromancer Journal Entry": Spelunky2LocationData(91, "Temple"),  # Also from Sun Challenge
    "Anubis Journal Entry": Spelunky2LocationData(92, "Temple"),
    "Ammit Journal Entry": Spelunky2LocationData(93, "Duat"),
    "Apep Journal Entry": Spelunky2LocationData(94, "Duat"),
    "Anubis II Journal Entry": Spelunky2LocationData(95, "Duat"),
    "Osiris Journal Entry": Spelunky2LocationData(96, "Duat"),

    # Ice Caves
    "UFO Journal Entry": Spelunky2LocationData(97, "Ice Caves"),
    "Alien Journal Entry": Spelunky2LocationData(98, "Ice Caves"),
    "Yeti Journal Entry": Spelunky2LocationData(99, "Ice Caves"),
    "Yeti King Journal Entry": Spelunky2LocationData(100, "Ice Caves"),
    "Yeti Queen Journal Entry": Spelunky2LocationData(101, "Ice Caves"),
    "Lamahu Journal Entry": Spelunky2LocationData(102, "Mothership"),
    "Proto Shopkeeper Journal Entry": Spelunky2LocationData(103, "Mothership"),

    # Neo Babylon
    "Olmite Journal Entry": Spelunky2LocationData(104, "Neo Babylon"),
    "Lamassu Journal Entry": Spelunky2LocationData(105, "Neo Babylon"),
    "Tiamat Journal Entry": Spelunky2LocationData(106, "Neo Babylon"),

    # Sunken City
    "Tadpole Journal Entry": Spelunky2LocationData(107, "Sunken City", Spelunky2Goal.HARD),
    "Frog Journal Entry": Spelunky2LocationData(108, "Sunken City", Spelunky2Goal.HARD),
    "Fire Frog Journal Entry": Spelunky2LocationData(109, "Sunken City", Spelunky2Goal.HARD),
    "Goliath Frog Journal Entry": Spelunky2LocationData(110, "Sunken City", Spelunky2Goal.HARD),
    "Grub Journal Entry": Spelunky2LocationData(111, "Sunken City", Spelunky2Goal.HARD),
    "Giant Fly Journal Entry": Spelunky2LocationData(112, "Sunken City", Spelunky2Goal.HARD),
    "Hundun Journal Entry": Spelunky2LocationData(113, "Sunken City", Spelunky2Goal.HARD),
    "Eggplant Minister Journal Entry": Spelunky2LocationData(114, "Eggplant World", Spelunky2Goal.HARD),
    "Eggplup Journal Entry": Spelunky2LocationData(115, "Eggplant World", Spelunky2Goal.HARD),

    # Cosmic Ocean
    "Celestial Jelly Journal Entry": Spelunky2LocationData(116, "Cosmic Ocean", Spelunky2Goal.CO),

    # Miscellaneous
    "Scorpion Journal Entry": Spelunky2LocationData(117, "Any World 2"),  # Moon Challenge. Typically farmed from Tiamat in All Journal Entires speedruns
    "Bee Journal Entry": Spelunky2LocationData(118, "Jungle"),  # Also from destroying altars or Temple
    "Queen Bee Journal Entry": Spelunky2LocationData(119, "Jungle"),  # Also from Temple
    "Scarab Journal Entry": Spelunky2LocationData(120, "Dwelling"),
    "Golden Monkey Journal Entry": Spelunky2LocationData(121, "Menu"),
    "Leprechaun Journal Entry": Spelunky2LocationData(122, "Menu"),  # Can be in either Jungle or Volcana
    "Monty Journal Entry": Spelunky2LocationData(123, "Dwelling"),
    "Percy Journal Entry": Spelunky2LocationData(124, "Dwelling"),
    "Poochi Journal Entry": Spelunky2LocationData(125, "Dwelling"),
    "Ghist Journal Entry": Spelunky2LocationData(126, "Tide Pool"),  # Can be found sooner by killing a Hired Hand or finding a Dead are Restless level feeling in World 2
    "Ghost Journal Entry": Spelunky2LocationData(127, "Dwelling"),
    "Cave Turkey Journal Entry": Spelunky2LocationData(128, "Dwelling"),
    "Rock Dog Journal Entry": Spelunky2LocationData(129, "Volcana"),  # Can be found earlier in Pet Shops
    "Axolotl Journal Entry": Spelunky2LocationData(130, "Tide Pool"),  # Can be found earlier in Pet Shops
    "Qilin Journal Entry": Spelunky2LocationData(131, "Neo Babylon"),
    "Mech Rider Journal Entry": Spelunky2LocationData(132, "Ice Caves")  # TODO: Rare; Limit to non-important or force it
}

item_entries = {
    # For the most part, regions will be where the earliest guaranteed drop is, i.e. Jetpack is in Temple because Anubis II always drops one
    # The exception for this are things that are very common, like bomb bags
    # Items that can appear in shops or crates must be guesstimated to Dwelling, due to lock-out rules.
    "Rope Pile Journal Entry": Spelunky2LocationData(133, "Dwelling"),
    "Bomb Bag Journal Entry": Spelunky2LocationData(134, "Dwelling"),
    "Bomb Box Journal Entry": Spelunky2LocationData(135, "Dwelling"),
    "Paste Journal Entry": Spelunky2LocationData(136, "Jungle"),  # From Giant Spiders
    "Spectacles Journal Entry": Spelunky2LocationData(137, "Black Market"),
    "Climbing Gloves Journal Entry": Spelunky2LocationData(138, "Black Market"),
    "Pitcher's Mitt Journal Entry": Spelunky2LocationData(139, "Black Market"),
    "Spring Shoes Journal Entry": Spelunky2LocationData(140, "Black Market"),
    "Spike Shoes Journal Entry": Spelunky2LocationData(141, "Ice Caves"),  # Guaranteed drop from Yeti Queen
    "Compass Journal Entry": Spelunky2LocationData(142, "Ice Caves"),  # Guaranteed drop from Yeti King
    "Alien Compass Journal Entry": Spelunky2LocationData(143, "Vlad's Castle"),  # See 'can_obtain_alien_compass' for handling the rest of this quest
    "Parachute Journal Entry": Spelunky2LocationData(144, "Olmec's Lair"),  # Guaranteed in the Olmec's back layer
    "Udjat Eye Journal Entry": Spelunky2LocationData(145, "Dwelling"),
    "Kapala Journal Entry": Spelunky2LocationData(146, "Neo Babylon"),  # Guaranteed altar with enough sacrifices on 6-3 (also found at 75% of 1-4 Ghist shops)
    "Hedjet Journal Entry": Spelunky2LocationData(147, "Black Market"),
    "Crown Journal Entry": Spelunky2LocationData(148, "Vlad's Castle"),
    "Eggplant Crown Journal Entry": Spelunky2LocationData(149, "Eggplant World", Spelunky2Goal.HARD),
    "True Crown Journal Entry": Spelunky2LocationData(150, "Ice Caves"),  # Likely to find enough altars by this point. Note Beg cannot enter Tusk's Palace.
    "Ankh Journal Entry": Spelunky2LocationData(151, "Olmec's Lair"),
    "Tablet of Destiny Journal Entry": Spelunky2LocationData(152, "Menu"),  # Can be dropped from either Kingu or Osiris, so can't tie it to either Tide Pool or Temple
    "Skeleton Key Journal Entry": Spelunky2LocationData(153, "Any World 2"),  # Dropped from Sparrow
    "Royal Jelly Journal Entry": Spelunky2LocationData(154, "Jungle"),  # Also from Kali or from Queen Bee in Temple
    "Cape Journal Entry": Spelunky2LocationData(155, "Vlad's Castle"),  # From Vampires (which are also from altars)
    "Vlad's Cape Journal Entry": Spelunky2LocationData(156, "Vlad's Castle"),
    "Jetpack Journal Entry": Spelunky2LocationData(157, "Duat"),  # Guaranteed drop from Anubis II, also in 18.75% of Ghist Shops
    "Telepack Journal Entry": Spelunky2LocationData(158, "Black Market"),  # Also from Beg, also in 18.75% of Ghist Shops
    "Hoverpack Journal Entry": Spelunky2LocationData(159, "Black Market"),  # also in 18.75% of Ghist Shops
    "Powerpack Journal Entry": Spelunky2LocationData(160, "Black Market"),  # also in 18.75% of Ghist Shops
    "Webgun Journal Entry": Spelunky2LocationData(161, "Black Market"),  # also in 18.75% of Ghist Shops
    "Shotgun Journal Entry": Spelunky2LocationData(162, "Dwelling"),  # Drops from Shopkeeper, also in 18.75% of Ghist Shops
    "Freeze Ray Journal Entry": Spelunky2LocationData(163, "Black Market"),  # also in 18.75% of Ghist Shops
    "Clone Gun Journal Entry": Spelunky2LocationData(164, "Tide Pool"),  # also in 75% of Eggplant World Ghist Shops
    "Crossbow Journal Entry": Spelunky2LocationData(165, "Dwelling"),  # Drops from Yang
    "Camera Journal Entry": Spelunky2LocationData(166, "Tide Pool"),  # Guaranteed drop from Giant Humphead
    "Teleporter Journal Entry": Spelunky2LocationData(167, "Black Market"),
    "Mattock Journal Entry": Spelunky2LocationData(168, "Any World 2"),  # From Moon Challenge
    "Boomerang Journal Entry": Spelunky2LocationData(169, "Jungle"),  # From Tiki Men
    "Machete Journal Entry": Spelunky2LocationData(170, "Black Market"),
    "Excalibur Journal Entry": Spelunky2LocationData(171, "Tide Pool"),
    "Broken Sword Journal Entry": Spelunky2LocationData(172, "Tide Pool"),  # Clone Gun always available on the same level
    "Plasma Cannon Journal Entry": Spelunky2LocationData(173, "Mothership"),  # also in 18.75% of Ghist Shops and very rarely in Presents or Crates
    "Scepter Journal Entry": Spelunky2LocationData(174, "Temple"),
    "Hou Yi's Bow Journal Entry": Spelunky2LocationData(175, "Any World 2"),  # Same deal as the Tablet, but with Jungle and Volcana
    "Arrow of Light Journal Entry": Spelunky2LocationData(176, "Sunken City", Spelunky2Goal.HARD),
    "Wooden Shield Journal Entry": Spelunky2LocationData(177, "Jungle"),  # From Tiki Men
    "Metal Shield Journal Entry": Spelunky2LocationData(178, "Tide Pool"),  # Uncommon drop from Pangxie
    "Idol Journal Entry": Spelunky2LocationData(179, "Dwelling"),
    "The Tusk Idol Journal Entry": Spelunky2LocationData(180, "Tide Pool"),
    "Curse Pot Journal Entry": Spelunky2LocationData(181, "Dwelling"),
    "Ushabti Journal Entry": Spelunky2LocationData(182, "Neo Babylon"),
    "Eggplant Journal Entry": Spelunky2LocationData(183, "Tide Pool"),  # Most consistent from 4-2 due to guaranteed altar
    "Cooked Turkey Journal Entry": Spelunky2LocationData(184, "Dwelling"),
    "Elixir Journal Entry": Spelunky2LocationData(185, "Temple"),
    "Four-Leaf Clover Journal Entry": Spelunky2LocationData(186, "Any World 2"),  # From Moon Challenge
}

trap_entries = {
    "Spikes Journal Entry": Spelunky2LocationData(187, "Dwelling"),
    "Arrow Trap Journal Entry": Spelunky2LocationData(188, "Dwelling"),
    "Totem Trap Journal Entry": Spelunky2LocationData(189, "Dwelling"),
    "Log Trap Journal Entry": Spelunky2LocationData(190, "Dwelling"),
    "Spear Trap Journal Entry": Spelunky2LocationData(191, "Jungle"),
    "Thorny Vine Journal Entry": Spelunky2LocationData(192, "Jungle"),
    "Bear Trap Journal Entry": Spelunky2LocationData(193, "Jungle"),  # Also in Tide Pool and rarely from Presents
    "Powder Box Journal Entry": Spelunky2LocationData(194, "Volcana"),  # Also in Tide Pool (from Hermit Crabs)
    "Falling Platform Journal Entry": Spelunky2LocationData(195, "Volcana"),  # Also in Ice Caves
    "Spikeball Journal Entry": Spelunky2LocationData(196, "Volcana"),
    "Lion Trap Journal Entry": Spelunky2LocationData(197, "Tide Pool"),
    "Giant Clam Journal Entry": Spelunky2LocationData(198, "Tide Pool"),
    "Sliding Wall Journal Entry": Spelunky2LocationData(199, "Tide Pool"),  # Also in Vlad's Castle and City of Gold
    "Crush Trap Journal Entry": Spelunky2LocationData(200, "Temple"),
    "Giant Crush Trap Journal Entry": Spelunky2LocationData(201, "Temple"),
    "Boulder Journal Entry": Spelunky2LocationData(202, "Ice Caves"),
    "Spring Trap Journal Entry": Spelunky2LocationData(203, "Ice Caves"),
    "Landmine Journal Entry": Spelunky2LocationData(204, "Ice Caves"),
    "Laser Trap Journal Entry": Spelunky2LocationData(205, "Neo Babylon"),
    "Spark Trap Journal Entry": Spelunky2LocationData(206, "Neo Babylon"),
    "Frog Trap Journal Entry": Spelunky2LocationData(207, "Sunken City", Spelunky2Goal.HARD),
    "Sticky Trap Journal Entry": Spelunky2LocationData(208, "Sunken City", Spelunky2Goal.HARD),
    "Bone Drop Journal Entry": Spelunky2LocationData(209, "Sunken City", Spelunky2Goal.HARD),
    "Egg Sac Journal Entry": Spelunky2LocationData(210, "Sunken City", Spelunky2Goal.HARD),
}

location_data_table = {

    **place_entries,
    **people_entries,
    **bestiary_entries,
    **item_entries,
    **trap_entries,
}


