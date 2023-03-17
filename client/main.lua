function showNotification(message)
  SetNotificationTextEntry("STRING")
  AddTextComponentSubstringPlayerName(message)
  DrawNotification(false, false)
end

function DrawText3D(x, y, z, text)
  local onScreen,_x,_y = World3dToScreen2d(x, y, z)
  local px,py,pz = table.unpack(GetGameplayCamCoord())
  local dist = #(vector3(px,py,pz) - vector3(x,y,z))

  if onScreen then
    SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextOutline()

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)

    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.02+factor, 0.03, 0, 0, 0, 100)
  end
end

function henshinModel(model)
  local playerPed = GetPlayerPed(-1)
  if DoesEntityExist(playerPed) then
    RequestModel(model)
    while not HasModelLoaded(model) do
      Citizen.Wait(1)
    end

    local coords = GetEntityCoords(playerPed)
    SetEntityHeading(playerPed, 0.0)
    SetEntityCoords(playerPed, coords.x, coords.y, coords.z - 1.0, 0, 0, 0, 0)
    Citizen.Wait(500)
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)

    showNotification("変身しました")
  end
end

RegisterCommand("henshin", function(source, args)
  local modelName = "a_m_y_skater_01"
  if args[1] ~= nil then
    if args[1] == "cat" then
      modelName = "a_c_cat_01"
    elseif args[1] == "dog" then
      modelName = "a_c_shepherd"
    end
  end

  henshinModel(modelName)
end)