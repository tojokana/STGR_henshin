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

-- TriggerServerEventを削除する
--[[
RegisterNetEvent("stgr:henshin:changed")
AddEventHandler("stgr:henshin:changed", function(model)
  SetPlayerModel(PlayerId(), model)
end)
--]]

-- TriggerClientEventでクライアント側で変身処理を行うように指示する
RegisterServerEvent("stgr:henshin:change")
AddEventHandler("stgr:henshin:change", function()
  TriggerClientEvent("stgr:henshin:change")
end)