local gc = Var("GameCommand");
local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame {
    GainFocusCommand=function(self) self:stoptweening(); self:bob(); self:effectmagnitude(0,10,0); self:decelerate(0.3); self:zoom(0.5); end;
	LoseFocusCommand=function(self) self:stoptweening(); self:stopeffect(); self:decelerate(0.3); self:zoom(0.5*0.4); end;
    Def.ActorFrame{
        GainFocusCommand=function(self) self:diffuseshift(); self:effectcolor1({0.5,0.5,0.5,1}); self:effectcolor2({1.2,1.2,1.2,1}); end;
	    LoseFocusCommand=function(self) self:stopeffect(); end;
        LoadModule("Menu.Button.lua")(0,0,ColorLightTone(ModeIconColors[gc:GetName()]),ColorDarkTone(ModeIconColors[gc:GetName()]),ColorMidTone(ModeIconColors[gc:GetName()]),color("#000000"),color("#FFFFFF"),gc:GetText(),"")
    };
};
return t