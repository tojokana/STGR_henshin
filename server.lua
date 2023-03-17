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
RegisterNetEvent('stgr_henshin:transform')
AddEventHandler('stgr_henshin:transform', function(model)
    local player = source
    PerformTransformation(player, model)
end)

-- プレイヤーの再ログイン時に以前の変身状態を復元する
AddEventHandler('playerSpawned', function()
    local player = source
    if transformations[player] then
        PerformTransformation(player, transformations[player])
    end
end)