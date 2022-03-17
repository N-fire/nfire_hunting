lib.versionCheck('N-fire/nfire_hunting')
if not lib.checkDependency('ox_lib', '2.0.2') then error('You don\'t have latest version of ox_lib') end
if not lib.checkDependency('ox_inventory', '2.6.0') then error('You don\'t have latest version of ox_inventory') end


RegisterNetEvent('nfire_hunting:harvestCarcass')
AddEventHandler('nfire_hunting:harvestCarcass',function (entityId)
    local entity = NetworkGetEntityFromNetworkId(entityId)
    item = Config.carcass[GetEntityModel(entity)]
    if exports.ox_inventory:CanCarryItem(source, item, 1) and DoesEntityExist(entity) and GetEntityAttachedTo(entity) == 0 then
        exports.ox_inventory:AddItem(source, item, 1)
        DeleteEntity(entity)
    end
end)