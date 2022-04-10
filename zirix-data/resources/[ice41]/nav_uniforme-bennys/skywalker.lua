local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

Bennys = {}
Tunnel.bindInterface("nav_uniforme-bennys",Bennys)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ROUPAS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local trabalhador = {
    [1885233650] = {
        [1] = { -1,0 }, -- Mascara
        [3] = { 17,0 }, -- Maos
        [4] = { 39,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 24,0 }, -- Sapato
        [7] = { -1,0 }, -- Acessorios			
        [8] = { 90,0 }, -- Camisa
        [9] = { -1,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 66,0 }, -- Jaqueta
        ["p0"] = { -1,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { -1,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    },
    [-1667301416] = {
        [1] = { -1,0 }, -- Mascara
        [3] = { 23,0 }, -- Maos
        [4] = { 38,0,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 24,0 }, -- Sapato
        [7] = { -1,0 },	-- Acessorios		
        [8] = { 54,0 }, -- Camisa
        [9] = { -1,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 59,0 }, -- Jaqueta		
        ["p0"] = { -1,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { -1,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    }
}

local boss = {
    [1885233650] = {
        [1] = { -1,0 }, -- Mascara
        [3] = { 30,0 }, -- Maos
        [4] = { 39,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 7,6 }, -- Sapato
        [7] = { -1,0 }, -- Acessorios			
        [8] = { 89,0 }, -- Camisa
        [9] = { -1,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 63,0 }, -- Jaqueta
        ["p0"] = { -1,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { 1,0 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    },
    [-1667301416] = {
        [1] = { -1,0 }, -- Mascara
        [3] = { 14,0 }, -- Maos
        [4] = { 38,0 }, -- Calça
        [5] = { -1,0 }, -- Mochila
        [6] = { 25,0 }, -- Sapato
        [7] = { 0,0 },	-- Acessorios		
        [8] = { 56,0 }, -- Camisa
        [9] = { -1,0 }, -- Colete
        [10] = { -1,0 }, -- Adesivo
        [11] = { 56,0 }, -- Jaqueta		
        ["p0"] = { -1,0 }, -- Chapeu
        ["p1"] = { -1,0 }, -- Oculos
        ["p2"] = { -1,0 }, -- Orelhas
        ["p6"] = { 3,1 }, -- Braço Esquerdo
        ["p7"] = { -1,0 } -- Braço Direito
    }
}

RegisterServerEvent("trabalhador")
AddEventHandler("trabalhador",function()
    local user_id = vRP.getUserId(source)
    local custom = trabalhador
    if custom then
        local old_custom = vRPclient.getCustomization(source)
        local idle_copy = {}

        idle_copy = vRP.save_idle_custom(source,old_custom)
        idle_copy.modelhash = nil

        for l,w in pairs(custom[old_custom.modelhash]) do
            idle_copy[l] = w
        end
        vRPclient._setCustomization(source,idle_copy)
    end
end)

RegisterServerEvent("boss")
AddEventHandler("boss",function()
    local user_id = vRP.getUserId(source)
    local custom = boss
    if custom then
        local old_custom = vRPclient.getCustomization(source)
        local idle_copy = {}

        idle_copy = vRP.save_idle_custom(source,old_custom)
        idle_copy.modelhash = nil

        for l,w in pairs(custom[old_custom.modelhash]) do
            idle_copy[l] = w
        end
        vRPclient._setCustomization(source,idle_copy)
    end
end)

RegisterServerEvent("tirar-uniforme")
AddEventHandler("tirar-uniforme",function()
    local user_id = vRP.getUserId(source)
    vRP.removeCloak(source)
end)

function Bennys.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"bennys.permissao") or vRP.hasPermission(user_id,"paisana-bennys.permissao") then
        return true
	end
end