local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------
--[ CONEXÕES ]---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
oC = Tunnel.getInterface("oc_lavagem-dinheiro")
-----------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
local onmenu = false
local emprocesso = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
local maquinas_bratva = {
	{ ['x'] = -60.32, ['y'] = -2517.85, ['z'] = 7.41 }, --bratva

--	-60.32,-2517.85,7.41
}
local maquinas_yakuza = {
	{ ['x'] = 1129.52, ['y'] = -3194.13, ['z'] = -40.39 } --yakuza
--	-60.32,-2517.85,7.41
}
local lavadoras_yakuza = {
	{ ['x'] = 1125.63, ['y'] = -3194.33, ['z'] = -40.39 } -- yakuza
	--{ ['x'] = 1123.79, ['y'] = -3194.38, ['z'] = -40.39 } --yakuza
--	-60.32,-2517.85,7.41
}

local lavadoras_bratva = {
	{ ['x'] = -55.17, ['y'] = -2520.89, ['z'] = 7.41 } -- bratva
	--{ ['x'] = 1123.79, ['y'] = -3194.38, ['z'] = -40.39 } --bratva
--	-60.32,-2517.85,7.41
}
local lavadora = {
    {id = 1, x=-53.51, y=-2521.28, z=7.41,h=0, state = 0, value = 0, propAberto = "bkr_prop_prtmachine_dryer_op", propFechado = "bkr_prop_prtmachine_dryer_spin"},
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ MENU ]-------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------

-- YAKUZA LAVAR

Citizen.CreateThread(function()
    while true do
        local idle = 1000
        for k,v in pairs(maquinas_yakuza) do
            local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
            local maquinas_yakuza = maquinas_yakuza[k]
            
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), maquinas_yakuza.x, maquinas_yakuza.y, maquinas_yakuza.z, true) < 1.2 then
                DrawText3D(maquinas_yakuza.x, maquinas_yakuza.y, maquinas_yakuza.z, "[~r~E~w~] Para iniciar o ~r~SISTEMA~w~.")
            end

            if distance <= 5 then
                DrawMarker(23, maquinas_yakuza.x, maquinas_yakuza.y, maquinas_yakuza.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
                idle = 5
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and oC.checkPermissao_yakuza() then
                        oC.lavagemDinheiro_yakuza()
					end
				end
			end
        end
        Citizen.Wait(idle)
    end
end)

-- YAKUZA RECOLHER
Citizen.CreateThread(function()
    while true do
        local idle = 1000
        for k,v in pairs(lavadoras_yakuza) do
            local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
            local lavadoras_yakuza = lavadoras_yakuza[k]
            
            
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), lavadoras_yakuza.x, lavadoras_yakuza.y, lavadoras_yakuza.z, true) < 1.2 then
                DrawText3D(lavadoras_yakuza.x, lavadoras_yakuza.y, lavadoras_yakuza.z, "[~r~G~w~] Para recolher o ~r~Dinheiro~w~.")
            end
			
			if distance <= 5 then
                DrawMarker(23, lavadoras_yakuza.x, lavadoras_yakuza.y, lavadoras_yakuza.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
                idle = 5
				if distance <= 1.2 then
					if IsControlJustPressed(0,47) and oC.checkPermissao_yakuza() then
                        oC.getDinheiro_yakuza()
					end
				end
			end
			
        end
        Citizen.Wait(idle)
    end
end)


-- BRATVA LAVAR
Citizen.CreateThread(function()
    while true do
        local idle = 1000
        for k,v in pairs(maquinas_bratva) do
            local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
            local maquinas_bratva = maquinas_bratva[k]
            
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), maquinas_bratva.x, maquinas_bratva.y, maquinas_bratva.z, true) < 1.2 then
                DrawText3D(maquinas_bratva.x, maquinas_bratva.y, maquinas_bratva.z, "[~r~E~w~] Para iniciar o ~r~SISTEMA~w~.")
            end

            if distance <= 5 then
                DrawMarker(23, maquinas_bratva.x, maquinas_bratva.y, maquinas_bratva.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
                idle = 5
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and oC.checkPermissao_bratva() then
                        oC.lavagemDinheiro_bratva()
						--TriggerEvent('oc_lavagem-dinheiro:criarMaquinas', 1)						
					end
				end
			end
        end
        Citizen.Wait(idle)
    end
end)



--BRATVA RECOLHER
Citizen.CreateThread(function()
    while true do
        local idle = 1000
        for k,v in pairs(lavadoras_bratva) do
            local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
            local lavadoras_bratva = lavadoras_bratva[k]
            
            
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), lavadoras_bratva.x, lavadoras_bratva.y, lavadoras_bratva.z, true) < 1.2 then
                DrawText3D(lavadoras_bratva.x, lavadoras_bratva.y, lavadoras_bratva.z, "[~r~G~w~] Para recolher o ~r~Dinheiro~w~.")
            end
			
			if distance <= 5 then
                DrawMarker(23, lavadoras_bratva.x, lavadoras_bratva.y, lavadoras_bratva.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
                idle = 5
				if distance <= 1.2 then
					if IsControlJustPressed(0,47) and oC.checkPermissao_bratva() then
                        oC.getDinheiro_bratva()
					end
				end
			end
			
        end
        Citizen.Wait(idle)
    end
end)






-----------------------------------------------------------------------------------------------------------------------------------
--[ SEGUNDOS ]---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if emprocesso then
			if segundos > 0 then
				segundos = segundos - 1
				if segundos == 0 then
					emprocesso = false
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("lavagem-dinheiro:posicao")
AddEventHandler("lavagem-dinheiro:posicao", function()
	local ped = PlayerPedId()
	if vRP.hasPermission(user_id,"yakuza.permissao") then
		SetEntityHeading(ped, 326.29)
		SetEntityCoords(ped, 1129.52,-3194.13,-40.39,false,false,false,false)
	else
		SetEntityHeading(ped, 326.29)
		SetEntityCoords(ped, -60.32,-2517.85,7.41-1,false,false,false,false)
	end
end)

RegisterNetEvent("lavagem-dinheiro:processo")
AddEventHandler("lavagem-dinheiro:processo", function()
	
end)
-------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end

--[[RegisterNetEvent('oc_lavagem-dinheiro:criarMaquinas')
AddEventHandler('oc_lavagem-dinheiro:criarMaquinas', function(maq) 
    for k,v in pairs(lavadoura) do
        if v.id == maq then
            local nivel1 = "prop_"..v.id
            nivel1 = CreateObject(GetHashKey(v.propAberto), v.x,v.y,v.z, true, true, true)
            PlaceObjectOnGroundProperly(nivel1)
            SetEntityHeading(nivel1,v.h)
            FreezeEntityPosition(nivel1,true)
            SetEntityAsMissionEntity(nivel1,true,true)
            -- state 1
            v.state = 1
            Citizen.Wait(2*1000)
            v.state = 2
        end
    end
end)]]--

--teleport lavagem yakuza
local Teleport = {
	["Yakuza"] = { -- yakuza lavagem
		positionFrom = { ['x'] = -277.27, ['y'] = 303.1, ['z'] = 90.72, ['perm'] = "yakuza.permissao" },
		positionTo = { ['x'] = 1138.04, ['y'] = -3198.547, ['z'] = -39.66, ['perm'] = "yakuza.permissao" }
	}
}
Citizen.CreateThread(function()
	while true do
		
		Citizen.Wait(1)
		for k,v in pairs(Teleport) do
			
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.positionFrom.x,v.positionFrom.y,v.positionFrom.z)
			local destino = GetDistanceBetweenCoords(v.positionFrom.x,v.positionFrom.y,cdz,x,y,z,true)
			local bowz,cdz2 = GetGroundZFor_3dCoord(v.positionTo.x,v.positionTo.y,v.positionTo.z)
			local destino2 = GetDistanceBetweenCoords(v.positionTo.x,v.positionTo.y,cdz2,x,y,z,true)
			if destino <= 10 then
				
				DrawMarker(27,v.positionFrom.x,v.positionFrom.y,v.positionFrom.z-1,0,0,0,0,0,0,1.0,1.0,1.0,199,0,0,50,1,30,30,30)
				if destino <= 1.5 then
					if IsControlJustPressed(0,38) and oC.checkPermissao_yakuza() then
						SetEntityCoords(PlayerPedId(),v.positionTo.x,v.positionTo.y,v.positionTo.z-0.50)
					end
				end
			end
			if destino2 <= 10 then
				DrawMarker(27,v.positionTo.x,v.positionTo.y,v.positionTo.z-1,0,0,0,0,0,0,1.0,1.0,1.0,199,0,0,50,1,30,30,30)
				if destino2 <= 1.5 then
					if IsControlJustPressed(0,38) and oC.checkPermissao_yakuza() then
						SetEntityCoords(PlayerPedId(),v.positionFrom.x,v.positionFrom.y,v.positionFrom.z-0.50)
					end
				end
			end
		end
	end
end)