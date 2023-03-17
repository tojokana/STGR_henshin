local animals = {
  "a_c_cat_01",
  "a_c_chop"
}

local function SetPedModel(ped, model)
  local modelHash = GetHashKey(model)
  RequestModel(modelHash)
  while not HasModelLoaded(modelHash) do Citizen.Wait(0) end
  SetPlayerModel(PlayerId(), modelHash)
  SetModelAsNoLongerNeeded(modelHash)
end

RegisterNetEvent('stgr_henshin:transform')
AddEventHandler(
  'stgr_henshin:transform', function(animal)
    local playerPed = GetPlayerPed(-1)
    if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
      if animal and type(animal) == 'string' then
        if not HasAnimDictLoaded("mp_common") then
          RequestAnimDict("mp_common")
          while not HasAnimDictLoaded("mp_common") do Citizen.Wait(0) end
        end

        local model = GetHashKey(animals[animal])
        if IsModelValid(model) then
          SetPedModel(playerPed, animals[animal])
          SetPedDefaultComponentVariation(playerPed)
          SetPedRandomProps(playerPed)
          ClearPedDecorations(playerPed)
          SetEntityHealth(playerPed, GetPedMaxHealth(playerPed))

          TaskPlayAnim(playerPed, "mp_common", "givetake1_a", 8.0, -8.0, -1, 0, 0, false, false, false)
          Wait(3000)
          ClearPedTasks(playerPed)
        else
          TriggerEvent(
            'chat:addMessage', {
              args = {
                'Failed to change model: Invalid model hash'
              }
            })
        end
      end
    end
  end)

RegisterNetEvent('stgr_henshin:restore')
AddEventHandler(
  'stgr_henshin:restore', function()
    local playerPed = GetPlayerPed(-1)
    if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
      local model = GetHashKey(GetEntityModel(playerPed))
      SetPedDefaultComponentVariation(playerPed)
      SetPedRandomProps(playerPed)
      ClearPedDecorations(playerPed)
      SetEntityHealth(playerPed, GetPedMaxHealth(playerPed))
      SetPedModel(playerPed, model)
      TriggerEvent(
        'chat:addMessage', {
          args = {
            'You have been restored to your original form'
          }
        })
    end
  end)
