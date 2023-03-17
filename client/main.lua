QBCore = exports['qb-core']:GetCoreObject()
local currentSkin = nil

RegisterCommand('henshin', function(source, args)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        if args[1] == nil then
            if currentSkin ~= nil then
              RevertSkin()
                currentSkin = nil
                TriggerEvent('chat:addMessage', {
                    color = {255, 0, 0},
                    multiline = true,
                    args = {'STGR', '変身を解除しました。'}
                })
            else
                TriggerEvent('chat:addMessage', {
                    color = {255, 0, 0},
                    multiline = true,
                    args = {'STGR', '現在は変身していません。'}
                })
            end
        else
            local skin = nil
            if args[1] == 'cat' then
                skin = GetHashKey('a_c_cat_01')
            elseif args[1] == 'rat' then
                skin = GetHashKey('a_c_rat_01')
            elseif args[1] == 'crow' then
                skin = GetHashKey('a_c_crow')
            end
            if skin ~= nil then
                RequestModel(skin)
                while not HasModelLoaded(skin) do
                    Citizen.Wait(1)
                end
                SetPlayerModel(PlayerId(), skin)
                TriggerEvent('skinchanger:loadSkin', skin)
                currentSkin = skin
                TriggerEvent('chat:addMessage', {
                    color = {255, 0, 0},
                    multiline = true,
                    args = {'STGR', '変身しました。'}
                })
            else
                TriggerEvent('chat:addMessage', {
                    color = {255, 0, 0},
                    multiline = true,
                    args = {'STGR', '変身できませんでした。'}
                })
            end
        end
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {'STGR', '車両に乗っているため、変身できません。'}
        })
    end
end)
local function RevertSkin()
  local playerPed = PlayerPedId()
  QBCore.Functions.TriggerCallback('qb-clothing:loadPlayerClothing', function(clothing)
      if clothing ~= nil then
          if clothing[1] ~= nil then
              TriggerEvent('skinchanger:loadClothes', playerPed, clothing[1])
          end
          if clothing[2] ~= nil then
              TriggerEvent('skinchanger:loadClothes', playerPed, clothing[2])
          end
      end
  end, QBCore.Functions.GetPlayerData().charinfo.gender)
end

function henshin(catModel)
  local playerPed = PlayerPedId()

  if catModel ~= nil then
      if IsModelValid(catModel) then
          RequestModel(catModel)
          while not HasModelLoaded(catModel) do
              Citizen.Wait(0)
          end
          SetPlayerModel(PlayerId(), catModel)
          SetModelAsNoLongerNeeded(catModel)
          SetPedDefaultComponentVariation(playerPed)
          SetPedRandomComponentVariation(playerPed, true)
      else
          QBCore.Functions.Notify("Invalid model.")
      end
  else
      QBCore.Functions.Notify("No model specified.")
  end

  Citizen.CreateThread(function()
      while true do
          Citizen.Wait(0)
          if IsPedInAnyVehicle(playerPed, false) then
              SetPedIntoVehicle(playerPed, GetVehiclePedIsIn(playerPed, false), -1)
          end
      end
  end)

  RevertSkin()
end

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
