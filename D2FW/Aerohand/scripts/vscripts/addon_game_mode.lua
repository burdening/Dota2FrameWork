
-- Generated from template
hulage=0
if mgdbfGameMode == nil then
	mgdbfGameMode = class({})
end

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = mgdbfGameMode()
	GameRules.AddonTemplate:InitGameMode()
end

function mgdbfGameMode:InitGameMode()
	print( "Template addon is loaded." )
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
  ListenToGameEvent("npc_spawned", Dynamic_Wrap(mgdbfGameMode, "OnNPCSpawned"), self)
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

    --注册英雄攻击方向命令

    Convars:RegisterCommand( "TopShoot", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:ShootUp(cmdPlayer) 
    end
    end, "shoot up", 0 )

    Convars:RegisterCommand( "DownShoot", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:ShootDown(cmdPlayer) 
    end
    end, "Shoot down", 0 )

    Convars:RegisterCommand( "LeftShoot", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:ShootLeft(cmdPlayer) 
    end
    end, "Shoot left", 0 )

    Convars:RegisterCommand( "RightShoot", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:ShootRight(cmdPlayer) 
    end
    end, "Shoot right", 0 )    

 --注册英雄攻击方向结束命令

    Convars:RegisterCommand( "TopShootDone", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:ShootUpDone(cmdPlayer) 
    end
    end, "Shoot up Done", 0 )

    Convars:RegisterCommand( "DownShootDone", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:ShootDownDone(cmdPlayer) 
    end
    end, "Shoot down Done", 0 )

    Convars:RegisterCommand( "LeftShootDone", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:ShootLeftDone(cmdPlayer) 
    end
    end, "Shoot left Done", 0 )

    Convars:RegisterCommand( "RightShootDone", function(name)
    --锁定发送命令的玩家
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
         
        return self:ShootRightDone(cmdPlayer) 
    end
    end, "Shoot right Done", 0 )  



end

-- Evaluate the state of the game
function mgdbfGameMode:OnThink()
	if hulage==0 then
        hulage=1

     --    SendToConsole("dota_sf_hud_inventory 0")
     --    SendToConsole("dota_render_crop_height 0")
        ps_init()
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
  ps[player:GetPlayerID()][0]=1
  
end

function mgdbfGameMode:WalkingDown(player)
  print("get walking down!")
 --[[ local hero=player:GetAssignedHero()
  local vec=hero:GetAbsOrigin()
  local newvec
  newvec=Vector(vec.x,vec.y-500,vec.z)
  walk(hero,newvec)]]
    ps[player:GetPlayerID()][0]=2
end

function mgdbfGameMode:WalkingLeft(player)
  print("get walking left!")
  --[[
  local hero=player:GetAssignedHero()
  local vec=hero:GetAbsOrigin()
  local newvec
  newvec=Vector(vec.x-500,vec.y,vec.z)
  walk(hero,newvec)]]

  ps[player:GetPlayerID()][1]=1
end

function mgdbfGameMode:WalkingRight(player)
  print("get walking right!")
  --[[
  local hero=player:GetAssignedHero()
  local vec=hero:GetAbsOrigin()
  local newvec
  newvec=Vector(vec.x+500,vec.y,vec.z)
  walk(hero,newvec)]]

  ps[player:GetPlayerID()][1]=2 
end

--行走结束
function mgdbfGameMode:WalkingUpDone(player)

  ps[player:GetPlayerID()][0]=0
end

function mgdbfGameMode:WalkingDownDone(player)

    ps[player:GetPlayerID()][0]=0
end

function mgdbfGameMode:WalkingLeftDone(player)

    ps[player:GetPlayerID()][1]=0
end

function mgdbfGameMode:WalkingRightDone(player)

    ps[player:GetPlayerID()][1]=0
end

--攻击开始
function mgdbfGameMode:ShootUp(player)
  ps[player:GetPlayerID()][2]=1
end

function mgdbfGameMode:ShootDown(player)
  ps[player:GetPlayerID()][2]=2
end

function mgdbfGameMode:ShootLeft(player)
  ps[player:GetPlayerID()][3]=1
end

function mgdbfGameMode:ShootRight(player)
  ps[player:GetPlayerID()][3]=2
end

--攻击结束
function mgdbfGameMode:ShootUpDone(player)
  ps[player:GetPlayerID()][2]=0
end

function mgdbfGameMode:ShootDownDone(player)
  ps[player:GetPlayerID()][2]=0
end

function mgdbfGameMode:ShootLeftDone(player)
  ps[player:GetPlayerID()][3]=0
end

function mgdbfGameMode:ShootRightDone(player)
  ps[player:GetPlayerID()][3]=0
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
          temp1:SetLevel(1)                     --ÉèÖÃ¼¼ÄÜµÈ¼¶
          print(j)
          DeepPrintTable(temp1)
        end
      end
      pid=unit:GetPlayerOwnerID()
      PlayerResource:SetCameraTarget(pid,unit)
      GameRules:GetGameModeEntity():SetContextThink(DoUniqueString("moguidebufa"), 
        function()

          local vec=unit:GetAbsOrigin();
          local jilu=vec
          local newvec
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

          if ps[pid][1]==0 then
            newvec=vec
          else
            zou=1
            if ps[pid][1]==1 then  --往左走
              newvec=Vector(vec.x-30,vec.y,vec.z)
             else
              newvec=Vector(vec.x+30,vec.y,vec.z)
            end
          end
          vec=newvec
          if zou==1 then
            if she==0 then
              unit:SetForwardVector(vec-jilu)
            end  
          end  
          walk(unit,vec)
         --unit:SetAbsOrigin(vec)
           
          return 0.1
        end,0)
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


   end

end

function  ps_init()
  
  ps={}                       --行走状态
  local i
  local j
  for i=0,9 do
    if PlayerResource:IsValidPlayer(i) then

        print("playerconnected:")
        print(i)

        ps[i]={}     --0为上下 1为左右 2为攻击上下 3为攻击左右

        for j=0,3 do                   
          ps[i][j]=0
        end
      
      else
        
        ps[i]=nil
      
      end
    end
end