local carryCarcass = 0
local heaviestCarcass = 0

local animals = {}
local listItemCarcass= {}
local CarcassByItem= {}
for key, value in pairs(Config.carcass) do
    table.insert(animals, key)
    table.insert(listItemCarcass, value)
    CarcassByItem[value] = key
end
RegisterNetEvent('ox:playerLoaded')
AddEventHandler('ox:playerLoaded',function ()
    TriggerEvent('nfire_hunting:CarryCarcass')
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function ()
    TriggerEvent('nfire_hunting:CarryCarcass')
end)

exports.qtarget:AddTargetModel(animals, {
    options = {
        {
            action = function (entity)
                TriggerEvent('ox_inventory:disarm')
                local retval, bone = GetPedLastDamageBone(entity)
                TaskTurnPedToFaceEntity(PlayerPedId(), entity, -1)
                Wait(500)
                exports.ox_inventory:Progress({
                    duration = 3000,
                    label = _U('pickup_carcass'),
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        move = true,
                        car = true,
                        combat = true,
                        mouse = false
                    },
                    anim = {
                        dict = 'amb@medic@standing@kneel@idle_a',
                        clip = 'idle_a',
                        flag = 1,
                    },
                }, function(cancel)
                    if not cancel then
                        TriggerServerEvent('nfire_hunting:harvestCarcass',NetworkGetNetworkIdFromEntity(entity),bone)
                    end
                end)
            end,
            icon = "fa-solid fa-paw",
            label = _U('pickup_carcass'),
            canInteract = function (entity)
                return IsEntityDead(entity) and not IsEntityAMissionEntity(entity)
            end
        },
    },
    distance = 2
})

AddEventHandler('nfire_hunting:CarryCarcass',function ()
    TriggerEvent('ox_inventory:disarm')
    FreezeEntityPosition(playerPed, false)
    heaviestCarcass = 0
    local carcassCount = 0
    for key, value in pairs(exports.ox_inventory:Search('count', listItemCarcass)) do
        carcassCount += value
    end
    if carcassCount > 0 then
        local inventory = exports.ox_inventory:Search('slots', listItemCarcass)
        local weight = 0
        for key, value in pairs(inventory) do
            if next(value) ~= nil and value[1].weight > weight then
                weight = value[1].weight
                heaviestCarcass = CarcassByItem[key]
            end
        end

        lib.requestModel(heaviestCarcass)
        DeleteEntity(carryCarcass)
        carryCarcass = CreatePed(1, heaviestCarcass, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, true)
        SetEntityInvincible(carryCarcass, true)
        SetEntityHealth(carryCarcass, 0)
        local pos = Config.carcassPos[heaviestCarcass]
        AttachEntityToEntity(carryCarcass, PlayerPedId(),11816, pos.xPos, pos.yPos, pos.zPos, pos.xRot, pos.yRot, pos.zRot, false, false, false, true, 2, true)
        PlayCarryAnim()
    else
        DeleteEntity(carryCarcass)
        carryCarcass = 0
        PlayCarryAnim()
    end
end)
RegisterCommand('carcass', function ()
    lib.requestAnimDict('amb@medic@standing@kneel@idle_a')
    TaskPlayAnim(PlayerPedId(), 'amb@medic@standing@kneel@idle_a', 'idle_a', 8.0, -8.0, 10000, 1, 0, false, false, false)
end)


function PlayCarryAnim()
    if carryCarcass ~= 0 then
        if Config.carcassPos[heaviestCarcass].drag then
            lib.requestAnimDict('move_m@hiking')
            TaskPlayAnim(PlayerPedId(), 'move_m@hiking', 'idle', 2.0, 2.0, 100000, 49, 0, false, false, false)
            while carryCarcass ~= 0 do
                while not IsEntityPlayingAnim(PlayerPedId(), 'move_m@hiking', 'idle', 49) do
                    TaskPlayAnim(PlayerPedId(), 'move_m@hiking', 'idle', 2.0, 2.0, 100000, 49, 0, false, false, false)
                    Wait(0)
                end
                Wait(500)
            end
        else
            lib.requestAnimDict('missfinale_c2mcs_1')
            TaskPlayAnim(PlayerPedId(), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 8.0, -8.0, 100000, 49, 0, false, false, false)
            while carryCarcass ~= 0 do
                while not IsEntityPlayingAnim(PlayerPedId(), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 49) do
                    TaskPlayAnim(PlayerPedId(), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 8.0, -8.0, 100000, 49, 0, false, false, false)
                    Wait(0)
                end
                Wait(500)
            end
        end
    else
        ClearPedSecondaryTask(PlayerPedId())
    end
end

-- function CustomControl()
--     Citizen.CreateThread(function ()
--         local playerPed = PlayerPedId()
--         local enable = true

--         while enable do
--             if IsControlPressed(0, 35) then -- Right
--                 FreezeEntityPosition(playerPed, false)
--                 SetEntityHeading(playerPed, GetEntityHeading(playerPed)+0.5)
--             elseif IsControlPressed(0, 34) then -- Left
--                 FreezeEntityPosition(playerPed, false)
--                 SetEntityHeading(playerPed, GetEntityHeading(playerPed)-0.5)
--             elseif IsControlPressed(0, 32) or IsControlPressed(0, 33) then
--                 FreezeEntityPosition(playerPed, false)
--             else
--                 FreezeEntityPosition(playerPed, true)
--                 TaskPlayAnim(PlayerPedId(), 'move_m@hiking', 'idle', 0.0, 0.0, 1, 2, 7, false, false, false)
--             end
--             Wait(7)
--             if heaviestCarcass ~= 0 then
--                 enable = Config.carcassPos[heaviestCarcass].drag
--             else
--                 enable = false
--             end
--         end
--         FreezeEntityPosition(playerPed, false)
--         ClearPedSecondaryTask(playerPed)
--         ClearPedTasksImmediately(playerPed)
--     end)
-- end


--------------------- SELL -----------------------------------

exports.qtarget:AddBoxZone("nfire_hunting_sell",vector3(963.34, -2115.39, 31.47), 6.8, 1, {
    name="nfire_hunting_sell",
    heading=355,
    --debugPoly=true,
    minZ=31.27,
    maxZ=34.67
	}, {
		options = {
			{
				action = function ()
                    exports.ox_inventory:Progress({
                        duration = 3000,
                        label = _U('sell_in_progress'),
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                            mouse = false
                        },
                    }, function(cancel)
                        if not cancel then
                            TriggerServerEvent('nfire_hunting:SellCarcass', Config.carcass[heaviestCarcass])
                        end
                    end)
                end,
				icon = "fa-solid fa-sack-dollar",
				label = _U('sell_carcass'),
                canInteract= function ()
                    return heaviestCarcass ~= 0
                end
			},
		},
		distance = 2.0
})

Citizen.CreateThread(function ()
    blip = AddBlipForCoord(963.34, -2115.39)
	SetBlipSprite(blip, 141)
	SetBlipScale(blip, 0.8)
	SetBlipColour(blip, 43)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString(_U'blip_name')
	EndTextCommandSetBlipName(blip)
end)

------------------------------ DEBUG TOOLS -------------------------

if Config.debug then

    local attachTool = false
    local attachedPed
    RegisterCommand('attachTool', function(source,args)
        if attachTool then
            attachTool = false
            DeleteEntity(attachedPed)
            ClearPedSecondaryTask(PlayerPedId())
            return
        end
        attachTool = true

        lib.requestAnimDict('move_m@hiking')
        TaskPlayAnim(PlayerPedId(), 'move_m@hiking', 'idle', 2.0, 2.0, -1, 49, 0, false, false, false)

        local model = GetHashKey(args[1])
        lib.requestModel(model)
        DeleteEntity(attachedPed)
        attachedPed = CreatePed(1, model, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, true)
        SetEntityInvincible(attachedPed, true)
        SetEntityHealth(attachedPed, 0)
        local pos = Config.carcassPos[model]
        print('pos: '.. json.encode(pos,{indent = true}))
        AttachEntityToEntity(attachedPed, PlayerPedId(),11816, pos.xPos, pos.yPos, pos.zPos, pos.xRot, pos.yRot, pos.zRot, false, false, false, true, 2, true)
        while attachTool do
            if IsControlPressed(0, 191) then -- ENTER
                print('pos: '.. json.encode(pos))
                lib.setClipboard(json.encode(pos))
            ----------------------------- ROTATION SHIFT ------------------------------------------------------------------
            elseif IsControlPressed(0, 174) and IsControlPressed(0, 21) then -- ARROW LEFT
                pos.xRot += 1
            elseif IsControlPressed(0, 175) and IsControlPressed(0, 21) then -- ARROW RIGHT
                pos.xRot -= 1
            elseif IsControlPressed(0, 172) and IsControlPressed(0, 21) then -- ARROW UP
                pos.yRot += 1
            elseif IsControlPressed(0, 173) and IsControlPressed(0, 21) then -- ARROW DOWN
                pos.yRot -= 1
            elseif IsControlPressed(0, 10) and IsControlPressed(0, 21) then -- PAGE UP
                pos.zRot += 1
            elseif IsControlPressed(0, 11) and IsControlPressed(0, 21) then -- PAGE DOWN
                pos.zRot -= 1
            ----------------------------------- POS -----------------------------------------------------------------------------------
            elseif IsControlPressed(0, 174) then -- ARROW LEFT
                pos.xPos += 0.01
            elseif IsControlPressed(0, 175) then -- ARROW RIGHT
                pos.xPos -= 0.01
            elseif IsControlPressed(0, 172) then -- ARROW UP
                pos.yPos -= 0.01
            elseif IsControlPressed(0, 173) then -- ARROW DOWN
                pos.yPos += 0.01
            elseif IsControlPressed(0, 10) then -- PAGE UP
                pos.zPos += 0.01
            elseif IsControlPressed(0, 11) then -- PAGE DOWN
                pos.zPos -= 0.01
            end
            AttachEntityToEntity(attachedPed, PlayerPedId(),11816, pos.xPos, pos.yPos, pos.zPos, pos.xRot, pos.yRot, pos.zRot, false, false, false, true, 2, true)
            Wait(100)
        end
    end)

end
{"zPos":-0.70999999999999,"yPos":-0.91,"zRot":-156.0,"xRot":-357.0,"yRot":92.0,"drag":true,"xPos":-0.85}