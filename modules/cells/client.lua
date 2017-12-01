Config.Modules.Cells = {}

Config.Modules.Cells.ShowMenuOpenClose = function()

    ESX.TriggerServerCallback("esx_jail:getCellsState", function(cells)

        local _cells = {}

        for k,v in pairs(cells) do
            table.insert(_cells, {
                id = k,
                state = v
            })
        end

        SendNUIMessage({
            type = 'showMenu',
            data = _cells
        })

        SetNuiFocus(true, true)

    end)
end

Config.Modules.Cells.OpenClose = function(cell)
    if cell == 'open_all' or cell =='close_all' then

        local angle = 180.0
        if cell == 'open_all' then
            angle = -90.0
        end

        local cells = {}

        for k,v in pairs(Config.Cells) do
            local cell_door = GetClosestObjectOfType(
                Config.Cells[k].x,
                Config.Cells[k].y,
                Config.Cells[k].z,
                1.0,
                -275220570, false, false, false)

            local id = NetworkGetNetworkIdFromEntity(cell_door)
            SetNetworkIdCanMigrate(id, true)
            SetNetworkIdExistsOnAllMachines(id, true)
            NetworkRequestControlOfEntity(cell_door)
            table.insert(cells, cell_door)
        end
        TriggerServerEvent("esx_jail:dispatchCells", angle, cells)
    else
        local cell_door = GetClosestObjectOfType(
            Config.Cells[cell].x,
            Config.Cells[cell].y,
            Config.Cells[cell].z,
            1.0,
            -275220570, false, false, false)

        local xRot, yRot, zRot = table.unpack(GetEntityRotation(cell_door, 1))

        local angle = 180.0
        if zRot ~= -90.0 then
            angle = -90.0
        end

        local id = NetworkGetNetworkIdFromEntity(cell_door)
        SetNetworkIdCanMigrate(id, true, false)        
        SetEntityAsMissionEntity(cell_door)
        TriggerServerEvent("esx_jail:dispatchCell", angle, cell_door)        
    end
end

RegisterNUICallback('select', function(data, cb)
    print("select UI " .. json.ecode(data))
    Config.Modules.Cells.OpenClose(data.id)
end)

RegisterNUICallback('close', function(data, cb)
    print("closing UI")
    SetNuiFocus(false)
end)

RegisterNetEvent('esx_jail:dispatchCells')
AddEventHandler('esx_jail:dispatchCells', function(angle, cells)
    for i=1, #cells, 1 do
        SetEntityRotation(cells[i], 0.0, 0.0, angle, 1, true)
    end
end)

RegisterNetEvent('esx_jail:dispatchCell')
AddEventHandler('esx_jail:dispatchCell', function(angle, cell)
    SetEntityRotation(cell, 0.0, 0.0, angle, 1, true)
end)


print("LOADED")
