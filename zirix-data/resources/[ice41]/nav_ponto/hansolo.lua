local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

PPonto = Tunnel.getInterface("nav_ponto")
Bennys = Tunnel.getInterface("nav_ponto")
Emergencia = Tunnel.getInterface("nav_ponto")
Police = Tunnel.getInterface("nav_ponto")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNCTION ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BUTTON ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "entrar-servico" then
		TriggerServerEvent("entrar-servico")
		ToggleActionMenu()
	
	elseif data == "sair-servico" then
		TriggerServerEvent("sair-servico")
		ToggleActionMenu()

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local ponto = {
	{ ['x'] = -202.14, ['y'] = -1338.11, ['z'] = 30.9 }, -- bennys -- -202.14,-1338.11,30.9
	{ ['x'] = 348.29, ['y'] = -579.3, ['z'] = 47.33 }, -- emergencia -- 348.29,-579.3,47.33
	{ ['x'] = -1077.96, ['y'] = -817.26, ['z'] = 27.04 } -- Policia -- -1077.96,-817.26,27.04
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local idle = 1000

		for k,v in pairs(ponto) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local ponto = ponto[k]
			
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), ponto.x, ponto.y, ponto.z, true ) < 1.2 then
				DrawText3D(ponto.x, ponto.y, ponto.z, "[~g~E~w~] Para acessar o ~g~registro de ponto~w~.")
			end
			bennys = ponto[1]
			medico = ponto[2]
			policia = ponto[3]
			losantos = ponto[4]
			advogado = ponto[5]
			
			if distance <= 5 then
				DrawMarker(23,ponto.x,ponto.y,ponto.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,20,20,20,240,0,0,0,0)
				idle = 5
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and PPonto.checkPermissao() then
						ToggleActionMenu()
					end
				end
			end
		
		end
		Citizen.Wait(idle)
	end
end)

function DrawText3D(x,y,z, text)
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