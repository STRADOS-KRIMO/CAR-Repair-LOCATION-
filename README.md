QBCore Multi-Location Vehicle Repair Script

A simple, optimized repair script for QBCore that supports multiple locations, synchronized vehicle fixes, progress bars, and custom sounds.


📜 Credits & Disclaimer

This script is not my original work.

Huge thanks to -Keigal- for providing the original code.

This version is simply a patch/modification created with the assistance of Gemini to add multi-location support, sound synchronization, and performance fixes.


🛠 Configuration Guide

All primary settings are located at the top of the main.lua file in clinet folder.


1. How to Change or Add Locations

The script uses a table called repairLocations. Each entry is a vector3 coordinate (X, Y, Z).

To change an existing location: Replace the numbers inside the vector3().

To add a new location: Add a comma after the last entry and insert a new vector3.


local repairLocations = {
    vector3(100.72, 6534.53, 31.51),  -- Location 1
    vector3(-355.73, -1362.34, 30.83), -- Location 2
    vector3(123.45, 678.90, 12.34)    -- New Location Example
}



2. How to Change the Price

Locate the repairPrice variable. Changing this value updates both the cost logic and the map blip labels automatically.

local repairPrice = 1500 -- Change this number to your desired cost



3. How to Change the Blip Icon

The map icon is controlled by the SetBlipSprite function.

Find the line: SetBlipSprite(blip, 402)

Replace 402 with a different ID from the GTAV Blip List.

402: Wrench (Current)

446: Alternate Wrench

100: Gold Mine



4. How to Change the Sound

The script plays car_repair.ogg simultaneously with the progress bar.

Ensure your sound file is in interact-sound/client/html/sounds/car_repair.ogg.

To use a different file name, change this line in main.lua:

TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'your_new_file_name', 0.5)


📋 Requirements

qb-core

interact-sound (For the repair audio)

🚀 Installation

Drag and drop the folder into your resources directory.

Ensure your sound file (car_repair.ogg) is placed in the interact-sound resource.

Add ensure [resource_name] to your server.cfg.
