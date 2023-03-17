local isTransformed = false

RegisterNetEvent("stgr_henshin:transformed")
AddEventHandler("stgr_henshin:transformed", function(model)
    local ped = GetPlayerPed(source)

    if isTransformed then
        isTransformed = false
        ResetPedMovementClipset(ped, 0)
        RequestAnimDict("missheistdockssetup1clipboard@base")
        while not HasAnimDictLoaded("missheistdockssetup1clipboard@base") do
            Citizen.Wait(100)
        end
        SetPedMovementClipset(ped, "missheistdockssetup1clipboard@base", 1.0)
        DrawNotification("~g~You have returned to your original form.")
    else
        isTransformed = true
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(100)
        end
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
        DrawNotification("~g~You have been transformed!")
        
        -- TriggerClientEvent("stgr_henshin:transformed", source, model)
        TriggerClientEvent('stgr_henshin:transform', playerId, modelName)
    end
end)

RegisterNetEvent("stgr_henshin:transformed")
AddEventHandler("stgr_henshin:transformed", function(playerId, model)
    local ped = GetPlayerPed(GetPlayerFromServerId(playerId))

    if IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(100)
        end
        SetPlayerModel(GetPlayerFromServerId(playerId), model)
        SetModelAsNoLongerNeeded(model)
        DrawNotification("~g~" .. GetPlayerName(GetPlayerFromServerId(playerId)) .. " has been transformed!")
    end
end)