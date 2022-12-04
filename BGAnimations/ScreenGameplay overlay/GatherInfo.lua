local BattleMemories = {};
local Players = GAMESTATE:GetHumanPlayers();
local thisTapTiming = {}
local indTapTiming = {}

return Def.ActorFrame{


    Def.Quad{--Timing
        InitCommand=function(self) self:zoom(20); self:visible(false); end;
        OnCommand=function(self)
            for pn in ivalues(Players) do
                thisTapTiming[pn] = {};
                indTapTiming[pn] = 1;
            end
        end;
        JudgmentMessageCommand=function(self,params)
            
            if params.HoldNoteScore then return end;

            local smallTapNoteScore = ToEnumShortString(params.TapNoteScore)
            local TName,Length = LoadModule("Options.SmartTapNoteScore.lua")()
            local thisTime = GAMESTATE:GetCurMusicSeconds()
            
            
            if FindInTable(smallTapNoteScore, TName) or smallTapNoteScore == "Miss" then

                if thisTapTiming[params.Player] == nil then
                    --! This shouldn't happen
                    thisTapTiming[params.Player] = {}
                    indTapTiming[params.Player] = 1;
                end

                thisTapTiming[params.Player][indTapTiming[params.Player]] = {thisTime,params.TapNoteScore,
                smallTapNoteScore == "Miss" and 1 or params.TapNoteOffset};
                indTapTiming[params.Player] = indTapTiming[params.Player] + 1
            end

        end;
        OffCommand=function(self)
            for pn in ivalues(Players) do
                TP.Eva.TapTiming[pn] = thisTapTiming[pn];
            end
        end;
    };


    --[[Def.Quad{--Battle Memories
        Condition = (not GAMESTATE:IsCourseMode()) ;
        InitCommand=function(self) self:zoom(20); self:visible(false); end;
        JudgmentMessageCommand=function(self,params)
            PP[params.Player] = params;
            LP = params.Player;
            self:sleep(0.05):queuecommand("Addto")
        end;
        AddtoCommand=function(self)
            local params = PP[LP]

            local tsc = params.TapNoteScore

            if params.HoldNoteScore then
                tsc = "nil"
            end


            BattleMemories[params.Player] = (BattleMemories[params.Player] or "")..
            string.format("{%.3f,\"%s\",%.2f,\"%s\"},\n",
            GAMESTATE:GetCurMusicSeconds(),tostring(tsc),
            STATSMAN:GetCurStageStats():GetPlayerStageStats(params.Player):GetPercentDancePoints()*100,
            STATSMAN:GetCurStageStats():GetPlayerStageStats(params.Player):GetGrade())
            LS[params.Player] = STATSMAN:GetCurStageStats():GetPlayerStageStats(params.Player):GetPercentDancePoints()*100

            

            -- printf("<1>%d <2>%s <3>%s <4>%s\n%s",
            -- math.random(1,9),
            -- tostring(PROFILEMAN:GetProfile(LP):GetGUID()),
            -- tostring(PROFILEMAN:GetProfileDir("ProfileSlot_Player1")),
            -- string.gsub( tostring(GAMESTATE:GetCurrentSong():GetSongDir()),"/Songs/",""),
            -- tostring(GAMESTATE:GetCurrentSteps(LP):GetHash())
            -- )
            
            --printf("LP is %s!",tostring(LP))
                

        end;
        OffCommand=function(self)
            if GAMESTATE:GetCurMusicSeconds() >= GAMESTATE:GetCurrentSong():GetLastSecond()-1 then
                
                for k,LP in pairs(GAMESTATE:GetHumanPlayers()) do
                    if PROFILEMAN:GetProfile(LP):GetDisplayName() then
                        local PathA = tostring(PROFILEMAN:GetProfileDir(LP == PLAYER_1 and "ProfileSlot_Player1" or "ProfileSlot_Player2")).."Memories/BattleMemories/"
                        local PathB = (string.gsub( tostring(GAMESTATE:GetCurrentSong():GetSongDir()),"/Songs/","") or "SomeSong/")..tostring(ToEnumShortString(GAMESTATE:GetCurrentSteps(LP):GetStepsType())).."/";
    
                        local PathC;
                        if tostring(GAMESTATE:GetCurrentSteps(LP):GetDifficulty()) == "Difficulty_Edit" then
                            PathC = tostring(GAMESTATE:GetCurrentSteps(LP):GetHash())..".lua"
                        else
                            PathC = tostring(ToEnumShortString(GAMESTATE:GetCurrentSteps(LP):GetDifficulty()))..".lua"
                        end
    
    
                        if FILEMAN:DoesFileExist(PathA..PathB..PathC) then
                            
                            local TOD = LoadActor(PathA..PathB..PathC);
                            
                            if LS[LP] == nil then--some how when you play with Both Input
                                return;
                            end
                            --printf("%.2f vs %.2f is %s",LS , TOD[#TOD][3],LS <= TOD[#TOD][3] and "No Highscore..." or "Whatever")
                            if LS[LP] <= TOD[#TOD][3] then
                                return;
                            end
    
                        end
    
                        
    
                        local f = RageFileUtil.CreateRageFile()
                        if f:Open(PathA..PathB..PathC, 2) then
                            if BattleMemories[LP] ~= nil then--Some how
                                f:Write("return {"..BattleMemories[LP]:sub(1,BattleMemories[LP]:len()-2).."};")
                            end
                            --printf("Saving at %s%s%s!!",PathA,PathB,PathC)
                        end
                        f:destroy()
    
                    --SaveProfileCustom(PROFILEMAN:GetProfile(LP), dir)
                    end
                end


                
                
            end
            
        end;
    };]]


};