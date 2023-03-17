local modelList = {
    [GetHashKey("a_c_cat_01")] = true,
    [GetHashKey("a_c_chickenhawk")] = true,
}

RegisterNetEvent("stgr_henshin:transformed")
AddEventHandler("stgr_henshin:transformed", function(model)
    local src = source
    local ped = GetPlayerPed(src)

    if isTransformed[src] then
        isTransformed[src] = false
        ResetPedMovementClipset(ped, 0)
        RequestAnimDict("missheistdockssetup1clipboard@base")
        while not HasAnimDictLoaded("missheistdockssetup1clipboard@base") do
            Citizen.Wait(100)
        end
        SetPedMovementClipset(ped, "missheistdockssetup1clipboard@base", 1.0)
        DrawNotification("~g~You have returned to your original form.")
    else
        isTransformed[src] = true
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(100)
        end
        SetPlayerModel(src, model)
        SetModelAsNoLongerNeeded(model)
        DrawNotification("~g~You have been transformed!")
    end
end)