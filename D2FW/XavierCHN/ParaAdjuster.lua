if ParaAdjuster == nil then
	ParaAdjuster = class({})
end
function ParaAdjuster:Init()
	ListenToGameEvent( "npc_spawned", Dynamic_Wrap( ParaAdjuster, "OnNPCSpawned" ), self )
    ListenToGameEvent( "dota_player_pick_hero", Dynamic_Wrap( ParaAdjuster, "OnPlayerPicked" ), self )
    self.__sth_para = 0
    self.__itm_para = 0
    self.__ats_para = 0
    self.__ata_para = 0
    self.__adjusting_units = {}
end
function ParaAdjuster:SetStrToHealth(value)
	self.__sth_para = value - 19
end
function ParaAdjuster:SetIntToMana(value)
	self.__itm_para = value - 13
end
function ParaAdjuster:SetAgiToAtkSpd(value)
	self.__ats_para = value - 0.01
end
function ParaAdjuster:SetAgiToAmr(value)
	self.__ata_para = value - 0.14
end
function ParaAdjuster:OnPlayerPicked( event )
    local unit = EntIndexToHScript(event.heroindex)
    if self.__sth_para ~= 0 then
    	self:ModifyData(unit, self.__sth_para, "health")
    end
    if self.__itm_para ~= 0 then
    	self:ModifyData(unit, self.__itm_para, "mana")
    end
    if self.__ats_para ~= 0 then
    	self:ModifyData(unit, self.__ats_para, "atkspeed")
    end
    if self.__ata_para ~= 0 then
    	self:ModifyData(unit, self.__ata_para, "armor")
    end
    table.insert(self.__adjusting_units, unit)
end
function ParaAdjuster:OnNPCSpawned(event)
	local unit = EntIndexToHScript( event.entindex )
	if unit:IsHero() then
		if not self.__adjusting_units.unit then
			self:OnPlayerPicked({heroindex = unit:entindex()})
		end
	end
end
function ParaAdjuster:ModifyData(unit, data, mod_name)
	print("DO MODIFY DATA", data, mod_name)
	unit:SetContextThink(DoUniqueString("modify_data"),
		function()
			if unit.__recorder__ == nil then
				unit.__recorder__ = {}
			end
			if unit.__recorder__[mod_name] == nil then
				unit.__recorder__[mod_name] = 0
			end
			local current_data = nil
			if mod_name == "health" then current_data = unit:GetStrength() end
			if mod_name == "mana" then current_data = unit:GetIntellect() end
			if mod_name == "atkspeed" then current_data = unit:GetAgility() end
			if mod_name == "armor" then current_data = unit:GetAgility() end

			if current_data ~= unit.__recorder__[mod_name] then
				ability_name = 'ability_'..mod_name..'_modifier'
				mod_name_pos_prefix = 'modifier_'..mod_name..'_mod_'
				mod_name_neg_prefix = 'modifier_'..mod_name..'_mod_neg_'

				local ModifierAbility = unit:FindAbilityByName(ability_name)
				if not ModifierAbility then
					unit:AddAbility(ability_name)
					ModifierAbility = unit:FindAbilityByName(ability_name)
					ModifierAbility:SetLevel(1)
				end

				local bitTable = {512,256,128,64,32,16,8,4,2,1}
 
				local modCount = unit:GetModifierCount()
				for i = 0, modCount do
					for u = 1, #bitTable do
						local val = bitTable[u]
						if unit:GetModifierNameByIndex(i) == mod_name_pos_prefix .. val  then
							unit:RemoveModifierByName(mod_name_pos_prefix .. val)
						end
						if unit:GetModifierNameByIndex(i) == mod_name_neg_prefix .. val  then
							unit:RemoveModifierByName(mod_name_neg_prefix .. val)
						end
					end
				end

				local to_modify_value = self.__sth_para * current_data
				print('VALUE TO MODIFY', mod_name, to_modify_value)
				if to_modify_value > 0 then
					mod_prefix = mod_name_pos_prefix
				else
					mod_prefix = mod_name_neg_prefix
					to_modify_value = 0 - to_modify_value
				end
				-- think about a very big data
				if to_modify_value > 1023 then
					local out_count = math.floor(to_modify_value/512)
					for i = 1, out_count do
						ModifierAbility:ApplyDataDrivenModifier(unit, unit, mod_prefix .. "512", {})
					end
					to_modify_value = to_modify_value - out_count * 512
				end
				-- fix small data
				for p=1, #bitTable do
					local val = bitTable[p]
					local count = math.floor(to_modify_value / val)
					if count >= 1 then
						ModifierAbility:ApplyDataDrivenModifier(unit, unit, mod_prefix.. val, {})
						to_modify_value = to_modify_value - val
					end
				end

				unit:RemoveAbility(ability_name)
				
				unit.__recorder__[mod_name] = current_data
			end
			return 0.2
		end,
	0.2)
end
