RegisterCommand("henshin", function(source, args, rawCommand)
  local model
  local playerPed = PlayerPedId()
  
  if not args[1] then -- 引数がない場合、元のスキンに戻る
    model = GetHashKey("mp_m_freemode_01")
  elseif args[1] == "cat" then -- "cat" が引数の場合、 a_c_cat_01 のスキンに変更する
    model = GetHashKey("a_c_cat_01")
  elseif args[1] == "dog" then -- "dog" が引数の場合、 a_c_husky のスキンに変更する
    model = GetHashKey("a_c_husky")
  end
  
  if model then
    QBCore.Functions.SpawnCharacter(playerPed, { x = 0, y = 0, z = 0 }, function(spawnedPed)
      SetPlayerModel(PlayerId(), model)
      SetModelAsNoLongerNeeded(model)
      FreezeEntityPosition(spawnedPed, true)
      SetEntityInvincible(spawnedPed, true)
      SetEntityVisible(spawnedPed, false, false)
      SetTimeout(1000, function()
        SetPlayerModel(PlayerId(), model)
        FreezeEntityPosition(playerPed, false)
        SetEntityInvincible(playerPed, false)
        SetEntityVisible(playerPed, true, false)
        SetModelAsNoLongerNeeded(model)
      end)
    end)
  end
end, false)

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