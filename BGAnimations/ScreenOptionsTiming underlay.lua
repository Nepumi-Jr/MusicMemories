
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
    printf("%g + %g\n",scale,add)
    local thisTiming = LoadModule("Options.ReturnCurrentTiming.lua")()

    if thisTiming["Timings"]['TapNoteScore_'..timing] then
        return GetWindowSeconds(thisTiming["Timings"]['TapNoteScore_'..timing], scale, add)
    else
        return 0
    end
end;

local function createTiming()
    local t = Def.ActorFrame{
        InitCommand=cmd(x,SCREEN_CENTER_X-200;y,SCREEN_CENTER_Y-85);
    };
    for i,vTime in pairs({"ProW1","ProW2","ProW3","ProW4","ProW5","W1","W2","W3","W4","W5"}) do
        t[#t+1] = Def.ActorFrame{
            InitCommand=cmd(y,i*19;zoom,0.8);
            LoadFont("Common normal").. {
                InitCommand=cmd(settext,nameTime[vTime];diffuse,LoadModule("Color.Judgment.lua")(vTime);diffusebottomedge,LoadModule("Color.Judgment.lua")(vTime));
                UserPlayerJudgmentMessageCommand=function(self)
                    local thisVal = getBoundSecondTap(vTime)
                    self:stoptweening():decelerate(0.5)
                    self:diffusebottomedge(LoadModule("Color.Judgment.lua")(vTime))
                end;
            };
            LoadFont("Combo Number").. {
                InitCommand=cmd(x,100;horizalign,left;zoom,0.3;diffuse,LoadModule("Color.Judgment.lua")(vTime));
                OnCommand=function(self)
                    local thisVal = getBoundSecondTap(vTime)
                    local thisStr = string.format( "%g",math.mod( thisVal,1 ))
                    self:settext(string.sub( thisStr, 2,string.len(thisStr) ))
                    if thisVal == 0 then self:diffuse(ColorDarkTone(LoadModule("Color.Judgment.lua")(vTime))) end
                end;
            };
            LoadFont("Combo Number").. {
                InitCommand=cmd(x,100;horizalign,right;zoom,0.3;diffuse,LoadModule("Color.Judgment.lua")(vTime));
                OnCommand=function(self)
                    local thisVal = getBoundSecondTap(vTime)
                    self:settextf("%d",thisVal)
                    if thisVal == 0 then self:diffuse(ColorDarkTone(LoadModule("Color.Judgment.lua")(vTime))) end
                end;
            };

            LoadFont("Combo Number").. {
                InitCommand=cmd(x,350;horizalign,left;zoom,0.3;diffuse,LoadModule("Color.Judgment.lua")(vTime));
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
                InitCommand=cmd(x,350;horizalign,right;zoom,0.3;diffuse,LoadModule("Color.Judgment.lua")(vTime));
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
        InitCommand=cmd(xy,SCREEN_CENTER_X, SCREEN_CENTER_Y+20;zoomto,700,200;);
    };
    Def.Quad{
        InitCommand=cmd(xy,SCREEN_CENTER_X, SCREEN_CENTER_Y+20;zoomto,695,195;diffuse,{0.1,0.1,0.1,1});
    };
    createTiming();
    LoadActor(THEME:GetPathG("Arrow","Right"),Color.Green).. {
        InitCommand=cmd(xy,SCREEN_CENTER_X, SCREEN_CENTER_Y+20);
    };
    LoadFont("Common Normal").. {
        Text = THEME:GetString("ScreenOptionsTiming","unitExplain");
        InitCommand=cmd(xy,SCREEN_CENTER_X+200, SCREEN_CENTER_Y+105;skewx,-0.2;zoom,0.5)
    };
    
};