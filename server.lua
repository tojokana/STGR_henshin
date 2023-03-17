-- 変身を管理するテーブル
local transformations = {}

-- 変身処理
function PerformTransformation(player, model)
    if IsModelInCdimage(model) and IsModelValid(model) then
        -- 以前の変身があれば、解除する
        if transformations[player] then
            SetPlayerModel(player, transformations[player])
            transformations[player] = nil
        end

        -- プレイヤーのモデルを変更する
        SetPlayerModel(player, model)
        SetModelAsNoLongerNeeded(model)

        -- 変身を記憶する
        transformations[player] = model
    end
end

-- クライアントからのトリガーを受け取る
RegisterNetEvent("stgr_henshin:transform")
AddEventHandler("stgr_henshin:transform", function()
local model
local ped = PlayerPedId()
if IsPedInAnyVehicle(ped, false) then return end

if IsPedOnFoot(ped) then
    local x, y, z = table.unpack(GetEntityCoords(ped, false))
    local closest, closestDist = GetClosestObjectOfType(x, y, z, 5.0, GetHashKey("prop_cs_cardbox_01"), false, false, false)
    if closestDist ~= -1 and closestDist <= 5.0 then
        model = GetHashKey("a_c_cat_01")
    else
        model = GetHashKey("a_c_chop")
    end
end

if model then TriggerClientEvent("stgr_henshin:transformed", -1, model) end
end)

RegisterNetEvent("stgr_henshin:transform_back")
AddEventHandler("stgr_henshin:transform_back", function(playerId) TriggerClientEvent("stgr_henshin:transform_back", playerId) end)

-- プレイヤーの再ログイン時に以前の変身状態を復元する
AddEventHandler('playerSpawned', function()
    local player = source
    if transformations[player] then PerformTransformation(player, transformations[player]) end
end)
