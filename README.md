# Spelunky 2 Archipelago Mod
This mod allows you to connect to Archipelago in order to play a multiworld randomizer. Every journal entry is a location that you can check, and the item you send out could be anything from anyone's game, including your own. For more information about Archipelago, visit their [website](https://archipelago.gg/) or join their [Discord server](https://discord.gg/8Z65BR2).

## Features
- Multiple game options to customize your experience, such as:
    - The goal of the run
    - How worlds should be unlocked
    - Starting Health, Bombs, and Ropes
    - A variety of disruptive traps
    - Death link, where if someone dies in their game, you die as well. The reverse is also true
- Worlds must be unlocked
    - By default, you will have access to the Dwelling. To progress any further than that, you will need to find or be sent world unlocks from other people in the multiworld
- Chain items must be unlocked
    - In order to use chain items, you must first find or be sent that particular item from other people in the multiworld
- Characters must be unlocked
    - Characters will not be unlocked upon freeing them from their coffins. You must either find or be sent them from other people in the multiworld
- Seed Specific Save Files
    - Checked locations and received items are unique to the Archipelago seed, allowing you to have multiple Archipelago games running at once

## Goals
- Easy: Defeat Tiamat in 6-4 to complete the normal ending
- Hard: Defeat Hundun in 7-4 to complete the hard ending
- CO: Reach a level specified by your player options in Cosmic Ocean to complete the secret ending

## Locations
- Every Journal Entry is a location: Worlds, Items, Characters, Enemies, Traps
- There's an option to exclude hard locations such as Lavamander and True Crown. You can also use the `exclude_locations` yaml field for this purpose.
- Journal entries are logically located in an area that must be reachable. For example Plasma Cannon Journal Entry logically requires access to the Mothership; Paste Journal Entry is in Jungle; Spike Shoes Journal Entry is in Ice Caves; etc. Items with no guaranteed spawn that can be found in shops, such as Powerpack, are logically located in the Black Market. For full details, see the [source code](https://github.com/DDR-Khat/Spelunky2-Archipelago/blob/main/.spelunky2/Locations.py).

## Items
- World Unlock: You start with only Dwelling accessible and further worlds must be unlocked as AP items. Entering an area must be done from the correct doorway. A doorway to a locked world loops back to 1-1 or whichever other level number you started via a shortcut.
- Rope Pile, Bomb Bag, Bomb Box, Cooked Turkey, Royal Jelly: a benefit for the current run only.
- Gold Bar, Emerald, Sapphire, Ruby, Diamond: Some gold (scales with the world you're in) for this run only. There's an option to grant gold received through AP at the start of every run instead.
- Starting Health/Bomb/Rope Upgrade: +1 Health/Bomb/Rope at the start of every run for each stack you have.
- Unlock Items: Items which normally exist in Vanilla are locked until an AP item is found to unlock them. Almost every item can be locked according to your yaml: Ankh, Arrow of Light, Camera, Cape, etc.
- Permanent Items: Start every run with an item once the AP item "Upgrade" has been found. There's an option to additionally require the Journal Entry for the item before you get it. Most items can be granted at the start of a run: Paste, Jetpack, Spike Shoes, etc.
- Permanent Waddler Inventory: Like Permanent Items, but Waddler starts every run with the item instead of you. A larger set of items is allowed at Waddler including quest items.
- Cosmic Ocean Checkpoint: Each stack you have lets you start further into Cosmic Ocean if you die there. 1 stack will let you start at 7-10, 2 stacks at 7-20, and so on.

## Traps
- Poison Trap: Poisons the player
- Curse Trap: Curses the player
- Ghost Trap: Immediately summons the ghost on the current level
- Stun Trap: Stuns the player for 1 second
- Loose Bombs Trap: Spawns 1 lit bomb at the players feet every second for 5 seconds
- Blindness Trap: Triggers the "I can't see a thing!" level feeling for the current level
- Punish Ball Trap: Gives the player a ball and chain for 3 levels

# Installation Instructions
1. Download the latest version of the Spelunky 2 apworld from the github release page below
2. Double click the downloaded apworld to automatically install it to Archipelago, or manually move the file into the custom_worlds folder of your Archipelago installation
3. Download the latest version of Modlunky 2 [here](https://github.com/spelunky-fyi/modlunky2/releases/latest) and latest "Spelunky 2 Archipelago.zip" from the other release page below.
4. Open up Modlunky 2, and drag the "Spelunky 2 Archipelago.zip" onto it -- this will change it to the "Install Mods" tab and at the bottom right use the "Install selected file to existing pack"
5. Navigate to the Playlunky tab in Modlunky 2, toggle "Spelunky 2 Archipelago" and click "Play!"
    - It is HIGHLY recommended to turn on the "Use Playlunky Save" in the options menu! This mod frequently overwrites the save used by the game, and while it does make backups, errors can occur. I cannot be held liable if you lose your save file while using this mod.
6. Once on the main menu, you will need to enable the mod manually, as it requires unsafe mode to load the library used to connect to Archipelago
7. Enter your slot name, the server address, and password (if applicable) in the popup menu and click connect to connect to Archipelago
    - If you receive a message saying "Socket Error: invalid http status", restart your game. I don't know why this happens, but restarting the game usually fixes it
8. Once you see a message saying "Slot Connected" in the top left, you are connected to Archipelago and ready to begin playing!

For any suggestions or bug reports, please join the Archipelago Discord server (linked above), navigate to the future-game-designs forum, and find the Spelunky 2 thread. I likely won't see them anyplace else.
