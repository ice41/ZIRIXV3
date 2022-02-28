local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

oC = Tunnel.getInterface("oc_producao-coca")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodMachineC = {
	{ ['x'] = -1106.51, ['y'] = 4951.13, ['z'] = 218.65 },
	--{ ['x'] = -1108.2, ['y'] = 4946.39, ['z'] = 218.65 }
	-- -1106.51, 4951.13, 218.65
}
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false
local onmenuc = false

function ToggleActionMenuc()
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
	if data == "produzir-pasta-alta" then
		TriggerServerEvent("produzir-coca","pasta-alta")

	elseif data == "produzir-coca-alta" then
		TriggerServerEvent("produzir-coca","coca-alta")

	elseif data == "produzir-coca-media" then
		TriggerServerEvent("produzir-coca","coca-media")

	elseif data == "produzir-coca-baixa" then
		TriggerServerEvent("produzir-coca","coca-baixa")

	elseif data == "produzir-leite-po" then
		TriggerServerEvent("produzir-coca","leite-po")

	elseif data == "fechar" then
		ToggleActionMenuc()
		onmenuc = false
	end
end)


RegisterNetEvent("kelelaLindo-coca")
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

		for k,v in pairs(prodMachineC) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local prodMachineC = prodMachineC[k]
			--local idBancada = prodMachineC[id]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), prodMachineC.x, prodMachineC.y, prodMachineC.z, true ) < 1.2 and not onmenu then
				DrawText3D(prodMachineC.x, prodMachineC.y, prodMachineC.z, "Pressione [~r~E~w~] para acessar a ~r~BANCADA DE COCAINA~w~.")
			end
			if distance <= 5 then
				DrawMarker(23, prodMachineC.x, prodMachineC.y, prodMachineC.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
				idle = 5
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and oC.checkPermissao() then
						ToggleActionMenuc()
						onmenuc = true
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