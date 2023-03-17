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
        RequestAnimDict("missheistdockssetup1clipboard@base")
        while not HasAnimDictLoaded("missheistdockssetup1clipboard@base") do
            Citizen.Wait(100)
        end
        SetPedMovementClipset(GetPlayerPed(-1), "missheistdockssetup1clipboard@base", 1.0)
        DrawNotification("~g~You have been transformed!")
    end
end)