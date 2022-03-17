local carryCarcass = 0

local animals = {}
local listItemCarcass= {}
local CarcassByItem= {}
for key, value in pairs(Config.carcass) do
    table.insert(animals, key)
    table.insert(listItemCarcass, value)
    CarcassByItem[value] = key
end


exports.qtarget:AddTargetModel(animals, {
	options = {
		{
			action = function (entity)
                TriggerServerEvent('nfire_hunting:harvestCarcass',NetworkGetNetworkIdFromEntity(entity))
            end,
			icon = "fas fa-paw",
			label = _U('pickup_carcass'),
            canInteract = function (entity)
                return IsEntityDead(entity) and not IsEntityAMissionEntity(entity)
            end
		},
	},
	distance = 2
})

AddEventHandler('nfire_hunting:CarryCarcass',function ()
    local carcassCount = 0
    local heaviestCarcass
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

        RequestModel(heaviestCarcass)
        while not HasModelLoaded(heaviestCarcass) do
            Wait(0)
        end
        DeleteEntity(carryCarcass)
        carryCarcass = CreatePed(1, heaviestCarcass, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, true)
        SetEntityInvincible(carryCarcass, true)
        SetEntityHealth(carryCarcass, 0)
        -- SetPedToRagdoll(carryCarcass, 10000, 10000, 0, false, false, false)
        AttachEntityToEntity(carryCarcass, PlayerPedId(), table.unpack(Config.carcassPos[heaviestCarcass]), false, false, false, false, 2, false)
        PlayCarryAnim()
    else
        DeleteEntity(carryCarcass)
        carryCarcass = 0
        PlayCarryAnim()
        print('no carcass')
    end
end)
RegisterCommand('carcass', function ()
    TriggerEvent('nfire_hunting:CarryCarcass')
end)


function PlayCarryAnim()
    if carryCarcass ~= 0 then
        RequestAnimDict('missfinale_c2mcs_1')

	    while not HasAnimDictLoaded('missfinale_c2mcs_1') do
	    	Wait(10)
	    end
        TaskPlayAnim(PlayerPedId(), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 8.0, -8.0, 100000, 49, 0, false, false, false)
        while carryCarcass ~= 0 do
            while not IsEntityPlayingAnim(PlayerPedId(), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 49) do
                TaskPlayAnim(PlayerPedId(), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 8.0, -8.0, 100000, 49, 0, false, false, false)
                Wait(0)
            end
            SetPedToRagdoll(carryCarcass, 10000, 10000, 0, false, false, false)
            Wait(500)
        end
    else
        ClearPedSecondaryTask(PlayerPedId())
    end
end