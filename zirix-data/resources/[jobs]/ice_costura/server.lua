local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
func = {}
Tunnel.bindInterface("ice_costura",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"triad.permissao")
end
RegisterCommand('use',function(source,args,rawCommand)
	if args[1] == nil then
		return
   end
   
  	if args[1] == "mochila" then
		if vRP.tryGetInventoryItem(user_id,"mochila",1) then
			vRP.varyExp(user_id,"physical","strength", 650)
			TriggerClientEvent("Notify",source,"sucesso","Mochila utilizada com sucesso.")
		else
			TriggerClientEvent("Notify",source,"negado","Mochila não encontrada na mochila.")
      end
	end
end)

RegisterServerEvent("costura-comprar")
AddEventHandler("costura-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"triad.permissao") then
		for k,v in pairs(Config.valores) do
			if item == v.item then

				local tempo = 0
				local isArma = false
				if v.componentes then
					for k2,v2 in pairs(v.componentes) do -- VERIFICA SE TEM TODOS OS ITTENS
						if vRP.getInventoryItemAmount(user_id, v2.componente) >= v2.qtd then
							tempo = tempo+v2.qtd
						else
							TriggerClientEvent("Notify",source,"negado","Não possui "..vRP.getItemName(v2.componente).." suficiente!")
							return false
						end
					end
					for k2,v2 in pairs(v.componentes) do -- SE TEM TODOS OS ITENS, TIRA ELES DO INVENTARIO
						vRP.tryGetInventoryItem(user_id, v2.componente, v2.qtd)
					end
					isArma = true
				else
					tempo = 10
					isArma = false
				end

				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.qtd <= vRP.getInventoryMaxWeight(user_id) then

						TriggerClientEvent("costura_fabricar:fecharMenu", source)
						TriggerClientEvent("progress",source,tempo*1000,"COSTURANDO")
						TriggerClientEvent("costura_fabricar:animacao",source, true)
						Citizen.Wait(tempo*1000)
						TriggerClientEvent("costura_fabricar:animacao",source, false)


						if not isArma then
							if vRP.tryPayment(user_id,parseInt(v.compra)) then
								vRP.giveInventoryItem(user_id,v.item,parseInt(v.qtd))
								TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.qtd).."x "..vRP.getItemName(v.item).."</b> por <b>€"..vRP.format(parseInt(v.compra)).." Euros</b>.")
							else
								TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
							end
						else
							vRP.giveInventoryItem(user_id,v.item,parseInt(v.qtd))
							TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>"..parseInt(v.qtd).."x "..vRP.getItemName(v.item).."</b>")
						end

				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)


-------------------
--Coletar
-------------------
local quantidadeLinha = {}
local quantidadeTecido = {}
function func.geraQuant()
	local source = source
	if quantidadeLinha[source] == nil then
		quantidadeLinha[source] = math.random(1,4)
	end
	if quantidadeTecido[source] == nil then
		quantidadeTecido[source] = math.random(1,6)
	end
	
end


function func.checkPayment()
	
   func.geraQuant()
   local source = source
   local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"triad.permissao") then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("tecido")*quantidadeTecido[source]+vRP.getItemWeight("linha")*quantidadeLinha[source] <= vRP.getInventoryMaxWeight(user_id) then
			 vRP.giveInventoryItem(user_id,"tecido",quantidadeTecido[source])
			 vRP.giveInventoryItem(user_id,"linha",quantidadeLinha[source])
			 TriggerClientEvent("Notify",source,"sucesso","<b>Recebeu "..quantidadeTecido[source].."x Tecido</b>")
			 TriggerClientEvent("Notify",source,"sucesso","<b>Recebeu "..quantidadeLinha[source].."x Linha de Costura</b>")
			 quantidadeLinha[source]=nil
			 quantidadeTecido[source]=nil
			 return true
		else
         TriggerClientEvent("Notify",source,"negado","<b>Mochila cheia</b>.")
		end
	else
		TriggerClientEvent("Notify",source,"negado","<b>Não tem permissao</b>")
	end
end
