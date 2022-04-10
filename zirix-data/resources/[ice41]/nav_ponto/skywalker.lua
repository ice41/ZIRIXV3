local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

PPonto ={}
Bennys = {}
Emergencia = {}
Police = {}
Tunnel.bindInterface("nav_ponto",PPonto,Bennys,Emergencia,Police)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ WEBHOOK ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local BennysPonto = "https://discord.com/api/webhooks/840297225690939443/dhQw3L9yeC5nkHZ2XZZgakcHvBgsU0Rs3wgRUSPBYL6cuQCliPU0tg32dnu9CQYlRcYm"
local resgatePonto = "https://discord.com/api/webhooks/944016464573243422/ZD4OLjafi0vfewo0EiMbpczguzhENukGa0xZFSrhqhtIihZa9jHbV20nfcryBfZWU4vJ"
local policiaPonto = "https://discord.com/api/webhooks/758376750441955369/8VmdhrZq4ydVbBI6c5aoYQ1LMf12eoRj22DhLhNz4zxTN6L31rGZYCXcSNwGqQ4GUsZN"
-----------------------------------------------------------------------------------------------------------------------------------------
--[ PONTO ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("entrar-servico")
AddEventHandler("entrar-servico",function()
    local user_id = vRP.getUserId(source)
	
	if vRP.hasPermission(user_id,"paisana-bennys.permissao") then
		if vRP.hasPermission(user_id,"bennys.permissao") then
			TriggerClientEvent("Notify",source,"negado","Já está em serviço.")
		else
			vRP.addUserGroup(user_id,"bennys")
			TriggerClientEvent("Notify",source,"sucesso","Entrou em serviço.")
			logEntradaServicoB()
		end
	elseif vRP.hasPermission(user_id,"paisana-ems.permissao") then
		if vRP.hasPermission(user_id,"ems.permissao") then
			TriggerClientEvent("Notify",source,"negado","Já está em serviço.")
		else
			vRP.addUserGroup(user_id,"ems")
			TriggerClientEvent("Notify",source,"sucesso","Entrou em serviço.")
			logEntradaServicoM()
		end
	elseif vRP.hasPermission(user_id,"paisana-policia.permissao") then
		if vRP.hasPermission(user_id,"policia.permissao") then
			TriggerClientEvent("Notify",source,"negado","Já está em serviço.")
		else
			vRP.addUserGroup(user_id,"policia")
			TriggerClientEvent("Notify",source,"sucesso","Entrou em serviço.")
			logEntradaServicoP()
		end
	end
	
end)

RegisterServerEvent("sair-servico")
AddEventHandler("sair-servico",function()
    local user_id = vRP.getUserId(source)
	if  vRP.hasPermission(user_id,"bennys.permissao") then
		if vRP.hasPermission(user_id,"paisana-bennys.permissao") then
			TriggerClientEvent("Notify",source,"negado","Já está fora de serviço.")
		else
			vRP.addUserGroup(user_id,"paisana-bennys")
			TriggerClientEvent("Notify",source,"sucesso","Saiu de serviço.")
			logSaidaServicoB()
		end
	elseif  vRP.hasPermission(user_id,"ems.permissao")  then
		if vRP.hasPermission(user_id,"paisana-ems.permissao") then
			TriggerClientEvent("Notify",source,"negado","Já está fora de serviço.")
		else
			vRP.addUserGroup(user_id,"paisana-ems")
			TriggerClientEvent("Notify",source,"sucesso","Saiu de serviço.")
			logSaidaServicoM()
		end
	elseif vRP.hasPermission(user_id,"policia.permissao") then
		if vRP.hasPermission(user_id,"paisana-policia.permissao") then
			TriggerClientEvent("Notify",source,"negado","Já está fora de serviço.")
		else
			vRP.addUserGroup(user_id,"paisana-policia")
			TriggerClientEvent("Notify",source,"sucesso","Saiu de serviço.")
			logSaidaServicoP()
		end
	
	end
end)

-------[[Bennys log discord]]-----------------------------------
function logEntradaServicoB()
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    PerformHttpRequest(BennysPonto, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." entrou em serviço.", description = "Registro de Ponto Bennys de cdd Perdida. Registro de entrada em serviço.\n⠀", thumbnail = {url = "https://i.imgur.com/vtzgW95.png"}, fields = {{ name = "**Nome do Trabalhador:**", value = "` "..identity.name.." "..identity.firstname.." ` " },{ name = "**Nº Passaporte:**", value = "` "..user_id.." `\n⠀" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/vtzgW95.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
end

function logSaidaServicoB()
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    PerformHttpRequest(BennysPonto, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." saiu de serviço.", description = "Registro de Ponto Bennys de cdd Perdida. Registro de saída de serviço.\n⠀", thumbnail = {url = "https://i.imgur.com/vtzgW95.png"}, fields = {{ name = "**Nome do Trabalhador:**", value = "` "..identity.name.." "..identity.firstname.." ` " },{ name = "**Nº Passaporte:**", value = "` "..user_id.." `\n⠀" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/vtzgW95.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
end
---------[[Emergencia log discord]]-----------------------------

function logEntradaServicoM()
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    PerformHttpRequest(resgatePonto, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." entrou em serviço.", description = "Registro de Ponto do Departamento Médico de cdd Perdida. Registro de entrada em serviço.\n⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Nome do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ` " },{ name = "**Nº Passaporte:**", value = "` "..user_id.." `\n⠀" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
end

function logSaidaServicoM()
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    PerformHttpRequest(resgatePonto, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." saiu de serviço.", description = "Registro de Ponto do Departamento Médico de cdd Perdida. Registro de saída de serviço.\n⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Nome do Colaborador:**", value = "` "..identity.name.." "..identity.firstname.." ` " },{ name = "**Nº Passaporte:**", value = "` "..user_id.." `\n⠀" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
end
---------[[Policia log discord]]-----------------------------
function logEntradaServicoP()
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    PerformHttpRequest(policiaPonto, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." entrou em serviço.", description = "Registro de Ponto do Departamento de Polícia de cdd Perdida. Registro de entrada em serviço.\n⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Nome do Agente:**", value = "` "..identity.name.." "..identity.firstname.." ` " },{ name = "**Nº Passaporte:**", value = "` "..user_id.." `\n⠀" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
end

function logSaidaServicoP()
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    PerformHttpRequest(policiaPonto, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." saiu de serviço.", description = "Registro de Ponto do Departamento de Polícia de cdd Perdida. Registro de saída de serviço.\n⠀", thumbnail = {url = "https://i.imgur.com/jSXFScq.png"}, fields = {{ name = "**Nome do Agente:**", value = "` "..identity.name.." "..identity.firstname.." ` " },{ name = "**Nº Passaporte:**", value = "` "..user_id.." `\n⠀" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/jSXFScq.png" },color = 15906321 }}}), { ['Content-Type'] = 'application/json' })
end

---------[[Check de permissões]]-----------------------------
function PPonto.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"bennys.permissao") or vRP.hasPermission(user_id,"bennys.permissao") or vRP.hasPermission(user_id,"paisana-bennys.permissao") or vRP.hasPermission(user_id,"ems.permissao") or vRP.hasPermission(user_id,"paisana-ems.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paisana-policia.permissao") then
        return true
	end
end

function Bennys.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"bennys.permissao") or vRP.hasPermission(user_id,"paisana-bennys.permissao") then
        return true
	end
end

function Emergencia.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"ems.permissao") or vRP.hasPermission(user_id,"paisana-emsems.permissao") then
        return true
	end
end
function Police.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paisana-policia.permissao") then
        return true
	end
end
