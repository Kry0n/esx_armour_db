RegisterNetEvent('LRP-Armour:Client:SetPlayerArmour')
AddEventHandler('LRP-Armour:Client:SetPlayerArmour', function(armour)
    Citizen.Wait(5000)  -- Give ESX time to load their stuff. Because some how ESX remove the armour when load the ped.
                        -- If there is a better way to do this, make an pull request with 'Tu eres una papa' (you are a potato) as a subject
    SetPedArmour(PlayerPedId(), tonumber(armour))
end)

local TimeFreshCurrentArmour = 1000  -- 1s

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        TriggerServerEvent('LRP-Armour:Server:RefreshCurrentArmour', GetPedArmour(PlayerPedId()))
        Citizen.Wait(TimeFreshCurrentArmour)
    end
end)