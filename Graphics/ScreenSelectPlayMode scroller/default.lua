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
	InitCommand=function(self) self:x(SCREEN_CENTER_X/4); self:y(70); self:rotationz(90); self:zoomx(0.7); self:zoomy(3); end;
-- 	GainFocusCommand=function(self) self:visible(true); end;
-- 	LoseFocusCommand=function(self) self:visible(false); end;
};
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) self:y(-120); end;
    LoadFont("Common Large")..{
		InitCommand=function(self)
            (function(self) self:settext(bigText); self:horizalign(left); self:zoom(0.4); self:y(15); self:x(30-SCREEN_CENTER_X); self:skewx(-0.2); end)(self)
            bigTextWidth = self:GetWidth()
            self:visible(false);
        end;
        
	};

    Def.Quad{
        InitCommand=function(self) self:visible(bigTextWidth ~= 0); self:diffuse(bigTextColor); self:horizalign(right); self:vertalign(top); self:x(SCREEN_CENTER_X); self:y(-2); self:zoomy(2); self:zoomx(bigTextWidth*0.4 + 150); self:fadeleft(0.3); end;
        GainFocusCommand=function(self) self:stoptweening(); self:decelerate(0.3); self:diffusealpha(1); end;
        LoseFocusCommand=function(self) self:stoptweening(); self:decelerate(0.3); self:diffusealpha(0); end;
    };
    Def.Quad{
        InitCommand=function(self) self:visible(bigTextWidth ~= 0); self:diffuse(color("#333333")); self:horizalign(right); self:vertalign(top); self:x(SCREEN_CENTER_X); self:zoomy(50); self:zoomx(bigTextWidth*0.4 + 150); self:fadeleft(0.3); end;
        GainFocusCommand=function(self) self:visible(true); end;
        LoseFocusCommand=function(self) self:visible(false); end;
    };
    Def.Quad{
        InitCommand=function(self) self:visible(bigTextWidth ~= 0); self:diffuse(bigTextColor); self:horizalign(right); self:vertalign(top); self:x(SCREEN_CENTER_X); self:y(50); self:zoomy(2); self:zoomx(bigTextWidth*0.4 + 150); self:fadeleft(0.3); end;
        GainFocusCommand=function(self) self:stoptweening(); self:decelerate(0.3); self:diffusealpha(1); end;
        LoseFocusCommand=function(self) self:stoptweening(); self:decelerate(0.3); self:diffusealpha(0); end;
    };
    

	LoadFont("Common Large")..{
		InitCommand=function(self) self:settext(bigText); self:diffuse(bigTextColor); self:diffusebottomedge(ColorLightTone(bigTextColor)); self:horizalign(right); self:zoom(0.4); self:y(15); self:x(-30+SCREEN_CENTER_X); self:skewx(-0.2); end;
        GainFocusCommand=function(self) self:stoptweening(); self:visible(true); self:x(-30+SCREEN_CENTER_X-20); self:decelerate(0.5); self:x(-30+SCREEN_CENTER_X); end;
        LoseFocusCommand=function(self) self:stoptweening(); self:visible(false); end;
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
            InitCommand=function(self) self:x(veryList[i][2]); self:y(veryList[i][3]); self:zoom(0.7); self:bob(); self:effectmagnitude(0,10,0); self:effectperiod(math.random(10,40)/2); self:effectoffset(math.random(4,10)/10); self:rotationz(veryList[i][4]); end;
        };
    end

    return thisDef;
end

t[#t+1] = Def.ActorFrame {
    FOV=90;
    InitCommand=function(self) self:y(SCREEN_TOP-20); self:x(-150); end;
    OffFocusedCommand=function(self) self:decelerate(0.8); self:rotationy(360*2); self:y(SCREEN_TOP); self:x(-150); self:zoom(1.3); self:accelerate(0.4); self:y(30); self:decelerate(0.7); self:y(-SCREEN_CENTER_Y*4); self:zoomx(0); end;
    -- Main Emblem
    Def.ActorFrame {
        GainFocusCommand=function(self) self:finishtweening(); self:visible(true); self:x(50); self:glow(Color("White")); self:decelerate(0.5); self:glow(Color("Invisible")); self:x(0); self:bob(); self:effectmagnitude(0,5,0); self:effectperiod(7); end;
        LoseFocusCommand=function(self) self:finishtweening(); self:stopeffect(); self:visible(false); end;
        LoadActor( gc:GetName() ) .. {
            InitCommand=function(self) self:diffusealpha(1); self:zoom(0.4); end;
        };
        NoteAndBomb(gc:GetName());
    };
    
};
    -- Text Frame
t[#t+1] = Def.ActorFrame {
    LoadFont("Common Normal") .. {
		Text= expText;
		InitCommand=function(self)
            (function(self) self:horizalign(right); self:x(SCREEN_CENTER_X-20); self:y(-30); self:skewx(-0.125); self:zoom(1.2); self:shadowlength(1); self:diffusebottomedge(BoostColor(bigTextColor,2)); end)(self)
            expTextWidth = self:GetWidth()
            self:visible(false)
        end;
	};
    Def.Quad{
        InitCommand=function(self) self:diffuse(color("#333333")); self:horizalign(right); self:vertalign(top); self:x(SCREEN_CENTER_X); self:y(-55); self:zoomy(30 * (LoadModule("Utils.CountText.lua")(expText, "\n") + 1) + 20); self:zoomx(expTextWidth*1.7 + 10); self:fadeleft(0.3); end;
        GainFocusCommand=function(self) self:visible(true); end;
        LoseFocusCommand=function(self) self:visible(false); end;
        OffFocusedCommand=function(self) self:stoptweening(); self:decelerate(0.75); self:cropleft(1); end
    };
	LoadFont("Common Normal") .. {
		Text= expText;
		InitCommand=function(self) self:horizalign(right); self:vertalign(top); self:x(SCREEN_CENTER_X-20); self:y(-30); self:skewx(-0.125); self:zoom(1.2); self:shadowlength(1); self:diffusebottomedge(BoostColor(bigTextColor,2)); end;
		GainFocusCommand=function(self) self:stoptweening(); self:visible(true); self:x(SCREEN_CENTER_X-60); self:decelerate(0.45); self:x(SCREEN_CENTER_X-20); end;
		LoseFocusCommand=function(self) self:stoptweening(); self:visible(false); end;
		OffFocusedCommand=function(self) self:stoptweening(); self:linear(0.75); self:cropleft(1); end;
	};
    
};


return t