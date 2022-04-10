--[ https://ice41.pt ]--
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_dealership",src)
vCLIENT = Tunnel.getInterface("vrp_dealership")

local motos = {}
local carros = {}
local import = {} 
local exclusive = {} 
local vehicle = {}
local pedidos = {}

Citizen.CreateThread(function()
	for k,v in pairs(vRP.vehicleGlobal()) do
		if v.tipo == "carros" then
			local vehicle = vRP.query("losanjos/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				table.insert(carros,{ k = k, nome = v.name, price = v.price, chest = v.mala, stock = parseInt(vehicle[1].quantidade) })
			end
		end
		if v.tipo == "motos" then
			local vehicle = vRP.query("losanjos/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				table.insert(motos,{ k = k, nome = v.name, price = v.price, chest = v.mala, stock = parseInt(vehicle[1].quantidade) })
			end
		end
		if v.tipo == "import" then
			local vehicle = vRP.query("losanjos/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				table.insert(import,{ k = k, nome = v.name, price = v.price, chest = v.mala, stock = parseInt(vehicle[1].quantidade) })
			end
		end
		if v.tipo == "exclusive" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				local bau = inventory.chestweight[k] or 50
				table.insert(exclusive,{ k = k, nome = v.name, price = v.price, chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade) })
			end
		end
	end
end)

function src.updateVehicles(vname,vehtype)
	if vehtype == "carros" then
		for k,v in pairs(carros) do
			if v.k == vname then
				table.remove(carros,k)
				local vehicle = vRP.query("losanjos/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					table.insert(carros,{ k = vname, nome = vRP.vehicleName(vname), price = (vRP.vehiclePrice(vname)), chest = (vRP.vehicleChest(vname)), stock = parseInt(vehicle[1].quantidade) })
				end
			end
		end
	elseif vehtype == "motos" then
		for k,v in pairs(motos) do
			if v.k == vname then
				table.remove(motos,k)
				local vehicle = vRP.query("losanjos/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					table.insert(motos,{ k = vname, nome = vRP.vehicleName(vname), price = (vRP.vehiclePrice(vname)), chest = (vRP.vehicleChest(vname)), stock = parseInt(vehicle[1].quantidade) })
				end
			end
		end
	elseif vehtype == "import" then
		for k,v in pairs(import) do
			if v.k == vname then
				table.remove(import,k)
				local vehicle = vRP.query("losanjos/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					table.insert(import,{ k = vname, nome = vRP.vehicleName(vname), price = vRP.vehiclePrice(vname), chest = (vRP.vehicleChest(vname)), stock = parseInt(vehicle[1].quantidade) })
				end
			end
		end
	elseif vehtype == "exclusive" then
		for k,v in pairs(exclusive) do
			if v.k == vname then
				table.remove(exclusive,k)
				local vehicle = vRP.query("losanjos/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					table.insert(exclusive,{ k = vname, nome = vRP.vehicleName(vname), price = vRP.vehiclePrice(vname), chest = (vRP.vehicleChest(vname)), stock = parseInt(vehicle[1].quantidade) })
				end
			end
		end
	end			
end

function src.Carros()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return carros
	end
end

function src.Motos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return motos
	end
end

function src.Import()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return import
	end
end

function src.Exclusive()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return exclusive
	end
end

function src.buyRents(name)
	local source = source
	local user_id = vRP.getUserId(source)
	local spawnveh = vCLIENT.buyRent(source,name,1000,1000,100,custom,0,0,0,0,0,0,true)
end

function src.Possuidos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local veiculos = {}
		local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(user_id) })
		for k,v in pairs(vehicle) do
			local bau = inventory.chestweight[v.vehicle] or 50
			table.insert(veiculos,{ k = v.vehicle, nome = vRP.vehicleName(v.vehicle), price = parseInt(vRP.vehiclePrice(v.vehicle)), chest = parseInt(bau) })
		end
		return veiculos
	end
end

function src.addEstoque(name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		--if vRP.hasPermission(user_id,"concessionaria.permissao") then
			if vRP.vehicleType(name) == "exclusive" then
				TriggerClientEvent("Notify",source,"importante","Não pode pedir mais veículos importados.",8000)
			else
				local maxvehs = vRP.query("losanjos/con_maxvehs",{ user_id = parseInt(user_id) })
				local maxgars = vRP.query("losanjos/get_users",{ user_id = parseInt(user_id) })
				local vehicle = vRP.query("losanjos/get_vehicles",{ user_id = parseInt(user_id), vehicle = name })

				if vRP.hasPermission(user_id,"ultimate.permissao") then
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 20 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
						return
					end
				elseif vRP.hasPermission(user_id,"platinum.permissao") then
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 15 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
						return
					end
				elseif vRP.hasPermission(user_id,"gold.permissao") then
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 10 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
						return
					end
				elseif vRP.hasPermission(user_id,"standard.permissao") then
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 5 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
						return
					end
				else
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 2 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
						return
					end
				end

				if vehicle[1] then
					TriggerClientEvent("Notify",source,"importante","Você já possui um <b>"..vRP.vehicleName(name).."</b> em sua garagem.",10000)
					return
				else
					local rows2 = vRP.query("losanjos/get_estoque",{ vehicle = name })

					if pedidos[vRP.vehicleName(name)] == true then
						TriggerClientEvent("Notify",source,"importante","Estoque de <b>"..vRP.vehicleName(name).."</b> já está sobre encomenda.",8000)
					else
						if parseInt(rows2[1].quantidade) <= 0 then
							TriggerClientEvent("Notify",source,"sucesso","Estoque de <b>"..vRP.vehicleName(name).."</b> será adicionado em alguns minutos.",8000)
							pedidos[vRP.vehicleName(name)] = true

							SetTimeout(900000,function()
								vRP.execute("losanjos/set_estoque",{ vehicle = name, quantidade = parseInt(rows2[1].quantidade) + 1 })
								TriggerClientEvent("Notify",source,"sucesso","Estoque de <b>"..vRP.vehicleName(name).."</b> adicionado.",8000)
								src.updateVehicles(name,vRP.vehicleType(name))
								if vRP.vehicleType(name) == "carros" then
									TriggerClientEvent('dealership:Update',source,'updateCarros')
								elseif vRP.vehicleType(name) == "motos" then
									TriggerClientEvent('dealership:Update',source,'updateMotos')
								elseif vRP.vehicleType(name) == "import" then
									TriggerClientEvent('dealership:Update',source,'updateImport')
								elseif vRP.vehicleType(name) == "exclusive" then
									TriggerClientEvent('dealership:Update',source,'updateExclusive')
								end
								pedidos[vRP.vehicleName(name)] = false
								return
							end)

						else
							TriggerClientEvent("Notify",source,"importante","<b>"..vRP.vehicleName(name).."</b> já possui no estoque.",8000)
						end
					end
				end
			end
		--end
	end
end

function src.buyDealer(name)
	local source = source
	local user_id = vRP.getUserId(source)
	local value = vRP.getUData(parseInt(user_id),"vRP:gemas")
	local coins = json.decode(value) or 0
	local preco = vRP.vehiclePrice(name)
	
	if user_id then
		--if vRP.hasPermission(user_id,"concessionaria.permissao") then
			if vRP.vehicleType(name) == "exclusive" then
					TriggerClientEvent("Notify",source,"importante","Espero que tenha guardado as suas Coins",8000)
					
				--[[if coins >= preco then
					vRP.setUData(user_id,"vRP:gemas",json.encode(parseInt(gemas)-parseInt(preco)))
					TriggerClientEvent('dealership:Update',source,'updateExclusive')
					TriggerClientEvent("Notify",source,"sucesso","Pode levantar o seu carro na garagem",8000)
				else
					TriggerClientEvent("Notify",source,"negado","Não tem Coins suficientes",8000)
				end --]]
			TriggerClientEvent("Notify",source,"negado","Não pode comprar veículos exclusivos.",8000)
			else
				local maxvehs = vRP.query("losanjos/con_maxvehs",{ user_id = parseInt(user_id) })
				local maxgars = vRP.query("losanjos/get_users",{ user_id = parseInt(user_id) })
				local vehicle = vRP.query("losanjos/get_vehicles",{ user_id = parseInt(user_id), vehicle = name })

				if vRP.hasPermission(user_id,"ultimate.permissao") then
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 25 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos na sua garagem.",8000)
						return
					end
				elseif vRP.hasPermission(user_id,"platinum.permissao") then
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 20 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos na sua garagem.",8000)
						return
					end
				elseif vRP.hasPermission(user_id,"gold.permissao") then
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 15 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos na sua garagem.",8000)
						return
					end
				elseif vRP.hasPermission(user_id,"standard.permissao") then
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 10 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos na sua garagem.",8000)
						return
					end
				else
					if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 5 then
						TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos na sua garagem.",8000)
						return
					end
				end

				if vehicle[1] then
					TriggerClientEvent("Notify",source,"importante","Já possui um <b>"..vRP.vehicleName(name).."</b> na sua garagem.",10000)
					return
				else
					local rows2 = vRP.query("losanjos/get_estoque",{ vehicle = name })

					if parseInt(rows2[1].quantidade) <= 0 then
						TriggerClientEvent("Notify",source,"aviso","Estoque de <b>"..vRP.vehicleName(name).."</b> indisponível.",8000)
						return
					end

					local preco = vRP.vehiclePrice(name)
					local coins = vRP.prepare("losanjos/get_gemas","SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @dkey")
					
					if vRP.vehicleType(name) == "import" then
					TriggerClientEvent("Notify",source,"importante","Espero que tenha guardado as suas Coins",8000)
					
						if coins >= preco then
						
						TriggerClientEvent('dealership:Update',source,'updateExclusive')
						vRP.execute("losanjos/set_estoque",{ vehicle = name, quantidade = parseInt(rows2[1].quantidade) - 1 })
						vRP.execute("losanjos/add_vehicle",{ user_id = parseInt(user_id), vehicle = name, ipva = os.time() })

							TriggerClientEvent("Notify",source,"sucesso","Comprou um <b>"..vRP.vehicleName(name).."</b> por <b> "..vRP.format(parseInt(preco)).." Coins</b>.",10000)
							vRP.setUData(user_id,"vRP:gemas",json.encode(parseInt(coins)-parseInt(preco)))
							src.updateVehicles(name,vRP.vehicleType(name))
						else
						TriggerClientEvent("Notify",source,"negado","Não tem Coins suficientes",8000)
						end
					else
						if vRP.tryPayment(user_id,parseInt(preco)) then
							vRP.execute("losanjos/set_estoque",{ vehicle = name, quantidade = parseInt(rows2[1].quantidade) - 1 })
							vRP.execute("losanjos/add_vehicle",{ user_id = parseInt(user_id), vehicle = name, ipva = os.time() })

							TriggerClientEvent("Notify",source,"sucesso","Comprou um <b>"..vRP.vehicleName(name).."</b> por <b>€ "..vRP.format(parseInt(preco)).." Euros</b>.",10000)
							
							src.updateVehicles(name,vRP.vehicleType(name))
							
							if vRP.vehicleType(name) == "carros" then
								TriggerClientEvent('dealership:Update',source,'updateCarros')
							elseif vRP.vehicleType(name) == "motos" then
								TriggerClientEvent('dealership:Update',source,'updateMotos')
							elseif vRP.vehicleType(name) == "import" then
								TriggerClientEvent('dealership:Update',source,'updateImport')
							end
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")			
						end
					end
				end
			end
		--end
	end
end

function src.permissao()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id,"concessionaria.permissao")
end