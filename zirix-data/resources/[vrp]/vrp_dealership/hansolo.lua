-- [https://ice41.pt ]--

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONEXÃO ]----------------------------------------------------------------------------------------------------------------------------

src = {}
Tunnel.bindInterface("vrp_dealership",src)
vSERVER = Tunnel.getInterface("vrp_dealership")

--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------

local dealerOpen = false
local vehicle = {}
local pointspawn = 1

--[ DEALERS ]----------------------------------------------------------------------------------------------------------------------------

local dealers = {
	{ ['x'] = -56.64, ['y'] = -1096.91, ['z'] = 26.43 }
}

local spawn = {
	{ ['x'] = -27.5, ['y'] = -1081.94, ['z'] = 26.64, ['h'] = 70.32 }
}
--[ OPEN DEALER ]------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for k,v in pairs(dealers) do
				local distance = Vdist(x,y,z,v.x,v.y,v.z)
				if distance < 10.5 then
					idle = 5
					DrawMarker(23,v.x,v.y,v.z-0.98,0,0,0,0,0,0,0.7,0.7,0.5, 255, 255, 255, 180,0,0,0,0)
					if distance <= 1.5 and IsControlJustPressed(0,38) then
						SetNuiFocus(true,true)
						SendNUIMessage({ action = "showMenu" })
						dealerOpen = true
						vRP._CarregarObjeto("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a","idle_b","prop_cs_tablet",49,28422)
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

function src.buyRent(vehname)
	if vehicle[vehname] == nil then
		local mhash = GetHashKey(vehname)
		local player = GetPlayerFromServerId(k)
		local ped = GetPlayerPed(player)
		local checkslot = 1
		while not HasModelLoaded(mhash) do
			RequestModel(mhash)
			Citizen.Wait(1)
		end
			if HasModelLoaded(mhash) then
				while true do
					local checkPos = GetClosestVehicle(spawn[checkslot].x,spawn[checkslot].y,spawn[checkslot].z,3.001,0,71)
					if DoesEntityExist(checkPos) and checkPos ~= nil then
						checkslot = checkslot + 1
						if checkslot > #spawn then
							checkslot = -1
							TriggerEvent("Notify","importante","Todas as vagas estão ocupadas no momento.",10000)
							break
						end
					else
						break
					end
					Citizen.Wait(10)
				end
				SetNuiFocus(false,false)
				SendNUIMessage({ action = "hideMenu" })
				dealerOpen = false
				vRP._DeletarObjeto()
				vRP._stopAnim(false)

				while not HasModelLoaded(mhash) do
					RequestModel(mhash)
					Citizen.Wait(1)
				end

				if checkslot ~= -1 then
				local nveh = CreateVehicle(mhash,spawn[checkslot].x,spawn[checkslot].y,spawn[checkslot].z+0.5,spawn[checkslot].h,true,false)
				local netveh = VehToNet(nveh)
				local id = NetworkGetNetworkIdFromEntity(nveh)

				NetworkRegisterEntityAsNetworked(nveh)
				while not NetworkGetEntityIsNetworked(nveh) do
					NetworkRegisterEntityAsNetworked(nveh)
					Citizen.Wait(1)
				end
			
				if NetworkDoesNetworkIdExist(netveh) then
					SetEntitySomething(nveh,true)
					if NetworkGetEntityIsNetworked(nveh) then
					SetNetworkIdExistsOnAllMachines(netveh,true)
					end
				end
			
				SetNetworkIdCanMigrate(id,true) 
				SetPedIntoVehicle(ped,nveh,-1) 

				SetVehicleIsStolen(nveh,false)
				SetVehicleNeedsToBeHotwired(nveh,false)
				SetVehicleOnGroundProperly(nveh)
				SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber())
				SetEntityAsMissionEntity(nveh,true,true)
				SetVehRadioStation(nveh,"OFF")
				
				SetVehicleDoorsLocked(nveh,true)
				SetVehicleDoorsLockedForAllPlayers(nveh,true)

				TriggerEvent("Notify","importante","Seu test drive começou, ir ate o veículo.")

				SetTimeout(180000,function()
					DeleteVehicle(nveh)
				end)

				TriggerEvent("Notify","importante","Tem 3 minutos para realizar o seu test drive.")
				Wait(60000)
				TriggerEvent("Notify","importante","Faltam 2 minutos para encerrar o seu test drive.")
				Wait(60000)
				TriggerEvent("Notify","importante","Faltam 1 minuto para encerrar seu test drive.")
				Wait(60000)
				TriggerEvent("Notify","importante","O seu test drive chegou ao fim!")

			end
		end
	end
	return false
end

--[ STARTFOCUS ]-------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)

--[ DEALERCLOSE ]------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("dealerClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	dealerOpen = false
	vRP._DeletarObjeto()
	vRP._stopAnim(false)
end)

--[ REQUESTCARROS ]----------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("requestCarros",function(data,cb)
	local veiculos = vSERVER.Carros()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)

--[ REQUESTMOTOS ]------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("requestMotos",function(data,cb)
	local veiculos = vSERVER.Motos()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)

--[ REQUESTIMPORT ]----------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("requestImport",function(data,cb)
	local veiculos = vSERVER.Import()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)

--[ REQUESTExclusive ]----------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestExclusive",function(data,cb)
	local veiculos = vSERVER.exclusive()
	if veiculos then
		cb({ veiculos = exclusive })
	end
end)

--[ BUYDEALER ]---------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("buyDealer",function(data)
	if data.name ~= nil then
		vSERVER.buyDealer(data.name)
	end
end)

--[ RENT ]---------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("buyRents",function(data)
	if data.name ~= nil then
		vSERVER.buyRents(data.name,parseInt(pointspawn))
	end
end)

--[ ADDESTOQUE ]---------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("addEstoque",function(data)
	if data.name ~= nil then
		vSERVER.addEstoque(data.name)
	end
end)

--[ AUTO-UPDATE ]------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("dealership:Update")
AddEventHandler("dealership:Update",function(action)
	SendNUIMessage({ action = action })
end)
----------------------------------------------------------------------------------------------
--ShowROOM
----------------------------------------------------------------------------------------------
--local heading = 72.27
local vehicle1 = nil
local vehicle2 = nil
local vehicle3 = nil

Citizen.CreateThread(function()
	while true do
	local heading = 180.27
		Citizen.Wait(10)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -48.7, -1098.57, 26.43, true) < 40 then
			if DoesEntityExist(vehicle1) == false then
				RequestModel(GetHashKey('elegy'))
				while not HasModelLoaded(GetHashKey('elegy')) do
					Wait(1)
				end
				vehicle1 = CreateVehicle(GetHashKey('elegy'), -48.7, -1098.57, 26.43, heading, false, false)
				FreezeEntityPosition(vehicle1, true)
				SetEntityInvincible(vehicle1, true)
				SetEntityCoords(vehicle1, -48.7, -1098.57, 26.43, false, false, false, true)
			else
				SetEntityHeading(vehicle1, heading)
				heading = heading
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		if vehicle1 ~= nil and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -48.7, -1098.57, 26.43, true) < 40 then
			SetEntityCoords(vehicle1, -48.7, -1098.57, 26.43, false, false, false, true)
		end
	end
end)
------------------------------------------------------------------------------------------------------------
-- vehicle2
Citizen.CreateThread(function()
	while true do
	local heading = 180.27
		Citizen.Wait(10)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -44.23, -1099.33, 26.43, true) < 40 then
			if DoesEntityExist(vehicle2) == false then
				RequestModel(GetHashKey('ferrariitalia'))
				while not HasModelLoaded(GetHashKey('ferrariitalia')) do
					Wait(1)
				end
				vehicle2 = CreateVehicle(GetHashKey('ferrariitalia'), -44.23, -1099.33, 26.43, heading, false, false)
				FreezeEntityPosition(vehicle2, true)
				SetEntityInvincible(vehicle2, true)
				SetEntityCoords(vehicle2, -44.23, -1099.33, 26.43, false, false, false, true)
			else
				SetEntityHeading(vehicle2, heading)
				heading = heading
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		if vehicle2 ~= nil and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -44.23, -1099.33, 26.43, true) < 40 then
			SetEntityCoords(vehicle2, -44.23, -1099.33, 26.43, false, false, false, true)
		end
	end
end)
------------------------------------------------------------------------------------------------------------
-- vehicle3
Citizen.CreateThread(function()
	while true do
	local heading = 180.27
		Citizen.Wait(10)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -40.39, -1099.01, 26.43, true) < 40 then
			if DoesEntityExist(vehicle3) == false then
				RequestModel(GetHashKey('zentorno'))
				while not HasModelLoaded(GetHashKey('zentorno')) do
					Wait(1)
				end
				vehicle3 = CreateVehicle(GetHashKey('zentorno'), -40.39, -1099.01, 26.43, heading, false, false)
				FreezeEntityPosition(vehicle3, true)
				SetEntityInvincible(vehicle3, true)
				SetEntityCoords(vehicle3, -40.39, -1099.01, 26.43, false, false, false, true)
			else
				SetEntityHeading(vehicle3, heading)
				heading = heading
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		if vehicle3 ~= nil and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -40.39, -1099.01, 26.43, true) < 40 then
			SetEntityCoords(vehicle3, -40.39, -1099.01, 26.43, false, false, false, true)
		end
	end
end)