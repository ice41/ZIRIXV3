----------------------------------------------------------------------------------------------
--ShowROOM ICE41
----------------------------------------------------------------------------------------------
--local heading = 72.27
local vehicle1 = nil
local vehicle2 = nil
local vehicle3 = nil

Citizen.CreateThread(function()
	while true do
	local heading = 36.20
		Citizen.Wait(10)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -54.79, -1097.0, 26.59, true) < 40 then
			if DoesEntityExist(vehicle1) == false then
				RequestModel(GetHashKey('bora'))
				while not HasModelLoaded(GetHashKey('bora')) do
					Wait(1)
				end
				vehicle1 = CreateVehicle(GetHashKey('bora'), -54.79, -1097.0, 26.59, heading, false, false)
				FreezeEntityPosition(vehicle1, true)
				SetEntityInvincible(vehicle1, true)
				SetEntityCoords(vehicle1, -54.79, -1097.0, 26.59, false, false, false, true)
			else
				SetEntityHeading(vehicle1, heading)
				heading = heading +0.1
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		if vehicle1 ~= nil and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -54.79, -1097.0, 26.59, true) < 40 then
			SetEntityCoords(vehicle1, -54.79, -1097.0, 26.59, false, false, false, true)
		end
	end
end)
------------------------------------------------------------------------------------------------------------
-- vehicle2
Citizen.CreateThread(function()
	while true do
	local heading = 38.83
		Citizen.Wait(10)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -49.52, -1084.16, 27.31, true) < 40 then
			if DoesEntityExist(vehicle2) == false then
				RequestModel(GetHashKey('santa'))
				while not HasModelLoaded(GetHashKey('santa')) do
					Wait(1)
				end
				vehicle2 = CreateVehicle(GetHashKey('santa'), -49.52, -1084.16, 27.31, heading, false, false)
				FreezeEntityPosition(vehicle2, true)
				SetEntityInvincible(vehicle2, true)
				SetEntityCoords(vehicle2, -49.52, -1084.16, 27.31, false, false, false, true)
			else
				SetEntityHeading(vehicle2, heading)
				heading = heading +0.1
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		if vehicle2 ~= nil and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -49.52, -1084.16, 27.31, true) < 40 then
			SetEntityCoords(vehicle2, -49.52, -1084.16, 27.31, false, false, false, true)
		end
	end
end)
