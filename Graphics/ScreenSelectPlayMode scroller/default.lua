local gc = Var "GameCommand";
local Lew = 1;
local Wario = {0,0,0,0};
local bigTextWidth;
local bigText = gc:GetText()
local bigTextColor = ModeIconColors[gc:GetName()]
local expTextWidth;
local expText;
if bigText == "Oni" then
    expText = THEME:GetString("ScreenSelectPlayMode",  "SurvivalExplanation")
else
    expText = THEME:GetString("ScreenSelectPlayMode", gc:GetName() .. "Explanation")
end


local t = Def.ActorFrame {};


t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X/4;y,70;rotationz,90;zoomx,0.7;zoomy,3);
-- 	GainFocusCommand=cmd(visible,true);
-- 	LoseFocusCommand=cmd(visible,false);
};
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(y,-120;);
    LoadFont("Common Large")..{
		InitCommand=function(self)
            (cmd(settext,bigText;horizalign,left;zoom,0.4;y,15;x,30-SCREEN_CENTER_X;skewx,-0.2;))(self)
            bigTextWidth = self:GetWidth()
            self:visible(false);
        end;
        
	};

    Def.Quad{
        InitCommand=cmd(visible,bigTextWidth ~= 0;diffuse,bigTextColor;horizalign,right;vertalign,top;x,SCREEN_CENTER_X;y,-2;zoomy,2;zoomx,bigTextWidth*0.4 + 150;fadeleft,0.3);
        GainFocusCommand=cmd(stoptweening;decelerate,0.3;diffusealpha,1);
        LoseFocusCommand=cmd(stoptweening;decelerate,0.3;diffusealpha,0);
    };
    Def.Quad{
        InitCommand=cmd(visible,bigTextWidth ~= 0;diffuse,color("#333333");horizalign,right;vertalign,top;x,SCREEN_CENTER_X;zoomy,50;zoomx,bigTextWidth*0.4 + 150;fadeleft,0.3);
        GainFocusCommand=cmd(visible,true);
        LoseFocusCommand=cmd(visible,false);
    };
    Def.Quad{
        InitCommand=cmd(visible,bigTextWidth ~= 0;diffuse,bigTextColor;horizalign,right;vertalign,top;x,SCREEN_CENTER_X;y,50;zoomy,2;zoomx,bigTextWidth*0.4 + 150;fadeleft,0.3);
        GainFocusCommand=cmd(stoptweening;decelerate,0.3;diffusealpha,1);
        LoseFocusCommand=cmd(stoptweening;decelerate,0.3;diffusealpha,0);
    };
    

	LoadFont("Common Large")..{
		InitCommand=cmd(settext, bigText ;diffuse,bigTextColor;diffusebottomedge,ColorLightTone(bigTextColor);horizalign,right;zoom,0.4;y,15;x,-30+SCREEN_CENTER_X;skewx,-0.2);
        GainFocusCommand=cmd(stoptweening;visible,true;x,-30+SCREEN_CENTER_X-20;decelerate,0.5;x,-30+SCREEN_CENTER_X);
        LoseFocusCommand=cmd(stoptweening;visible,false;);
    };
};

local function NoteAndBomb(name)
    local veryList = {}
    local thisDef = Def.ActorFrame{};

    if name == "Normal" then
        veryList = {
            {"arrow", 70, 0, 225},
            {"arrow", -20, 50, 8},
        }
    elseif name == "Endless" then
        veryList = {
            {"arrow", 90, -20, 145},
            {"arrow", -90, 40, 30},
            {"arrow", -110, -50, 242},
            {"bomb", 0, -15, 75},
            {"bomb", 40, 50, 123},
        }
    elseif name == "Nonstop" then
        veryList = {
            {"arrow", 80, -30, 98},
            {"bomb", -90, 40, 121},
            {"arrow", -110, -50, 43},
        }
    elseif name == "Oni" then
        veryList = {
            {"arrow", -20, -15, 12},
            {"arrow", -70, -10, 143},
            {"arrow", -110, -80, 324},
            {"bomb", -25, 40, 75},
            {"bomb", 45, 30, 123},
        }
    end

    for i = 1,#veryList do
        thisDef[#thisDef+1] = LoadActor(THEME:GetPathG("OutfoxNote/_"..veryList[i][1], "")) .. {
            InitCommand=cmd(x,veryList[i][2];y,veryList[i][3];zoom,0.7;bob;effectmagnitude,0,10,0;effectperiod,math.random(10,40)/2;effectoffset,math.random(4,10)/10;rotationz,veryList[i][4]);
        };
    end

    return thisDef;
end

t[#t+1] = Def.ActorFrame {
    FOV=90;
    InitCommand=cmd(y,SCREEN_TOP-20;x,-150);
    OffFocusedCommand=cmd(decelerate,0.8;rotationy,360*2;y,SCREEN_TOP;x,-150;zoom,1.3;accelerate,0.4;y,30;decelerate,0.7;y,-SCREEN_CENTER_Y*4;zoomx,0);
    -- Main Emblem
    Def.ActorFrame {
        GainFocusCommand=cmd(finishtweening;visible,true;x,50;glow,Color("White");decelerate,0.5;glow,Color("Invisible");x,0;bob;effectmagnitude,0,5,0;effectperiod,7;);
        LoseFocusCommand=cmd(finishtweening;stopeffect;visible,false);
        LoadActor( gc:GetName() ) .. {
            InitCommand=cmd(diffusealpha,1;zoom,0.4);
        };
        NoteAndBomb(gc:GetName());
    };
    
};
    -- Text Frame
t[#t+1] = Def.ActorFrame {
    LoadFont("Common Normal") .. {
		Text= expText;
		InitCommand=function(self)
            (cmd(horizalign,right;x,SCREEN_CENTER_X-20;y,-30;skewx,-0.125;zoom,1.2;shadowlength,1;diffusebottomedge,BoostColor(bigTextColor,2)))(self)
            expTextWidth = self:GetWidth()
            self:visible(false)
        end;
	};
    Def.Quad{
        InitCommand=cmd(diffuse,color("#333333");horizalign,right;vertalign,top;x,SCREEN_CENTER_X;y,-55;
        zoomy,30 * (LoadModule("Utils.CountText.lua")(expText, "\n") + 1) + 20;zoomx,expTextWidth*1.7 + 10;fadeleft,0.3);
        GainFocusCommand=cmd(visible,true);
        LoseFocusCommand=cmd(visible,false);
        OffFocusedCommand=cmd(stoptweening;decelerate,0.75;cropleft,1)
    };
	LoadFont("Common Normal") .. {
		Text= expText;
		InitCommand=cmd(horizalign,right;vertalign,top;x,SCREEN_CENTER_X-20;y,-30;skewx,-0.125;zoom,1.2;shadowlength,1;diffusebottomedge,BoostColor(bigTextColor,2));
		GainFocusCommand=cmd(stoptweening;visible,true;x,SCREEN_CENTER_X-60;decelerate,0.45;x,SCREEN_CENTER_X-20);
		LoseFocusCommand=cmd(stoptweening;visible,false;);
		OffFocusedCommand=cmd(stoptweening;linear,0.75;cropleft,1);
	};
    
};


return t