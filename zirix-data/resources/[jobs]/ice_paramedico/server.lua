local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("ice_paramedico",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"dmla.permissao")
end

function emP.checkPayment(payment)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveMoney(user_id,parseInt(math.random(250,300)*payment))
	end
end