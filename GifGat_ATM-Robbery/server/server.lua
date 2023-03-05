local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('gifgat:server:checkcops', function(source, cb, data)
    local amount = 0
    for _, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    return cb(amount)
end)

RegisterNetEvent('gifgat:rewarditem')
AddEventHandler('gifgat:rewarditem', function(listKey)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Config.Items[math.random(1, #Config.Items)]
    Player.Functions.AddItem(item, math.random(1, 10))
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
end)


QBCore.Functions.CreateCallback("gifgat:weapon_stickybomb", function(source, cb, data)
    local Player = QBCore.Functions.GetPlayer(source)
    local src = source
    local weapon_stickybomb = nil
    if Player.Functions.GetItemByName("weapon_stickybomb") then
        weapon_stickybomb = true
        Player.Functions.RemoveItem('weapon_stickybomb', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weapon_stickybomb'], 'remove')
    else
        weapon_stickybomb = false
    end
    return cb(weapon_stickybomb)
end)


RegisterNetEvent('gifgat:server:Reward', function(cashProp, cash)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    local info = {
        worth = Config.worth
    }
    ply.Functions.AddItem(Config.reward, Config.rewardAmount, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.reward], "add")
end)
