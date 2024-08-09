GetClosestVehicle = function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local vehicles = GetGamePool('CVehicle')
    local closestDistance = -1
    local closestVehicle = nil

    for _, vehicle in ipairs(vehicles) do
        local vehicleCoords = GetEntityCoords(vehicle)
        local distance = #(playerCoords - vehicleCoords)

        if closestDistance == -1 or distance < closestDistance then
            closestVehicle = vehicle
            closestDistance = distance
        end
    end
    Wait(100)
    return closestVehicle, closestDistance
end


SprayParticles = function(dict, name, scale, color, entity)
    RequestNamedPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do
        Wait(10)
    end

    UseParticleFxAsset(dict)
    local particleHandle = StartParticleFxLoopedOnEntity(name, entity, 0.2, 0.0, 0.1, 0.0, 80.0, 0.0, scale, false, false, false)
    SetParticleFxLoopedAlpha(particleHandle, 100.0)
    SetParticleFxLoopedColour(particleHandle, color[1] / 255.0, color[2] / 255.0, color[3] / 255.0)

    return particleHandle
end

RegisterNetEvent('atlanta-carpaint:useSprayCan')
AddEventHandler('atlanta-carpaint:useSprayCan', function()
    local vehicle, distance = GetClosestVehicle()
    if not vehicle or distance > 2.5 then
        return TriggerEvent('atlanta-carpaint:notify', Shared.Translation['novehnearby'])
    end

    local input = lib.inputDialog(Shared.Translation['title'], {
        { type = 'input', label = Shared.Translation['primary'], description = Shared.Translation['description'], placeholder = '255,255,255' },
        { type = 'input', label = Shared.Translation['secondary'], description = Shared.Translation['description'], placeholder = '255,255,255' },
    })

    if not input then
        return TriggerEvent('atlanta-carpaint:notify', Shared.Translation['cancelled'])
    end

    local primaryColor, secondaryColor = {}, {}
    for value in string.gmatch(input[1], "%d+") do
        table.insert(primaryColor, tonumber(value))
    end
    for value in string.gmatch(input[2], "%d+") do
        table.insert(secondaryColor, tonumber(value))
    end

    if #primaryColor == 3 and #secondaryColor == 3 then
        TaskTurnPedToFaceEntity(PlayerPedId(), vehicle, 1000)
        Wait(2000)
        SprayParticles('scr_paintnspray', 'scr_respray_smoke', 0.5, primaryColor, vehicle)
        SprayParticles('scr_paintnspray', 'scr_respray_smoke', 0.5, secondaryColor, vehicle)

        lib.progressBar({
            duration = Shared.Duration,
            label = Shared.Translation['label'],
            prop = {
                model = `ng_proc_spraycan01a`,
                pos = vec3(0.07, 0.0, 0.03),
                rot = vec3(33.0, 98.0, 0.6)
            },
            anim = {
                dict = 'anim@mp_player_intupperwave',
                clip = 'idle_a',
            },
        })

        SetVehicleCustomPrimaryColour(vehicle, table.unpack(primaryColor))
        SetVehicleCustomSecondaryColour(vehicle, table.unpack(secondaryColor))
        TriggerServerEvent('atlanta-carpaint:removeItem')
        TriggerEvent('atlanta-carpaint:notify', Shared.Translation['success'])
    else
        TriggerEvent('atlanta-carpaint:notify', Shared.Translation['invalid_input'])
    end
end)