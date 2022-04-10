local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
func = Tunnel.getInterface("ice_costura")
vRP = Proxy.getInterface("vRP")

function drawTxt(text, font, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu(type)
    menuactive = not menuactive
    if menuactive then
        SetNuiFocus(true, true)
        SendNUIMessage({showmenu = true, type = type})
    else
        SetNuiFocus(false)
        SendNUIMessage({hidemenu = true})
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS DA COSTURA
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
   {x = 718.82, y = -962.47, z = 30.39, type = "costura"},
   {x = 716.27, y = -962.39, z = 30.39, type = "costura"},
   {x = 713.93, y = -959.95, z = 30.39, type = "costura"},
   {x = 718.96, y = -960.07, z = 30.39, type = "costura"},
   {x = 716.47, y = -960.04, z = 30.39, type = "costura"},
   {x = 707.23, y = -966.95, z = 30.42, type = "ilegal"},
}
Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    menuactive = false
    TriggerEvent("animacao", source, false)
    while true do
        Citizen.Wait(1)
        for i, item in pairs(locais) do
            local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), item.x, item.y,item.z, true)
				if distance <= 10 and not menuactive then  
				   DrawMarker(25,item.x,item.y,item.z-0.9,0,0,0,0,180.0,130.0,1.0,1.0,1.0,199,0,0,30,0,0,0,1)
				   if distance <=1.3 then
					  drawTxt("PRESSIONE ~b~E~w~ PARA ABRIR O MENU", 4, 0.5, 0.91,0.50, 255, 255, 255, 180)
					  if IsControlJustPressed(0, 38) and func.checkPermission() then
						 -- if item.type == "triad" and func.checkPermission() then
							   ToggleActionMenu(item.type)
						  --else
							--   ToggleActionMenu(item.type)
							
						 --end
					  end

				   end
				end
        end
    end
end)

RegisterNUICallback("ButtonClick", function(data, cb)
    if data == "fechar" then
        ToggleActionMenu()
    else
        TriggerServerEvent("costura-comprar", data)
    end
end)

RegisterNetEvent('costura_fabricar:fecharMenu')
AddEventHandler('costura_fabricar:fecharMenu', function() ToggleActionMenu() end)

RegisterNetEvent('costura_fabricar:animacao')
AddEventHandler('costura_fabricar:animacao', function(isPlay)
    if isPlay then
        TriggerEvent('cancelando', true)
        vRP._playAnim(false, {
            {"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}
        }, true)
    else
        TriggerEvent('cancelando', false)
        ClearPedTasks(PlayerPedId())
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end
