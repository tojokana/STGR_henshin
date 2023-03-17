RegisterServerEvent('stgr_henshin:transform')
AddEventHandler('stgr_henshin:transform', function(model)
    local src = source
    local ped = GetPlayerPed(src)
    local modelHash = GetHashKey(model)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Citizen.Wait(0)
    end
    SetPlayerModel(src, modelHash)
    TriggerClientEvent('stgr_henshin:transformed', src, model)
end)

RegisterServerEvent('stgr_henshin:revert')
AddEventHandler('stgr_henshin:revert', function()
    local src = source
    local ped = GetPlayerPed(src)
    SetPlayerModel(src, ped)
end)