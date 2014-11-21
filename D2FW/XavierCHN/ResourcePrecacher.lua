--[Comment]
-- English
-- PrecacheResourceFromKV( context )
-- Put this function into your addon_game_mode.lua@Precache( context )
-- This function will search and precache particles/models/sound files in your KV file
-- 中文
-- 从你的KV文件载入所有的资源
-- 你需要在你的addon_game_mode.lua中的Precache( context )函数中调用本函数
-- 
function PrecacheEveryThingFromKV( context )
	-- 所有的KV文件
	local kv_files = {
	    "scripts/npc/npc_units_custom.txt",
	    "scripts/npc/npc_abilities_custom.txt",
	    "scripts/npc/npc_heroes_custom.txt",
	    "scripts/npc/npc_abilities_override.txt",
	    "npc_items_custom.txt"
	}
	for _, kv in pairs(kv_files) do
		local kvs = LoadKeyValues(kv)
		if kvs then
			print("BEGIN TO PRECACHE RESOURCE FROM: ", kv)
			PrecacheEverythingFromTable( context, kvs)
		end
	end
end
function PrecacheEverythingFromTable( context, kvtable)
	for key, value in pairs(kvtable) do
		if type(value) == "table" then
			PrecacheEverythingFromTable( context, value )
		else
			if string.find(value, "vpcf") then
				PrecacheResource( "particle",  value, context)
				print("PRECACHE PARTICLE RESOURCE", value)
			end
			if string.find(value, "vmdl") then
				PrecacheResource( "model",  value, context)
				print("PRECACHE MODEL RESOURCE", value)
			end
			if string.find(value, "vsndevts") then
				PrecacheResource( "soundfile",  value, context)
				print("PRECACHE SOUND RESOURCE", value)
			end
		end
	end
end
