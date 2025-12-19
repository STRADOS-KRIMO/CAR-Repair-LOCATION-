local QBCore = exports['qb-core']:GetCoreObject()
local repairPrice = 1500
local mechanicJobName = "mechanic" -- Change this to your specific mechanic job name if different

-- Register the keigs-repair command
RegisterCommand('keigs-repair', function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        -- Check if player has enough money (checking bank first, then cash)
        local paid = false
        if Player.Functions.GetMoney('bank') >= repairPrice then
            Player.Functions.RemoveMoney('bank', repairPrice, "vehicle-repair-cmd")
            paid = true
        elseif Player.Functions.GetMoney('cash') >= repairPrice then
            Player.Functions.RemoveMoney('cash', repairPrice, "vehicle-repair-cmd")
            paid = true
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have enough money ($" .. repairPrice .. ")", "error")
        end

        if paid then
            -- Send money to Mechanic Society/Boss Menu
            exports['qb-management']:AddMoney(mechanicJobName, repairPrice)
            TriggerClientEvent('vehicleRepair:client:keigs-repair', -1, src)
        end
    end
end, false)


-- Server event called upon by the interaction point in main.lua
RegisterServerEvent('vehicleRepair:server:keigs-repair')
AddEventHandler('vehicleRepair:server:keigs-repair', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        -- Payment logic for the interaction point
        local paid = false
        if Player.Functions.GetMoney('bank') >= repairPrice then
            Player.Functions.RemoveMoney('bank', repairPrice, "vehicle-repair-loc")
            paid = true
        elseif Player.Functions.GetMoney('cash') >= repairPrice then
            Player.Functions.RemoveMoney('cash', repairPrice, "vehicle-repair-loc")
            paid = true
        else
            TriggerClientEvent('QBCore:Notify', src, "Insufficient funds to repair!", "error")
        end

        if paid then
            -- Send money to Mechanic Society/Boss Menu
            exports['qb-management']:AddMoney(mechanicJobName, repairPrice)
            TriggerClientEvent('vehicleRepair:client:keigs-repair', -1, src)
        end
    end
end)