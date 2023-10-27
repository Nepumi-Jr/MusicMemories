return Def.ActorFrame{
    LoadFont("Common", "Normal")..{
        InitCommand = function(self) self:y(40):zoom(0.5):settext("Barely!"):strokecolor(Color.Black) end;
        OnCommand = function(self) self:diffuseshift():effectcolor1(Color.Red):effectcolor2(Color.White) end;
    };
    LoadActor(THEME:GetPathG("_Mini","Arrow")).. {
        InitCommand=function(self) self:bob(); self:effectmagnitude(0,2,0); self:effecttiming(0.2,0.6,0.2,0):effectclock("beat"); self:diffuse(Color.Red); end;
        OnCommand=function(self) self:y(53):zoom(0.2) end;
    };
};