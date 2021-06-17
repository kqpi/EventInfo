ESX = nil
-- kqpi#4453
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('event', function(source, args, rawCommand)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
		
	if xPlayer.getGroup() == Config.permisja then
		TriggerClientEvent("k_eventy:otwieramenu", source, eloszka)
	end
end)

RegisterServerEvent("k_eventy:event1")
AddEventHandler("k_eventy:event1", function(elo)
	TriggerClientEvent("k_eventy:event1", -1, source, elo)
end)

RegisterServerEvent("k_eventy:event2")
AddEventHandler("k_eventy:event2", function(elo2)
	TriggerClientEvent("k_eventy:event2", -1, source, elo2)
end)

RegisterServerEvent("k_eventy:customedevent")
AddEventHandler("k_eventy:customedevent", function(text)
	TriggerClientEvent("k_eventy:customedevent", -1, source, text)
end)

-- kqpi#4453