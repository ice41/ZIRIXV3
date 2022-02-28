local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("oc_producao-coca",oC)
-----------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
local cocasitens = {
	{ item = "pasta-alta" },
	{ item = "coca-alta" },
	{ item = "coca-media" },
	{ item = "coca-baixa" },
	{ item = "leite-po" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-coca")
AddEventHandler("produzir-coca",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(cocasitens) do
			if item == v.item then
				if item == "pasta-alta" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("folhas-coca") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"folhas-coca") >= 5 then
                            if vRP.getInventoryItemAmount(user_id,"querosene") >= 3 then
                                if vRP.getInventoryItemAmount(user_id,"acido-sulfurico") >= 2 then
                                    if vRP.getInventoryItemAmount(user_id,"calcio-po") >= 5 then
                                        if vRP.tryGetInventoryItem(user_id,"folhas-coca",5) and vRP.tryGetInventoryItem(user_id,"querosene",3) and vRP.tryGetInventoryItem(user_id,"acido-sulfurico",2) and vRP.tryGetInventoryItem(user_id,"calcio-po",5) then
                                            
											--TriggerClientEvent("kelelaLindo",source)
											TriggerClientEvent("kelelaLindo-coca",source)
											
                                            TriggerClientEvent("progress",source,10000,"A FABRICAR PASTA ALTA QUALIDADE")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"pasta-alta",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Produziu<b>Pasta de Alta Qualidade</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Não tem <b>calcio em pó</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Precisa de <b>2x Acido Sulfurico</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Precisa de <b>3x querosene</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Não tem <b>folhas-coca</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
				elseif item == "coca-alta" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pasta-alta") <= vRP.getInventoryMaxWeight(user_id) then
                                    if vRP.getInventoryItemAmount(user_id,"pasta-alta") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"pasta-alta",2)  then
                                            TriggerClientEvent("kelelaLindo-coca",source)

                                            TriggerClientEvent("progress",source,10000,"A produzir coca Alta")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"coca-alta",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Produziu uma <b>Coca Alta</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Não tem <b>Pasta Alta</b> na mochila.")
                                    end
                        else
                            TriggerClientEvent("Notify",source,"negado","Não tem <b>pasta alta</b> na mochila.")
                        end
                elseif item == "coca-media" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("coca-alta") <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.getInventoryItemAmount(user_id,"leite-po") >= 1 then
                                    if vRP.getInventoryItemAmount(user_id,"coca-alta") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"leite-po",3) and vRP.tryGetInventoryItem(user_id,"coca-alta",1) then
                                            TriggerClientEvent("kelelaLindo-coca",source)

                                            TriggerClientEvent("progress",source,10000,"A produzir coca Media")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"coca-media",2)
                                                TriggerClientEvent("Notify",source,"sucesso","Produziu uma <b>Coca Media</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Não tem <b>coca alta</b> na mochila.")
                                    end                           
								else
                                    TriggerClientEvent("Notify",source,"negado","Não tem <b>Leite em pó</b> na mochila.")
                                end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "coca-baixa" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("coca-media") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"coca-media") >= 1 then
                                if vRP.getInventoryItemAmount(user_id,"leite-po") >= 1 then
                                    if vRP.tryGetInventoryItem(user_id,"coca-media",1) and vRP.tryGetInventoryItem(user_id,"leite-po",6) then
                                        TriggerClientEvent("kelelaLindo-coca",source)

                                        TriggerClientEvent("progress",source,10000,"A produzir coca Baixa")
                                        vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                        SetTimeout(10000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"coca-baixa",5)
                                            TriggerClientEvent("Notify",source,"sucesso","Produziu uma <b>Coca Baixa</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Não tem <b>Leite em pó</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Não tem <b>coca media</b> na mochila.")
                            end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "leite-po" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("garrafadeleite") <= vRP.getInventoryMaxWeight(user_id) then
                                if vRP.getInventoryItemAmount(user_id,"garrafadeleite") >= 1 then
                                    if vRP.tryGetInventoryItem(user_id,"garrafadeleite",5) then
                                        TriggerClientEvent("kelelaLindo-coca",source)

                                        TriggerClientEvent("progress",source,10000,"A desidratar o leite")
                                        vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                        SetTimeout(10000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"leite-po",3)
                                            TriggerClientEvent("Notify",source,"sucesso","Desidratou o <b>Leite</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Não tem <b>Garrafas de Leite</b> na mochila.")
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
    if vRP.hasPermission(user_id,"ballas.permissao") then
        return true
    end
end