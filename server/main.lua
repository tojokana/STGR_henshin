RegisterNetEvent('stgr_henshin:transform')
AddEventHandler('stgr_henshin:transform', function(animal)
    local src = source
    TriggerClientEvent('stgr_henshin:transform', -1, animal, src)
end)