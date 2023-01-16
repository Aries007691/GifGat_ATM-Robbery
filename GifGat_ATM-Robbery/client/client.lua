Acidental Genius 2.0
#8068

Acidental Genius 2.0 — Yesterday at 21:51
turn on the lights
gifgat — Yesterday at 21:52
Lol
That light is my mic coz it runs on battery
I go get water k
Acidental Genius 2.0 — Yesterday at 21:53
and then ?
you gonna stop baileying
and play cs
gifgat — Yesterday at 21:56
Nvm
I wanted to send vid of me getting water but 2 big need nitro
Buy me nitro
I send vid
Acidental Genius 2.0 — Yesterday at 21:57
why do i want a vid of you getting water
gifgat — Yesterday at 21:57
Coz its cool
Maybe u see ghost
Acidental Genius 2.0 — Yesterday at 21:57
come play cs
i know you lying
gifgat — Yesterday at 21:58
Truuue
Image
Look
Lights outside
Wow
Acidental Genius 2.0 — Yesterday at 21:59
gifgat — Yesterday at 21:59
Lel that was 2 nights ago leme show u now
Image
See no lights in the background
Acidental Genius 2.0 — Yesterday at 22:05
gifgat — Yesterday at 22:05
I read lebanese
Fuck bailey
Yeah i ran yo the church in the bavkground to turn their lights off
Acidental Genius 2.0 — Yesterday at 22:06
trueee
Acidental Genius 2.0 — Today at 14:50
look at you being good support
gifgat — Today at 14:50
🖕
Acidental Genius 2.0 — Today at 14:53
🤣
i promote you to head of support
gifgat — Today at 14:54
🖕🖕🖕
Acidental Genius 2.0 — Today at 14:54
🤣🤣🤣
Acidental Genius 2.0 — Today at 17:24
a game of cs later ?
gifgat — Today at 18:33
My power is still off
I fucking hope it comes on before late
Acidental Genius 2.0 — Today at 18:36
go check your main its probably still off there when you turned it off last night to send me that pic
gifgat — Today at 18:37
Lol yeah true
Acidental Genius 2.0 — Today at 18:37
seesh ima play without you again then go to bed
gifgat — Today at 18:38
Awe and ima be awake till 2 again coz i cant sleep coz i have no fan and its poes warm
Acidental Genius 2.0 — Today at 18:38
seeeesh i have 2 fans on next to me
gifgat — Today at 18:40
Fuckoff
gifgat — Today at 20:40
Kan jy daai script net later update asb > na<
Acidental Genius 2.0 — Today at 22:06
done
gifgat — Today at 22:58
xMaddMackx — Today at 10:36 PM
Hey, I have a complete fix for the ATM Bombing script for the item removal, police count, and console native error if anyone else was having this issue.
local QBCore = exports['qb-core']:GetCoreObject()
local cash = {}

QBCore.Functions.CreateCallback('gifgat:server:checkcops', function(source, cb, data)
    local amount = 0
    for _, v in pairs(QBCore.Functions.GetQBPlayers()) do
Expand
server.lua
3 KB
local QBCore = exports['qb-core']:GetCoreObject()
local cooldown = false
local CurrentCops = 0

local atmtargets = Config.atmTargets

Expand
client.lua
8 KB
gifgat — Today at 22:58
awe
random guy sent me that
﻿
local QBCore = exports['qb-core']:GetCoreObject()
local cooldown = false
local CurrentCops = 0

local atmtargets = Config.atmTargets


exports['qb-target']:AddTargetModel(atmtargets, {
    options = {
        {
            action = function()
                QBCore.Functions.TriggerCallback('gifgat:weapon_stickybomb', function(HasItem)
                    if HasItem and not cooldown then
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
                        TriggerServerEvent('gifgat:RemoveBombItem')
                        exports['ps-dispatch']:ATMRobbery() --TriggerServerEvent('police:server:policeAlert', 'ATM Bombing in progress')
                        cooldown = true
                    elseif cooldown == true then
                        TriggerEvent('gifgat:CooldownNotify')
                    elseif not HasItem then
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


    local coords = GetOffsetFromEntityInWorldCoords(atm, 0.0, -1.0, 0.0)
    local cash   = GetHashKey('prop_cash_pile_02')
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
                        TriggerServerEvent('gifgat:server:Reward', cashProp)
                        DeleteEntity(cashProp)
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
client.lua
8 KB
