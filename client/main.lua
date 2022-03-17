local carryCarcass

local listItemCarcass= {}
local CarcassByItem= {}
for key, value in pairs(Config.carcass) do
    table.insert(listItemCarcass, value)
    CarcassByItem[value] = key
end

exports.qtarget:AddTargetModel(Config.animals, {
	options = {
		{
			action = function (entity)
                TriggerServerEvent('nfire_hunting:harvestCarcass',NetworkGetNetworkIdFromEntity(entity))
            end,
			icon = "fas fa-paw",
			label = _U('pickup_carcass'),
            canInteract = function (entity)
                return IsEntityDead(entity)
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
                heaviestCarcass = key
            end
        end
    else
        print('no carcass')
    end
end)
RegisterCommand('carcass', function ()
    TriggerEvent('nfire_hunting:CarryCarcass')
end)