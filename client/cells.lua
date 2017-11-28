Cells = {}

Cells.debug = 'test'

Cells.ShowMenuOpenClose = function()

    local elements = {}

    table.insert(elements, {label = _U('open_all'),   value = 'open_all'})
    table.insert(elements, {label = _U('close_all'),  value = 'close_all'})
    table.insert(elements, {label = _U('floor1'),     value = 'floor1'})
    table.insert(elements, {label = _U('floor2'),     value = 'floor2'})

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'cells',
        {
            title = _U('cells'),
            align = 'top-left',
            elements = elements
        },
        function(data, menu) --Submit Cb
            local val = data.current.value
            if val == 'open_all' or val == 'close_all' then
                Cells.OpenClose(val)
                menu.close()
                CurrentAction     = 'cells_menu'
                CurrentActionMsg  = _U('cells_menu')
                CurrentActionData = {}
            else
                local elements2 = {}

                for i=1, 7, 1 do
                    table.insert(elements2, 
                    {
                        label = _U('cell') .. ' ' .. i,
                        value = val .. '_cell_' .. i,
                    })
                end

                ESX.UI.Menu.Open(
                    'default', GetCurrentResourceName(), 'cells2',
                    {
                        title = _U(val),
                        align = 'top-left',
                        elements = elements2
                    },
                    function(data2, menu2) --Submit Cb
                        Cells.OpenClose(data2.current.value)
                    end,
                    function(data, menu) --Cancel Cb
                        menu.close()
                    end
                )
            end
        end,
        function(data, menu) --Cancel Cb
            menu.close()
            CurrentAction     = 'cells_menu'
            CurrentActionMsg  = _U('cells_menu')
            CurrentActionData = {}
        end
    )
end

Cells.OpenClose = function(cell)
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