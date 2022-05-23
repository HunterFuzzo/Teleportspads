RegisterCommand("coords", function(source, args, rawcommand) -- command to get your coords
    local playerPed = GetPlayerPed(PlayerPedId())
    print(pos.x ..", ".. pos.y ..", ".. pos.z)
end)

local pos1 = {
    vector3(axe.x, axe.y, axe.z) -- fill this coords with /coords ig
}

local pos2 = {
    vector3(axe.x, axe.y, axe.z) -- fill this coords with /coords ig
}

Citizen.CreateThread(function()
    while true do
        local playerPed = GetPlayerPed(PlayerPedId())
        local playerPos = GetEntityCoords(playerPed)
        local getDistance1 = GetDistanceBetweenCoords(playerPos, pos1[1], true)
        local getDistance2 = GetDistanceBetweenCoords(playerPos, pos2[1], true)
        local interval = 1
        
        -- first position of the tp marker
        if getDistance1 < 20 then -- don't change it's for optimisation
            interval = 200
        else
            interval = 1
            DrawMarker(2, pos1[1], 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.75, 0.75, 0.75, 0, 255, 0, 100, false, true, 2, false, false, false, false)
            if getDistance < 1 then
                AddTextEntry("HELP", "Press ~INPUT_CONTEXT~ to teleport")
                DisplayHelpTextThisFrame("HELP", false)
                
                if IsControlJustPressed(0, 51) then
                    SetEntityCoords(playerPed, pos2[1], true, false, false, false)
                end
            end
        end 

        -- seconde position of the tp marker
        if getDistance2 < 20 then -- don't change it's for optimisation
            interval = 200
        else
            interval = 1
            DrawMarker(2, pos2[1], 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.75, 0.75, 0.75, 0, 255, 0, 100, false, true, 2, false, false, false, false)
            if getDistance2 < 1 then
                AddTextEntry("HELP", "Press ~INPUT_CONTEXT~ to teleport")
                DisplayHelpTextThisFrame("HELP", false)

                if IsControlJustPressed(0, 51) then
                    SetEntityCoords(playerPed, pos1[1], true, false, false, false)
                end
            end
        end 
        Citizen.Wait(interval)
    end
end)