ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterCommand("coords", function(source, args, rawcommand)
    local playerPed = GetPlayerPed(PlayerPedId())
    local playerPos = GetEntityCoords(playerPed)
    print(playerPos.x ..", ".. playerPos.y ..", ".. playerPos.z)
end)

Citizen.CreateThread(function()
    local isInTeleportZone = false

    while true do
        local playerPed = GetPlayerPed(PlayerPedId())
        local playerPos = GetEntityCoords(playerPed)
        local interval = 1

        for k, initialPos in pairs(Config.Position.Initial) do
            local getDistance = GetDistanceBetweenCoords(playerPos, initialPos, true)
            if getDistance < 20 then
                interval = 200
                if getDistance < 1 then
                    isInTeleportZone = true
                end
            end
        end

        for k, teleportedPos in pairs(Config.Position.Teleported) do
            local getDistance = GetDistanceBetweenCoords(playerPos, teleportedPos, true)
            if getDistance < 20 then
                interval = 200
                if getDistance < 1 then
                    isInTeleportZone = true
                end
            end
        end

        if isInTeleportZone then
            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to teleport") 
            if IsControlJustPressed(0, 51) then
                isInTeleportZone = false
                for k, initialPos in pairs(Config.Position.Initial) do
                    local getDistance = GetDistanceBetweenCoords(playerPos, initialPos, true)
                    if getDistance < 1 then
                        SetEntityCoords(playerPed, Config.Position.Teleported[k], true, false, false, false)
                    end
                end

                for k, teleportedPos in pairs(Config.Position.Teleported) do
                    local getDistance = GetDistanceBetweenCoords(playerPos, teleportedPos, true)
                    if getDistance < 1 then
                        SetEntityCoords(playerPed, Config.Position.Initial[k], true, false, false, false)
                    end
                end
            end
        else
            for k, initialPos in pairs(Config.Position.Initial) do
                DrawMarker(Config.MarkerType, initialPos, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, Config.MarkerSize, Config.MarkerColor, 100, false, true, 2, false, false, false, false)
            end
            for k, teleportedPos in pairs(Config.Position.Teleported) do
                DrawMarker(Config.MarkerType, teleportedPos, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, Config.MarkerSize, Config.MarkerColor, 100, false, true, 2, false, false, false, false)
            end
        end

        Citizen.Wait(interval)
    end
end)
