-- Client-side script

local transformed = false

-- Function to transform the player into a given animal model
function transformAnimal(model)
    local playerPed = GetPlayerPed(-1)

    -- Check if the player is not already transformed and the given model is valid
    if not transformed and IsModelValid(model) then
        RequestModel(model)

        -- Wait for the model to load
        while not HasModelLoaded(model) do
            Citizen.Wait(100)
        end

        -- Change the player's model and set the transformed flag to true
        SetPlayerModel(PlayerId(), model)
        transformed = true
    end
end

-- Function to transform the player into a cat
function transformToCat()
    transformAnimal(GetHashKey("a_c_cat"))
end

-- Function to transform the player into a dog
function transformToDog()
    transformAnimal(GetHashKey("a_c_shepherd"))
end

-- Function to transform the player back to the default model
function transformBack()
    -- Check if the player is transformed and restore the default model
    if transformed then
        SetPlayerModel(PlayerId(), GetHashKey("mp_m_freemode_01"))
        transformed = false
    end
end

-- Register commands to transform the player into a cat, a dog or back to the default model
RegisterCommand("transformtocat", transformToCat)
RegisterCommand("transformtodog", transformToDog)
RegisterCommand("transformback", transformBack)