local firstspawn = true

AddEventHandler('playerSpawned', function ()
    if firstspawn then
        TriggerServerEvent('byk3_save:server:load')
        firstspawn = false
    end
end)

local spawned = false
RegisterNetEvent('byk3_save:client:load')
AddEventHandler('byk3_save:client:load', function (health, armour)

    if spawned then
        print ('Already spawned')
        return
    end

    local ped = GetPlayerPed(-1)
    SetEntityHealth(ped, health)
    SetPedArmour(ped, armour)
    spawned = true
end)
