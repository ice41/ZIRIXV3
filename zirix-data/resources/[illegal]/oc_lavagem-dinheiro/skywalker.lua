local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local lavado_yakuza = false
local lavado_bratva = false
local valor_yakuza = 0
local valor_bratva = 0
local comecouLavagem_yakuza=false
local comecouLavagem_bratva=false
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------
--[ CONEXÕES ]---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
oC = {}
Tunnel.bindInterface("oc_lavagem-dinheiro",oC)
-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÕES ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
function oC.lavagemDinheiro_yakuza()
    local source = source
    local user_id = vRP.getUserId(source)
	
	
	if comecouLavagem_yakuza then
		return TriggerClientEvent("Notify",source,"negado","Tem de esperar a lavagem atual terminar")
	else
		if lavado_yakuza then
			return TriggerClientEvent("Notify",source,"negado","Recolha o dinheiro da maquina de lavar")
		else
			valor_yakuza = vRP.prompt(source,"Quanto dinheiro deseja lavar:","")
		end
	end
	
	
    --local banco = vRP.getBankMoney(user_id)

    if valor_yakuza == "" then 
        return TriggerClientEvent("Notify",source,"negado","Precisa colocar um valor para confirmar sua solicitação.")
    end
	
	if parseInt(valor_yakuza) <=999 then
		valor_yakuza = 0
		return TriggerClientEvent("Notify",source,"negado","Dinheiro sujo inferior a 1000, Cancelado")
	else
		TriggerClientEvent("Notify",source,"sucesso","Lavagem iniciada.")
	end
	

    if vRP.getInventoryItemAmount(user_id,"dinheiro-sujo") >= parseInt(valor_yakuza) then

        TriggerClientEvent("progress",source,10000,"LAVANDO DINHEIRO")
        --TriggerClientEvent("lavagem-dinheiro:posicao",source)
        --vRPclient._playAnim(source,false,{{"anim@heists@prison_heistig1_p1_guard_checks_bus","loop"}},true)
        vRP.tryGetInventoryItem(user_id,"dinheiro-sujo",parseInt(valor_yakuza))
		
		comecouLavagem_yakuza = true
		
        SetTimeout(10000,function()
            --vRPclient._stopAnim(source,false)
            --vRP.giveMoney(user_id,valor*0.9)
            --TriggerClientEvent("Notify",source,"sucesso","Lavou <b>€"..valor.."</b> Euros.")
			lavado_yakuza=true
			comecouLavagem_yakuza=false
			TriggerClientEvent("Notify",source,"sucesso","Recolha o dinheiro!")
			
        end)
    else
        TriggerClientEvent("Notify",source,"negado","Não tem <b>dinheiro sujo</b> suficiente na mochila.")
    end
end


function oC.getDinheiro_yakuza()

	local user_id = vRP.getUserId(source)
	if lavado_yakuza then
		if valor_yakuza < 50000 then
			local liquido = 0.9 -- Ele só recebe 90%
		else
			local liquido = 0.93 -- Ele só recebe 93%
		end
		
		vRP.giveMoney(user_id,parseInt(valor_yakuza*liquido))
		TriggerClientEvent("Notify",source,"sucesso","Lavou <b>€"..(valor_yakuza*liquido).."</b> Euros.")
		lavado_yakuza=false
		valor_yakuza=0
		return true
	else
		if comecouLavagem_yakuza then
			return TriggerClientEvent("Notify",source,"negado","Tem de esperar que o dinheiro-sujo lave ")
		else
			return TriggerClientEvent("Notify",source,"negado","Tem de colocar o dinheiro a lavar primeiro")
		end
	end
end


function oC.lavagemDinheiro_bratva()
    local source = source
    local user_id = vRP.getUserId(source)
	
	
	if comecouLavagem_bratva then
		return TriggerClientEvent("Notify",source,"negado","Tem de esperar a lavagem atual terminar")
	else
		if lavado_bratva then
			return TriggerClientEvent("Notify",source,"negado","Recolha o dinheiro da maquina de lavar")
		else
			valor_bratva = vRP.prompt(source,"Quanto dinheiro deseja lavar:","")
		end
	end
	
	
    --local banco = vRP.getBankMoney(user_id)

    if valor_bratva == "" then 
        return TriggerClientEvent("Notify",source,"negado","Precisa colocar um valor para confirmar sua solicitação.")
    end
	
	if parseInt(valor_bratva) <=999 then
		valor_bratva = 0
		return TriggerClientEvent("Notify",source,"negado","Dinheiro sujo inferior a 1000, Cancelado")
	else
		TriggerClientEvent("Notify",source,"sucesso","Lavagem iniciada.")
	end
	

    if vRP.getInventoryItemAmount(user_id,"dinheiro-sujo") >= parseInt(valor_bratva) then

        TriggerClientEvent("progress",source,10000,"LAVANDO DINHEIRO")
        --TriggerClientEvent("lavagem-dinheiro:posicao",source)
        --vRPclient._playAnim(source,false,{{"anim@heists@prison_heistig1_p1_guard_checks_bus","loop"}},true)
        vRP.tryGetInventoryItem(user_id,"dinheiro-sujo",parseInt(valor_bratva))
		
		comecouLavagem_bratva = true
		
        SetTimeout(10000,function()
            --vRPclient._stopAnim(source,false)
            --vRP.giveMoney(user_id,valor*0.9)
            --TriggerClientEvent("Notify",source,"sucesso","Lavou <b>€"..valor.."</b> Euros.")
			lavado_bratva=true
			comecouLavagem_bratva=false
			TriggerClientEvent("Notify",source,"sucesso","Recolha o dinheiro!")
			
        end)
    else
        TriggerClientEvent("Notify",source,"negado","Não tem <b>dinheiro sujo</b> suficiente na mochila.")
    end
end


function oC.getDinheiro_bratva()
	
	local user_id = vRP.getUserId(source)
	if lavado_bratva then
		if valor_bratva < 50000 then
			local liquido = 0.90 -- Ele só recebe 90% Valor bruto 100.. valor liquido é 90%
		else
			local liquido = 0.93 -- Ele só recebe 93%
		end
		vRP.giveMoney(user_id,parseInt(valor_bratva*liquido))
		TriggerClientEvent("Notify",source,"sucesso","Lavou <b>€"..(valor_bratva*liquido).."</b> Euros.")
		lavado_bratva=false
		valor_bratva=0 -- resset da maquina de lavar
		return true
	else
		if comecouLavagem_bratva then
			return TriggerClientEvent("Notify",source,"negado","Tem de esperar que o dinheiro-sujo lave ")
		else
			return TriggerClientEvent("Notify",source,"negado","Tem de colocar o dinheiro a lavar primeiro")
		end
	end
end

function oC.checkPermissao_yakuza()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id,"yakuza.permissao") or vRP.hasPermission(user_id,"diretor-yakuza.permissao") then
        return true
    end
end

function oC.checkPermissao_bratva()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id,"lider-bratva") or vRP.hasPermission(user_id,"bratva.permissao") then
        return true
    end
end