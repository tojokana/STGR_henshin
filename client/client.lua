local isHenshin = false -- 変身しているかどうかを示すフラグ

-- 変身するトリガーとなるコマンドを追加
RegisterCommand("henshin", function()
  TriggerServerEvent("stgr_henshin:transform")
end)

-- サーバーからの通知を受け取って変身する
RegisterNetEvent("stgr_henshin:transformPlayer")
AddEventHandler("stgr_henshin:transformPlayer", function(modelHash)
  -- 変身中でない場合のみ変身する
  if not isHenshin then
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
      Wait(1)
    end

    local playerPed = PlayerPedId()
    SetPlayerModel(PlayerId(), modelHash)
    SetPedRandomComponentVariation(playerPed, true)
    SetModelAsNoLongerNeeded(modelHash)

    isHenshin = true
    exports["mythic_notify"]:SendAlert("success", "変身しました。")
  else
    exports["mythic_notify"]:SendAlert("error", "すでに変身しています。")
  end
end)

-- 元のモデルに戻るコマンドを追加
RegisterCommand("henshin_back", function()
  TriggerServerEvent("stgr_henshin:transformBack")
end)

-- サーバーからの通知を受け取って元のモデルに戻る
RegisterNetEvent("stgr_henshin:transformPlayerBack")
AddEventHandler("stgr_henshin:transformPlayerBack", function(modelHash)
  -- 変身中である場合のみ元のモデルに戻る
  if isHenshin then
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
      Wait(1)
    end

    local playerPed = PlayerPedId()
    SetPlayerModel(PlayerId(), modelHash)
    SetPedRandomComponentVariation(playerPed, true)
    SetModelAsNoLongerNeeded(modelHash)

    isHenshin = false
    exports["mythic_notify"]:SendAlert("success", "元に戻りました。")
  else
    exports["mythic_notify"]:SendAlert("error", "変身していません。")
  end
end)

RegisterNetEvent('stgr_henshin:transformed')
AddEventHandler('stgr_henshin:transformed', function(model)
    local playerPed = PlayerPedId()
    if IsPedModel(playerPed, GetHashKey(model)) then
        ESX.ShowNotification('You transformed into a ' .. model .. '!')
    else
        ESX.ShowNotification('Failed to transform into a ' .. model .. '.')
    end
end)