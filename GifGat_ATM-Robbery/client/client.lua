local QBCore = exports['qb-core']:GetCoreObject()
local cooldown = false
local CurrentCops = 0

local atmtargets = Config.atmTargets


exports['qb-target']:AddTargetModel(atmtargets, {
    options = {
        {
            action = function()
                QBCore.Functions.TriggerCallback('gifgat:weapon_stickybomb', function(HasItem)
                    if HasItem then
                        QBCore.Functions.TriggerCallback('gifgat:server:checkcops', function(amount)
                            CurrentCops = amount
                        end)
                        while CurrentCops == nil do
                            Wait(10)
                        end
                        if CurrentCops >= Config.RequiredPolice then
                            QBCore.Functions.Notify("Not enough police on duty")
                            return
                        end
                        TriggerEvent('gifgat:startrobbery')
                        TriggerServerEvent('police:server:policeAlert', 'ATM Bombing in progress')
                    else
                        QBCore.Functions.Notify("You Dont Have The Equipment Needed")
                    end
                end)
            end,
            icon = "fas fa-circle",
            label = "Bomb ATM",
        },
    },
    distance = 2.0
})



RegisterNetEvent('gifgat:startrobbery', function()
    if cooldown == false then
        TriggerEvent('gifgat:client:rob')
        cooldown = true
        Citizen.Wait(1800000) --- cooldown timer 1000 = 1sec
        cooldown = false
    elseif cooldown == true then
        TriggerEvent('gifgat:CooldownNotify')
    end
end)


RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)


RegisterNetEvent('gifgat:client:rob', function()
    local coords    = GetEntityCoords(PlayerPedId())
    local atm       = nil
    local atms      = {
        'prop_atm_02',
        'prop_atm_03',
        'prop_atm_01',
        'prop_fleeca_atm',
    }
    for i = 1, #atms do
        local retval =
        GetClosestObjectOfType(
            coords.x,
            coords.y,
            coords.z,
            5.0,
            GetHashKey(atms[i]),
            false
        )
        if retval ~= 0 then
            atm = retval
        end
    end

    local y = 0.05

    if GetEntityModel(atm) == -870868698 then
        y = -0.15
    end

    local coords  =
    GetOffsetFromEntityInWorldCoords(
        atm,
        0.0,
        y,
        1.0
    )
    local heading = GetEntityHeading(atm)
    local cash    = GetHashKey('prop_c4_final')
    RequestModel(cash)
    while not cash do
        wait(10)
    end
    local anim = "anim@heists@narcotics@trash"
    local play = 'throw_ranged_a'
    RequestAnimDict(anim)
    while not HasAnimDictLoaded(anim) do
        Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), anim, play, 8.0, 8.0, -1, 50, 0.2, 0, 0, 0)
    local cashProp = CreateObject(cash, vector3(coords.x, coords.y, coords.z)
        , true, true, false)
    SetEntityHeading(cashProp, heading)
    Wait(1000)
    ClearPedTasks(PlayerPedId())
    Wait(5000)
    DeleteEntity(object)
    AddExplosion(coords.x, coords.y, coords.z, 4, 5.0, true, false, true)
    TriggerEvent('gifgat:client:cash', coords)
    Wait(1000)
    DeleteEntity(cashProp)
end)



RegisterNetEvent('gifgat:client:cash', function(coords)
    local atm  = nil
    local atms = {
        'prop_atm_02',
        'prop_atm_03',
        'prop_atm_01',
        'prop_fleeca_atm',
    }
    for i = 1, #atms do
        local coordinates =
        GetClosestObjectOfType(
            coords.x,
            coords.y,
            coords.z,
            5.0,
            GetHashKey(atms[i]),
            false
        )
        if coordinates ~= 0 then
            atm = coordinates
        end
    end


    local coords =
    GetOffsetFromEntityInWorldCoords(
        atm,
        0.0,
        -1.0,
        0.0
    )
    local cash   = GetHashKey('prop_anim_cash_pile_01')
    RequestModel(cash)
    while not cash do
        wait(10)
    end
    local loc = { math.random(1, 99) / 100, math.random(1, 99) / 100,
        math.random(1, 99) / 100, math.random(1, 99) / 100, math.random(1, 99) / 100,
        math.random(1, 99) / 100, math.random(1, 99) / 100, math.random(1, 99) / 100,
        math.random(1, 99) / 100, math.random(1, 99) / 100, math.random(1, 99) / 100,
        math.random(1, 99) / 100, math.random(1, 99) / 100, math.random(1, 99) / 100,
        math.random(1, 99) / 100, math.random(1, 99) / 100, math.random(1, 99) / 100,
        math.random(1, 99) / 100, math.random(1, 99) / 100, math.random(1, 99) / 100,
        math.random(1, 99) / 100, math.random(1, 99) / 100, math.random(1, 99) / 100,
        math.random(1, 99) / 100, math.random(1, 99) / 100, math.random(1, 99) / 100,
    }
    local y = { math.random(1, 99) / 100, math.random(1, 99) / 100,
        math.random(1, 99) / 100, math.random(1, 99) / 100, math.random(1, 99) / 100,
        math.random(1, 99) / 100, math.random(1, 99) / 100, math.random(1, 99) / 100,
        math.random(1, 99) / 100, math.random(1, 99) / 100, math.random(1, 99) / 100,
        math.random(1, 99) / 100, math.random(1, 99) / 100, math.random(1, 99) / 100,
        math.random(1, 99) / 100, math.random(1, 99) / 100, math.random(1, 99) / 100,
        math.random(1, 99) / 100, math.random(1, 99) / 100, math.random(1, 99) / 100,
        math.random(1, 99) / 100, math.random(1, 99) / 100, math.random(1, 99) / 100,
        math.random(1, 99) / 100, math.random(1, 99) / 100, math.random(1, 99) / 100,
    }
    for i = 1, #loc do

        local cashProp = CreateObject(cash, vector3(coords.x + loc[i], coords.y + y[i], coords.z), true, true, false)
        local random = math.random(0, 180)
        SetEntityRotation(cashProp, 0.0, 0.0, tonumber(random .. (.0)), 1, true)
        exports['qb-target']:AddTargetEntity(cashProp, {
            options = {
                {
                    type = "client",
                    icon = 'fas fa-example',
                    label = 'Pick up stained cash',
                    action = function(entity)
                        if IsPedAPlayer(entity) then return false end
                        local anim = "anim@move_m@trash"
                        local play = 'pickup'

                        RequestAnimDict(anim)
                        while not HasAnimDictLoaded(anim) do
                            Wait(10)
                        end
                        TaskPlayAnim(PlayerPedId(), anim, play, 8.0, 8.0, -1, 32, 0.2, 0, 0, 0)
                        Wait(1000)
                        if DoesEntityExist(cashProp) then
                            DeleteEntity(cashProp)
                        end
                        TriggerServerEvent('gifgat:server:Reward', cashProp, cash)
                    end,
                }
            },
            distance = 2.5,
        })
    end
end
)


RegisterNetEvent('gifgat:CooldownNotify')
AddEventHandler('gifgat:CooldownNotify', function()
    TriggerEvent("QBCore:Notify", "An ATM Bombing has happened Recently.")
end)
