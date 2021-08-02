local gc = Var("GameCommand");
local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame {
    GainFocusCommand=cmd(stoptweening;bob;effectmagnitude,0,10,0;decelerate,0.3;zoom,0.5);
	LoseFocusCommand=cmd(stoptweening;stopeffect;decelerate,0.3;zoom,0.5*0.4);
    Def.ActorFrame{
        GainFocusCommand=cmd(diffuseshift;effectcolor1,{0.5,0.5,0.5,1}; effectcolor2, {1.2,1.2,1.2,1};);
	    LoseFocusCommand=cmd(stopeffect;);
        LoadModule("Menu.Button.lua")(0,0,ColorLightTone(ModeIconColors[gc:GetName()]),ColorDarkTone(ModeIconColors[gc:GetName()]),ColorMidTone(ModeIconColors[gc:GetName()]),color("#000000"),color("#FFFFFF"),gc:GetText(),"")
    };
};
return t