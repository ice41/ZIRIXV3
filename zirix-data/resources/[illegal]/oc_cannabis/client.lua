local step = 0
local premisa = false
local colhendo = false
local plantacoes = {
    -- primeira fileira
    {x=2904.92,y=4652.63,z=49.15, objectName = "weed1", objectName2 = "seed1", plantado = false, state = 0, planta = 1, tempo = 60},
    {x=2903.77,y=4656.80,z=49.17, objectName = "weed2", objectName2 = "seed2", plantado = false, state = 0, planta = 2, tempo = 60},
    {x=2903.23,y=4661.33,z=49.14, objectName = "weed3", objectName2 = "seed3", plantado = false, state = 0, planta = 3, tempo = 60},
    {x=2902.37,y=4665.53,z=49.13, objectName = "weed4", objectName2 = "seed4", plantado = false, state = 0, planta = 4, tempo = 60},
    {x=2901.58,y=4669.24,z=49.14, objectName = "weed5", objectName2 = "seed5", plantado = false, state = 0, planta = 5, tempo = 60},
    {x=2900.88,y=4673.02,z=49.12, objectName = "weed6", objectName2 = "seed6", plantado = false, state = 0, planta = 6, tempo = 60},
    {x=2900.19,y=4675.64,z=49.12, objectName = "weed7", objectName2 = "seed7", plantado = false, state = 0, planta = 7, tempo = 60},
    {x=2899.02,y=4679.36,z=49.08, objectName = "weed8", objectName2 = "seed8", plantado = false, state = 0, planta = 8, tempo = 60},
    {x=2898.35,y=4683.80,z=49.06, objectName = "weed9", objectName2 = "seed9", plantado = false, state = 0, planta = 9, tempo = 60},
    -- fim primeira fileira
    -- segunda fileira
    {x=2906.90,y=4652.22,z=49.20, objectName = "weed10", objectName2 = "seed10", plantado = false, state = 0, planta = 10, tempo = 60}, 
    {x=2900.14,y=4685.20,z=49.12, objectName = "weed11", objectName2 = "seed11", plantado = false, state = 0, planta = 11, tempo = 60}, 
    {x=2900.86,y=4682.31,z=49.07, objectName = "weed12", objectName2 = "seed12", plantado = false, state = 0, planta = 12, tempo = 60}, 
    {x=2901.31,y=4679.19,z=49.15, objectName = "weed13", objectName2 = "seed13", plantado = false, state = 0, planta = 13, tempo = 60}, 
    {x=2902.22,y=4675.13,z=49.17, objectName = "weed14", objectName2 = "seed14", plantado = false, state = 0, planta = 14, tempo = 60}, 
    {x=2903.05,y=4671.41,z=49.18, objectName = "weed15", objectName2 = "seed15", plantado = false, state = 0, planta = 15, tempo = 60}, 
    {x=2903.95,y=4668.10,z=49.16, objectName = "weed16", objectName2 = "seed16", plantado = false, state = 0, planta = 16, tempo = 60}, 
    {x=2904.74,y=4663.65,z=49.18, objectName = "weed17", objectName2 = "seed17", plantado = false, state = 0, planta = 17, tempo = 60}, 
    {x=2905.46,y=4658.92,z=49.17, objectName = "weed18", objectName2 = "seed18", plantado = false, state = 0, planta = 18, tempo = 60}, 
    {x=2906.51,y=4655.21,z=49.25, objectName = "weed19", objectName2 = "seed19", plantado = false, state = 0, planta = 19, tempo = 60}, 
    -- fim segunda fileira
    -- terceira fileira
    {x=2908.82,y=4652.81,z=49.20, objectName = "weed20", objectName2 = "seed20", plantado = false, state = 0, planta = 20, tempo = 60}, 
    {x=2907.55,y=4659.29,z=49.19, objectName = "weed21", objectName2 = "seed21", plantado = false, state = 0, planta = 21, tempo = 60}, 
    {x=2906.75,y=4663.76,z=49.17, objectName = "weed22", objectName2 = "seed22", plantado = false, state = 0, planta = 22, tempo = 60}, 
    {x=2905.85,y=4668.27,z=49.17, objectName = "weed23", objectName2 = "seed23", plantado = false, state = 0, planta = 23, tempo = 60}, 
    {x=2905.00,y=4672.06,z=49.18, objectName = "weed24", objectName2 = "seed24", plantado = false, state = 0, planta = 24, tempo = 60}, 
    {x=2904.30,y=4675.39,z=49.18, objectName = "weed25", objectName2 = "seed25", plantado = false, state = 0, planta = 25, tempo = 60}, 
    {x=2903.10,y=4679.76,z=49.15, objectName = "weed26", objectName2 = "seed26", plantado = false, state = 0, planta = 26, tempo = 60}, 
    {x=2902.76,y=4682.70,z=49.09, objectName = "weed27", objectName2 = "seed27", plantado = false, state = 0, planta = 27, tempo = 60}, 
    {x=2902.20,y=4685.62,z=49.13, objectName = "weed28", objectName2 = "seed28", plantado = false, state = 0, planta = 28, tempo = 60}, 
    -- fim terceira fileira
    -- quarta fileira
    {x=2910.26,y=4655.11,z=49.23, objectName = "weed29", objectName2 = "seed29", plantado = false, state = 0, planta = 29, tempo = 60}, 
    {x=2904.08,y=4685.64,z=49.16, objectName = "weed30", objectName2 = "seed30", plantado = false, state = 0, planta = 30, tempo = 60}, 
    {x=2904.69,y=4682.49,z=49.18, objectName = "weed31", objectName2 = "seed31", plantado = false, state = 0, planta = 31, tempo = 60}, 
    {x=2905.98,y=4677.00,z=49.19, objectName = "weed32", objectName2 = "seed32", plantado = false, state = 0, planta = 32, tempo = 60}, 
    {x=2907.22,y=4671.68,z=49.18, objectName = "weed33", objectName2 = "seed33", plantado = false, state = 0, planta = 33, tempo = 60}, 
    {x=2908.24,y=4667.58,z=49.14, objectName = "weed34", objectName2 = "seed34", plantado = false, state = 0, planta = 34, tempo = 60}, 
    {x=2909.14,y=4662.37,z=49.16, objectName = "weed35", objectName2 = "seed35", plantado = false, state = 0, planta = 35, tempo = 60}, 
    {x=2909.78,y=4658.38,z=49.23, objectName = "weed36", objectName2 = "seed36", plantado = false, state = 0, planta = 36, tempo = 60}, 
    -- fim quarta fileira
    -- quinta fileira
    {x=2911.78,y=4659.01,z=49.18, objectName = "weed37", objectName2 = "seed37", plantado = false, state = 0, planta = 37, tempo = 60}, 
    {x=2911.02,y=4662.13,z=49.18, objectName = "weed38", objectName2 = "seed38", plantado = false, state = 0, planta = 38, tempo = 60}, 
    {x=2910.33,y=4666.06,z=49.17, objectName = "weed39", objectName2 = "seed39", plantado = false, state = 0, planta = 39, tempo = 60}, 
    {x=2909.66,y=4669.62,z=49.16, objectName = "weed40", objectName2 = "seed40", plantado = false, state = 0, planta = 40, tempo = 60}, 
    {x=2908.98,y=4673.16,z=49.17, objectName = "weed41", objectName2 = "seed41", plantado = false, state = 0, planta = 41, tempo = 60}, 
    {x=2908.08,y=4676.66,z=49.22, objectName = "weed42", objectName2 = "seed42", plantado = false, state = 0, planta = 42, tempo = 60}, 
    {x=2907.34,y=4680.23,z=49.25, objectName = "weed43", objectName2 = "seed43", plantado = false, state = 0, planta = 43, tempo = 60}, 
    {x=2906.53,y=4683.70,z=49.19, objectName = "weed44", objectName2 = "seed44", plantado = false, state = 0, planta = 44, tempo = 60}, 
    {x=2905.75,y=4687.12,z=49.22, objectName = "weed45", objectName2 = "seed45", plantado = false, state = 0, planta = 45, tempo = 60}, 
    -- fim quinta fileira [ brkk ]
    -- sexta fileira 
    {x=2913.82,y=4658.94,z=49.17, objectName = "weed46", objectName2 = "seed46", plantado = false, state = 0, planta = 46, tempo = 60}, 
    {x=2913.00,y=4663.03,z=49.14, objectName = "weed47", objectName2 = "seed47", plantado = false, state = 0, planta = 47, tempo = 60}, 
    {x=2912.26,y=4667.17,z=49.13, objectName = "weed48", objectName2 = "seed48", plantado = false, state = 0, planta = 48, tempo = 60}, 
    {x=2911.09,y=4671.78,z=49.19, objectName = "weed49", objectName2 = "seed49", plantado = false, state = 0, planta = 49, tempo = 60}, 
    {x=2910.07,y=4676.82,z=49.25, objectName = "weed50", objectName2 = "seed50", plantado = false, state = 0, planta = 50, tempo = 60}, 
    {x=2909.08,y=4681.72,z=49.32, objectName = "weed51", objectName2 = "seed51", plantado = false, state = 0, planta = 51, tempo = 60}, 
    {x=2908.17,y=4686.16,z=49.26, objectName = "weed52", objectName2 = "seed52", plantado = false, state = 0, planta = 52, tempo = 60}, 
    -- fim sexta filiera
    -- setima fileira
    {x=2915.57,y=4659.72,z=49.24, objectName = "weed53", objectName2 = "seed53", plantado = false, state = 0, planta = 53, tempo = 60}, 
    {x=2909.77,y=4687.86,z=49.37, objectName = "weed54", objectName2 = "seed54", plantado = false, state = 0, planta = 54, tempo = 60}, 
    {x=2910.42,y=4684.26,z=49.37, objectName = "weed55", objectName2 = "seed55", plantado = false, state = 0, planta = 55, tempo = 60}, 
    {x=2911.32,y=4680.88,z=49.39, objectName = "weed56", objectName2 = "seed56", plantado = false, state = 0, planta = 56, tempo = 60}, 
    {x=2912.02,y=4677.38,z=49.27, objectName = "weed57", objectName2 = "seed57", plantado = false, state = 0, planta = 57, tempo = 60}, 
    {x=2912.99,y=4673.96,z=49.15, objectName = "weed58", objectName2 = "seed58", plantado = false, state = 0, planta = 58, tempo = 60}, 
    {x=2913.65,y=4670.47,z=49.11, objectName = "weed59", objectName2 = "seed59", plantado = false, state = 0, planta = 59, tempo = 60}, 
    {x=2914.32,y=4666.92,z=49.13, objectName = "weed60", objectName2 = "seed60", plantado = false, state = 0, planta = 60, tempo = 60}, 
    {x=2915.04,y=4663.42,z=49.18, objectName = "weed61", objectName2 = "seed61", plantado = false, state = 0, planta = 61, tempo = 60}, 
    -- fim setima fileira
    -- oitava fileira
    {x=2917.88,y=4660.40,z=49.20, objectName = "weed62", objectName2 = "seed62", plantado = false, state = 0, planta = 62, tempo = 60}, 
    {x=2919.49,y=4662.15,z=49.13, objectName = "weed63", objectName2 = "seed63", plantado = false, state = 0, planta = 63, tempo = 60}, 
    {x=2921.43,y=4663.44,z=49.12, objectName = "weed64", objectName2 = "seed64", plantado = false, state = 0, planta = 64, tempo = 60}, 
    {x=2922.76,y=4665.93,z=49.17, objectName = "weed65", objectName2 = "seed65", plantado = false, state = 0, planta = 65, tempo = 60}, 
    {x=2924.57,y=4667.12,z=49.24, objectName = "weed66", objectName2 = "seed66", plantado = false, state = 0, planta = 66, tempo = 60}, 
    {x=2926.07,y=4669.51,z=49.14, objectName = "weed67", objectName2 = "seed67", plantado = false, state = 0, planta = 67, tempo = 60}, 
    {x=2928.06,y=4669.64,z=49.13, objectName = "weed68", objectName2 = "seed68", plantado = false, state = 0, planta = 68, tempo = 60}, 
    {x=2929.93,y=4670.29,z=49.09, objectName = "weed69", objectName2 = "seed69", plantado = false, state = 0, planta = 69, tempo = 60}, 
    {x=2931.79,y=4670.79,z=49.15, objectName = "weed70", objectName2 = "seed70", plantado = false, state = 0, planta = 70, tempo = 60}, 
    {x=2933.85,y=4671.05,z=49.12, objectName = "weed71", objectName2 = "seed71", plantado = false, state = 0, planta = 71, tempo = 60} 
}
RegisterNetEvent('crz_maconha:permissao')
AddEventHandler('crz_maconha:permissao', function()
	premisa = true
end)
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        -- iluminação na plantação
        if not premisa then
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 2932.3229980469,4624.2119140625,48.723407745361, true) <= 1.0 then	
                DrawText3Ds(2932.32,4624.21,48.72+0.5,"PRESSIONE ~r~E~w~ PARA COMEÇAR A TRABALHAR")
                if IsControlJustPressed(0, 38) then		
                    TriggerServerEvent('crz_maconha:permissao')
                end
            end	
        else
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 2932.3229980469,4624.2119140625,48.723407745361, true) <= 1.0 then	
                DrawText3Ds(2932.32,4624.21,48.72+0.5,"TRABALHANDANDO, VÁ PLANTAR.")
              
            end
            for _,v in pairs(plantacoes) do
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x,v.y,v.z, true) <= 1.5 then
                    local obj = GetClosestObjectOfType(v.x,v.y,v.z, 1.0, GetHashKey("prop_weed_02"), false, true ,true)
                    local obj2 = GetClosestObjectOfType(v.x,v.y,v.z, 1.0, GetHashKey("prop_weed_01"), false, true ,true)
                    if (obj == 0 and obj2 == 0)  then
                        if v.state ~= 3 and v.plantado == false then
                            DrawText3Ds(v.x,v.y,v.z+0.5,"PRESSIONE ~r~E~w~ PARA PLANTAR UMA Cannabis")
                            if IsControlJustPressed(0, 38) then
                                TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
                                FreezeEntityPosition(PlayerPedId(),true)
                                Citizen.Wait(10000)
                                FreezeEntityPosition(PlayerPedId(),false)
                                ClearPedTasksImmediately(PlayerPedId())
                                TriggerEvent('crz_maconha:createWeed',v.planta)
                                TriggerEvent('crz_maconha:enviarDados', v.planta)
                                v.plantado = true
                            end
                        else
                            if IsControlJustPressed(0, 38) and colhendo == false then
                                TriggerEvent('crz_maconha:colherPlanta',v.planta)
                                colhendo = true
                            end
                        end
                    else
                        if v.state == 3 and v.plantado == true then
                            if IsControlJustPressed(0, 38) and colhendo == false then
                                TriggerEvent('crz_maconha:colherPlanta',v.planta)
                                colhendo = true
                            end
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('crz_maconha:createWeed')
AddEventHandler('crz_maconha:createWeed', function(planta)
    for _,v in pairs(plantacoes) do
        if v.planta == planta then
            v.objectName = CreateObject(GetHashKey("prop_weed_02"), v.x,v.y,v.z, true, true, true)
            PlaceObjectOnGroundProperly(v.objectName)
            SetEntityHeading(v.objectName,340.00)
            FreezeEntityPosition(v.objectName,true)
            -- state 1
            v.state = 1
            Citizen.Wait(v.tempo*1000)
            v.state = 2
            DeleteObject(v.objectName)
            v.objectName2 = CreateObject(GetHashKey("prop_weed_01"),v.x,v.y,v.z, true, true, true)
            PlaceObjectOnGroundProperly(v.objectName2)
            SetEntityHeading(v.objectName2,340.00)
            FreezeEntityPosition(v.objectName2,true)
            Citizen.Wait(v.tempo*1000)
            v.state = 3
        end
    end
end)

RegisterNetEvent('crz_maconha:enviarDados')
AddEventHandler('crz_maconha:enviarDados', function(planta)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            for _,v in pairs(plantacoes) do
                if v.planta == planta then
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x,v.y,v.z, true) <= 1.0 then	
                        if v.state == 1 then
                            DrawText3Ds(v.x,v.y,v.z+0.5,"EM PROCESSO...")
                        elseif v.state == 2 then
                            DrawText3Ds(v.x,v.y,v.z+0.5,"TERMINANDO...")
                        elseif v.state == 3 then
                            DrawText3Ds(v.x,v.y,v.z+0.5,"PRESSIONE ~r~E~w~ PARA COLHER.")
                        end
                    end
                end
            end
        end
    end)
end)

RegisterNetEvent('crz_maconha:colherPlanta')
AddEventHandler('crz_maconha:colherPlanta',function(planta)
    for _,v in pairs(plantacoes) do
        if v.planta == planta then
            if v.state == 3 then
                TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                FreezeEntityPosition(PlayerPedId(),true)
                Citizen.Wait(10000)
                PlaySoundFrontend(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
                TriggerServerEvent('crz_maconha:enviarWeed')
                FreezeEntityPosition(PlayerPedId(),false)
                ClearPedTasksImmediately(PlayerPedId())
                DeleteObject(v.objectName2)
                v.plantado = false
                colhendo = false
                v.state = 0
            end
        end
    end
end)


-- FUNCTION

local sitting = false
local produzindo = 0
local closest = {}
local cadeiras = {
	{objectId = -1281587804, x=114.05, y=6360.52, z=32.31, h = 115.22}, -- cadeira DROGA   112.52102661133,6360.16796875,32.787044525146
	{objectId = -1281587804, x=112.13, y=6360.79, z=32.31, h = 290.87}, -- cadeira DROGA   112.52102661133,6360.16796875,32.787044525146
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        local list = {}
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
        for k,v in pairs(cadeiras) do
            local obj = GetClosestObjectOfType(x, y, z, 1.5, v.objectId, false, true ,true)
            local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(obj), true)
            table.insert(list, {object = obj, distance = dist})
        end
        closest = list[1]
        for k,v in pairs(list) do
            if v.distance < closest.distance then
                closest = v
            end
        end
        
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 112.52102661133,6360.16796875,32.78, true) <= 1.5 or GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 116.44131469727,6362.4877929688,32.785820007324, true) <= 0.8   then
            if closest then
                local distance = closest.distance
                local object = closest.object
                local objloc = GetEntityCoords(object)
                if not sitting and DoesEntityExist(object) then
                    local x,y,z = table.unpack(GetEntityCoords(object))
                    DrawMarker(0, x, y, z+1.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, true, 2, false, false, false, false)
                    if IsControlJustPressed(0, 38) then
                        TaskStartScenarioAtPosition(PlayerPedId(), "PROP_HUMAN_SEAT_BENCH", objloc.x-0.14, objloc.y, objloc.z+0.5, 269.0, 0, true, true)
                        sitting = true

                    end
                end
                if sitting then
                    if produzindo == 0 then
                        DrawText3Ds(objloc.x, objloc.y, objloc.z+0.60,"PARA FINALIZAR PRESSIONE ~r~F6~w~, PARA PRODUZIR APERTE ~r~Y~w~.")
                    end
                    if IsControlJustPressed(0, 167) then
                        local x,y,z = table.unpack(GetEntityCoords(object))
                        SetEntityCoords(PlayerPedId(), x+0.2,y,z,119.0)
                        sitting = false
                    end
                    if IsControlJustPressed(0, 246) then
                        produzindo = 1
                        Citizen.Wait(10000)
                        produzindo = 0
                        TriggerServerEvent('crz_maconha:enviarDroga')
                        PlaySoundFrontend(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
                    end
                end
            end
        end
	end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if produzindo == 1 then
            local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
            DrawText3Ds(x,y,z+0.60,"PRODUZINDO...") 
        end
    end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
