local isHenshin = false

RegisterNetEvent('stgr_henshin:transform')
AddEventHandler('stgr_henshin:transform', function(animal)
    local ped = PlayerPedId()
    local model = GetHashKey(animal)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(10)
    end
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    isHenshin = true
end)

RegisterCommand('henshin', function(source, args)
    if isHenshin then
        SetPlayerModel(PlayerId(), GetHashKey('mp_m_freemode_01'))
        isHenshin = false
    else
        if args[1] == 'cat' then
            TriggerServerEvent('stgr_henshin:transform', 'a_c_cat_01')
        elseif args[1] == 'dog' then
            TriggerServerEvent('stgr_henshin:transform', 'a_c_husky')
        end
    end
end)