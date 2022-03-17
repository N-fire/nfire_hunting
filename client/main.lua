local carryCarcass

local listItemCarcass
for key, value in pairs(Config.carcass) do
    table.insert(listItemCarcass, value)
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
    if exports.ox_inventory:Search('count', listItemCarcass) > 0 then
    local inventory = exports.ox_inventory:Search('slots', listItemCarcass)
    print(json.encode(inventory,{indent = true}))
    else
        print('no carcass')
    end
end)
RegisterCommand('carcass', function ()
    TriggerEvent('nfire_hunting:CarryCarcass')
end)