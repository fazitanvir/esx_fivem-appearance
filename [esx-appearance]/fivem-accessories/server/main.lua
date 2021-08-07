--? Check if the player have at least one of the required items to return his metadatas
ESX.RegisterServerCallback('fivem-accessories:getItemMetadata', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    for k, xItem in pairs(xPlayer.inventory) do 
        if xItem.name == item then 
            cb(xItem.metadata)
            break
        end
    end
end)