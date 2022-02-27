-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_dealership",src)
vSERVER = Tunnel.getInterface("vrp_dealership")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local dealerOpen = false
local vehicle = {}
local pointspawn = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEALERS
-----------------------------------------------------------------------------------------------------------------------------------------
local dealers = {
	--{ ['x'] = -1165.89, ['y'] = -1723.67, ['z'] = 11.8 }, -- -1165.89,-1723.67,11.8
	--{ ['x'] = -1173.57, ['y'] = -1728.99, ['z'] = 11.8 }, -- -1173.57,-1728.99,11.8
	{ ['x'] = -30.03, ['y'] = -1104.67, ['z'] = 26.42 }, -- -30.03,-1104.67,26.42 concessionaria antiga
	{ ['x'] = -795.63, ['y'] = -220.03, ['z'] = 37.08 }, -- -795.63,-220.03,37.08 stand de carros
}

local spawn = {
	{ ['x'] = -774.68, ['y'] = -232.67, ['z'] = 37.08, ['h'] = 207.38 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN DEALER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for k,v in pairs(dealers) do
				local distance = Vdist(x,y,z,v.x,v.y,v.z)
				if distance <= 10.5 then
					--DrawMarker(21,v.x,v.y,v.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
					DrawMarker(29,v.x,v.y,v.z,0,0,0,0,0,0,1.0,1.0,1.0,199,0,0,50,1,30,30,30)
					DrawMarker(27,v.x,v.y,v.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,199,0,0,20,0,0,0,0)
					if distance <= 1.5 and IsControlJustPressed(0,38) then
						SetNuiFocus(true,true)
						SendNUIMessage({ action = "showMenu" })
						dealerOpen = true
						vRP._CarregarObjeto("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a","idle_b","prop_cs_tablet",49,28422)
					end
				end
			end
		end
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

				TriggerEvent("Notify","importante","Tem 3 minutos para realizar seu test drive.")
				Wait(60000)
				TriggerEvent("Notify","importante","Faltam 2 minutos para encerrar seus test drive.")
				Wait(60000)
				TriggerEvent("Notify","importante","Faltam 1 minuto para encerrar seus test drive.")
				Wait(60000)
				TriggerEvent("Notify","importante","O seu test drive chegou ao fim!")

			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEALERCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dealerClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	dealerOpen = false
	vRP._DeletarObjeto()
	vRP._stopAnim(false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCARROS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCarros",function(data,cb)
	local veiculos = vSERVER.Carros()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMOTOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMotos",function(data,cb)
	local veiculos = vSERVER.Motos()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTIMPORT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestImport",function(data,cb)
	local veiculos = vSERVER.Import()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTExclusive
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestExclusive",function(data,cb)
	local veiculos = vSERVER.Exclusive()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPOSSUIDOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestPossuidos",function(data,cb)
	local veiculos = vSERVER.Possuidos()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUYDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
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

-----------------------------------------------------------------------------------------------------------------------------------------
-- SELLDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sellDealer",function(data)
	if data.name ~= nil then
		vSERVER.sellDealer(data.name)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
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
	local heading = 72.27
		Citizen.Wait(10)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -786.11, -245.02, 36.08, true) < 40 then
			if DoesEntityExist(vehicle1) == false then
				RequestModel(GetHashKey('fordmustang'))
				while not HasModelLoaded(GetHashKey('fordmustang')) do
					Wait(1)
				end
				vehicle1 = CreateVehicle(GetHashKey('fordmustang'), -786.11, -245.02, 36.08, heading, false, false)
				FreezeEntityPosition(vehicle1, true)
				SetEntityInvincible(vehicle1, true)
				SetEntityCoords(vehicle1, -786.11, -245.02, 36.08, false, false, false, true)
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
		if vehicle1 ~= nil and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -786.11, -245.02, 36.08, true) < 40 then
			SetEntityCoords(vehicle1, -786.11, -245.02, 36.08, false, false, false, true)
		end
	end
end)
------------------------------------------------------------------------------------------------------------
-- vehicle2
Citizen.CreateThread(function()
	while true do
	local heading = 72.27
		Citizen.Wait(10)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -789.11, -240.34, 36.08, true) < 40 then
			if DoesEntityExist(vehicle2) == false then
				RequestModel(GetHashKey('ferrariitalia'))
				while not HasModelLoaded(GetHashKey('ferrariitalia')) do
					Wait(1)
				end
				vehicle2 = CreateVehicle(GetHashKey('ferrariitalia'), -789.11, -240.34, 36.08, heading, false, false)
				FreezeEntityPosition(vehicle2, true)
				SetEntityInvincible(vehicle2, true)
				SetEntityCoords(vehicle2, -789.11, -240.34, 36.08, false, false, false, true)
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
		if vehicle2 ~= nil and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -789.11, -240.34, 36.08, true) < 40 then
			SetEntityCoords(vehicle2, -789.11, -240.34, 36.08, false, false, false, true)
		end
	end
end)
------------------------------------------------------------------------------------------------------------
-- vehicle3
Citizen.CreateThread(function()
	while true do
	local heading = 98.22
		Citizen.Wait(10)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -783.94, -223.84, 36.33, true) < 40 then
			if DoesEntityExist(vehicle3) == false then
				RequestModel(GetHashKey('zentorno'))
				while not HasModelLoaded(GetHashKey('zentorno')) do
					Wait(1)
				end
				vehicle3 = CreateVehicle(GetHashKey('zentorno'), -783.94, -223.84, 36.33, heading, false, false)
				FreezeEntityPosition(vehicle3, true)
				SetEntityInvincible(vehicle3, true)
				SetEntityCoords(vehicle3, -783.94, -223.84, 36.33, false, false, false, true)
			else
				SetEntityHeading(vehicle3, heading2)
				heading = heading +0.1
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		if vehicle3 ~= nil and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -783.94, -223.84, 36.33, true) < 40 then
			SetEntityCoords(vehicle3, -783.94, -223.84, 36.33, false, false, false, true)
		end
	end
end)