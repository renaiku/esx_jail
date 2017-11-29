ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- true => closed
Cells = {
	floor1_cell_1 = true,
	floor1_cell_2 = true,
	floor1_cell_4 = true,
	floor1_cell_5 = true,
	floor1_cell_3 = true,
	floor1_cell_6 = true,
	floor1_cell_7 = true,
	floor2_cell_7 = true,
	floor2_cell_6 = true,
	floor2_cell_5 = true,
	floor2_cell_4 = true,
	floor2_cell_3 = true,
	floor2_cell_2 = true,
	floor2_cell_1 = true
}

ESX.RegisterServerCallback("esx_jail:getCellsState", function(source, cb)
	cb(Cells)
end)

RegisterServerEvent("esx_jail:setCellsState") 
AddEventHandler("esx_jail:setCellsState", function(cell, state)
	Cells[cell] = state
end)

RegisterServerEvent("esx_jail:dispatchCells") 
AddEventHandler("esx_jail:dispatchCells", function(angle, cells)
	local state = true

	if angle ~= 180.0 then
		state = false
	end

	for k,v in pairs(Cells) do
		Cells[k] = state
	end

    TriggerClientEvent("esx_jail:dispatchCells", -1, angle, cells) 
end)

RegisterServerEvent("esx_jail:dispatchCell") 
AddEventHandler("esx_jail:dispatchCell", function(angle, cell)
	local state = true
	
	if angle ~= 180.0 then
		state = false
	end

	Cells[cell] = state

    TriggerClientEvent("esx_jail:dispatchCell", -1, angle, cell) 
end)