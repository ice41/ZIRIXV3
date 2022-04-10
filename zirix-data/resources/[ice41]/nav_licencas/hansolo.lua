----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da CidadePerdida <Ice41>, por favor mantenha os créditos   ]--
--[                     NPED.PT - DarkDEVs Discord: discord.gg/ZTPrPbtaTu                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

mtt = Tunnel.getInterface("nav_carta")
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------

local fteorico =0
local fmota = 0
local fcarro = 0
local fcamiao = 0
local freboque = 0
-----------------------------------------------------------------------------------------------------------------------------------------
--[FUNCTION]-----------------------------------------------------------------------------------------------------------------------------
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
-- [MENU]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "teorico" then
		TriggerEvent("teorico")
		fteorico = 1
	
	elseif data == "arma" and mtt.checkarma() and mtt.pagamento() then
				farma = 1
				DoScreenFadeOut(1000)
				Wait(1500)
				ToggleActionMenu()
				TriggerEvent("geral:final")
			

	elseif data == "direito" and mtt.checkdireito() and mtt.pagamento() then
				fdireito = 1
				DoScreenFadeOut(1000)
				Wait(1500)
				ToggleActionMenu()
				TriggerEvent("geral:final")
	elseif data == "piloto" and mtt.checkpiloto() and mtt.pagamento() then
				fpiloto = 1
				DoScreenFadeOut(1000)
				Wait(1500)
				ToggleActionMenu()
				TriggerEvent("geral:final")

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAl DE ONDE ACEDER AO MENU ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['x'] = 450.5, ['y'] = -973.12, ['z'] = 30.69 } -- 450.5,-973.12,30.69
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local idle = 1000

		for k,v in pairs(locais) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local locais = locais[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), locais.x, locais.y, locais.z, true ) < 1.2 then
				DrawText3D(450.5,-973.12,31.69, "[~g~E~w~] Para acessar o ~g~Menu~w~ da licenças.")
			end
			if distance <= 5 then
				DrawMarker(23,locais.x,locais.y,locais.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,20,20,20,240,0,0,0,0)
				idle = 5
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) then
						ToggleActionMenu()
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)


--[ TESTE FINAL ]------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('geral:final')
AddEventHandler('geral:final', function()
    if fteorico == 1 then 
			mtt.steorico()
			TriggerEvent("Notify","sucesso","Foi aprovado no teste Teorico!",8000)
	elseif farma == 1 then 
			mtt.sarma()
			TriggerEvent("Notify","sucesso","Porte de Arma Comprado",8000)
	elseif fdireito == 1 then
			mtt.sdireito()
			TriggerEvent("Notify","sucesso","Licença de direito comprada",8000)
	elseif fpiloto == 1 then
			mtt.spiloto()
			TriggerEvent("Notify","sucesso","Licença de piloto comprada",8000)
    end
end)

--[ FUNÇÕES ]----------------------------------------------------------------------------------------------------------------------------

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

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

--[[ NPC Esquadra]]----------------------------------------------------------------------------------------------------------------------------
local pedlist = {
		--{ ['x'] = 450.5, ['y'] = -973.12, ['z'] = 30.69, ['h'] = 169.15, ['hash'] = 2374966032, ['hash2'] = "S_M_Y_Swat_01" }, -- Policia DP;
		--{ ['x'] = 450.5, ['y'] = -973.12, ['z'] = 30.69, ['h'] = 169.15, ['hash'] = 1096929346, ['hash2'] = "s_f_y_sheriff_01" }, -- Policia DP;
		--{ ['x'] = 450.5, ['y'] = -973.12, ['z'] = 30.69, ['h'] = 169.15, ['hash'] = 2974087609, ['hash2'] = "s_m_y_sheriff_01" }, -- Policia DP;
		--{ ['x'] = 450.5, ['y'] = -973.12, ['z'] = 30.69, ['h'] = 169.15, ['hash'] = 3613962792, ['hash2'] = "s_m_m_security_01" }, -- Policia DP;
		--{ ['x'] = 450.5, ['y'] = -973.12, ['z'] = 30.69, ['h'] = 169.15, ['hash'] = 4017173934, ['hash2'] = "S_M_Y_Ranger_01" }, -- Policia DP;
		--{ ['x'] = 450.5, ['y'] = -973.12, ['z'] = 30.69, ['h'] = 169.15, ['hash'] = 2680682039, ['hash2'] = "s_f_y_ranger_01" }, -- Policia DP;
		--{ ['x'] = 450.5, ['y'] = -973.12, ['z'] = 30.69, ['h'] = 169.15, ['hash'] = 0x7FA2F024, ['hash2'] = "CSB_ProlSec" }, -- Policia DP;
		{ ['x'] = 450.5, ['y'] = -973.12, ['z'] = 30.69, ['h'] = 169.15, ['hash'] = 2595446627, ['hash2'] = "CSB_Cop" } -- Policia DP;
		
}
Citizen.CreateThread(function()
	for k,v in pairs(pedlist) do
		RequestModel(GetHashKey(v.hash2))
		while not HasModelLoaded(GetHashKey(v.hash2)) do
			Citizen.Wait(10)
		end
		local ped = CreatePed(4,v.hash,v.x,v.y,v.z-1,v.h,false,true)
		FreezeEntityPosition(ped,true)
		SetEntityInvincible(ped,true)
		SetBlockingOfNonTemporaryEvents(ped,true)
	end
end)