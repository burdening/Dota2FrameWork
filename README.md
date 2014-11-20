AMHC-Code_Hub
=============


使用方法：
```Lua
require("amhc")
require("amhc/XavierCHN/Abilities")
local Abi = amhc.XavierCHN.Abilities

Abi:ReplaceAllAbilities( hero, { [1] = "ability_1", [3] = "ability_3"})
```
代码规则：
1、类似命名空间的规则
为了避免全局变量冲突，同时体现作者，代码库的代码除类名以外，均使用 amhc.作者ID.库名作为唯一全局变量。
其中，amhc由amhc_code_hub来定义，在每个库中，使用如下方式来声明
```Lua
if amhc.XavierCHN == nil then amhc.XavierCHN = class({}) end
if amhc.XavierCHN.Abilities == nil then amhc.XavierCHN.Ability = class({})

-- 成员函数

-- 替换单位的所有技能，由传入的表来定义替换之后的技能表，空置的那个技能则不替换
-- abilityTable: table类型，定义替换后的技能
-- 
amhc.XavierCHN.Abilities.ReplaceAllAbilities = function( self, hero, abilityTable)
    -- 确认英雄正确
    if hero ~= nil then
        -- 遍历要替换的所有技能
        for index, ability_name in pairs(abilityTable) do
            -- 获取对应位置的英雄技能
            local hero_ability = hero:GetAbilityByIndex(index)
            -- 确保技能获取正确
            if hero_ability then
                -- 替换技能
                hero:SwapAbilities(hero_ability, ability_name, false, true)
                -- 去掉原始技能
                hero:RemoveAbilityByName(hero_ability)
            end
        end
    end
end
```
> 2、必须有详细的注释！

> 3、必须有正确的缩进！

> 4、其他的等我想到了再添加！
