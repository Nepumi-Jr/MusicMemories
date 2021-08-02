
return function(player)
    return Def.ActorFrame {
        LoadFont("Common Normal") .. {
            Text = "0/0";
            InitCommand=cmd(x,-35;y,5;horizalign,left;zoom,1);
            OnCommand=cmd(settext,"0/"..(GAMESTATE:GetCurrentSteps(player):GetRadarValues(player):GetValue('RadarCategory_TapsAndHolds')+GAMESTATE:GetCurrentSteps(player):GetRadarValues(player):GetValue('RadarCategory_Holds')));
            JudgmentMessageCommand=function(self, param)
                if param.Player ==  player then
                    local curValue =  GAMESTATE:GetCurrentSteps(player):GetRadarValues(player);
                    local all = curValue:GetValue('RadarCategory_TapsAndHolds')+curValue:GetValue('RadarCategory_Holds');
                    
                    if TP.Battle.IsBattle and ((TP.Battle.Hidden and TP.Battle.Mode == "Ac") or (TP.Battle.Mode == "Dr" and TP.Battle.Hidden and not TP.Battle.IsfailorIsDraw)) then
				        self:settext("??/??")
                        return
                    end

                    if param.TapNoteScore=="TapNoteScore_W1" or
                    param.TapNoteScore=="TapNoteScore_ProW1" or
                    param.TapNoteScore=="TapNoteScore_ProW2" or
                    param.TapNoteScore=="TapNoteScore_ProW3" or
                    param.TapNoteScore=="TapNoteScore_ProW4" or
                    param.TapNoteScore=="TapNoteScore_ProW5" or
                    param.TapNoteScore=="TapNoteScore_W3" or
				    param.TapNoteScore=="TapNoteScore_W2" then
                        local newTap = tonumber(string.match( self:GetText(),"%d+" )) + 1
                        self:stopeffect():finishtweening():diffusealpha(1):rotationz(-1):addx(5):decelerate(0.05*2.5):rotationz(0):addx(-5)
                        :sleep(2):decelerate(0.1):diffusealpha(0):rotationz(10)
                        self:settextf("%d/%d",newTap, all)
                    end
                
                end
            end;
		};
    };
end