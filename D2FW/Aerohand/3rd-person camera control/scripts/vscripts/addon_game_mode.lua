require('generateM')
-- Generated from template
hulage=0
benti={}
pvalue=90
if mgdbfGameMode == nil then
	mgdbfGameMode = class({})
end
function PrecacheEveryThingFromKV( context )
  local kv_files = {"scripts/npc/npc_units_custom.txt","scripts/npc/npc_abilities_custom.txt","scripts/npc/npc_heroes_custom.txt","scripts/npc/npc_abilities_override.txt","npc_items_custom.txt"}
  for _, kv in pairs(kv_files) do
    local kvs = LoadKeyValues(kv)
    if kvs then
      print("BEGIN TO PRECACHE RESOURCE FROM: ", kv)
      PrecacheEverythingFromTable( context, kvs)
    end
  end

 local zr={
 
--demo_12
"models/heroes/clinkz/clinkz_head.vmdl",
"models/heroes/clinkz/clinkz_bow.vmdl",
"models/heroes/clinkz/clinkz_pads.vmdl",
"models/heroes/clinkz/clinkz_back.vmdl",
"models/heroes/clinkz/clinkz_horns.vmdl",
"models/heroes/clinkz/clinkz_gloves.vmdl",


--demo_13
"models/heroes/pugna/pugna_head.vmdl",
"models/heroes/pugna/pugna_cape.vmdl",
"models/heroes/pugna/pugna_bracers.vmdl",
"models/heroes/pugna/pugna_weapon.vmdl",
"models/heroes/pugna/pugna_belt.vmdl",

--demo_21
"models/heroes/broodmother/broodmother_hair.vmdl",
"models/heroes/broodmother/broodmother_legs.vmdl",
"models/heroes/broodmother/broodmother_abdomen.vmdl",


--demo_51
"models/heroes/nightstalker/nightstalker_wings_night.vmdl",
"models/heroes/nightstalker/nightstalker_legarmor_night.vmdl",
"models/heroes/nightstalker/nightstalker_tail_night.vmdl",


--demo_60
"models/items/shadow_demon/back_ishobolaa/back_ishobolaa.vmdl",
"models/items/shadow_demon/belt_demonlord/belt_demonlord.vmdl",
"models/items/shadow_demon/diabolical_back/diabolical_back.vmdl",
"models/items/shadow_demon/tail_bishobola/tail_bishobola.vmdl",


--demo_61
"models/items/slark/anuxi_encore_dagger/anuxi_encore_dagger.vmdl",
"models/items/doom/eternal_fire_helmet/eternal_fire_helmet.vmdl",
"models/items/doom/eternal_fire_arms/eternal_fire_arms.vmdl",
"models/items/doom/eternal_fire_back/eternal_fire_back.vmdl",
"models/items/doom/eternal_fire_belt/eternal_fire_belt.vmdl",
"models/items/doom/eternal_fire_shoulders/eternal_fire_shoulders.vmdl",
"models/items/doom/eternal_fire_tail/eternal_fire_tail.vmdl",


    }
     

    print("loading shiping")
  local t=#zr;
  for i=1,t do

      PrecacheResource( "model", zr[i], context)

    end

    print("done loading shiping")


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
function Precache( context )
  print("BEGIN TO PRECACHE RESOURCE")
  local time = GameRules:GetGameTime()
  PrecacheEveryThingFromKV( context )
  time = time - GameRules:GetGameTime()
  print("DONE PRECACHEING IN:"..tostring(time).."Seconds")
end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = mgdbfGameMode()
	GameRules.AddonTemplate:InitGameMode()
end

function mgdbfGameMode:InitGameMode()
	print( "Template addon is loaded." )

    GameRules:SetPreGameTime(10)
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
  ListenToGameEvent("npc_spawned", Dynamic_Wrap(mgdbfGameMode, "OnNPCSpawned"), self)
  ListenToGameEvent("entity_killed", Dynamic_Wrap(mgdbfGameMode, "OnEntityKilled"), self)
    --注册英雄行走方向命令

    Convars:RegisterCommand( "UpWalking", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingUp(cmdPlayer) 
    end
    end, "walking up", 0 )

    Convars:RegisterCommand( "DownWalking", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingDown(cmdPlayer) 
    end
    end, "walking down", 0 )

    Convars:RegisterCommand( "LeftWalking", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingLeft(cmdPlayer) 
    end
    end, "walking left", 0 )

    Convars:RegisterCommand( "RightWalking", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingRight(cmdPlayer) 
    end
    end, "walking right", 0 )    

 --注册英雄行走方向结束命令

    Convars:RegisterCommand( "UpWalkingDone", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingUpDone(cmdPlayer) 
    end
    end, "walking up Done", 0 )

    Convars:RegisterCommand( "DownWalkingDone", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingDownDone(cmdPlayer) 
    end
    end, "walking down Done", 0 )

    Convars:RegisterCommand( "LeftWalkingDone", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingLeftDone(cmdPlayer) 
    end
    end, "walking left Done", 0 )

    Convars:RegisterCommand( "RightWalkingDone", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:WalkingRightDone(cmdPlayer) 
    end
    end, "walking right Done", 0 )  

    GameRules:GetGameModeEntity():SetCameraDistanceOverride(500);
    GameRules:GetGameModeEntity():SetFogOfWarDisabled(true);

end

-- Evaluate the state of the game
function mgdbfGameMode:OnThink()
	if hulage==0 then
        hulage=1
       SendToConsole("dota_camera_pitch_max 25")
       SendToConsole("dota_camera_lock_lerp 0")
       SendToConsole("dota_camera_lock")
      --SendToConsole("dota_camera_pitch_max 10");
      SendToConsole("r_farz 6000");
       SendToConsole("unbindall");
       SendToConsole("alias \"+move_left\" \"LeftWalking\"");
       SendToConsole("alias \"-move_left\" \"LeftWalkingDone\"");
       SendToConsole("alias \"+move_right\" \"RightWalking\"");
       SendToConsole("alias \"-move_right\" \"RightWalkingDone\"");
       SendToConsole("bind leftarrow +move_left");
       SendToConsole("bind rightarrow +move_right");
     --    SendToConsole("dota_sf_hud_inventory 0")
     --    SendToConsole("dota_render_crop_height 0")
        ps_init()
       -- gm()
      end

	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end

--行走开始
function mgdbfGameMode:WalkingUp(player)
  print("get walking up!")
 --[[
  local hero=player:GetAssignedHero()       --获得玩家操控英雄
  local vec=hero:GetAbsOrigin()
  local newvec   
  newvec=Vector(vec.x,vec.y+500,vec.z)      --获得行走方向
  walk(hero,newvec)                         --走过去]]
  --加速
  ps[player:GetPlayerID()][4]=ps[player:GetPlayerID()][4]+10

end

function mgdbfGameMode:WalkingDown(player)
  print("get walking down!")
 --[[ local hero=player:GetAssignedHero()
  local vec=hero:GetAbsOrigin()
  local newvec
  newvec=Vector(vec.x,vec.y-500,vec.z)
  walk(hero,newvec)]]
   ps[player:GetPlayerID()][4]=ps[player:GetPlayerID()][4]-10
end

function mgdbfGameMode:WalkingLeft(player)
  print("get walking left!")
  --[[
  local hero=player:GetAssignedHero()
  local vec=hero:GetAbsOrigin()
  local newvec
  newvec=Vector(vec.x-500,vec.y,vec.z)
  walk(hero,newvec)]]
  local pid=player:GetPlayerID()
  local layer=ps[pid][6]
  --当前操作队列为左
  ps[pid][1][layer]=1
  --操作队列指针+1
  ps[pid][6]=ps[pid][6]+1
end

function mgdbfGameMode:WalkingRight(player)
  print("get walking right!")
  --[[
  local hero=player:GetAssignedHero()
  local vec=hero:GetAbsOrigin()
  local newvec
  newvec=Vector(vec.x+500,vec.y,vec.z)
  walk(hero,newvec)]]
  local pid=player:GetPlayerID()
  local layer=ps[pid][6]
  ps[pid][1][layer]=2
  ps[pid][6]=ps[pid][6]+1
end

--行走结束
function mgdbfGameMode:WalkingUpDone(player)

  ps[player:GetPlayerID()][0]=0
end

function mgdbfGameMode:WalkingDownDone(player)

    ps[player:GetPlayerID()][0]=0
end

function mgdbfGameMode:WalkingLeftDone(player)
  local pid=player:GetPlayerID()
  --获得当前操作队列指针
  ps[pid][6]=ps[pid][6]-1
  local layer=ps[pid][6]
  --查看当前操作是否为向左
  if (ps[pid][1][layer]==1) then
    ps[pid][1][layer]=0
  else
    --当前队列不为左 右向操作下移一位
    ps[pid][1][layer]=0
    ps[pid][1][layer-1]=2
  end  
end

function mgdbfGameMode:WalkingRightDone(player)
  local pid=player:GetPlayerID()
  --获得当前操作队列指针
  ps[pid][6]=ps[pid][6]-1
  local layer=ps[pid][6]
  --查看当前操作是否为向右
  if (ps[pid][1][layer]==2) then
    ps[pid][1][layer]=0
  else
    --当前队列不为右 左向操作下移一位
    ps[pid][1][layer]=0
    ps[pid][1][layer-1]=1
  end  
end


--行走函数
function walk(unit,position)
  local newOrder = {
         
    UnitIndex = unit:entindex(),             
    OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,  
    TargetIndex = nil,                   
    AbilityIndex = 0,                             
    Position = position,                
    Queue = 0                       
  }
          
  ExecuteOrderFromTable(newOrder)
end

function atk(unit,position)
  
  unit:CastAbilityOnPosition(position,unit:GetAbilityByIndex(0),0)

--[[
  local newOrder = {
         
    UnitIndex = unit:entindex(),             
    OrderType = DOTA_UNIT_ORDER_CAST_POSITION,  
    TargetIndex = nil,                   
    AbilityIndex = 0,                             
    Position = position,                
    Queue = 0                       
  }
          
  ExecuteOrderFromTable(newOrder)]]
end

function mgdbfGameMode:OnNPCSpawned( keys )

   local unit =  EntIndexToHScript(keys.entindex)
   
   if unit:IsHero() then                      --Èç¹ûÊÇÓ¢ÐÛ

      unit:SetAbilityPoints(0)                --È¡Ïû¼¼ÄÜµã
 
      local j=0 
      zou=0
      she=0
      for j = 0,15,1 do
        local temp1=unit:GetAbilityByIndex(j) --»ñÈ¡¼¼ÄÜÊµÌå
        if temp1 then
          temp1:SetLevel(1)                   --ÉèÖÃ¼¼ÄÜµÈ¼¶
          print(j)
          DeepPrintTable(temp1)
        end
      end
      
      pid=unit:GetPlayerOwnerID()
      ps[pid][5]=unit:GetForwardVector()
      view(ps[pid][5],pid)
      --benti[pid]=CreateUnitByName("tank1", unit:GetAbsOrigin() , false, nil, nil, unit:GetTeam()) 
      --PlayerResource:SetCameraTarget(pid, benti[pid])
      --SendToConsole("")
      GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("moguidebufa"), 
        function()
          --local pid=unit:GetPlayerOwnerID()

          local vec=unit:GetAbsOrigin();
          local jilu=vec
          local newvec
          local layer=ps[pid][6]-1
          zou=0
          if ps[pid][0]==0 then
            newvec=vec
          else
            zou=1
            if ps[pid][0]==1 then  --往上走
              newvec=Vector(vec.x,vec.y+30,vec.z)
             else
              newvec=Vector(vec.x,vec.y-30,vec.z)
            end
          end
          vec=newvec
          local chaoxiang=unit:GetForwardVector()
          local xincx=chaoxiang
          print("layer")
          print(layer)
          print(ps[pid][1][layer])
          if ps[pid][1][layer]==0 then
            newvec=vec
          else
            zou=1
            if ps[pid][1][layer]==1 then  --往左走
              xincx=Vector(chaoxiang.x*math.cos(math.pi/180*4)-chaoxiang.y*math.sin(math.pi/180*4),chaoxiang.x*math.sin(math.pi/90)+chaoxiang.y*math.cos(math.pi/90),chaoxiang.z)
              --pvalue=pvalue+4
              --SendToConsole("dota_camera_yaw "..tostring(pvalue-90))
             else
              --pvalue=pvalue-4
              xincx=Vector(chaoxiang.x*math.cos(math.pi/180*4)+chaoxiang.y*math.sin(math.pi/180*4),-chaoxiang.x*math.sin(math.pi/90)+chaoxiang.y*math.cos(math.pi/90),chaoxiang.z)
              --SendToConsole("dota_camera_yaw "..tostring(pvalue-90))


            end
          end
          vec=newvec
          if zou==1 then
            if she==0 then
              unit:SetForwardVector(xincx)
            end  
          end 
          view(xincx,pid) 
          walk(unit,jilu+xincx*200)
           
          --unit:SetAbsOrigin(benti[pid]:GetAbsOrigin())
          --PlayerResource:SetCameraTarget(pid,unit)
          return 0.1
        end,0)
--[[
      GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("moguidesheji"), 
        function()

          local vec=unit:GetAbsOrigin();
          local jilu=vec
          local newvec
          she=0
          if ps[pid][2]==0 then
            newvec=vec
          else
            she=1
            if ps[pid][2]==1 then  --往上射
              newvec=Vector(vec.x,vec.y+10,vec.z)
             else
              newvec=Vector(vec.x,vec.y-10,vec.z)
            end
          end
          vec=newvec

          if ps[pid][3]==0 then
            newvec=vec
          else
            she=1
            if ps[pid][3]==1 then  --往左射
              newvec=Vector(vec.x-10,vec.y,vec.z)
             else
              newvec=Vector(vec.x+10,vec.y,vec.z)
            end
          end
          vec=newvec
          if she==1 then
            print("sheji!")
            unit:SetForwardVector(vec-jilu)
            atk(unit,vec)
          end  

          return 0.3
        end,0)
]]

   end

end

function view(a,pid)
  pvalue=math.deg(math.acos(a.x*ps[pid][5].y-ps[pid][5].x*a.y))
  
  SendToConsole("dota_camera_yaw "..tostring(pvalue-90))  
end  

function  ps_init()
  
  ps={}                       --行走状态
  local i
  local j
  for i=0,9 do
    if PlayerResource:IsValidPlayer(i) then

        print("playerconnected:")
        print(i)

        ps[i]={}     --0为上下 1为左右操作队列 2为攻击上下 3为攻击左右 4为速度 5为初始朝向 6为左右操作队列指针
        ps[i][0]=0
        ps[i][1]={}
        ps[i][6]=0
        for j=2,4 do                   
          ps[i][j]=0
          ps[i][1][j-3]=0
        end
      
        
      else
        
        ps[i]=nil
      
      end
    end

    local temp=Entities:FindByName(nil,"zibao") --所有单位假死沉睡的最终之地 神之居所瓦尔哈拉！
    zibao=temp:GetAbsOrigin()
end

function mgdbfGameMode:OnEntityKilled( keys )
        print("OnEntityKilled")
        DeepPrintTable(keys)    --详细打印传递进来的表
        local burden=EntIndexToHScript(keys.entindex_killed)
        burden:SetAbsOrigin(zibao)

        

end