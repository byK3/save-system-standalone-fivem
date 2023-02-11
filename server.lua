stats = {}

AddEventHandler('onResourceStart', function (resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    loadDatabase()
    print ('[byK3 - SAVE SYSTEM] Loaded Database')
end)

loadDatabase = function()
    local file = json.decode(LoadResourceFile(GetCurrentResourceName(), "save.json")) or {}
    stats = file
end

saveDatabase = function()
    SaveResourceFile(GetCurrentResourceName(), 'save.json', json.encode(stats), -1)
end

AddEventHandler('playerDropped', function (reason)
    local ped = GetPlayerPed(source)
    local health = GetEntityHealth(ped)
    local armour = GetPedArmour(ped)

    savePlayerInformation(source, health, armour)
end)

local spawned = false
RegisterNetEvent('byk3_save:server:load')
AddEventHandler('byk3_save:server:load', function ()
    local identifier = GetPlayerIdentifier(source, 0)

    if spawned then
        print ('Already spawned')
        return
    end

    for i = 1, #stats do
        if (stats[i].identifier == identifier) then
            TriggerClientEvent('byk3_save:client:load', source, stats[i].health, stats[i].armour)
            table.remove(stats, i)
            saveDatabase()
            spawned = true
            print ('[byK3 - SAVE SYSTEM] User Stats for ' .. GetPlayerName(source) .. ' loaded')
            break
        end
    end
end)

savePlayerInformation = function (source, health, armour)
    local identifier = GetPlayerIdentifier(source, 0)

    if identifier then
        data = {
            identifier = identifier,
            health = health,
            armour = armour
        }

        table.insert(stats, data)
        saveDatabase()
        print ('[byK3 - SAVE SYSTEM] User Stats for ' .. GetPlayerName(source) .. ' saved')
    end
end

RegisterCommand('debugsavelist', function (source, args, rawCommand)
    print(json.encode(stats))
end)