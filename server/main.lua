RegisterNetEvent('nfire_hunting:harvestCarcass')
AddEventHandler('nfire_hunting:harvestCarcass',function (entityId)
    local entity = NetworkGetEntityFromNetworkId(entityId)
    item = Config.carcass[GetEntityModel(entity)]
    if exports.ox_inventory:CanCarryItem(source, item, 1) and DoesEntityExist(entity) then
        exports.ox_inventory:AddItem(source, item, 1)
        DeleteEntity(entity)
    end
end)