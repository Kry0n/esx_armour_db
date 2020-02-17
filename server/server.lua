ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    MySQL.Async.fetchScalar("SELECT armour FROM users WHERE identifier = @identifier", { 
        ['@identifier'] = xPlayer.getIdentifier()
        }, function(data)
        if (data ~= nil) then
            TriggerClientEvent('LRP-Armour:Client:SetPlayerArmour', playerId, data)
        end
    end)
end)

RegisterServerEvent('LRP-Armour:Server:RefreshCurrentArmour')
AddEventHandler('LRP-Armour:Server:RefreshCurrentArmour', function(updateArmour)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.execute("UPDATE users SET armour = @armour WHERE identifier = @identifier", { 
        ['@identifier'] = xPlayer.getIdentifier(),
        ['@armour'] = tonumber(updateArmour)
    })
end)

