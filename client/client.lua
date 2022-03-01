local ESX = nil

TriggerEvent(Config.GetESX, function(obj)
    ESX = obj
end)

-- FERMER LE NUI
RegisterNUICallback('close', function(data, cb)
	SetNuiFocus( false )
	SendNUIMessage({display = false})
  	cb('ok')
end)

-- INTERACTION
CreateThread(function()
	local blip = AddBlipForCoord(Config.Location.Positions.PosMenu)
	SetBlipSprite(blip, Config.Location.Blip.Sprite)
	SetBlipDisplay(blip, Config.Location.Blip.Display)
	SetBlipScale(blip, Config.Location.Blip.Scale)
	SetBlipColour(blip, Config.Location.Blip.Color)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config.Location.Blip.Name)
	EndTextCommandSetBlipName(blip)
    while true do
        Citizen.Wait(1)
        local pCoords = GetEntityCoords(PlayerPedId())
        local SleepWait = true
        if #(pCoords - Config.Location.Positions.PosMenu) < 1.2 then
            SleepWait = false
            ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour accéder au menu ~b~location.")
            if IsControlJustReleased(0, 38) then
                SetNuiFocus( true, true )
                SendNUIMessage({display = true})
            end
		end
        if SleepWait then
           Citizen.Wait(500)
        end
    end
end)

RegisterNUICallback('cst_location-ui:buy', function(data, cb)
    price = tonumber(data.price)
    ESX.TriggerServerCallback("cst_location-ui:buyVehicle", function(HasPrice)
		if HasPrice then
			SetNuiFocus( false )
			SendNUIMessage({
				display = false
			})
			local model = GetHashKey(data.name)
			RequestModel(model)
			while not HasModelLoaded(model) do Citizen.Wait(10) end
			DoScreenFadeOut(1000)
			Wait(1000)
			print(Config.Location.SpawnPosition)
			local vehicle = CreateVehicle(model, Config.Location.Positions.SpawnPosition.x, Config.Location.Positions.SpawnPosition.y, Config.Location.Positions.SpawnPosition.z, Config.Location.Positions.SpawnPosition.w, true, false)
			SetVehicleNumberPlateText(vehicle, "loc-"..math.random(50, 999))
			SetVehRadioStation(vehicle, false)
			SetVehicleMaxSpeed(vehicle, 23.0)
			TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
			DoScreenFadeIn(1000)
		else
			ESX.ShowNotification("~r~Vous n'avez pas assez d'argent !")
		end
	end, price)
    cb('ok')
end)

-- PED
Citizen.CreateThread(function()
    local hash = GetHashKey("s_m_m_autoshop_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
      Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "s_m_m_autoshop_01", Config.Location.Positions.SpawnPed.x, Config.Location.Positions.SpawnPed.y, Config.Location.Positions.SpawnPed.z, Config.Location.Positions.SpawnPed.w, false, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

-- Copyright (c) 2022 COSSART - LazyDev --