ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("esx_jail:dispatchCells") 
AddEventHandler("esx_jail:dispatchCells", function(angle, cells) 
    TriggerClientEvent("esx_jail:dispatchCells", -1, angle, cells) 
end)

RegisterServerEvent("esx_jail:dispatchCell") 
AddEventHandler("esx_jail:dispatchCell", function(angle, cell) 

    TriggerClientEvent("esx_jail:dispatchCell", -1, angle, cell) 
end)