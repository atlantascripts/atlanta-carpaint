ESX.RegisterUsableItem(Shared.ItemName, function(playerId)
    TriggerClientEvent('atlanta-carpaint:useSprayCan', playerId)
end)

RegisterNetEvent('atlanta-carpaint:removeItem')
AddEventHandler('atlanta-carpaint:removeItem', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        local item = Shared.ItemName
        local itemQuantity = 1

        if xPlayer.getInventoryItem(item).count >= itemQuantity then
            xPlayer.removeInventoryItem(item, itemQuantity)
        end
    end
end)
