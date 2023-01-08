Config = {}


-- Police Settings:
Config.RequiredPolice = 2 -- Required Police online to rob an ATM.

Config.reward = "markedbills" -- Reward dropped when atm is bombed

Config.atmTargets = { --- ATM Models "DO NOT CHANGE THESE UNLESS YOU KNOW WHAT YOU ARE DOING"
    `prop_atm_02`,
    `prop_atm_03`,
    `prop_atm_01`,
    `prop_fleeca_atm`,
}
Config.rewardAmount = math.random(1, 3) --amount of markedbills
Config.worth = math.random(250, 400) --markedbills worth
