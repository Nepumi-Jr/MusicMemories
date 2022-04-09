
local nameTime = {
    ProW1 = "Flawless",
    ProW2 = "Perfect+",
    ProW3 = "Perfect",
    ProW4 = "Wicked+",
    ProW5 = "Wicked",
    W1 = "Fantastic",
    W2 = "Excellent",
    W3 = "Great",
    W4 = "Decent",
    W5 = "Way off",
}
local TName,Length = LoadModule("Options.SmartTapNoteScore.lua")()
TName = LoadModule("Utils.SortTiming.lua")(TName)

local function getBoundSecondTap(timing, newScale)
    local scale = newScale or PREFSMAN:GetPreference("TimingWindowScale")
    local add = PREFSMAN:GetPreference("TimingWindowAdd")
    --printf("%g + %g\n",scale,add)
    local thisTiming = LoadModule("Options.ReturnCurrentTiming.lua")()

    if thisTiming["Timings"]['TapNoteScore_'..timing] then
        return GetWindowSeconds(thisTiming["Timings"]['TapNoteScore_'..timing], scale, add)
    else
        return 0
    end
end;

local function createTiming()
    local t = Def.ActorFrame{
        InitCommand=function(self) self:x(SCREEN_CENTER_X-200); self:y(SCREEN_CENTER_Y-85); end;
    };
    for i,vTime in pairs({"ProW1","ProW2","ProW3","ProW4","ProW5","W1","W2","W3","W4","W5"}) do
        t[#t+1] = Def.ActorFrame{
            InitCommand=function(self) self:y(i*19); self:zoom(0.8); end;
            LoadFont("Common normal").. {
                InitCommand=function(self) self:settext(nameTime[vTime]); self:diffuse(LoadModule("Color.Judgment.lua")(vTime)); self:diffusebottomedge(LoadModule("Color.Judgment.lua")(vTime)); end;
                UserPlayerJudgmentMessageCommand=function(self)
                    local thisVal = getBoundSecondTap(vTime)
                    self:stoptweening():decelerate(0.5)
                    self:diffusebottomedge(LoadModule("Color.Judgment.lua")(vTime))
                end;
            };
            LoadFont("Combo Number").. {
                InitCommand=function(self) self:x(100); self:horizalign(left); self:zoom(0.3); self:diffuse(LoadModule("Color.Judgment.lua")(vTime)); end;
                OnCommand=function(self)
                    local thisVal = getBoundSecondTap(vTime)
                    local thisStr = string.format( "%g",math.mod( thisVal,1 ))
                    self:settext(string.sub( thisStr, 2,string.len(thisStr) ))
                    if thisVal == 0 then self:diffuse(ColorDarkTone(LoadModule("Color.Judgment.lua")(vTime))) end
                end;
            };
            LoadFont("Combo Number").. {
                InitCommand=function(self) self:x(100); self:horizalign(right); self:zoom(0.3); self:diffuse(LoadModule("Color.Judgment.lua")(vTime)); end;
                OnCommand=function(self)
                    local thisVal = getBoundSecondTap(vTime)
                    self:settextf("%d",thisVal)
                    if thisVal == 0 then self:diffuse(ColorDarkTone(LoadModule("Color.Judgment.lua")(vTime))) end
                end;
            };

            LoadFont("Combo Number").. {
                InitCommand=function(self) self:x(350); self:horizalign(left); self:zoom(0.3); self:diffuse(LoadModule("Color.Judgment.lua")(vTime)); end;
                OnCommand=function(self, param)
                    self:playcommand("ReloadTime", {})
                end;
                UserPlayerJudgmentMessageCommand=function(self, param)
                    self:playcommand("ReloadTime", {})
                end;
                TimingScaleChangedMessageCommand=function(self, param)
                    self:playcommand("ReloadTime", param)
                end;
                ReloadTimeCommand=function(self, param)
                    local thisVal = getBoundSecondTap(vTime, param.newScale)
                    local thisStr = string.format( "%g",math.mod( thisVal,1 ))
                    local thisColor = LoadModule("Color.Judgment.lua")(vTime)
                    self:stoptweening():diffusealpha(0)
                    self:settext(string.sub( thisStr, 2,string.len(thisStr) ))
                    if thisVal == 0 then 
                        self:diffuse(ColorDarkTone(thisColor))
                    else
                        self:diffuse(thisColor)
                    end
                    self:x(320):diffusealpha(0):decelerate(0.5):x(350):diffusealpha(1)
                end;
            };
            LoadFont("Combo Number").. {
                InitCommand=function(self) self:x(350); self:horizalign(right); self:zoom(0.3); self:diffuse(LoadModule("Color.Judgment.lua")(vTime)); end;
                OnCommand=function(self, param)
                    self:playcommand("ReloadTime", {})
                end;
                UserPlayerJudgmentMessageCommand=function(self, param)
                    self:playcommand("ReloadTime", {})
                end;
                TimingScaleChangedMessageCommand=function(self, param)
                    self:playcommand("ReloadTime", param)
                end;
                ReloadTimeCommand=function(self, param)
                    local thisVal = getBoundSecondTap(vTime, param.newScale)
                    local thisColor = LoadModule("Color.Judgment.lua")(vTime)
                    self:stoptweening():diffusealpha(0)
                    self:settextf("%d",thisVal)
                    if thisVal == 0 then 
                        self:diffuse(ColorDarkTone(thisColor))
                    else
                        self:diffuse(thisColor)
                    end
                    self:x(320):diffusealpha(0):decelerate(0.5):x(350):diffusealpha(1)
                    
                end;
            };
        };
    end
    return t;
end
return Def.ActorFrame{
    Def.Quad{
        InitCommand=function(self) self:xy(SCREEN_CENTER_X, SCREEN_CENTER_Y+20); self:zoomto(700,200); end;
    };
    Def.Quad{
        InitCommand=function(self) self:xy(SCREEN_CENTER_X, SCREEN_CENTER_Y+20); self:zoomto(695,195); self:diffuse({0.1,0.1,0.1,1}); end;
    };
    createTiming();
    LoadActor(THEME:GetPathG("Arrow","Right"),Color.Green).. {
        InitCommand=function(self) self:xy(SCREEN_CENTER_X, SCREEN_CENTER_Y+20); end;
    };
    LoadFont("Common Normal").. {
        Text = THEME:GetString("ScreenOptionsTiming","unitExplain");
        InitCommand=function(self) self:xy(SCREEN_CENTER_X+200, SCREEN_CENTER_Y+105); self:skewx(-0.2); self:zoom(0.5); end
    };
    
};