-- Plano celular / telefone by ice41
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------

local run = {}

--[ FUNÇÕES & EVENTOS ]------------------------------------------------------------------------------------------------------------------

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
		run[user_id] = 1
end)

AddEventHandler("vRP:playerLeave", function(user_id)
	if run[user_id] then
		run[user_id] = nil
	end
end)

Citizen.CreateThread(function()
	while true do
		for k,v in pairs(run) do
			if vRP.getUserSource(k) then
				local consulta = vRP.getUData(k,"vRP:plano")
				local resultado = json.decode(consulta) or {}
				if next(resultado) ~= nil then
					if os.time() > resultado.tempo then
						resultado.tempo = nil
						vRP.setUData(k, "vRP:plano", json.encode(resultado))
						TriggerClientEvent("Notify", vRP.getUserSource(k), "importante", "Seu Plano de celular expirou")
					end
				end
			end
		end
		Citizen.Wait(10000)
	end
end)
