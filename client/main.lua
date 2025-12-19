local QBCore = exports['qb-core']:GetCoreObject()

-- Configuration
local repairLocations = {
    vector3(100.72, 6534.53, 31.51),  -- Harmony Repair Shop
    vector3(-355.73, -1362.34, 30.83) -- New Location
}

local repairDistance = 5.0 
local repairKey = 38 -- 'E' key
local repairPrice = 1500
local repairTime = 5000 -- 5 seconds (Time for progress bar)
local blipName = "Vehicle Repair ($" .. repairPrice .. ")"

-- Create the Blips on the Map
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    for _, location in ipairs(repairLocations) do
        local blip = AddBlipForCoord(location.x, location.y, location.z)
        if DoesBlipExist(blip) then
            SetBlipSprite(blip, 402)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 1.5)
            SetBlipColour(blip, 5)
            SetBlipAsShortRange(blip, false)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(blipName)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

-- Suggestion for command
Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/keigs-repair', 'Fixes vehicle for the repairer and all other clients.')
end)

-- Main logic loop
Citizen.CreateThread(function()
    local showingText = false

    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        
        if IsPedInAnyVehicle(playerPed, false) then
            local coords = GetEntityCoords(playerPed)
            local nearAnyStation = false
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            for _, location in ipairs(repairLocations) do
                local distance = #(coords - location)

                if distance < 15.0 then
                    sleep = 0 
                    DrawMarker(2, location.x, location.y, location.z + 0.5, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 0, 100, false, true, 2, false, false, false, false)

                    if distance < repairDistance then
                        nearAnyStation = true
                        if not showingText then
                            exports['qb-core']:DrawText("Press [E] to Repair - $"..repairPrice, "left")
                            showingText = true
                        end

                        if IsControlJustReleased(0, repairKey) then
                            -- Check if vehicle actually needs repair
                            local engineHealth = GetVehicleEngineHealth(vehicle)
                            local bodyHealth = GetVehicleBodyHealth(vehicle)

                            if engineHealth >= 1000.0 and bodyHealth >= 1000.0 then
                                QBCore.Functions.Notify("This vehicle is already in perfect condition!", "error")
                            else
                                -- Hide text while repairing
                                exports['qb-core']:HideText()
                                showingText = false

                                -- PLAY SOUND IMMEDIATELY (Simultaneous with Progress Bar)
                                TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'car_repair', 0.5)

                                -- Start QBCore Progress Bar
                                QBCore.Functions.Progressbar("repairing_veh", "Repairing Vehicle...", repairTime, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                                    animName = "machinic_loop_mechandplayer",
                                    flags = 16,
                                }, {}, {}, function() -- Done
                                    -- Trigger the actual repair
                                    TriggerServerEvent('vehicleRepair:server:keigs-repair')
                                end, function() -- Cancel
                                    QBCore.Functions.Notify("Repair Cancelled", "error")
                                end)
                                
                                -- Prevent re-triggering while progress bar is active
                                Citizen.Wait(repairTime + 500)
                            end
                        end
                    end
                end
            end

            if not nearAnyStation and showingText then
                exports['qb-core']:HideText()
                showingText = false
            end
        elseif showingText then
            exports['qb-core']:HideText()
            showingText = false
        end
        Citizen.Wait(sleep)
    end
end)

-- Client side event to repair a specific vehicle (Synced via Server)
RegisterNetEvent('vehicleRepair:client:keigs-repair')
AddEventHandler('vehicleRepair:client:keigs-repair', function(playerId)
    local player = GetPlayerFromServerId(playerId)
    if player == -1 then return end 
    
    local playerPed = GetPlayerPed(player)
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if DoesEntityExist(vehicle) then
        if IsEntityOnFire(vehicle) then
            local vCoords = GetEntityCoords(vehicle)
            StopFireInRange(vCoords, 20.0)
            StopEntityFire(vehicle)
        end

        SetVehicleUndriveable(vehicle, false)
        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleEngineHealth(1000.0)
        SetVehicleBodyHealth(1000.0)
        SetVehicleDirtLevel(vehicle, 0.0)
        SetVehicleFuelLevel(vehicle, 100.0)

        if playerId == GetPlayerServerId(PlayerId()) then
            QBCore.Functions.Notify("Vehicle Repaired!", "success")
        end
    end
end)