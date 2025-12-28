# Spelunky 2 Archipelago
This is an [Archipelago](https://archipelago.gg/) ([Archipelago Discord server](https://discord.gg/8Z65BR2)) implementation enabling Spelunky 2 to be played in the multiworld randomizer.

# Installation Instructions
1. Download the latest version of the Spelunky 2 apworld from the github release page below
2. Double click the downloaded apworld to automatically install it to Archipelago, or manually move the file into the custom_worlds folder of your Archipelago installation
3. Download the latest version of Modlunky 2 [here](https://github.com/spelunky-fyi/modlunky2/releases/latest) and latest "Spelunky 2 Archipelago.zip" from the other release page below.
4. Open up Modlunky 2, and drag the "Spelunky 2 Archipelago.zip" onto it -- this will change it to the "Install Mods" tab and at the bottom right use the "Install selected file to existing pack"
5. Navigate to the Playlunky tab in Modlunky 2, toggle "Spelunky 2 Archipelago" and click "Play!"
  - It is HIGHLY recommended to turn on the "Use Playlunky Save" in the options menu! This mod frequently overwrites the save used by the game, and while it does make backups, errors can occur. I cannot be held liable if you lose your save file while using this mod.
6. Once on the main menu, you will need to enable the mod manually, as it requires unsafe mode to load the library used to connect to Archipelago
7. Enter your slot name, the server address, and password (if applicable) in the popup menu and click "connect" to connect to Archipelago
  - If you receive a message saying "Socket Error: invalid http status", restart your game. I don't know why this happens, but restarting the game usually fixes it
8. Once you see a message saying "Slot Connected" in the top left, you are connected to Archipelago and ready to begin playing!

For any suggestions or bug reports, please join the Archipelago Discord server (linked above), navigate to the future-game-designs forum, and find the Spelunky 2 thread. I likely won't see them anyplace else.

## Goal
You can choose one of the following goals:
- Easy: Defeat the boss in 6-4 and complete the normal ending
- Hard: Defeat the boss in 7-4 and complete the hard ending
- CO: Reach a level specified by your player options in Cosmic Ocean and complete the secret ending

## Locations / "Checks"
Locations (also known as "Checks" in Archipelago terminology) are specific points in a game that is considered something important, and it will release an associated item into the multiworld
For Spelunky2, **EVERY** Journal entry is a location (Each world, Item, Character, Enemy and Trap), for example when you "first" discover Spikes (dying in them or teleporting in them) you might send "Climbing Gloves" to another Spelunky player
Inside the options you can adjust if "hard" locations are excluded (I.E -- rare ones like Scorpions or Lavamander)

## Items
Depending on how you adjust your options (there is a lot of flexibility) below is the list of things you can expect to receive from the multiworld (from yourself, or other players):
- World Unlock: Either "Progressive" or individual worlds which are required to be allowed to travel to them; Otherwise exiting into a locked world will "wrap around" to the area you started in (you will retain all items from that run)
- One-Off Items: A bunch of items of varying benefit -- Rope piles, Bomb Bags, Bomb Boxes, Cooked Turkey, Royal Jelly or different gold amounts (Bar/Emerald/Emerald/Sapphire/Ruby/Diamond) 
- Characters: You will not be able to select to play as these characters until you receive them from the multiworld
- Item Locks: You will need to receive any "locked" items from the multiworld before you will be able to encounter them in your game
- Starting Upgrades: This can adjust how much health, how many bombs or ropes, or even upgrades (like Climbing Gloves) you begin with.
- Waddler Upgrades: These items will be automatically added to Waddler's storage each time you start a run.
- Cosmic Ocean Checkpoints: These are automatically added if your goal is set to "CO", receiving these let you start over directly in Cosmic Ocean if you die depending on how many received. This is based on what your goal world number is, 1 is addd per 10 levels. (so 1 starts you at 7-10, 2 at 7-20, etc...)
- Traps: These negative items can spice up your play experience as you/another player may accidentally cause you to become Poisoned, Cursed, spawn the Ghost and much more!

## Additional options
### Deathlink
This is an opt-in system where when a player dies, all other players will die also. In Spelunky2 there is some extra special customisation
"Amnesty" -- Set a threshold of how many deaths you suffer _before_ you send a death into the multiworld
"Bypass Ankh" -- If you receive a deathlink and this is on, the ankh will not save you
"Grace" -- Set a threshold of how many deaths you _receive_ before you get killed

The Spelunky 2 AP mod also has 2 in-game options to further fine-tune your experience which can be found in the in-game menu;
"Deathlink Explodes" -- Instead of being instantly killed, spontaneously explode when a Deathlink is sent. Might save you, if you have more than 10 health.
"Deathlink Enabled" --  Intended as a safety-measure, allows you to during live-play turn off/on Deathlink -- Helpful if you or others are dying too much.

### Starting_Wallet 
Any gold received from One-off items also increases how much gold you start each subsequent run with

### Starting_Characters
This setting lets you modify which characters you have access to from the beginning of the game; This can even make it that the default 4 starting characters are locked out and must be found in the multiworld

### Gameplay skip logic
There are multiple skips the player may be able to perform based on their skill level and practice with the game, this lets you tailor what Archipelago expects you to be able to do

### Journal Entry Required
If this is enabled you must find the item in your game locally before a Starting or Waddler upgrade you receive from the multiworld will be granted to you (as soon as you have, it will be there on each subsequent run)