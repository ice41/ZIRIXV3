----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da CidadePerdida <Ice41>, por favor mantenha os créditos   ]--
--[                     NPED.PT - DarkDEVs Discord: discord.gg/ZTPrPbtaTu                    ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

mtt = {}

vRP.prepare('vRP/vrp_user_identities',
    [[
		
        ALTER `vrp_user_identities`
		ADD IF NOT EXISTS gunlicence int(1) NOT NULL COMMENT 'Porte de armas',
		ADD IF NOT EXISTS direito int(1) NOT NULL COMMENT 'Licenças de Direito',
		ADD IF NOT EXISTS piloto int(1) NOT NULL COMMENT 'licença de Piloto',
		ADD IF NOT EXISTS cmota int(1) NOT NULL COMMENT 'Carta de Mota',
		ADD IF NOT EXISTS ccarro int(1) NOT NULL COMMENT 'Carta de carro',
		ADD IF NOT EXISTS ccamiao int(1) NOT NULL COMMENT 'Carta de camião',
		ADD IF NOT EXISTS creboque int(1) NOT NULL COMMENT 'Carta de reboque';
    ]]
)

Tunnel.bindInterface("nav_carta",mtt)
--[ CAPTURA mySQL ]------------------------------------------------------------------------------------------------------------------------------

vRP._prepare("vRP/update_gunlicense","UPDATE vrp_user_identities SET gunlicense = @gunlicense WHERE user_id = @user_id")
vRP._prepare("vRP/update_direito","UPDATE vrp_user_identities SET direito = @direito WHERE user_id = @user_id")
vRP._prepare("vRP/update_piloto","UPDATE vrp_user_identities SET ccamiao = @ccamiao WHERE user_id = @user_id")

vRP._prepare("vRP/get_gunlicense","SELECT user_id FROM vrp_user_identities WHERE gunlicense = @gunlicense")
vRP._prepare("vRP/get_direito","SELECT user_id FROM vrp_user_identities WHERE direito = @direito")
vRP._prepare("vRP/get_piloto","SELECT user_id FROM vrp_user_identities WHERE ccamiao = @ccamiao")

--[CHECA SE PODE FAZER O PAGAMENTO]-----------------------------------------------------------------------------------------------------

function mtt.pagamento()
    local source = source
    local user_id = vRP.getUserId(source)
    local preco = 600

    if preco then
        if vRP.hasPermission(user_id,"platina.permissao") then
            desconto = math.floor(preco*20/100)
            pagamento = math.floor(preco-desconto)
        elseif vRP.hasPermission(user_id,"ouro.permissao") then
            desconto = math.floor(preco*15/100)
            pagamento = math.floor(preco-desconto)
        elseif vRP.hasPermission(user_id,"prata.permissao") then
            desconto = math.floor(preco*10/100)
            pagamento = math.floor(preco-desconto)
        elseif vRP.hasPermission(user_id,"bronze.permissao") then
            desconto = math.floor(preco*5/100)
            pagamento = math.floor(preco-desconto)
        else
            pagamento = math.floor(preco)
        end

        if vRP.getInventoryItemAmount(user_id,"cartaodebito") >= 1 then
            if vRP.tryPayment(user_id,parseInt(pagamento)) then
                TriggerClientEvent("Notify",source,"sucesso","Pagou <b>€"..vRP.format(parseInt(pagamento)).." Euros</b>. <b>( Dinheiro )</b>")
                return true
            else
                if vRP.tryDebitPayment(user_id,parseInt(pagamento)) then
                    TriggerClientEvent("Notify",source,"sucesso","Pagou <b>€"..vRP.format(parseInt(pagamento)).." Euros</b>. <b>( Débito )</b>")
                    return true
                else
                    TriggerClientEvent("Notify",source,"negado","Dinheiro ou saldo bancario insuficientes.")
                    return false
                end
            end
        else
            if vRP.tryPayment(user_id,parseInt(pagamento)) then
                if preco > 0 then
                    TriggerClientEvent("Notify",source,"sucesso","Pagou <b>€"..vRP.format(parseInt(pagamento)).." Euros</b>. <b>( Dinheiro )</b>")
                    return true
                end
            else
                TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
                return false
            end
        end
    end
end

--[[CHECA A LICENÇA DO JOGADOR]]---------------------------------------------------------------------------------------

function mtt.checkarma()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	
	if identity.gunlicense == 1 then
		TriggerClientEvent("Notify",source,"negado","Já tem Porte de arma.")
		return false
    elseif identity.gunlicense == 0 or identity.gunlicense == 3 then
        return true
    end
end

function mtt.checkdireito()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	
	if	identity.direito == 1 then
		TriggerClientEvent("Notify",source,"negado","Já tem licença de Direito.")
		return false
    elseif identity.direito == 0 or identity.direito == 3 then
        return true
    end
end

function mtt.checkpiloto()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	
	if identity.piloto == 1 then
		TriggerClientEvent("Notify",source,"negado","Já tem licença de pilotagem.")
		return false
    elseif identity.piloto == 0 or identity.piloto == 3 then
        return true
    end
end

--[[FUNÇÃO QUE ADICIONA A CARTA AO PLAYER]]-----------------------------------------------------------------------------

function mtt.arma()
	local user_id = vRP.getUserId(source)
		TriggerEvent("rarma",1,user_id)		
end
function mtt.direito()
	local user_id = vRP.getUserId(source)
		TriggerEvent("rdireito",1,user_id)			
end

function mtt.sspiloto()
	local user_id = vRP.getUserId(source)
	TriggerEvent("rspiloto",1,user_id)			
end

--[[COMANDO PARA POLICIA/JUIZ REMOVER LICENÇA]]-----------------------------------------------------------------------------
--[[ QUANDO O VALOR DA CARTA É 3 A CARTA ESTÁ APREENDIDA ]]-----------------------------------------------------------------------------
--[[ /TIRARCARTA MOTA | /TIRARCARTA CARRO | /TIRARCARTA CAMIAO | /TIRARCARTA REBOQUE ]]-----------------------------------------------------------------------------
RegisterCommand("removerlicenca",function(source,args)
	local source = source
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	local nuser_id = vRP.getUserId(nplayer)
	local identitynu = vRP.getUserIdentity(nuser_id)
	local cmota = vRP.identity.cmota (source,user_id,cmota)
	local ccarro = vRP.identity.ccarro (source,user_id,ccarro)
	local ccamiao = vRP.identity.ccamiao (source,user_id,ccamiao)
	local creboque = vRP.identity.creboque (source,user_id,creboque)
	--if vRP.hasPermission(user_id,"dpla.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") or vRP.hasPermission(user_id,"administrador.permissao") then	
		if nplayer then
			if args[1] == "arma" then
				if arma == 1 then
					TriggerEvent("rmota",3,nuser_id)
					TriggerClientEvent("Notify",source,"sucesso","Apreendeu a carta de condução de <b>"..identitynu.name.." "..identitynu.firstname.."</b>.",5000)
					TriggerClientEvent("Notify",nplayer,"negado","O oficial <b>"..identity.name.." "..identity.firstname.."</b> apreendeu a sua carta de condução.",5000)
				
				elseif cmota == 3 then
					TriggerClientEvent("Notify",source,"negado","Carta já apreendida",5000) 
				end
				
			elseif args[1] == "direito" then
				if ccarro == 1 then
					TriggerEvent("rcarro",3,nuser_id)
					TriggerClientEvent("Notify",source,"sucesso","Apreendeu a carta de condução de <b>"..identitynu.name.." "..identitynu.firstname.."</b>.",5000)
					TriggerClientEvent("Notify",nplayer,"negado","O oficial <b>"..identity.name.." "..identity.firstname.."</b> apreendeu a sua carta de condução.",5000)
				elseif ccarro == 3 then
					TriggerClientEvent("Notify",source,"negado","Carta já apreendida",5000) 
				end
				
			elseif args[1] == "piloto" then
				if ccamiao == 1 then
					TriggerEvent("rcamiao",3,nuser_id)
					TriggerClientEvent("Notify",source,"sucesso","Apreendeu a carta de condução de <b>"..identitynu.name.." "..identitynu.firstname.."</b>.",5000)
					TriggerClientEvent("Notify",nplayer,"negado","O oficial <b>"..identity.name.." "..identity.firstname.."</b> apreendeu a sua carta de condução.",5000)
				elseif ccamiao == 3 then
					TriggerClientEvent("Notify",source,"negado","Carta já apreendida",5000) 
				end
			end	
		end
	--end
end)

--[[CHECA SE O PLAYER TEM CARTA]]-----------------------------------------------------------------------------
----[[ /CARTA /CARTA MOTA | /CARTA CARRO | /CARTA CAMIAO | /CARTA REBOQUE ]--

RegisterCommand("licenca",function(source,args)
	local source = source
	local identity = vRP.getUserIdentity(user_id)
	local cmota = vRP.identity.cmota (source,user_id,cmota)
	local ccarro = vRP.identity.ccarro (source,user_id,ccarro)
	local ccamiao = vRP.identity.ccamiao (source,user_id,ccamiao)
	local creboque = vRP.identity.creboque (source,user_id,creboque)
	--if vRP.hasPermission(user_id,"admininistrador.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then	
		if nplayer then
			if args[1] == "arma" then
				if carma == 1 then
					TriggerClientEvent("Notify",source,"importante","Utilizador com carta de Mota",5000) 
				elseif carma == 3 then
					TriggerClientEvent("Notify",source,"negado","Carta apreendida",5000) 
				else
					TriggerClientEvent("Notify",source,"importante","Sem carta de Mota",5000) 
				end
			elseif args[1] == "carro" then
				if ccarro == 1 then
					TriggerClientEvent("Notify",source,"importante","Utilizador com carta de Carro",5000) 
				elseif ccarro == 3 then
					TriggerClientEvent("Notify",source,"importante","Carta apreendida",5000) 
				else
					TriggerClientEvent("Notify",source,"importante","Sem carta de Carro",5000) 
				end
			elseif args[1] == "camiao" then
				if ccamiao == 1 then
					TriggerClientEvent("Notify",source,"importante","Utilizador com carta de Camiao",5000) 
				elseif ccamiao == 3 then
					TriggerClientEvent("Notify",source,"importante","Carta apreendida",5000) 
				else
					TriggerClientEvent("Notify",source,"importante","Sem carta de Camiao",5000) 
				end
			elseif args[1] == "reboque" then
				if creboque == 1 then
					TriggerClientEvent("Notify",source,"importante","Utilizador com carta de Reboque",5000) 
				elseif creboque == 3 then
					TriggerClientEvent("Notify",source,"importante","Carta apreendida",5000) 
				else
					TriggerClientEvent("Notify",source,"importante","Sem carta de Reboque",5000) 
				end
			else
				TriggerEvent("Notify","negado","Sem carta de condução")
			end
		end
	--end
end)

RegisterServerEvent("carta")
AddEventHandler("carta",function(driverlicense,user_id)
    vRP.execute("vRP/update_driverlicense", {driverlicense = driverlicense, user_id = user_id})
end)

RegisterServerEvent("rmota")
AddEventHandler("rmota",function(gunlicense,user_id)
    vRP.execute("vRP/update_gunlicense", {gunlicense = gunlicense, user_id = user_id})
end)

RegisterServerEvent("rdireito")
AddEventHandler("rdireito",function(direito,user_id)
    vRP.execute("vRP/update_direito", {direito = direito, user_id = user_id})
end)

RegisterServerEvent("rspiloto")
AddEventHandler("rspiloto",function(spiloto,user_id)
    vRP.execute("vRP/update_piloto", {spiloto = spiloto, user_id = user_id})
end)


Citizen.CreateThread(function()
	if get_direito == nil or get_piloto == nil then

		return
	else
		vRP.execute('vRP/vrp_user_identities')
	end
end)