local ESX = nil

TriggerEvent(Config.GetESX, function(obj)
    ESX = obj
end)

ESX.RegisterServerCallback("cst_location-ui:buyVehicle", function(source, cb, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
         if xPlayer.getMoney() >= price then
              cb(true)
              xPlayer.removeMoney(price)
         else
              cb(false)
         end
    end
end)

-- Copyright (c) 2022 COSSART - LazyDev --