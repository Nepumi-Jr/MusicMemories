local t = Def.ActorFrame {};
t[#t + 1] = StandardDecorationFromFileOptional("BackgroundFrame","BackgroundFrame");
t[#t + 1] = LoadActor(THEME:GetPathG("Arrow", "Right")) ..{
    OnCommand = function(self) self:xy(SCREEN_CENTER_X + 370, SCREEN_CENTER_Y + 120); self:zoom(0.7); end;
    OffCommand= function(self) self:accelerate(0.3); self:addx(100); end;
};
t[#t + 1] = LoadActor(THEME:GetPathG("Arrow", "Left")) ..{
    OnCommand = function(self) self:xy(SCREEN_CENTER_X - 370, SCREEN_CENTER_Y + 120); self:zoom(0.7); end;
    OffCommand= function(self) self:accelerate(0.3); self:addx(-100); end;
};
return t
