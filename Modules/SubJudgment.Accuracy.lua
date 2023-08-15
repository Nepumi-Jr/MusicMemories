
return function(player)
    return Def.ActorFrame {
        LoadFont("Combo Number") .. {
            InitCommand=function(self) self:x(-35); self:y(5); self:horizalign(left); self:zoom(0.3); end;
            JudgmentMessageCommand=function(self, param)
                if param.Player ==  player then
                    local stat = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
                    local acc = math.min(stat:GetActualDancePoints()/stat:GetCurrentPossibleDancePoints(),1)
                    if TP.Battle.IsBattle and ((TP.Battle.Hidden and TP.Battle.Mode == "Ac") or (TP.Battle.Mode == "Dr" and TP.Battle.Hidden and not TP.Battle.IsfailorIsDraw)) then
                        self:settext("--.--%")
                    else
                        self:settextf("%.2f%%",acc*100)
                    end
                    self:stopeffect():finishtweening():diffusealpha(1):rotationz(-1):addx(5):decelerate(0.05*2.5):rotationz(0):addx(-5)
                    :sleep(2):decelerate(0.1):diffusealpha(0):rotationz(10)
                end
            end;
		};
    };
end