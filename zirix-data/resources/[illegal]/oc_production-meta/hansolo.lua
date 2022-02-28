local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

oC = Tunnel.getInterface("oc_producao-meta")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodMachineM = {
	{ ['x'] = 1493.26, ['y'] = 6390.29, ['z'] = 21.26 }
	-- 1493.26, 6390.29, 21.26
}
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false
local onmenu = false

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end
-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "produzir-composito-baixa" then
		TriggerServerEvent("produzir-meta","composito-baixa")

	elseif data == "produzir-composito-media" then
		TriggerServerEvent("produzir-meta","composito-media")

	elseif data == "produzir-composito-baixa" then
		TriggerServerEvent("produzir-meta","composito-baixa")

	elseif data == "produzir-meta-baixa" then
		TriggerServerEvent("produzir-meta","meta-baixa")

	elseif data == "produzir-meta-media" then
		TriggerServerEvent("produzir-meta","meta-media")	
	
	elseif data == "produzir-meta-alta" then
		TriggerServerEvent("produzir-meta","meta-alta")
		
	elseif data == "produzir-meta-cristal" then
		TriggerServerEvent("produzir-meta","meta-cristal")

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)

RegisterNetEvent("kelelaLindo")
AddEventHandler("kelelaLindo", function()
	ToggleActionMenuc()
	onmenuc = false
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000

		for k,v in pairs(prodMachineM) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local prodMachineM = prodMachineM[k]
			local idBancada = prodMachineM[id]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), prodMachineM.x, prodMachineM.y, prodMachineM.z, true ) < 1.2 and not onmenu then
				DrawText3D(prodMachineM.x, prodMachineM.y, prodMachineM.z, "Pressione [~r~E~w~] para acessar a ~r~BANCADA DE METANFETAMINA~w~.")
			end
			if distance <= 5 then
				DrawMarker(23, prodMachineM.x, prodMachineM.y, prodMachineM.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
				idle = 5
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and oC.checkPermissao() then
						ToggleActionMenu()
						onmenu = true
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
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