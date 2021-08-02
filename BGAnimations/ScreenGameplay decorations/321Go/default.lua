if ThemePrefs.Get("StartSongStyle") >= 2 then
    return Def.ActorFrame{}
end



local PPeng;
if GAMESTATE:IsCourseMode() then
    PPeng = GAMESTATE:GetCurrentCourse():GetCourseEntry(0):GetSong();
else
    PPeng = GAMESTATE:GetCurrentSong();
end

if PPeng == nil then return Def.ActorFrame{}; end

local FB = round(round(PPeng:GetFirstBeat())/4)*4
local function BeatToSec(x)
	return PPeng:GetTimingData():GetElapsedTimeFromBeat(x);
end
local soundOffset = PREFSMAN:GetPreference('GlobalOffsetSeconds')*2;

local Y = {false,false,false,false,false}


local function Diff2Cli(d,i)
CD = GameColor.Difficulty[d];
return CD[i]
end;

local CL = {1,1,1,1};


local path = THEME:GetCurrentThemeDirectory().."Graphics/_GraphFont/";

local function TFB(x)
return GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(x) ;
end;

local CX = SCREEN_CENTER_X;
local CY = SCREEN_CENTER_Y;

local PX = 0;
local PY = 0;

local function doRIP(this, offset)
    for i = 1,3 do
        this["Count"..tostring(i)]:visible(false)
    end
    this["Go!"]:decelerate(offset/3):diffusealpha(0)

end;

local function doAnimationIn(this, offset, dir)
    local thisSym = this:GetChild("Sym");
    thisSym:linear((offset)*0.25):diffusealpha(0.7)
    
    if dir == "R" then
        this:x(CX-100):decelerate(offset):x(CX)
    else
        this:x(CX+100):decelerate(offset):x(CX)
    end

end;

local function doAnimationOut(this, offset, dir)
    local thisSym = this:GetChild("Sym");
    thisSym:linear((offset)*0.25):diffusealpha(0)
    
    if dir == "R" then
        this:x(CX):decelerate(offset):x(CX+10)
    else
        this:x(CX):decelerate(offset):x(CX-10)
    end
end;

local function doCount(this, numCrt)
    --printf("CRT %d...\n",numCrt);
    thisOffset = TFB(FB-(numCrt))-TFB(FB-(numCrt+1))
    if numCrt == 3 then
        doAnimationIn(this["Count3"], thisOffset,"R")
    elseif numCrt == 2 then
        doAnimationOut(this["Count3"], thisOffset,"R")
        doAnimationIn(this["Count2"], thisOffset,"L")
    elseif numCrt == 1 then
        doAnimationOut(this["Count2"], thisOffset,"L")
        doAnimationIn(this["Count1"], thisOffset,"R")
    else
        doAnimationOut(this["Count1"], thisOffset,"R")

        this["Go!"]:linear((thisOffset)*0.25):diffusealpha(1)
    end
end;


local Tune = Def.ActorFrame{
    OnCommand=cmd(sleep,0.1;queuecommand,"GM");--Use For Delay
        --IDK Why SM use > 0 beat and then turn back to real beat :(
    GMCommand=function(self)
        if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
            CL = Meter2Color(GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter()/2+GAMESTATE:GetCurrentSteps(PLAYER_2):GetMeter()/2)
        elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
            CL = Meter2Color(GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter())
        elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
            CL = Meter2Color(GAMESTATE:GetCurrentSteps(PLAYER_2):GetMeter())
        end
            
        for PN in ivalues(GAMESTATE:GetHumanPlayers()) do
            PX = PX + SCREENMAN:GetTopScreen():GetChild((PN==PLAYER_1) and "PlayerP1" or 'PlayerP2'):GetX()/(#GAMESTATE:GetHumanPlayers());
            PY = PY + SCREENMAN:GetTopScreen():GetChild((PN==PLAYER_1) and "PlayerP1" or 'PlayerP2'):GetY()/(#GAMESTATE:GetHumanPlayers());
        end

        this = self:GetChildren()
        for i = 1,3 do
            local thisSym = this["Count"..tostring(i)]:GetChildren()["Sym"];
            thisSym:diffuse(CL):Load(path.."BigCount/"..(((TFB(FB-i)-TFB(FB-(i+1))) < 0.3) and "M" or "")..tostring(i)..".png"):diffusealpha(0)
        end
        this["Go!"]:xy(PX,PY):diffuse(CL):diffusealpha(0)
        
        self:playcommand("Nep")
    end;
    NepCommand=function(self)
        this = self:GetChildren()
        
        if GAMESTATE:GetSongBeat() >= FB then
            if not Y[5] then
                doRIP(this, TFB(FB+1)-TFB(FB))
                Y[5] = true
            end
        elseif GAMESTATE:GetSongBeat() >= FB-1 then
        --self:settext("GOO")
            if not Y[1] then
                doCount(this, 0)
                Y[1] = true
            end
        elseif GAMESTATE:GetSongBeat() >= FB-2 then
        --self:settext("1")
            if not Y[2] then
                doCount(this, 1)
                Y[2] = true
            end
        elseif GAMESTATE:GetSongBeat() >= FB-3 then
        --self:settext("2")
            if not Y[3] then
                doCount(this, 2)
                Y[3] = true
            end
        elseif GAMESTATE:GetSongBeat() >= FB-4 then
        --self:settext("3")
            if not Y[4] then
                doCount(this, 3)
                Y[4] = true
            end
        end
        if GAMESTATE:GetSongBeat() < FB+10 then
            self:sleep(1/30):queuecommand("Nep")
        end
    end;
};

for i = 1,3 do
    Tune[#Tune + 1] = Def.ActorFrame{
        Name = "Count"..tostring(i);
        InitCommand=cmd(Center);
        Def.Sprite{
            Name = "Sym";
            InitCommand=cmd(blend,"BlendMode_Add";animate,false;zoom,0.9;diffusealpha,0);
        };
    };
end

Tune[#Tune + 1] = Def.ActorFrame{
    Name = "Go!";
    Def.Sprite{
        Name = "G";
        OnCommand=cmd(x,-37;Load,path.."Cha3D/G.png");
    };
    Def.Sprite{
        Name = "o";
        OnCommand=cmd(x,37;Load,path.."Cha3D/O.png");
    };
    Def.Sprite{
        Name = "!";
        OnCommand=cmd(x,85;Load,path.."Cha3D/!.png");
    };
};


return Tune;