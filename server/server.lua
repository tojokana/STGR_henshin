-- Server-side script

-- Function to log a message to the server console
function logMessage(message)
    print("[stgr_henshin] " .. message)
end

-- Function to handle a player requesting to transform into a cat
function transformToCat(source)
    -- Get the player's identifier and trigger the transformation on the client
    local identifier = GetPlayerIdentifiers(source)[1]
    TriggerClientEvent("stgr_henshin:transformToCat", source)

    -- Log the transformation to the server console
    logMessage("Player " .. identifier .. " has transformed into a cat")
end

-- Function to handle a player requesting to transform into a dog
function transformToDog(source)
    -- Get the player's identifier and trigger the transformation on the client
    local identifier = GetPlayerIdentifiers(source)[1]
    TriggerClientEvent("stgr_henshin:transformToDog", source)

    -- Log the transformation to the server console
    logMessage("Player " .. identifier .. " has transformed into a dog")
end

-- Function to handle a player requesting to transform back to the default model
function transformBack(source)
    -- Get the player's identifier and trigger the transformation on the client
    local identifier = GetPlayerIdentifiers(source)[1]
    TriggerClientEvent("stgr_henshin:transformBack", source)

    -- Log the transformation to the server console
    logMessage("Player " .. identifier .. " has transformed back to the default model")
end

-- Register commands to handle player requests to transform into a cat, a dog or back to the default model
RegisterCommand("transformtocat", function(source, args, rawCommand)
    transformToCat(source)
end)

RegisterCommand("transformtodog", function(source, args, rawCommand)
    transformToDog(source)
end)

RegisterCommand("transformback", function(source, args, rawCommand)
    transformBack(source)
end)

RegisterCommand('stgr_henshin', function(source, args, rawCommand)
    TriggerClientEvent('stgr_henshin:transform', source, args[1])
end)

RegisterServerEvent('stgr_henshin:transformServer')
AddEventHandler('stgr_henshin:transformServer', function(playerPed, modelHash)
    TriggerClientEvent('stgr_henshin:transformClient', -1, playerPed, modelHash)
end)