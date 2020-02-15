ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local currentArmour = nil

RegisterNetEvent('LRP-Armour:Server:RefreshCurrentArmour')
AddEventHandler('LRP-Armour:Server:RefreshCurrentArmour', function(updateArmour)
   currentArmour = updateArmour
end)

AddEventHandler('esx:playerLoaded', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    exports.ghmattimysql:scalar("SELECT armour FROM users WHERE identifier = @identifier", { 
        ['identifier'] = tostring(xPlayer.getIdentifier())
        }, function(data)
        if (data ~= nil) then
            TriggerClientEvent('LRP-Armour:Client:SetPlayerArmour', playerId, data)
        end
    end)
end)

AddEventHandler('esx:playerDropped', function(playerId)
    if currentArmour ~= nil then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        exports.ghmattimysql:execute("UPDATE users SET armour = @armour WHERE identifier = @identifier", { 
            ['identifier'] = tostring(xPlayer.getIdentifier()),
            ['armour'] = tonumber(currentArmour)
        })
    end
end)