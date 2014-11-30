--[Includes 包含]
-- GameRules:SetNumKillsToWinGameRule(nKillsToWin) https://github.com/XavierCHN/Dota2FrameWork/blob/master/D2FW/XavierCHN/GameRules.lua#L1
require('D2FW/XavierCHN/GameRules')

--[Includes 包含]
-- PrecacheEveryThingFromKV( context ) https://github.com/XavierCHN/Dota2FrameWork/blob/master/D2FW/XavierCHN/ResourcePrecacher.lua#L1
require('D2FW/XavierCHN/ResourcePrecacher')

--[Includes 包含]
-- [[
    (1) BuildingHelper:AddBuildingToGrid(vPoint, nSize, vOwnersHero)
    (2) BuildingHelper:AddBuilding(building)
    (3) BuildingHelper:AddUnit(unit)
]]
require('D2FW/MyII/BuildingHelper')

require('D2FW/XavierCHN/ParaAdjuster')
ParaAdjuster:Init()
--	ParaAdjuster:SetStrToHealth(30) -- set each point of strength give 30 point of health
--	ParaAdjuster:SetIntToMana(40) -- set each point of intellegence give 40 point of mana
--	ParaAdjuster:SetAgiToAtkSpd(50) -- set each point of agility give 50 point of attack speed bonus
--	ParaAdjuster:SetAgiToAmr(60) -- set each point of agility give 60 point of mana
