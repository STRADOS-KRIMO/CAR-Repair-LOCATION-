🚗 QBCore Multi-Location Vehicle Repair

<p align="center">
<img src="https://www.google.com/search?q=https://img.shields.io/badge/Framework-QBCore-blue%3Fstyle%3Dfor-the-badge" alt="QBCore">
<img src="https://www.google.com/search?q=https://img.shields.io/badge/Category-Script-orange%3Fstyle%3Dfor-the-badge" alt="Script">
<img src="https://www.google.com/search?q=https://img.shields.io/badge/Status-Patched-success%3Fstyle%3Dfor-the-badge" alt="Status">
</p>

📺 Preview

Check out the script in action:

https://www.google.com/search?q=https://github.com/user-attachments/assets/533ab5ec-7d44-4769-883b-70447b90c12b

(Note: If the video above doesn't load, you can view it directly here)

📜 Credits & Disclaimer

This script is not my original work.

👑 Original Code: Huge thanks to -Keigal- for providing the core logic.

🛠️ This Version: A specific patch/modification created with Gemini to include multi-location support, sound synchronization, and vehicle condition checks.

🛠 Configuration Guide

All primary settings are located at the top of the cl_repair.lua file.

1️⃣ How to Change or Add Locations

The script uses a table called repairLocations. Each entry is a vector3 coordinate (X, Y, Z).

To change an existing location: Replace the numbers inside the vector3().

To add a new location: Add a comma after the last entry and insert a new vector3.

local repairLocations = {
    vector3(100.72, 6534.53, 31.51),  -- Location 1
    vector3(-355.73, -1362.34, 30.83), -- Location 2
    vector3(123.45, 678.90, 12.34)    -- New Location Example
}


2️⃣ How to Change the Price

Locate the repairPrice variable. Changing this value updates both the cost logic and the map blip labels automatically.

local repairPrice = 1500 -- Change this number to your desired cost


3️⃣ How to Change the Blip Icon

The map icon is controlled by the SetBlipSprite function.

Find the line: SetBlipSprite(blip, 402)

Replace 402 with a different ID from the GTAV Blip List.

402: Wrench (Current)

446: Alternate Wrench

100: Gold Mine

4️⃣ How to Change the Sound

The script plays car_repair.ogg simultaneously with the progress bar.

Ensure your sound file is in interact-sound/client/html/sounds/car_repair.ogg.

To use a different file name, change this line in cl_repair.lua:

TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'your_new_file_name', 0.5)


📋 Requirements

qb-core

interact-sound (For the repair audio)

🚀 Installation

Drag and drop the folder into your resources directory.

Ensure your sound file (car_repair.ogg) is placed in the interact-sound resource.

Add ensure [resource_name] to your server.cfg.

<p align="center"><i>Maintained as a community patch.</i></p>
