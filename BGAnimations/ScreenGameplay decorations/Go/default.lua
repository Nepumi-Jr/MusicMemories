if ThemePrefs.Get("StartSongStyle") < 2 then
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


local path = THEME:GetCurrentThemeDirectory().."Resource/GraphFont/";

local function TFB(x)
return GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(x) ;
end;

local CX = SCREEN_CENTER_X;
local CY = SCREEN_CENTER_Y;

local PX = 0;
local PY = 0;

local function doRIP(this, offset)
    this["Go!"]:decelerate(offset):diffusealpha(0)

    this["Go!"]:GetChild("G"):x(-37):zoom(1):decelerate(offset):y(20):zoom(0.95)
    this["Go!"]:GetChild("o"):x(37):zoom(1):decelerate(offset):y(20):zoom(0.95)
    this["Go!"]:GetChild("!"):x(85):zoom(1):decelerate(offset):y(20):zoom(0.95)
end;

local function doGo(this, offset)
    this["Go!"]:linear(offset):diffusealpha(1)

    this["Go!"]:GetChild("G"):x(-37-15):zoom(0.95):decelerate(offset):x(-37):zoom(1)
    this["Go!"]:GetChild("o"):x(37):zoom(0.95):decelerate(offset):x(37):zoom(1)
    this["Go!"]:GetChild("!"):x(85+15):zoom(0.95):decelerate(offset):x(85):zoom(1)
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
        if GAMESTATE:GetSongBeat() >= FB-1 then
        --self:settext("GOO")
            if not Y[1] then
                doRIP(this, TFB(FB)-TFB(FB-1))
                Y[1] = true
            end
        elseif GAMESTATE:GetSongBeat() >= FB-4 then
        --self:settext("3")
            if not Y[4] then
                doGo(this, TFB(FB-3)-TFB(FB-4))
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