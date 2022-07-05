RegisterCommand("coords", function(source, args, rawcommand) -- command to get your coords
    local playerPed = GetPlayerPed(PlayerPedId())
    print(pos.x ..", ".. pos.y ..", ".. pos.z)
end)

Citizen.CreateThread(function()
    while true do
        for k, initalPos in pairs(Config.Position.Initial) do
            for k, teleportedPos in pairs(Config.Position.Teleported) do
                local playerPed = GetPlayerPed(PlayerPedId())
                local playerPos = GetEntityCoords(playerPed)
                local getDistance1 = GetDistanceBetweenCoords(playerPos, initialPos, true)
                local getDistance2 = GetDistanceBetweenCoords(playerPos, teleportedPos, true)
                local interval = 1
        
                -- first position of the tp marker
                if getDistance1 < 20 then -- don't change it's for optimisation
                    interval = 200
                else
                    interval = 1
                    DrawMarker(Config.MarkerType, initalPos, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, Config.MarkerSize, Config.MarkerColor, 100, false, true, 2, false, false, false, false)
                    if getDistance < 1 then
                        AddTextEntry("HELP", "Press ~INPUT_CONTEXT~ to teleport")
                        DisplayHelpTextThisFrame("HELP", false)
                
                        if IsControlJustPressed(0, 51) then
                            SetEntityCoords(playerPed, teleportedPos, true, false, false, false)
                        end
                    end
                end 
                

                -- seconde position of the tp marker
                if getDistance2 < 20 then -- don't change it's for optimisation
                    interval = 200
                else
                    interval = 1
                    DrawMarker(Config.MarkerType, teleportedPos, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, Config.MarkerSize, Config.MarkerColor, 100, false, true, 2, false, false, false, false)
                    if getDistance2 < 1 then
                        AddTextEntry("HELP", "Press ~INPUT_CONTEXT~ to teleport")
                        DisplayHelpTextThisFrame("HELP", false)

                        if IsControlJustPressed(0, 51) then
                            SetEntityCoords(playerPed, initialPos, true, false, false, false)
                        end
                    end
                end 
            end
        end
        Citizen.Wait(interval)
    end
end)
