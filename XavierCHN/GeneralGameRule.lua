if amhc.XavierCHN.GeneralGameRule == nil then 
    amhc.XavierCHN.GeneralGameRule = class({})
end

-- 设置游戏为某队死亡nKillsToWin次之后，对方就获得胜利的模式
-- 建议放在InitGameMode中
-- nKillsToWin: int 队伍获胜所需要击杀的人头数
-- 
function amhc.XavierCHN.GeneralGameRule:SetNumKillsToWinGameRule(nKillsToWin)
    self.__nKillsToWin = nKillsToWin
    -- 监听玩家被击杀的事件
    ListenToGameEvent("dota_player_killed", Dynamic_Wrap( amhc.XavierCHN.GeneralGameRule, "OnHeroKilled"), self)
end

-- 当玩家被击杀[N次杀敌获胜游戏模式的击杀响应]
-- keys: table 游戏自动生成的事件参数表
-- 
function amhc.XavierCHN.GeneralGameRule:OnHeroKilled(keys)
    -- 获取死亡玩家ID
    local player_id = keys.PlayerID
    -- 获取死亡玩家实体
    local player = PlayerResource:GetPlayer(player_id)
    -- 获取死亡玩家队伍
    local team = player:GetTeam()
    -- 初始化变量
    if self.nTeamDeaths == nil then self.nTeamDeaths = {} end
    if self.nTeamDeaths.team == nil then self.nTeamDeaths.team = 0 end
    -- 增加死亡次数
    self.nTeamDeaths.team = self.nTeamDeaths.team + 1
    -- 如果达到死亡次数，则设置对方获得胜利
    if self.nTeamDeaths.team >= self.__nKillsToWin then
        if team == DOTA_TEAM_GOODGUYS then
            GameRules:SetGameWinner( DOTA_TEAM_BADGUYS )
        end
        if team == DOTA_TEAM_BADGUYS then
            GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
        end
    end
end
