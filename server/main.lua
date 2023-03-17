local modelList = {
    [GetHashKey("a_c_cat_01")] = true,
    [GetHashKey("a_c_chickenhawk")] = true,
}

RegisterServerEvent("stgr_henshin:transformPlayer")
AddEventHandler("stgr_henshin:transformPlayer", function(model)
    local source = source
    local ped = GetPlayerPed(source)

    if not modelList[tonumber(model)] then
        print(("^1Invalid Model %s!"):format(model))
        return
    end

    if not IsModelValid(model) or not HasModelLoaded(model) then
        print(("^1Invalid Model %s!"):format(model))
        return
    end

    SetPlayerModel(source, model)
    SetModelAsNoLongerNeeded(model)

    TriggerClientEvent("stgr_henshin:transformed", -1, source, model)

    Citizen.CreateThread(function()
        Wait(600000)
        SetPlayerModel(source, GetHashKey("mp_m_freemode_01"))
        TriggerClientEvent("stgr_henshin:transformed", -1, source, GetHashKey("mp_m_freemode_01"))
    end)
end)