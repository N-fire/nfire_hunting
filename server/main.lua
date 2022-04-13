lib.versionCheck('N-fire/nfire_hunting')
if not lib.checkDependency('ox_lib', '2.1.0') then error('You don\'t have latest version of ox_lib') end
if not lib.checkDependency('ox_inventory', '2.7.4') then error('You don\'t have latest version of ox_inventory') end
if not lib.checkDependency('qtarget', '2.1.0') then error('You don\'t have latest version of qtarget') end


RegisterNetEvent('nfire_hunting:harvestCarcass')
AddEventHandler('nfire_hunting:harvestCarcass',function (entityId)
    local entity = NetworkGetEntityFromNetworkId(entityId)
    local weapon = GetPedCauseOfDeath(entity)
    local grade = '★☆☆'
    if InTable(Config.goodWeapon, weapon) then
        grade = '★★☆'
        if math.random(10) == 5 then
            grade = '★★★'
        end
    end

    local item = Config.carcass[GetEntityModel(entity)]
    if exports.ox_inventory:CanCarryItem(source, item, 1) and DoesEntityExist(entity) and GetEntityAttachedTo(entity) == 0 then
        exports.ox_inventory:AddItem(source, item, 1, {type = grade})
        DeleteEntity(entity)
    end
end)

function InTable(table, value)
    for i = 1, #table, 1 do
        if table[i] == value then
            return true
        end
    end
    return false
end

RegisterNetEvent('nfire_hunting:SellCarcass')
AddEventHandler('nfire_hunting:SellCarcass',function (item)
    local itemData = exports.ox_inventory:Search(source,'slots', item)[1]
    if itemData.count >= 1 then
        local reward = Config.sellPrice[item] *  Config.gradeMultiplier[itemData.metadata.type]
        exports.ox_inventory:RemoveItem(source, item, 1, nil, itemData.slot)
        exports.ox_inventory:AddItem(source, 'money', reward)
    end
end)