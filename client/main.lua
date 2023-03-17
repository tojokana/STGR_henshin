RegisterCommand('henshin', function(source, args)
  local model = args[1] or "a_c_cat_01"
  TriggerServerEvent("stgr_henshin:transform", model)
end)

function DrawNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end

RegisterNetEvent("stgr_henshin:transformed")
AddEventHandler("stgr_henshin:transformed", function(model)
  local ped = GetPlayerPed(PlayerId())
  local isTransformed = IsPedModel(ped, model)

  if isTransformed then
    isTransformed = false
    ResetPedMovementClipset(ped, 0)
    RequestAnimDict("missheistdockssetup1clipboard@base")
    while not HasAnimDictLoaded("missheistdockssetup1clipboard@base") do Citizen.Wait(100) end
    SetPedMovementClipset(ped, "missheistdockssetup1clipboard@base", 1.0)
    DrawNotification("~g~You have returned to your original form.")
  else
    isTransformed = true
    RequestModel(model)
    while not HasModelLoaded(model) do Citizen.Wait(100) end
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    DrawNotification("~g~You have been transformed!")
  end
end)