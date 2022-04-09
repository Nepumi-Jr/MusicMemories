
return function(player)
    return Def.ActorFrame {
        LoadFont("Common Normal") .. {
            InitCommand=function(self) self:x(-35); self:y(5); self:horizalign(left); end;
            ComboCommand=function(self, param)
                local oldMaxCombo = tonumber(string.match( self:GetText(),"%d+")) or 0
                local newMaxCombo = param.Combo or 0
                if newMaxCombo > oldMaxCombo then
                    self:stopeffect():finishtweening():diffusealpha(1):rotationz(-2):skewx(-0.125):addx(7):addy(2):decelerate(0.05*2.5):rotationz(0):addx(-7):skewx(0):addy(-2)
                    :sleep(2):decelerate(0.1):diffusealpha(0):rotationz(10)
                    self:settextf("MC : %d", newMaxCombo)
                end
            end;
		};
    };
end