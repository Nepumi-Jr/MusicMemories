
return function(player)
    local highScorePercent = nil
    return Def.ActorFrame {
        LoadFont("Combo Number") .. {
            InitCommand=function(self) 
                self:x(-35); self:y(5); self:horizalign(left); self:zoom(0.3); 
            end;
            OnCommand=function(self)
                local hst = PROFILEMAN:GetProfile(player):GetHighScoreListIfExists(GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(player)):GetHighScores();
                if hst[1] then
                    highScorePercent = hst[1]:GetPercentDP()
                end
            end;
            JudgmentMessageCommand=function(self, param)
                if param.Player ==  player then
                    local stat = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
                    local acc = math.min(stat:GetActualDancePoints()/stat:GetCurrentPossibleDancePoints(),1)
                    
                    if TP.Battle.IsBattle and ((TP.Battle.Hidden and TP.Battle.Mode == "Ac") or (TP.Battle.Mode == "Dr" and TP.Battle.Hidden and not TP.Battle.IsfailorIsDraw)) then
                        self:settext("--.--%")
                    else
                        --printf("??%s...", tostring(highScorePercent))
                        if highScorePercent then
                            local diff = (acc - highScorePercent) * 100
                            --printf("%.2f - %.2f = %.2f...",acc*100,highScorePercent*100,diff*100)
                            
                            if diff > 0 then
                                self:settextf("+%.2f%%",diff)
                                self:diffuse(Color.Green)
                            elseif diff < 0 then
                                self:settextf("%.2f%%",diff)
                                self:diffuse(Color.Red)
                            else
                                self:settextf("%.2f%%",diff)
                                self:diffuse(Color.White)
                            end
                        else
                            self:settextf("%.2f%%",acc*100)
                            self:diffuse(Color.White)
                        end
                    end
                    self:stopeffect():finishtweening():diffusealpha(1):rotationz(-1):addx(5):decelerate(0.05*2.5):rotationz(0):addx(-5)
                    :sleep(2):decelerate(0.1):diffusealpha(0):rotationz(10)
                end
            end;
		};
    };
end