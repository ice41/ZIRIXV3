local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-meta",oC)
-----------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
local metas = {
	{ item = "composito-baixa" },
	{ item = "composito-media" },
	{ item = "composito-baixa" },
	{ item = "meta-alta" },
	{ item = "meta-media" },
	{ item = "meta-baixa" },
	{ item = "cristal-meta" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-meta")
AddEventHandler("produzir-meta",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(metas) do
			if item == v.item then
				if item == "composito-baixa" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("composito-baixa") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pseudoefedrina") >= 5 then
                            if vRP.getInventoryItemAmount(user_id,"hidroxido-sodio") >= 5 then
                                if vRP.getInventoryItemAmount(user_id,"nitrato-amonia") >= 5 then
                                        if vRP.tryGetInventoryItem(user_id,"pseudoefedrina",5) and vRP.tryGetInventoryItem(user_id,"hidroxido-sodio",5) and vRP.tryGetInventoryItem(user_id,"nitrato-amonia",5) then
                                            TriggerClientEvent("kelelaLindo",source)

                                            TriggerClientEvent("progress",source,10000,"A FABRICAR COMPOSITO BAIXA QUALIDADE")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"composito-baixa",4)
                                                TriggerClientEvent("Notify",source,"sucesso","Produziu<b>COMPOSITO de BAIXA QUALIDADE</b>.")
                                            end)
                                        end
								else
									TriggerClientEvent("Notify",source,"negado","Não tem <b>5X Pseudoefedrina</b> na mochila.")
								end
							else
								TriggerClientEvent("Notify",source,"negado","Precisa de <b>5x Hidroxido de sodio</b>.")
							end
                        else
                            TriggerClientEvent("Notify",source,"negado","Não tem <b>5x Nitrato de Amonia</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "composito-media" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("composito-media") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"composito-baixa") >= 5 then
								if vRP.getInventoryItemAmount(user_id,"querosene") >= 2 then
											if vRP.tryGetInventoryItem(user_id,"composito-baixa",5) and vRP.tryGetInventoryItem(user_id,"querosene",2) then
												TriggerClientEvent("kelelaLindo",source)

												TriggerClientEvent("progress",source,10000,"A FABRICAR COMPOSITO Media QUALIDADE")
												vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

												SetTimeout(10000,function()
													vRPclient._stopAnim(source,false)
													vRP.giveInventoryItem(user_id,"composito-media",2)
													TriggerClientEvent("Notify",source,"sucesso","Produziu<b>COMPOSITO de Media QUALIDADE</b>.")
												end)
											end
								else
									TriggerClientEvent("Notify",source,"negado","Precisa de <b>5x composito de baixa qualidade</b>.")
								end
							else
								TriggerClientEvent("Notify",source,"negado","Não tem <b>5x querosene</b> na mochila.")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
					elseif item == "composito-alta" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("composito-alta") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"composito-media") >= 5 then
								if vRP.getInventoryItemAmount(user_id,"soda-caustica") >= 2 then
											if vRP.tryGetInventoryItem(user_id,"composito-media",5) and vRP.tryGetInventoryItem(user_id,"soda-caustica",2) then
												TriggerClientEvent("kelelaLindo",source)

												TriggerClientEvent("progress",source,10000,"A FABRICAR COMPOSITO Alta QUALIDADE")
												vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

												SetTimeout(10000,function()
													vRPclient._stopAnim(source,false)
													vRP.giveInventoryItem(user_id,"composito-alta",2)
													TriggerClientEvent("Notify",source,"sucesso","Produziu<b>COMPOSITO de Alta QUALIDADE</b>.")
												end)
											end
								else
									TriggerClientEvent("Notify",source,"negado","Precisa de <b>5x composito de media qualidade</b>.")
								end
							else
								TriggerClientEvent("Notify",source,"negado","Não tem <b>5x soda caustica</b> na mochila.")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "meta-alta" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("meta-alta") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"composito-alta") >= 5 then
								if vRP.getInventoryItemAmount(user_id,"eter") >= 2 then
											if vRP.tryGetInventoryItem(user_id,"composito-alta",5) and vRP.tryGetInventoryItem(user_id,"eter",2) then
												TriggerClientEvent("kelelaLindo",source)

												TriggerClientEvent("progress",source,10000,"A FABRICAR Meta Alta QUALIDADE")
												vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

												SetTimeout(10000,function()
													vRPclient._stopAnim(source,false)
													vRP.giveInventoryItem(user_id,"meta-alta",1)
													TriggerClientEvent("Notify",source,"sucesso","Produziu<b>Meta de Alta QUALIDADE</b>.")
												end)
											end
								else
									TriggerClientEvent("Notify",source,"negado","Precisa de <b>5x composito de alta qualidade</b>.")
								end
							else
								TriggerClientEvent("Notify",source,"negado","Não tem <b>5x éter</b> na mochila.")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "meta-media" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("meta-media") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"composito-media") >= 5 then
								if vRP.getInventoryItemAmount(user_id,"anticongelante") >= 3 then
											if vRP.tryGetInventoryItem(user_id,"composito-media",5) and vRP.tryGetInventoryItem(user_id,"anticongelante",3) then
												TriggerClientEvent("kelelaLindo",source)

												TriggerClientEvent("progress",source,10000,"A FABRICAR Meta Media QUALIDADE")
												vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

												SetTimeout(10000,function()
													vRPclient._stopAnim(source,false)
													vRP.giveInventoryItem(user_id,"meta-media",1)
													TriggerClientEvent("Notify",source,"sucesso","Produziu<b>Meta de Media QUALIDADE</b>.")
												end)
											end
								else
									TriggerClientEvent("Notify",source,"negado","Precisa de <b>5x composito de media qualidade</b>.")
								end
							else
								TriggerClientEvent("Notify",source,"negado","Não tem <b>3x anticongelante</b> na mochila.")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
				elseif item == "meta-alta" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("meta-alta") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"composito-alta") >= 5 then
								if vRP.getInventoryItemAmount(user_id,"acidobateria") >= 2 then
											if vRP.tryGetInventoryItem(user_id,"composito-alta",5) and vRP.tryGetInventoryItem(user_id,"acidobateria",2) then
												TriggerClientEvent("kelelaLindo",source)

												TriggerClientEvent("progress",source,10000,"A FABRICAR Meta Alta QUALIDADE")
												vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

												SetTimeout(10000,function()
													vRPclient._stopAnim(source,false)
													vRP.giveInventoryItem(user_id,"meta-media",1)
													TriggerClientEvent("Notify",source,"sucesso","Produziu<b>Meta de Alta QUALIDADE</b>.")
												end)
											end
								else
									TriggerClientEvent("Notify",source,"negado","Precisa de <b>5x composito de media qualidade</b>.")
								end
							else
								TriggerClientEvent("Notify",source,"negado","Não tem <b>2x acidobateria</b> na mochila.")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
				elseif item == "cristal-meta" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("cristal-meta") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"meta-alta") >= 5 then
								if vRP.getInventoryItemAmount(user_id,"acidobateria") >= 2 then
											if vRP.tryGetInventoryItem(user_id,"composito-alta",5) and vRP.tryGetInventoryItem(user_id,"acidobateria",2) then
												TriggerClientEvent("kelelaLindo",source)

												TriggerClientEvent("progress",source,10000,"A FABRICAR Meta Alta QUALIDADE")
												vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

												SetTimeout(10000,function()
													vRPclient._stopAnim(source,false)
													vRP.giveInventoryItem(user_id,"meta-media",1)
													TriggerClientEvent("Notify",source,"sucesso","Produziu<b>Meta de Alta QUALIDADE</b>.")
												end)
											end
								else
									TriggerClientEvent("Notify",source,"negado","Precisa de <b>5x composito de media qualidade</b>.")
								end
							else
								TriggerClientEvent("Notify",source,"negado","Não tem <b>2x acidobateria</b> na mochila.")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO DE PERMISSÃO ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
function oC.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"grove.permissao") then
        return true
    end
end