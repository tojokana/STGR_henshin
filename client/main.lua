local isTransformed = false
local currentLanguage = "ja" -- デフォルトの言語は英語

function DrawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

-- トランスフォームイベントを購読する
RegisterNetEvent("stgr_henshin:transformed")
AddEventHandler("stgr_henshin:transformed", function(player, model)
    local ped = GetPlayerPed(player)

    if isTransformed then
        -- 人間に戻る
        isTransformed = false
        ResetPedMovementClipset(ped, 0)
        RequestAnimDict("missheistdockssetup1clipboard@base")
        while not HasAnimDictLoaded("missheistdockssetup1clipboard@base") do
            Citizen.Wait(100)
        end
        SetPedMovementClipset(ped, "missheistdockssetup1clipboard@base", 1.0)
        DrawNotification("~g~" .. _U("transformed_back", currentLanguage)) -- 多言語化
    else
        -- 変身する
        isTransformed = true
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(100)
        end
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
        DrawNotification("~g~" .. _U("transformed", currentLanguage)) -- 多言語化
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsControlJustPressed(1, 167) then -- Press F6 to transform
            TriggerServerEvent("stgr_henshin:transformPlayer", GetHashKey("a_c_cat_01"))
        elseif IsControlJustPressed(1, 168) then -- Press F7 to transform
            TriggerServerEvent("stgr_henshin:transformPlayer", GetHashKey("a_c_chickenhawk"))
        end
    end
end)



-- 多言語化用の関数
function _U(str, lang)
    if lang == "en" then
        return str -- デフォルトの英語
    else
        local langTable = Config.Translation[lang]
        if langTable and langTable[str] then
            return langTable[str] -- 言語ファイルで翻訳されたテキストを返す
        else
            return str -- 翻訳が見つからない場合は、元の文字列を返す
        end
    end
end