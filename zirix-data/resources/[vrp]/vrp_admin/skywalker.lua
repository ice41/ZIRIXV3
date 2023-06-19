local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

vRPidd = {}
Tunnel.bindInterface('vrp_admin', vRPidd)
Proxy.addInterface('vrp_admin', vRPidd)
IDDclient = Tunnel.getInterface('vrp_admin')

-- Reseta a SKIN do personagem caso vier bugado ou criança
RegisterCommand('resetskin',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "administrador.permissao") or vRP.hasPermission(user_id, "manager.permissao") then
        if args[1] == "mulher" then
            TriggerClientEvent("skinmenu",source,"mp_f_freemode_01")
            vRPclient.setHealth(source,400)
			TriggerClientEvent("nation_barbershop:reloadOverlay", source)
        elseif args[1] == "homem" then     
            TriggerClientEvent("skinmenu",source,"mp_m_freemode_01")
            vRPclient.setHealth(source,400)
			TriggerClientEvent("nation_barbershop:reloadOverlay", source)
        end    
    end    
end)

-- Mostra o SRC do vagabundo apagando os carros ao redor
RegisterCommand('schack',function(source,args,command)
  local user_id = vRP.getUserId(source)
  if vRP.hasPermission(user_id, "administrador.permissao") or vRP.hasPermission(user_id, "manager.permissao") then
    TriggerClientEvent("MQCU:getfodido",source)
  end
end)

-- Bane o SCR do vagabundo com ID bugado
RegisterCommand('bansrc',function(source,args,command)
  local user_id = vRP.getUserId(source)
  if vRP.hasPermission(user_id, "administrador.permissao") or vRP.hasPermission(user_id, "manager.permissao") then
    local nsource = args[1]
    if(nsource)then
      local identifiers = {}
      local qtd = GetNumPlayerIdentifiers(nsource)
      for i=0,qtd do
        local idf = GetPlayerIdentifier(nsource,i)    
        table.insert(identifiers,idf)
      end            
      local nuser_id = vRP.getUserIdByIdentifiers(identifiers)
      if(nuser_id)then
        print("[/bansrc] Player Banido com sucesso!  user_id: "..user_id)
        vRP.setBanned(nuser_id,true)                
        local msg = "User_id: "..nuser_id.."  banido pelo /bansrc"                
        PerformHttpRequest(config.bansrc, function(err, text, headers) end, 'POST', json.encode({content = msg}), { ['Content-Type'] = 'application/json' })
      else
        print("[/bansrc] user_id não encontrado!")
        print("[/bansrc] identifiers:\t",table.concat(identifiers,"\t").."\n")
        local msg = "user_id não localizado: "..table.concat(identifiers,"\t")
        PerformHttpRequest(config.bansrc, function(err, text, headers) end, 'POST', json.encode({content = msg}), { ['Content-Type'] = 'application/json' })
      end
      DropPlayer(nsource, "[MQCU] Deu ruim pae...")
      print("[/bansrc] Source Kickada com sucesso!")
    end
  end
end)

-- Reseta o Player
RegisterCommand('reset',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"manager.permissao") then
            if args[1] then
                local nplayer = vRP.getUserSource(parseInt(args[1]))
                local id = vRP.getUserId(nplayer)
                if id then
                    vRP.setUData(id,"vRP:spawnController",json.encode(1))
                    vRP.kick(nplayer,"Seu personagem foi resetado !")
                    TriggerClientEvent("Notify",source,"sucesso","Você <b>resetou</b> o personagem do passaporte <b>"..vRP.format(parseInt(args[1])).."</b>.",5000)
                end
            end
        end
    end
end)

RegisterCommand('renomear', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

    if vRP.hasPermission(user_id, 'suporte.permissao') or vRP.hasPermission(user_id, 'moderador.permissao') or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
        local idjogador = vRP.prompt(source, 'Qual id do jogador?', '')
        local nome = vRP.prompt(source, 'Novo nome', '')
        local firstname = vRP.prompt(source, 'Novo sobrenome', '')
        local idade = vRP.prompt(source, 'Nova idade', '')
		local nuidentity = vRP.getUserIdentity(parseInt(idjogador))

        vRP.execute('vRP/update_user_identity', {
            user_id = idjogador,
            firstname = firstname,
            name = nome,
            age = idade,
            registration = nuidentity.registration,
            phone = nuidentity.phone
		})

		PerformHttpRequest(config.Rename, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 	------------------------------------------------------------
					title = 'REGISTRO DE ALTERAÇÃO IDENTIDADE⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
					thumbnail = {
						url = config.webhookIcon
					}, 
					fields = {
						{ 
							name = '**COLABORADOR DA EQUIPE:**',
							value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
						},
						{
							name = '**NOVOS DADOS DO RG:**',
							value = '**['..vRP.format(parseInt(idjogador))..'][ Nome: '..nome..' ][ Sobrenome: '..firstname..' ][ Idade: '..idade..' ]**\n⠀'
						}
					}, 
					footer = { 
						text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
						icon_url = config.webhookIcon
					},
					color = config.webhookColor 
				}
			}
		}), { ['Content-Type'] = 'application/json' })
    end
end)

local player_customs = {}
RegisterCommand('vroupas', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
	local custom = vRPclient.getCustomization(source)

    -- if vRP.hasPermission(user_id, 'suporte.permissao') or vRP.hasPermission(user_id, 'moderador.permissao') or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
        if player_customs[source] then
            player_customs[source] = nil
            vRPclient._removeDiv(source, 'customization')
        else 
			local content = ''

            for k, v in pairs(custom) do
                content = content..k..' => '..json.encode(v)..'<br/>' 
            end

            player_customs[source] = true
            vRPclient._setDiv(source, 'customization', '.div_customization{ margin: auto; padding: 4px; width: 250px; margin-top: 200px; margin-right: 50px; background: rgba(15, 15, 15, 0.7); color: #ffff; font-weight: bold; }', content)
        end
    -- end
end)

RegisterCommand('estoque', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, 'manager.permissao') then
		if args[1] and args[2] then

			PerformHttpRequest(config.Stock, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 	------------------------------------------------------------
						title = 'REGISTRO DE ALTERAÇÃO DE ESTOQUE⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
						thumbnail = {
							url = config.webhookIcon
						}, 
						fields = {
							{ 
								name = '**COLABORADOR DA EQUIPE:**',
								value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
							},
							{
								name = '**MODIFICAÇÃO DE ESTOQUE:**',
								value = '**[ Modelo: '..args[1]..' ][ Quantidade: '..vRP.format(parseInt(args[2]))..' ]**\n⠀'
							}
						}, 
						footer = { 
							text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
							icon_url = config.webhookIcon
						},
						color = config.webhookColor 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

            vRP.execute('losanjos/set_estoque', { vehicle = args[1], quantidade = args[2] })
            TriggerClientEvent('Notify', source, 'sucesso', 'Voce colocou mais <b>'..args[2]..'</b> no estoque, para o carro <b>'..args[1]..'</b>.') 
        end
    end
end)

RegisterCommand('addcar', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserId(parseInt(args[2]))

    if vRP.hasPermission(user_id, 'manager.permissao') or vRP.hasPermission(user_id, 'administrador.permissao') then
        if args[1] and args[2] then
            local nuser_id = vRP.getUserId(nplayer)
			local identitynu = vRP.getUserIdentity(nuser_id)

			PerformHttpRequest(config.Addcar, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 	------------------------------------------------------------
						title = 'REGISTRO DE CARRO ADICIONADO A PLAYER⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
						thumbnail = {
							url = config.webhookIcon
						}, 
						fields = {
							{ 
								name = '**COLABORADOR DA EQUIPE:**',
								value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
							},
							{
								name = '**INFORMAÇÕES:**',
								value = '**[ Modelo: '..args[1]..' ][ Player ID: '..args[2]..' ]**\n⠀'
							}
						}, 
						footer = { 
							text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
							icon_url = config.webhookIcon
						},
						color = config.webhookColor 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

            vRP.execute('losanjos/add_vehicle', { user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time()) })
            TriggerClientEvent('Notify', source, 'sucesso', 'Voce adicionou o veículo <b>'..args[1]..'</b> para o Passaporte: <b>'..parseInt(args[2])..'</b>.')
        end
    end
end)

RegisterCommand('remcar', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserId(parseInt(args[2]))
	
    if vRP.hasPermission(user_id, 'manager.permissao') then
        if args[1] and args[2] then
            local nuser_id = vRP.getUserId(nplayer)
			local identitynu = vRP.getUserIdentity(nuser_id)
			
			PerformHttpRequest(config.Remcar, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 	------------------------------------------------------------
						title = 'REGISTRO DE CARRO REMOVIDO DE PLAYER⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
						thumbnail = {
							url = config.webhookIcon
						}, 
						fields = {
							{ 
								name = '**COLABORADOR DA EQUIPE:**',
								value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
							},
							{
								name = '**INFORMAÇÕES:**',
								value = '**[ Modelo: '..args[1]..' ][ Player ID: '..args[2]..' ]**\n⠀'
							}
						}, 
						footer = { 
							text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
							icon_url = config.webhookIcon
						},
						color = config.webhookColor 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

            vRP.execute('losanjos/rem_vehicle', { user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time())  }) 
            TriggerClientEvent('Notify', source, 'sucesso', 'Voce removeu o veículo <b>'..args[1]..'</b> do Passaporte: <b>'..parseInt(args[2])..'</b>.')
        end
    end
end)

RegisterCommand('uncuff', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id, 'moderador.permissao') or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
			TriggerClientEvent('admcuff', source)
		end
	end
end)

RegisterCommand('limpararea', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local x, y, z = vRPclient.getPosition(source)
    if vRP.hasPermission(user_id, 'moderador.permissao') or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
        TriggerClientEvent('syncarea', -1, x, y, z)
    end
end)

RegisterCommand('apagao', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        if vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') and args[1] ~= nil then
            local cond = tonumber(args[1])
            --TriggerEvent('cloud:setApagao', cond)
            TriggerClientEvent('cloud:setApagao', -1, cond)                    
        end
    end
end)

RegisterCommand('raios', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        if vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') and args[1] ~= nil then
            local vezes = tonumber(args[1])
            TriggerClientEvent('cloud:raios', -1, vezes)           
        end
    end
end)

RegisterCommand('skin', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
        if parseInt(args[1]) then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent('skinmenu', nplayer, args[2])
                TriggerClientEvent('Notify', source, 'sucesso', 'Voce setou a skin <b>'..args[2]..'</b> no passaporte <b>'..parseInt(args[1])..'</b>.')
            end
        end
    end
end)

RegisterCommand('debug', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		if vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
			TriggerClientEvent('ToggleDebug', player)
		end
	end
end)

RegisterServerEvent('trydeleteobj')
AddEventHandler('trydeleteobj', function(index)
    TriggerClientEvent('syncdeleteobj', -1, index)
end)

RegisterCommand('fix', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	local vehicle = vRPclient.getNearestVehicle(source, 11)
	if vehicle then
		if vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'moderador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then

			PerformHttpRequest(config.Fix, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 	------------------------------------------------------------
						title = 'REGISTRO DE FIX⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
						thumbnail = {
							url = config.webhookIcon
						}, 
						fields = {
							{ 
								name = '**COLABORADOR DA EQUIPE:**',
								value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
							}
						}, 
						footer = { 
							text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
							icon_url = config.webhookIcon
						},
						color = config.webhookColor
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			TriggerClientEvent('reparar', source)
			TriggerClientEvent('repararmotor', source)
		end
	end
end)

RegisterCommand('reviver', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

    if vRP.hasPermission(user_id, 'suporte.permissao') or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'moderador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
        if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				local nuser_id = vRP.getUserId(nplayer)
				local identitynu = vRP.getUserIdentity(nuser_id)

				PerformHttpRequest(config.Revive, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 	
							title = 'REGISTRO DE REVIVER⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
							thumbnail = {
								url = config.webhookIcon
							}, 
							fields = {
								{ 
									name = '**COLABORADOR DA EQUIPE:**',
									value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
								},
								{
									name = '**INFORMAÇÕES DO PLAYER REVIVIDO:**',
									value = '**'..identitynu.name..' '..identitynu.firstname..'** [**'..nuser_id..'**]\n⠀'
								}
							}, 
							footer = { 
								text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
								icon_url = config.webhookIcon
							},
							color = config.webhookColor 
						}
					}
				}), { ['Content-Type'] = 'application/json' })

				TriggerClientEvent('resetBleeding', nplayer)
                TriggerClientEvent('resetDiagnostic', nplayer)

                vRPclient.killGod(nplayer)
				vRPclient.setHealth(nplayer, 400)
				vRP.varyThirst(nuser_id, -15)
				vRP.varyHunger(nuser_id, -15)
            end
		else
			PerformHttpRequest(config.Revive, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{
						title = 'REGISTRO DE REVIVER⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
						thumbnail = {
							url = config.webhookIcon
						}, 
						fields = {
							{ 
								name = '**COLABORADOR DA EQUIPE:**',
								value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
							}
						}, 
						footer = { 
							text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
							icon_url = config.webhookIcon
						},
						color = config.webhookColor 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			TriggerClientEvent('resetBleeding', source)
            TriggerClientEvent('resetDiagnostic', source)

            vRPclient.killGod(source)
			vRPclient.setHealth(source, 400)
			vRP.varyThirst(user_id, -100)
			vRP.varyHunger(user_id, -100)
        end
    end
end)

RegisterCommand('reviverall', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, 'manager.permissao') then
    	local users = vRP.getUsers()
        for k, v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
            	TriggerClientEvent('resetBleeding', id)
            	TriggerClientEvent('resetDiagnostic', id)
            	vRPclient.killGod(id)
				vRPclient.setHealth(id, 400)
            end
		end

		PerformHttpRequest(config.Revive, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 	
					title = 'REGISTRO DE REVIVER TODOS⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
					thumbnail = {
						url = config.webhookIcon
					}, 
					fields = {
						{ 
							name = '**COLABORADOR DA EQUIPE:**',
							value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
						}
					}, 
					footer = { 
						text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
						icon_url = config.webhookIcon
					},
					color = config.webhookColor 
				}
			}
		}), { ['Content-Type'] = 'application/json' })
    end
end)

RegisterCommand('hash', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'manager.permissao') then
		TriggerClientEvent('vehash', source)
	end
end)

RegisterCommand('tuning', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		TriggerClientEvent('vehtuning', source)
	end
end)

RegisterCommand('wl', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id) 
    if vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'moderador.permissao') or vRP.hasPermission(user_id, 'suporte.permissao') or vRP.hasPermission(user_id, 'manager.permissao') or vRP.hasPermission(user_id, 'aprovador-wl.permissao') then
		if args[1] then

			PerformHttpRequest(config.Whitelist, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 	
						title = 'NOVO ID ADICIONADO A WHITELIST⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
						thumbnail = {
							url = config.webhookIcon
						}, 
						fields = {
							{ 
								name = '**COLABORADOR DA EQUIPE:**',
								value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
							},
							{
								name = '**ID ADICIONADO: **'..vRP.format(parseInt(args[1])),
								value = '⠀'
							}
						}, 
						footer = { 
							text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
							icon_url = config.webhookIcon
						},
						color = config.webhookColor 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

            vRP.setWhitelisted(parseInt(args[1]), true)
            TriggerClientEvent('Notify', source, 'sucesso', 'Você aprovou o passaporte <b>'..args[1]..'</b> na whitelist.')
        end
    end
end)

RegisterCommand('unwl', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'moderador.permissao') or vRP.hasPermission(user_id, 'suporte.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		if args[1] then

			PerformHttpRequest(config.UnWhitelist, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = 'ID REMOVIDO DA WHITELIST⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
						thumbnail = {
							url = config.webhookIcon
						}, 
						fields = {
							{ 
								name = '**COLABORADOR DA EQUIPE:**',
								value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
							},
							{
								name = '**ID REMOVIDO: **'..vRP.format(parseInt(args[1])),
								value = '⠀'
							}
						}, 
						footer = { 
							text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
							icon_url = config.webhookIcon
						},
						color = config.webhookColor 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			vRP.setWhitelisted(parseInt(args[1]), false)
			TriggerClientEvent('Notify', source, 'sucesso', 'Você retirou o passaporte <b>'..args[1]..'</b> da whitelist.')
		end
	end
end)

RegisterCommand('kick', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'moderador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		if args[1] then
			local id = vRP.getUserSource(parseInt(args[1]))
			if id then

				PerformHttpRequest(config.Kick, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 	
							title = 'REGISTRO DE KICK⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
							thumbnail = {
								url = config.webhookIcon
							}, 
							fields = {
								{ 
									name = '**COLABORADOR DA EQUIPE:**',
									value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
								},
								{
									name = '**ID KIKADO: **'..vRP.format(parseInt(args[1])),
									value = '⠀'
								}
							}, 
							footer = { 
								text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
								icon_url = config.webhookIcon
							},
							color = config.webhookColor 
						}
					}
				}), { ['Content-Type'] = 'application/json' })

				vRP.kick(id, 'Você foi expulso da cidade.')
				TriggerClientEvent('Notify', source, 'sucesso', 'Voce kickou o passaporte <b>'..args[1]..'</b> da cidade.')
			end
		end
	end
end)

RegisterCommand('kickall', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

    if vRP.hasPermission(user_id, 'manager.permissao') then
        local users = vRP.getUsers()
        for k, v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
                vRP.kick(id, 'Você foi vitima do terremoto.')
            end
		end

		PerformHttpRequest(config.Kick, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 	
					title = 'REGISTRO DE KICKAR TODOS⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
					thumbnail = {
						url = config.webhookIcon
					}, 
					fields = {
						{ 
							name = '**COLABORADOR DA EQUIPE:**',
							value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
						}
					}, 
					footer = { 
						text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
						icon_url = config.webhookIcon
					},
					color = config.webhookColor 
				}
			}
		}), { ['Content-Type'] = 'application/json' })
    end
end)

RegisterCommand('ban', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local motivo = vRP.prompt(source,"Motivo do Banimento:","")
	if motivo == "" then
		TriggerClientEvent("Notify", source, "importante", "Motivo não pode ser vazio.")
		return
	end
	if vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		if args[1] then
			local nuser_id = vRP.getUserSource(parseInt(args[1]))

			PerformHttpRequest(config.Ban, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{
						title = 'REGISTRO DE BANIMENTO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
						thumbnail = {
							url = config.webhookIcon
						}, 
						fields = {
							{ 
								name = '**COLABORADOR DA EQUIPE:**',
								value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
							},
							{
								name = '**ID BANIDO: **'..vRP.format(parseInt(args[1])),
								value = '⠀'
							},
							{
								name = "**MOTIVO**",
								value = "**Motivo do Banimento: **"..motivo.."⠀"
                            },
						},
						footer = { 
							text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
							icon_url = config.webhookIcon
						},
						color = config.webhookColor 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			vRP.setBanned(nuser_id, true)
			vRP.kick(nuser_id, "Você foi banido! [ Mais informações em: https://ice41rp.com.br/ ]")

			TriggerClientEvent('Notify', source, 'sucesso', 'Voce baniu o passaporte <b>'..args[1]..'</b> da cidade.')
		end
	end
end)

RegisterCommand('unban', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local motivo = vRP.prompt(source,"Motivo para remover ban:","")
	if motivo == "" then
		TriggerClientEvent("Notify", source, "importante", "Motivo não pode ser vazio.")
		return
	end
	if vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		if args[1] then

			PerformHttpRequest(config.UnBan, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = 'REGISTRO DE DESBANIMENTO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
						thumbnail = {
							url = config.webhookIcon
						},
						fields = {
							{
								name = '**COLABORADOR DA EQUIPE:**',
								value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
							},
							{
								name = '**ID DESBANIDO: **'..vRP.format(parseInt(args[1])),
								value = '⠀'
							},
							{
								name = "**MOTIVO**",
								value = "**Motivo do Banimento: **"..motivo.."⠀"
                            },
						},
						footer = { 
							text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
							icon_url = config.webhookIcon
						},
						color = config.webhookColor
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			vRP.setBanned(parseInt(args[1]), false)
			TriggerClientEvent('Notify', source, 'sucesso', 'Voce desbaniu o passaporte <b>'..args[1]..'</b> da cidade.')
		end
	end
end)

RegisterCommand('banchar', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	if vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		if args[1] then
			local nuser_id = vRP.getUserSource(parseInt(args[1]))
			local daysBanned = vRP.prompt(source, 'Digite quantos dias de banimento para esse personagem.', '')

			PerformHttpRequest(config.BanChar, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = 'REGISTRO DE BANIMENTO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
						thumbnail = {
							url = config.webhookIcon
						}, 
						fields = {
							{ 
								name = '**COLABORADOR DA EQUIPE:**',
								value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
							},
							{
								name = '**ID DO PERSONAGEM BANIDO: **'..vRP.format(parseInt(args[1])),
								value = '⠀'
							},
							{
								name = '**DIAS: **'..vRP.format(parseInt(daysBanned)),
								value = '⠀'
							}
						}, 
						footer = { 
							text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
							icon_url = config.webhookIcon
						},
						color = config.webhookColor 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			vRP.setBannedChar(nuser_id, true, daysBanned)

			TriggerClientEvent('Notify', source, 'sucesso', 'Voce baniu o passaporte <b>'..args[1]..'</b> da cidade.')
		end
	end
end)

RegisterCommand('unbanchar', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		if args[1] then

			PerformHttpRequest(config.UnBanChar, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = 'REGISTRO DE DESBANIMENTO DO PERSONAGEM:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
						thumbnail = {
							url = config.webhookIcon
						}, 
						fields = {
							{ 
								name = '**COLABORADOR DA EQUIPE:**',
								value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
							},
							{
								name = '**ID DO PERSONAGEM DESBANIDO: **'..vRP.format(parseInt(args[1])),
								value = '⠀'
							}
						}, 
						footer = { 
							text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
							icon_url = config.webhookIcon
						},
						color = config.webhookColor
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			vRP.setBannedChar(parseInt(args[1]), false, 0)
			TriggerClientEvent('Notify', source, 'sucesso', 'Voce desbaniu o passaporte <b>'..args[1]..'</b> da cidade.')
		end
	end
end)

RegisterCommand('bansrc',function(source,args,command)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "administrador.permissao") or vRP.hasPermission(user_id, "manager.permissao") then
	  local nsource = args[1]
	  if(nsource)then
		local identifiers = {}
		local qtd = GetNumPlayerIdentifiers(nsource)
		for i=0,qtd do
		  local idf = GetPlayerIdentifier(nsource,i)    
		  table.insert(identifiers,idf)
		end            
		local nuser_id = vRP.getUserIdByIdentifiers(identifiers)
		if(nuser_id)then
		  print("[/bansrc] Player Banido com sucesso!  user_id: "..user_id)
		  vRP.setBanned(nuser_id,true)                
		  local msg = "User_id: "..nuser_id.."  banido pelo /bansrc"                
		  PerformHttpRequest(config.bansrc, function(err, text, headers) end, 'POST', json.encode({content = msg}), { ['Content-Type'] = 'application/json' })
		else
		  print("[/bansrc] user_id não encontrado!")
		  print("[/bansrc] identifiers:\t",table.concat(identifiers,"\t").."\n")
		  local msg = "user_id não localizado: "..table.concat(identifiers,"\t")
		  PerformHttpRequest(config.bansrc, function(err, text, headers) end, 'POST', json.encode({content = msg}), { ['Content-Type'] = 'application/json' })
		end
		DropPlayer(nsource, "[MQCU] Deu ruim pae...")
		print("[/bansrc] Source Kickada com sucesso!")
	  end
	end
  end)

RegisterCommand('nc', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	if vRP.hasPermission(user_id, 'lider-corretor.permissao') or vRP.hasPermission(user_id, 'suporte.permissao') or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'moderador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		
		PerformHttpRequest(config.Nc, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 	
					title = 'REGISTRO DE NC⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
					thumbnail = {
						url = config.webhookIcon
					}, 
					fields = {
						{ 
							name = '**COLABORADOR DA EQUIPE:**',
							value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
						}
					}, 
					footer = { 
						text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
						icon_url = config.webhookIcon
					},
					color = config.webhookColor
				}
			}
		}), { ['Content-Type'] = 'application/json' })
		
		vRPclient.toggleNoclip(source)
	end
end)

RegisterCommand('tpcds', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'suporte.permissao') or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		local fcoords = vRP.prompt(source, 'Cordenadas:', '')
		if fcoords == '' then
			return
		end
		local coords = {}
		local a = fcoords:gsub( "[%a='%[%]]", '' )
		for coord in string.gmatch(a or '0, 0, 0', '[^, ]+') do
			table.insert(coords, parseInt(coord))
		end
		vRPclient.teleport(source, coords[1] or 0, coords[2] or 0, coords[3] or 0)
	end
end)

RegisterCommand('cds', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'suporte.permissao') or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		local x, y, z = vRPclient.getPosition(source)
		heading = GetEntityHeading(GetPlayerPed(-1))
		vRP.prompt(source, 'Cordenadas:', "['x'] = "..tD(x)..", ['y'] = "..tD(y)..", ['z'] = "..tD(z))
	end
end)

RegisterCommand('cds2', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		local x, y, z = vRPclient.getPosition(source)
		vRP.prompt(source, 'Cordenadas:', tD(x)..', '..tD(y)..', '..tD(z))
	end
end)

RegisterCommand('cds3', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		local x, y, z = vRPclient.getPosition(source)
		vRP.prompt(source, 'Cordenadas:', "{name='ATM', id=277, x="..tD(x)..", y="..tD(y)..", z="..tD(z).."},")
	end
end)

RegisterCommand('cds4', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		local x, y, z = vRPclient.getPosition(source)
		vRP.prompt(source, 'Cordenadas:', 'x = '..tD(x)..', y = '..tD(y)..', z = '..tD(z))
	end
end)

RegisterCommand('cdsh', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'suporte.permissao') or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		local x, y, z = vRPclient.getPosition(source)
		heading = GetEntityHeading(GetPlayerPed(-1))
		vRP.prompt(source, 'Cordenadas:', "['x2'] = "..tD(x)..", ['y2'] = "..tD(y)..", ['z2'] = "..tD(z))
	end
end)

RegisterCommand('cdsp', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		local x, y, z = vRPclient.getPosition(source)
		vRP.prompt(source, 'Cordenadas:', "x="..tD(x)..", y="..tD(y)..", z="..tD(z).."")
	end
end)

RegisterCommand('group', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		if args[1] and args[2] then
			vRP.addUserGroup(parseInt(args[1]), args[2])
			
			TriggerClientEvent('Notify', source, 'sucesso', 'Voce setou o passaporte <b>'..parseInt(args[1])..'</b> no grupo <b>'..args[2]..'</b>.')

			PerformHttpRequest(config.Group, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = 'REGISTRO DE GROUP:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
						thumbnail = {
							url = config.webhookIcon
						}, 
						fields = {
							{ 
								name = '**COLABORADOR DA EQUIPE:**',
								value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
							},
							{
								name = '**ID & GROUP: **',
								value = '**'..args[1]..' no grupo: '..args[2]..'**'
							}
						}, 
						footer = { 
							text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
							icon_url = config.webhookIcon
						},
						color = config.webhookColor 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			TriggerClientEvent('oc_gps:coords', nplayer)
		end
	end
end)

RegisterCommand('ungroup', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		if args[1] and args[2] then
			vRP.removeUserGroup(parseInt(args[1]), args[2])

			TriggerClientEvent('Notify', source, 'sucesso', 'Voce removeu o passaporte <b>'..parseInt(args[1])..'</b> do grupo <b>'..args[2]..'</b>.')

			PerformHttpRequest(config.UnGroup, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = 'REGISTRO DE UNGROUP:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
						thumbnail = {
							url = config.webhookIcon
						}, 
						fields = {
							{ 
								name = '**COLABORADOR DA EQUIPE:**',
								value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
							},
							{
								name = '**ID & GROUP: **',
								value = '**'..args[1]..' retirou o grupo: '..args[2]..'**'
							}
						}, 
						footer = { 
							text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
							icon_url = config.webhookIcon
						},
						color = config.webhookColor 
					}
				}
			}), { ['Content-Type'] = 'application/json' })

			TriggerClientEvent('oc_gps:coords', nplayer)
		end
	end
end)

RegisterCommand('tptome', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id, 'suporte.permissao') or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'moderador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			local x, y, z = vRPclient.getPosition(source)
			if tplayer then

				PerformHttpRequest(config.Tps, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 	------------------------------------------------------------
							title = 'REGISTRO DE TPTOME⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
							thumbnail = {
								url = config.webhookIcon
							}, 
							fields = {
								{ 
									name = '**COLABORADOR:**',
									value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
								},
								{ 
									name = '**ID DO PLAYER PUXADO: **'..args[1],
									value = '⠀'
								}
							}, 
							footer = { 
								text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
								icon_url = config.webhookIcon
							},
							color = config.webhookColor
						}
					}
				}), { ['Content-Type'] = 'application/json' })

				vRPclient.teleport(tplayer, x, y, z)
			end
		end
	end
end)

RegisterCommand('tpto', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id, 'suporte.permissao') or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'moderador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			if tplayer then
				PerformHttpRequest(config.Tps, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 	------------------------------------------------------------
							title = 'REGISTRO DE TPTO⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
							thumbnail = {
								url = config.webhookIcon
							}, 
							fields = {
								{ 
									name = '**COLABORADOR:**',
									value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
								},
								{ 
									name = '**ID DO PLAYER: **'..args[1],
									value = '⠀'
								}
							}, 
							footer = { 
								text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
								icon_url = config.webhookIcon
							},
							color = config.webhookColor
						}
					}
				}), { ['Content-Type'] = 'application/json' })

				vRPclient.teleport(source, vRPclient.getPosition(tplayer))
			end
		end
	end
end)

RegisterCommand('tpway', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	if vRP.hasPermission(user_id, 'suporte.permissao') or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'moderador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		
		PerformHttpRequest(config.Tps, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 	------------------------------------------------------------
					title = 'REGISTRO DE TPWAY⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
					thumbnail = {
						url = config.webhookIcon
					}, 
					fields = {
						{ 
							name = '**COLABORADOR:**',
							value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
						}
					}, 
					footer = { 
						text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
						icon_url = config.webhookIcon
					},
					color = config.webhookColor
				}
			}
		}), { ['Content-Type'] = 'application/json' })

		TriggerClientEvent('tptoway', source)
	end
end)

RegisterCommand('delnpcs', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
		TriggerClientEvent('delnpcs', source)
	end
end)

RegisterCommand('pon', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'manager.permissao') or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'moderador.permissao') or vRP.hasPermission(user_id, 'suporte.permissao') then
        local users = vRP.getUsers()
        local players = ''
		local quantidade = 0
		
        for k, v in pairs(users) do
            if k ~= #users then
                players = players
			end
			
            players = players..' '..k
            quantidade = quantidade + 1
		end
		
        TriggerClientEvent('chatMessage', source, 'TOTAL ONLINE', {255, 160, 0}, quantidade)
        TriggerClientEvent('chatMessage', source, "ID's ONLINE", {255, 160, 0}, players)
    end
end)

RegisterCommand('org', function(source, args, rawCommand)
	if args[1] then
		local source = source
		local contratado = vRP.prompt(source, 'Passaporte:', '')
		local idcontratado = parseInt(contratado)
		if contratado ~= '' then
			local org = vRP.prompt(source, 'Cargo:', '')
			if org ~= '' then
				if args[1] == 'add' then
					local user_id = vRP.getUserId(source)
					local identity = vRP.getUserIdentity(user_id)
					if org == 'orgdone' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgdone.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, 'orgdone')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgdtwo' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgdtwo.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, 'orgdtwo')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgdthree' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgdthree.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, 'orgdthree')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgdfour' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgdfour.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, 'orgdfour')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgdfive' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgdfive.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, 'orgdfive')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgdsix' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgdsix.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, 'orgdsix')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orggone' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orggone.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, 'orggone')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orggtwo' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orggtwo.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, 'orggtwo')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgmone' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgmone.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, 'orgmone')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgmtwo' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgmtwo.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, 'orgmtwo')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgmthree' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgmthree.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, 'orgmthree')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgcone' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgcone.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, 'orgcone')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgctwo' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgctwo.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, 'orgctwo')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'diretor-geral' or org == 'diretor-auxiliar' or org == 'medico-chefe' or org == 'medico-cirurgiao' or org == 'medico-aulixiar' or org == 'medico' or org == 'paramedico' or org == 'residente' or org == 'socorrista' or org == 'estagiario' or org == 'hospital' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'diretor-geral.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, org)
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'chefe-policia' or org == 'sub-chefe-policia' or org == 'inspetor' or org == 'capitao' or org == 'tenente' or org == 'sub-tenente' or org == 'primeiro-sargento' or org == 'segundo-sargento' or org == 'agente-policia' or org == 'recruta-policia' or org == 'policia' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'chefe-policia') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, org)
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'juiz' or org == 'procurador' or org == 'promotor' or org == 'defensor' or org == 'advogado' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'juiz.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, org)
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'corretor' or org == 'visitante' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-corretor.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, org)
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'taxista' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-taxista.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, org)
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'mecanico' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-mecanico.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.addUserGroup(idcontratado, org)
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					end

					PerformHttpRequest(config.Org, function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{ 
								title = 'REGISTRO DE CONTRATAÇÃO ORG⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
								thumbnail = {
									url = config.webhookIcon
								}, 
								fields = {
									{ 
										name = '**LÍDER:**',
										value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
									},
									{ 
										name = '**INFORMAÇÕES DA CONTRATAÇÃO:**',
										value = '**[ ID Contratado: '..idcontratado..' ][ Cargo: '..org..' **]\n⠀'
									}
								}, 
								footer = { 
									text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
									icon_url = config.webhookIcon
								},
								color = config.webhookColor
							}
						}
					}), { ['Content-Type'] = 'application/json' })

				elseif args[1] == 'rem' then
					local user_id = vRP.getUserId(source)
					local identity = vRP.getUserIdentity(user_id)

					if org == 'orgdone' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgdone.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, 'orgdone')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgdtwo' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgdtwo.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, 'orgdtwo')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgdthree' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgdthree.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, 'orgdthree')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgdfour' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgdfour.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, 'orgdfour')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgdfive' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgdfive.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, 'orgdfive')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgdsix' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgdsix.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, 'orgdsix')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orggone' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orggone.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, 'orggone')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orggtwo' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orggtwo.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, 'orggtwo')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgmone' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgmone.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, 'orgmone')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgmtwo' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgmtwo.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, 'orgmtwo')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgmthree' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgmthree.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, 'orgmthree')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgcone' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgcone.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, 'orgcone')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'orgctwo' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-orgctwo.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, 'orgctwo')
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'diretor-geral' or org == 'diretor-auxiliar' or org == 'medico-chefe' or org == 'medico-cirurgiao' or org == 'medico-aulixiar' or org == 'medico' or org == 'paramedico' or org == 'residente' or org == 'socorrista' or org == 'estagiario' or org == 'ems' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'diretor-geral.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, org)
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'chefe-policia' or org == 'sub-chefe-policia' or org == 'inspetor' or org == 'capitao' or org == 'tenente' or org == 'sub-tenente' or org == 'primeiro-sargento' or org == 'segundo-sargento' or org == 'agente-policia' or org == 'recruta-policia' or org == 'policia' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'chefe-policia') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, org)
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'juiz' or org == 'procurador' or org == 'promotor' or org == 'defensor' or org == 'advogado' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'juiz.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, org)
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'corretor' or org == 'visitante' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-corretor.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, org)
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'taxista' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-taxista.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, org)
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					elseif org == 'mecanico' then
						local user_id = vRP.getUserId(source)
						if vRP.hasPermission(user_id, 'lider-mecanico.permissao') or vRP.hasPermission(user_id, 'manager.permissao') then
							vRP.removeUserGroup(idcontratado, org)
						else
							TriggerClientEvent('Notify', source, 'negado', 'Permissão <b>negada</b>!')	
						end
					end

					PerformHttpRequest(config.Org, function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{ 
								title = 'REGISTRO DE DEMISSÃO ORG⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
								thumbnail = {
									url = config.webhookIcon
								}, 
								fields = {
									{ 
										name = '**LÍDER:**',
										value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
									},
									{ 
										name = '**INFORMAÇÕES DA DEMISSÃO:**',
										value = '**[ ID Contratado: '..idcontratado..' ][ Cargo: '..org..' **]\n⠀'
									}
								}, 
								footer = { 
									text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
									icon_url = config.webhookIcon
								},
								color = config.webhookColor
							}
						}
					}), { ['Content-Type'] = 'application/json' })
				end
			else
				TriggerClientEvent('Notify', source, 'negado', 'Cargo <b>inválido</b> ou <b>inexistente</b>.')
			end
		else
			TriggerClientEvent('Notify', source, 'negado', 'Passaporte <b>inválido</b> ou <b>inexistente</b>.')
		end
	end
end)

function vRPidd.getPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'manager.permissao') or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'moderador.permissao') or vRP.hasPermission(user_id, 'suporte.permissao') then
		return true
	else
		return false
	end
end

RegisterCommand('ids', function(source, args, rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'manager.permissao') or vRP.hasPermission(user_id, 'administrador.permissao') or vRP.hasPermission(user_id, 'moderador.permissao') or vRP.hasPermission(user_id, 'suporte.permissao') then
		TriggerClientEvent('mostrarid', source)
	end
end)

function vRPidd.logID()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local x, y, z = vRPclient.getPosition(source)

	PerformHttpRequest(config.Corno, function(err, text, headers) end, 'POST', json.encode({
		embeds = {
			{ 	
				title = 'REGISTRO DE ID VISIVEL:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
				thumbnail = {
				url = config.webhookIcon
				}, 
				fields = {
					{ 
						name = '**COLABORADOR DA EQUIPE:**', 
						value = '**'..identity.name..' '..identity.firstname..'** [**'..user_id..'**]\n⠀'
					},
					{ 
						name = '**LOCAL: '..tD(x)..', '..tD(y)..', '..tD(z)..'**',
						value = '⠀'
					}
				}, 
				footer = { 
					text = 'DIAMOND'..os.date('%d/%m/%Y |: %H:%M:%S'), 
					icon_url = config.webhookIcon 
				},
				color = config.webhookColor 
			}
		}
	}), { ['Content-Type'] = 'application/json' })
end

RegisterCommand('staff', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local cargo = nil
	local status = nil

	if vRP.hasPermission(user_id, 'manager.permissao') then
		cargo = 'Manager'
		status = 'Saiu do modo administrativo.'
		vRP.addUserGroup(user_id, 'off-manager')
		TriggerClientEvent('Notify', source, 'negado', '<b>[MANAGER]</b> OFF.')

	elseif vRP.hasPermission(user_id, 'off-manager.permissao') then
		cargo = 'Manager'
		status = 'Entrou no modo administrativo.'
		vRP.addUserGroup(user_id, 'manager')
		TriggerClientEvent('Notify', source, 'sucesso', '<b>[MANAGER]</b> ON.')

	elseif vRP.hasPermission(user_id, 'administrador.permissao') then
		cargo = 'Administrador'
		status = 'Saiu do modo administrativo.'
		vRP.addUserGroup(user_id, 'off-administrador')
		TriggerClientEvent('Notify', source, 'negado', '<b>[ADMINISTRADOR]</b> OFF.')

	elseif vRP.hasPermission(user_id, 'off-administrador.permissao') then
		cargo = 'Administrador'
		status = 'Entrou no modo administrativo.'
		vRP.addUserGroup(user_id, 'administrador')
		TriggerClientEvent('Notify', source, 'sucesso', '<b>[ADMINISTRADOR]</b> ON.')

	elseif vRP.hasPermission(user_id, 'moderador.permissao') then
		cargo = 'Moderador'
		status = 'Saiu do modo administrativo.'
		vRP.addUserGroup(user_id, 'off-moderador')
		TriggerClientEvent('Notify', source, 'negado', '<b>[MODERADOR]</b> OFF.')

	elseif vRP.hasPermission(user_id, 'off-moderador.permissao') then
		cargo = 'Moderador'
		status = 'Entrou no modo administrativo.'
		vRP.addUserGroup(user_id, 'moderador')
		TriggerClientEvent('Notify', source, 'sucesso', '<b>[MODERADOR]</b> ON.')

	elseif vRP.hasPermission(user_id, 'suporte.permissao') then
		cargo = 'Suporte'
		status = 'Saiu do modo administrativo.'
		vRP.addUserGroup(user_id, 'off-suporte')
		TriggerClientEvent('Notify', source, 'negado', '<b>[SUPORTE]</b> OFF.')

	elseif vRP.hasPermission(user_id, 'off-suporte.permissao') then
		cargo = 'Suporte'
		status = 'Entrou no modo administrativo.'
		vRP.addUserGroup(user_id, 'suporte')
		TriggerClientEvent('Notify', source, 'sucesso', '<b>[SUPORTE]</b> ON.')

	end

	PerformHttpRequest(config.Status, function(err, text, headers) end, 'POST', json.encode({
        embeds = {
            { 	
                title = 'REGISTRO ADMINISTRATIVO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
                thumbnail = {
                    url = config.webhookIcon
                },
                fields = {
                    { 
                        name = '**IDENTIFICAÇÃO: '..identity.name..' '..identity.firstname..'** [**'..user_id..'**]',
                        value = '⠀'
					},
					{ 
                        name = '**CARGO: **'..cargo,
						value = '⠀',
						inline = true
					},
					{ 
                        name = '**STATUS: **'..status,
						value = '⠀',
						inline = true
                    }
                },
                footer = { 
                    text = config.webhookBottomText..os.date('%d/%m/%Y | %H:%M:%S'),
                    icon_url = config.webhookIcon
                },
                color = config.webhookColor
            }
        }
    }), { ['Content-Type'] = 'application/json' })
end)

local plan = {}

RegisterCommand("plano", function(source, args)
	local source = source
	local user_id = vRP.getUserId(source)
	if args[1] == "add" then
		if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") then
			if vRP.getUserSource(tonumber(args[2])) then
				if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") then
					local consulta = vRP.getUData(tonumber(args[2]), "vRP:plano")
					local resultado = json.decode(consulta) or {}
					resultado.tempo = (resultado.tempo or 0) + tonumber(args[3]) * 86400
					plan[vRP.getUserId(source)] = resultado.tempo
					vRP.setUData(tonumber(args[2]), "vRP:plano", json.encode(resultado))
				end
			end
		end
	elseif args[1] == "info" then
		local consulta = vRP.getUData(vRP.getUserId(source), "vRP:plano")
		local resultado = json.decode(consulta) or {}

		local v = (resultado.tempo - os.time()) / 86400
		if v >= 1.0 then
			dias = "" .. math.ceil((resultado.tempo - os.time()) / 86400) .. " dia(s)"
		else
			dias = "" .. math.floor((resultado.tempo - os.time()) / 3600) .. " hora(s) "
		end

		dias = os.date("%d/%m/%Y - %X", resultado.tempo)

		TriggerClientEvent("Notify", source, "importante", "<b>Validade do plano celular: </b> " .. dias)
	end
end)

function vRPidd.getId()
	local user_id = vRP.getUserId()
	return user_id
end

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end

local run = {}
local UTC = 0

-- Adiciona VIP /admvip add 4 bronze 2
-- Remove VIP /admvip rem 4 ultimate
-- Verificar VIP /admvip status

-- Adiciona e Remove VIP /admvip add (id) (tipodevip)(dias) /adminvip /rem (id) 
RegisterCommand("admvip", function(source, args)
	local source = source
	local user_id = vRP.getUserId(source)
	local nuser_id = parseInt(args[2])
	if args[1] == "add" then
		local vip = args[3]
		if vRP.hasPermission(user_id, "manager.permissao") then
			if vip == "ultimate" then
				if vRP.getUserIdentity(nuser_id, 0) == nil then
					TriggerClientEvent("Notify", source, "negado", "Id inexistente.")
					return
				end
				vRP.addUserGroup(nuser_id, "ultimate")
				TriggerClientEvent("Notify", source, "sucesso", "ID " .. nuser_id .. " setado VIP Ultimate.")
				local consulta = vRP.getUData(nuser_id, "vRP:vip")
				local resultado = json.decode(consulta) or {}
				if next(resultado) == nil then
					resultado.tempo = os.time() + 60 * 60 * 24 * tonumber(args[4]) + 60 * 60 * UTC
				else
					resultado.tempo = (resultado.tempo or 0) + 60 * 60 * 24 * tonumber(args[4]) + 60 * 60 * UTC
				end
				vRP.setUData(nuser_id, "vRP:vip", json.encode(resultado))
			elseif vip == "platina" then
				if vRP.getUserIdentity(nuser_id, 0) == nil then
					TriggerClientEvent("Notify", source, "negado", "Id inexistente.")
					return
				end
				vRP.addUserGroup(nuser_id, "platinum")
				TriggerClientEvent("Notify", source, "sucesso", "ID " .. nuser_id .. " setado VIP Platina.")
				local consulta = vRP.getUData(nuser_id, "vRP:vip")
				local resultado = json.decode(consulta) or {}
				if next(resultado) == nil then
					resultado.tempo = os.time() + 60 * 60 * 24 * tonumber(args[4]) + 60 * 60 * UTC
				else
					resultado.tempo = (resultado.tempo or 0) + 60 * 60 * 24 * tonumber(args[4]) + 60 * 60 * UTC
				end
				vRP.setUData(nuser_id, "vRP:vip", json.encode(resultado))
			elseif vip == "ouro" then
				if vRP.getUserIdentity(nuser_id, 0) == nil then
					TriggerClientEvent("Notify", source, "negado", "Id inexistente.")
					return
				end
				vRP.addUserGroup(nuser_id, "ouro")
				TriggerClientEvent("Notify", source, "sucesso", "ID " .. nuser_id .. " setado VIP Ouro.")
				local consulta = vRP.getUData(nuser_id, "vRP:vip")
				local resultado = json.decode(consulta) or {}
				if next(resultado) == nil then
					resultado.tempo = os.time() + 60 * 60 * 24 * tonumber(args[4]) + 60 * 60 * UTC
				else
					resultado.tempo = (resultado.tempo or 0) + 60 * 60 * 24 * tonumber(args[4]) + 60 * 60 * UTC
				end
				vRP.setUData(nuser_id, "vRP:vip", json.encode(resultado))
			elseif vip == "prata" then
				if vRP.getUserIdentity(nuser_id, 0) == nil then
					TriggerClientEvent("Notify", source, "negado", "Id inexistente.")
					return
				end
				vRP.addUserGroup(nuser_id, "prata")
				TriggerClientEvent("Notify", source, "sucesso", "ID " .. nuser_id .. " setado VIP Prata.")
				local consulta = vRP.getUData(nuser_id, "vRP:vip")
				local resultado = json.decode(consulta) or {}
				if next(resultado) == nil then
					resultado.tempo = os.time() + 60 * 60 * 24 * tonumber(args[4]) + 60 * 60 * UTC
				else
					resultado.tempo = (resultado.tempo or 0) + 60 * 60 * 24 * tonumber(args[4]) + 60 * 60 * UTC
				end
				vRP.setUData(nuser_id, "vRP:vip", json.encode(resultado))
			elseif vip == "bronze" then
				if vRP.getUserIdentity(nuser_id, 0) == nil then
					TriggerClientEvent("Notify", source, "negado", "Id inexistente.")
					return
				end
				vRP.addUserGroup(nuser_id, "bronze")
				TriggerClientEvent("Notify", source, "sucesso", "ID " .. nuser_id .. " setado VIP Bronze.")
				local consulta = vRP.getUData(nuser_id, "vRP:vip")
				local resultado = json.decode(consulta) or {}
				if next(resultado) == nil then
					resultado.tempo = os.time() + 60 * 60 * 24 * tonumber(args[4]) + 60 * 60 * UTC
				else
					resultado.tempo = (resultado.tempo or 0) + 60 * 60 * 24 * tonumber(args[4]) + 60 * 60 * UTC
				end
				vRP.setUData(nuser_id, "vRP:vip", json.encode(resultado))
			end
		end
	elseif args[1] == "rem" then
		if vRP.hasPermission(vRP.getUserId(source), "manager.permissao") then
			if vRP.getUserIdentity(nuser_id, 0) == nil then
				TriggerClientEvent("Notify", source, "negado", "Id inexistente.")
				return
			end
			local consulta = vRP.getUData(nuser_id, "vRP:vip")
			local resultado = json.decode(consulta) or {}
			resultado.tempo = nil
			--run[vRP.getUserId(source)] = resultado.tempo
			vRP.setUData(nuser_id, "vRP:vip", json.encode(resultado))
			TriggerClientEvent("Notify", source, "sucesso", "Você removeu o VIP do ID: " .. nuser_id)
			if vRP.hasPermission(nuser_id, "ultimate.permissao") then
				vRP.removeUserGroup(nuser_id, "ultimate")
			elseif vRP.hasPermission(nuser_id, "platinum.permissao") then
				vRP.removeUserGroup(nuser_id, "platinum")
			elseif vRP.hasPermission(nuser_id, "ouro.permissao") then
				vRP.removeUserGroup(nuser_id, "ouro")
			elseif vRP.hasPermission(nuser_id, "prata.permissao") then
				vRP.removeUserGroup(nuser_id, "prata")
			elseif vRP.hasPermission(nuser_id, "bronze.permissao") then
				vRP.removeUserGroup(nuser_id, "bronze")
			end
		end
	elseif args[1] == "status" then
		local pass = ""
		local consulta = vRP.getUData(vRP.getUserId(source), "vRP:vip")
		local resultado = json.decode(consulta) or {}
		if next(resultado) == nil then
			TriggerClientEvent("Notify", source, "negado", "Voce não possui VIP")
			return
		end

		local v = (resultado.tempo - os.time()) / 86400
		if v >= 1.0 then
			dias = "" .. math.ceil((resultado.tempo - os.time()) / 86400) .. " dia(s)"
		else
			dias = "" .. math.floor((resultado.tempo - os.time()) / 3600) .. " hora(s) "
		end

		dias = os.date("%d/%m/%Y - %X", resultado.tempo)

		if vRP.hasPermission(user_id, "ultimate.permissao") then
			pass = "Ultimate"
		elseif vRP.hasPermission(user_id, "platinum.permissao") then
			pass = "Platina"
		elseif vRP.hasPermission(user_id, "ouro.permissao") then
			pass = "Ouro"
		elseif vRP.hasPermission(user_id, "prata.permissao") then
			pass = "Prata"
		elseif vRP.hasPermission(user_id, "bronze.permissao") then
			pass = "Bronze"
		end

		TriggerClientEvent("Notify", source, "importante", "<b>VIP:</b> " .. pass .. " | <b>Validade: </b> " .. dias)
	end
end)

RegisterCommand('ice41', function(source, rawCommand)
	if not vRPclient.getCancelando(source) then
		local user_id = vRP.getUserId(source)
		vRPclient._setCustomization(source, vRPclient.getCustomization(source))
		vRP.removeCloak(source)
		TriggerClientEvent("nation_barbershop:reloadOverlay", source)
	else
		TriggerClientEvent('Notify', source, 'negado', 'Você não pode dar bvida pois está em tratamento')
	end		
end)

RegisterCommand('status', function(source, rawCommand)
	local police, mec, ems = 0, 0, 0
	for k, v in pairs(vRP.getUsers()) do
		id = vRP.getUserId(v)
		if vRP.hasPermission(id, 'policia.permissao') then
			police = police + 1
		elseif vRP.hasPermission(id, 'hospital.permissao') then
			ems = ems + 1
		elseif vRP.hasPermission(id, 'mecanico.permissao') then
			mec = mec + 1
		end
	end
	TriggerClientEvent('Notify', source, 'importante', '<b>Policiais</b> online: '..police)
	TriggerClientEvent('Notify', source, 'importante', '<b>Medicos</b> online: '..ems)
	TriggerClientEvent('Notify', source, 'importante', '<b>Mecanicos</b> online: '..mec)
end)

-- Manda mensagem privada /msgpv ID
RegisterCommand('msgpv', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserSource(parseInt(args[1]))
    if vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, "manager.permissao") then
        if args[1] == nil then
            TriggerClientEvent("Notify", source, "negado", "Necessário passar o ID após o comando, exemplo: <b>/dm 1</b>")
            return
        elseif nplayer == nil then
            TriggerClientEvent("Notify", source, "negado", "O jogador não está online!")
            return
        end
        local mensagem = vRP.prompt(source, "Digite a mensagem:", "")
        if mensagem == "" then
            return
        end
        TriggerClientEvent("Notify", source, "sucesso", "Mensagem enviada com sucesso!")
        TriggerClientEvent('chatMessage', nplayer, "MENSAGEM DA ADMINISTRAÇÃO:", { 50, 205, 50 }, mensagem)
        TriggerClientEvent("Notify", nplayer, "aviso", "<b>Mensagem da Administração:</b> " .. mensagem .. "", 30000)
    end
end)

-- Comando RG2 info do player
RegisterCommand('rg2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "suporte.permissao") or vRP.hasPermission(user_id, "administrador.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, "manager.permissao") then
        local nuser_id = parseInt(args[1])
        local identity = vRP.getUserIdentity(nuser_id)
        local bankMoney = vRP.getBankMoney(nuser_id)
        local walletMoney = vRP.getMoney(nuser_id)
        local sets = json.decode(vRP.getUData(nuser_id, "vRP:datatable"))


        if args[1] then
            TriggerClientEvent("Notify", source, "importante", "ID: <b>" .. parseInt(nuser_id) .. "</b><br>Nome: <b>" .. identity.name .. " " .. identity.firstname .. "</b><br>Idade: <b>" .. identity.age .. "</b><br>Telefone: <b>" .. identity.phone .. "</b><br>Carteira: <b>" .. vRP.format(parseInt(walletMoney)) .. "</b><br>Banco: <b>" .. vRP.format(parseInt(bankMoney)) .. "</b><br>Sets: <b>" .. json.encode(sets.groups) .. "</b>", 5000)
        else
            TriggerClientEvent("Notify", source, "negado", "Negado", "Digite o ID desejado!")

        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FESTINHA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('festinha',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id, "administrador.permissao") then
        local identity = vRP.getUserIdentity(user_id)
        local mensagem = vRP.prompt(source,"Mensagem:","")
        if mensagem == "" then
            return
        end
        vRPclient.setDiv(-1,"festinha"," @keyframes blinking {    0%{ background-color: #ff3d50; border: 2px solid #871924; opacity: 0.8; } 25%{ background-color: #d22d99; border: 2px solid #901f69; opacity: 0.8; } 50%{ background-color: #55d66b; border: 2px solid #126620; opacity: 0.8; } 75%{ background-color: #22e5e0; border: 2px solid #15928f; opacity: 0.8; } 100%{ background-color: #222291; border: 2px solid #6565f2; opacity: 0.8; }  } .div_festinha { font-size: 11px; font-family: arial; color: rgba(255, 255, 255,1); padding: 30px; bottom: 40%; right: 1%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; animation: blinking 1s infinite; } bold { font-size: 16px; }","<bold>"..mensagem.."</bold><br><br> "..identity.name.." "..identity.firstname)
        SetTimeout(30000,function()
            vRPclient.removeDiv(-1,"festinha")
        end)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('anunciar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "manager.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"hospital.permissao") or vRP.hasPermission(user_id,"mecanico.permissao") then
		local identity = vRP.getUserIdentity(user_id)
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end
		vRPclient.setDiv(-1,"anuncio",".div_anuncio { background: rgba(0,128,192,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 10%; right: 4%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 15px; }","<bold>"..mensagem.."</bold><br><br>Mensagem enviada por: "..identity.name.." "..identity.firstname)
		SetTimeout(30000,function()
			vRPclient.removeDiv(-1,"anuncio")
		end)
	end
end)
