QBCore Multi-Location Vehicle Repair Script

A simple, optimized vehicle repair script for QBCore that supports multiple repair locations, synchronized vehicle repairs, progress bars, and custom repair sounds.

📜 Credits & Disclaimer

⚠ This script is not my original work.

Huge thanks to -Keigal- for the original code.

This version is a patch/modification created with the assistance of Gemini.

Modifications include:

Multi-location support

Sound synchronization

Minor performance fixes

All credit for the base script goes to the original author.

🛠 Configuration Guide

All primary settings are located at the top of main.lua inside the client folder.

📍 How to Change or Add Locations

The script uses a table called repairLocations.
Each entry is a vector3(x, y, z) coordinate.

Example:
local repairLocations = {
    vector3(100.72, 6534.53, 31.51), -- Location 1
    vector3(-355.73, -1362.34, 30.83), -- Location 2
    vector3(123.45, 678.90, 12.34) -- New Location Example
}


To edit a location

Replace the numbers inside an existing vector3().

To add a new location

Add a comma after the last entry

Insert a new vector3() line

💰 How to Change the Repair Price

Locate the repairPrice variable.

local repairPrice = 1500 -- Change this to your desired cost


✔ This automatically updates:

Payment logic

Map blip labels

🗺 How to Change the Blip Icon

The map icon is controlled by SetBlipSprite.

Find this line:

SetBlipSprite(blip, 402)


Replace 402 with a different GTAV Blip ID.

Common examples:

402 – Wrench (Default)

446 – Alternate Wrench

100 – Gold Mine

🔊 How to Change the Repair Sound

The script plays a sound synchronized with the progress bar.

Default sound file location:

interact-sound/client/html/sounds/car_repair.ogg


To use a different sound file, change this line in main.lua:

TriggerServerEvent(
    'InteractSound_SV:PlayWithinDistance',
    10.0,
    'your_new_file_name',
    0.5
)


⚠ Do not include .ogg in the event call.

📋 Requirements

qb-core

interact-sound (for repair audio)

🚀 Installation

Drag and drop the resource folder into your resources directory.

Ensure car_repair.ogg is placed inside:

interact-sound/client/html/sounds/


Add the resource to your server.cfg:

ensure your_resource_name


Restart your server.

✅ Features

Multiple repair locations

Synced repairs for nearby players

Progress bar support

Customizable pricing

Custom repair sounds

Optimized performance
