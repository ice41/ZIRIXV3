local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRPclient = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

--[ CONEXÃO ]----------------------------------------------------------------------------------------------------------------------------

porte = {}
Tunnel.bindInterface("nav_porte",porte)

--[ mySQL ]------------------------------------------------------------------------------------------------------------------------------

vRP._prepare("vRP/update_gunlicense","UPDATE vrp_user_identities SET gunlicense = @gunlicense WHERE user_id = @user_id")
vRP._prepare("vRP/get_gunlicense","SELECT user_id FROM vrp_user_identities WHERE gunlicense = @gunlicense")

--[ AÇÃO ]-------------------------------------------------------------------------------------------------------------------------------

function porte.pagamento()
    local source = source
    local user_id = vRP.getUserId(source)
    local preco = 30000

    if preco then
        if vRP.hasPermission(user_id,"bronze.permissao") then
            desconto = math.floor(preco*20/100)
            pagamento = math.floor(preco-desconto)
        elseif vRP.hasPermission(user_id,"prata.permissao") then
            desconto = math.floor(preco*15/100)
            pagamento = math.floor(preco-desconto)
        elseif vRP.hasPermission(user_id,"ouro.permissao") then
            desconto = math.floor(preco*10/100)
            pagamento = math.floor(preco-desconto)
        elseif vRP.hasPermission(user_id,"platina.permissao") then
            desconto = math.floor(preco*5/100)
            pagamento = math.floor(preco-desconto)
        else
            pagamento = math.floor(preco)
        end

        if vRP.getInventoryItemAmount(user_id,"cartaodebito") >= 1 then
            if vRP.tryPayment(user_id,parseInt(pagamento)) then
                TriggerClientEvent("Notify",source,"sucesso","Pagou <b>€"..vRP.format(parseInt(pagamento)).." Euros</b>. <b>em ( Dinheiro )</b>")
                return true
            else
                if vRP.tryDebitPayment(user_id,parseInt(pagamento)) then
                    TriggerClientEvent("Notify",source,"sucesso","Pagou <b>€"..vRP.format(parseInt(pagamento)).." Euros</b> .. <b>No ( Débito )</b>")
                    return true
                else
                    TriggerClientEvent("Notify",source,"negado","Dinheiro & saldo insuficientes.")
                    return false
                end
            end
        else
            if vRP.tryPayment(user_id,parseInt(pagamento)) then
                if preco > 0 then
                    TriggerClientEvent("Notify",source,"sucesso","Pagou <b>€"..vRP.format(parseInt(pagamento)).." Euros</b>. <b>em ( Dinheiro )</b>")
                    return true
                end
            else
                TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
                return false
            end
        end
    end
end

function porte.checkcarlicense()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    if identity.gunlicense  == 0 or identity.gunlicense  == 3 then
        return true
    end
end

function porte.sucessoArma()
    local source = source
    local user_id = vRP.getUserId(source)
    TriggerEvent("arma",1,user_id)
end

RegisterCommand('apreender',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"dpla.permissao") then
        if args[1] == "porte" then
            local nplayer = vRPclient.getNearestPlayer(source,2)
            local nuser_id = user_id
            local identitynu = vRP.getUserIdentity(nuser_id)

            if nplayer then
                TriggerEvent("arma",3,nuser_id)
                TriggerClientEvent("Notify",source,"sucesso","Apreendeu o porte de arma de <b>"..identitynu.name.." "..identitynu.firstname.."</b>.")
                TriggerClientEvent("Notify",nplayer,"negado","O oficial <b>"..identity.name.." "..identity.firstname.."</b> apreendeu o seu porte de arma.")
            else
                TriggerClientEvent("Notify",source,"negado","Não há players por perto.")
            end
        end
    end
end)

RegisterCommand("licenca",function(source,args)
	local source = source
	local identity = vRP.getUserIdentity(user_id)
	local arma = vRP.identity.gunlicense (source,user_id,gunlicense)
	local direito = vRP.identity.direito (source,user_id,direito)
	local piloto = vRP.identity.piloto (source,user_id,piloto)
	local creboque = vRP.identity.creboque (source,user_id,creboque)
	if vRP.hasPermission(user_id,"dpla.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then	
		if nplayer then
			if args[1] == "arma" then
				if cmota == 1 then
					TriggerClientEvent("Notify",source,"importante","Utilizador com Porte de Arma",5000) 
				elseif cmota == 3 then
					TriggerClientEvent("Notify",source,"negado","Porte apreendido",5000) 
				else
					TriggerClientEvent("Notify",source,"importante","Sem Porte de Arma",5000) 
				end
			elseif args[1] == "direito" then
				if direito == 1 then
					TriggerClientEvent("Notify",source,"importante","Utilizador com Licença de direito",5000) 
				elseif direito == 3 then
					TriggerClientEvent("Notify",source,"importante","Licença de direito apreendida",5000) 
				else
					TriggerClientEvent("Notify",source,"importante","Sem Licença de direito",5000) 
				end
			elseif args[1] == "piloto" then
				if piloto == 1 then
					TriggerClientEvent("Notify",source,"importante","Utilizador com carta de Camiao",5000) 
				elseif piloto == 3 then
					TriggerClientEvent("Notify",source,"importante","Carta apreendida",5000) 
				else
					TriggerClientEvent("Notify",source,"importante","Sem carta de Camiao",5000) 
				end
			else
				TriggerEvent("Notify","negado","Sem Porte de Arma")
			end
		end
	end
end)

RegisterServerEvent("arma")
AddEventHandler("arma",function(gunlicense,user_id)
    vRP.execute("vRP/update_gunlicense", {gunlicense = gunlicense, user_id = user_id})
end)

--[[CHECA A LICENÇA DO JOGADOR]]---------------------------------------------------------------------------------------
function porte.checkdireito()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	
	if identity.arma == 1 then
		TriggerClientEvent("Notify",source,"negado","Já tem Licença de Direito.")
		return false
    elseif identity.direito == 0 or identity.direito == 3 then
        return true
    end
end

function porte.checkdireito()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	
	if identity.arma == 1 then
		TriggerClientEvent("Notify",source,"negado","Já tem Licença de Direito.")
		return false
    elseif identity.direito == 0 or identity.direito == 3 then
        return true
    end
end

function porte.givelicense()
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("portearmas") <= vRP.getInventoryMaxWeight(user_id) then
		if vRP.getInventoryItemAmount(user_id,"portearmas") > 0 then
			TriggerClientEvent("Notify",source,"negado","Você já possui uma porte de armas em sua mochila.")
		else
			if vRP.tryPayment(user_id,90) then
				vRP.giveInventoryItem(user_id,"portearmas",1)
				TriggerClientEvent("Notify",source,"sucesso","Sucesso, você adquiriu a segunda via da sua porte de armas por <b>$90 dólares</b>.")
			else
				TriggerClientEvent("Notify",source,"negado","Saldo insuficiente.")
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Sua mochila está cheia.")
	end
end