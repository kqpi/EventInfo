-- kqpi#4453

ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    PlayerLoaded = true
    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("k_eventy:otwieramenu")
AddEventHandler('k_eventy:otwieramenu', function(eloszka)
	MenuWybierania()
end)

RegisterNetEvent("k_eventy:event1")
AddEventHandler("k_eventy:event1", function(source, elo)
	Player = PlayerId()
	Ped = PlayerPedId()
	Coords = GetEntityCoords(Ped)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(source)
	if pid == myId then
		ESX.ShowNotification("~r~Rozpoczyna sie Event: " .. Config.event1)
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(4, 219, 0, 0.6); border-radius: 3px;"><i class="fa fa-exclamation-triangle"></i> {0}: Za chwile rozpocznie sie event: "' .. Config.event1 ..'" Sprawdz Lokalizacje na GPS</div>',
			args = { "EVENTY", text }
		})
		
	end

	local blipname = 'event1' .. source
	blipname = AddBlipForCoord(Coords.x, Coords.y, Coords.z)
		SetBlipSprite(blipname, 66)
		SetBlipScale(blipname, 1.0)
		SetBlipColour(blipname, 77)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Event: ' ..  Config.event1)
		EndTextCommandSetBlipName(blipname)
	Citizen.SetTimeout(Config.CzasBlipa, function()
		RemoveBlip(blipname)
	end)
end)

RegisterNetEvent("k_eventy:event2")
AddEventHandler("k_eventy:event2", function(source, elo2)
	Player = PlayerId()
	Ped = PlayerPedId()
	Coords = GetEntityCoords(Ped)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(source)
	if pid == myId then
		ESX.ShowNotification("~r~Rozpoczyna sie Event: " .. Config.event2)
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(4, 219, 0, 0.6); border-radius: 3px;"><i class="fa fa-exclamation-triangle"></i> {0}: Za chwile rozpocznie sie event: "' .. Config.event2 ..'" Sprawdz Lokalizacje na GPS</div>',
			args = { "EVENTY", text }
		})
		
	end

	local blipname = 'event2' .. source
	blipname = AddBlipForCoord(Coords.x, Coords.y, Coords.z)
		SetBlipSprite(blipname, 66)
		SetBlipScale(blipname, 1.0)
		SetBlipColour(blipname, 77)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Event: ' ..  Config.event2)
		EndTextCommandSetBlipName(blipname)
	Citizen.SetTimeout(Config.CzasBlipa, function()
		RemoveBlip(blipname)
	end)
end)

RegisterNetEvent("k_eventy:customedevent")
AddEventHandler("k_eventy:customedevent", function(source, text)
	Player = PlayerId()
	Ped = PlayerPedId()
	Coords = GetEntityCoords(Ped)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(source)
	if pid == myId then
		ESX.ShowNotification("~r~Rozpoczyna sie Event: " .. text)
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(4, 219, 0, 0.6); border-radius: 3px;"><i class="fa fa-exclamation-triangle"></i> {0}: Za chwile rozpocznie sie event: "' .. text ..'" Sprawdz Lokalizacje na GPS</div>',
			args = { "EVENTY", text }
		})
		
	end

	local blipname = 'customedevent' .. source
	blipname = AddBlipForCoord(Coords.x, Coords.y, Coords.z)
		SetBlipSprite(blipname, 66)
		SetBlipScale(blipname, 1.0)
		SetBlipColour(blipname, 77)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Event: ' .. text)
		EndTextCommandSetBlipName(blipname)
	Citizen.SetTimeout(Config.CzasBlipa, function()
		RemoveBlip(blipname)
	end)
end)

function MenuWybierania()
  
    local elements = {
        {label = 'Wybierz rodzaj Eventu',     value = 'none'},
        {label = '====================================',     value = 'none'},
        {label = Config.event1,     value = 'event1'},
        {label = Config.event2,     value = 'event2'},
		{label = "Customowy Event",     value = 'customevent'},

        }
    
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'anulowanie',
      {
        title    = 'Eventy',
        align    = 'center',
        elements = elements
        },
            function(data2, menu2)
                if data2.current.value == 'event1' then
					TriggerServerEvent("k_eventy:event1")
                    ESX.UI.Menu.CloseAll()
                elseif data2.current.value == 'event2' then
					TriggerServerEvent("k_eventy:event2")
                    ESX.UI.Menu.CloseAll()
				elseif data2.current.value == 'customevent' then
					ESX.UI.Menu.CloseAll()
					ESX.UI.Menu.Open(
          			'dialog', GetCurrentResourceName(), 'customevent_text',
          			{
            			title = "Wpisz Nazwe Eventu"
          			},
         			 function(data2, menu2)
            			local text = data2.value
            			if text  == nil then
            			    TriggerEvent('esx:showNotification', 'Wiadomość nie może być pusta!')
            			else
                			menu2.close()
							TriggerServerEvent("k_eventy:customedevent", text)
            			end

          			end,
        			function(data2, menu2)
            			menu2.close()
        			end)
        			end

            end,
            function(data, menu)
            menu.close()
          end)
    end 

-- kqpi#4453