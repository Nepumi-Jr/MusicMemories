
local PPeng;
if GAMESTATE:IsCourseMode() then
PPeng = GAMESTATE:GetCurrentCourse():GetCourseEntry(0):GetSong();
else
PPeng = GAMESTATE:GetCurrentSong();
end

if PPeng == nil then return Def.ActorFrame{}; end

local FB = round(round(PPeng:GetFirstBeat())/4)*4


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

local Tune = Def.ActorFrame{

Def.Quad{
OnCommand=function(self) self:sleep(0.1); self:queuecommand("GM"); end;--Use For Delay
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
		
MESSAGEMAN:Broadcast("SFB")
end;
};



LoadFont("Common Normal")..{
InitCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y*0.4); self:settext(""); self:rainbow(); end;
SFBMessageCommand=function(self)
self:playcommand("Nep")
end;
NepCommand=function(self)
if GAMESTATE:GetSongBeat() >= FB then
if not Y[5] then
MESSAGEMAN:Broadcast("RIPR")
Y[5] = true
end
elseif GAMESTATE:GetSongBeat() >= FB-1 then
--self:settext("GOO")

if not Y[1] then
MESSAGEMAN:Broadcast("Gooo")
Y[1] = true
end


elseif GAMESTATE:GetSongBeat() >= FB-2 then
--self:settext("1")
if not Y[2] then
MESSAGEMAN:Broadcast("Nueng")
Y[2] = true
end
elseif GAMESTATE:GetSongBeat() >= FB-3 then
--self:settext("2")
if not Y[3] then
MESSAGEMAN:Broadcast("Song")
Y[3] = true
end
elseif GAMESTATE:GetSongBeat() >= FB-4 then
--self:settext("3")
if not Y[4] then
MESSAGEMAN:Broadcast("Sam")
Y[4] = true
end
end
if GAMESTATE:GetSongBeat() < FB+10 then
self:sleep(1/30):queuecommand("Nep")
end
end;
};

Def.ActorFrame{
	InitCommand=function(self) self:Center(); end;
	SamMessageCommand=function(self) self:x(CX+100*0.4); self:decelerate((TFB(FB-3)-TFB(FB-4))); self:x(CX); end;
	SongMessageCommand=function(self) self:x(CX); self:decelerate((TFB(FB-2)-TFB(FB-3))); self:x(CX-5); end;
	RIPRMessageCommand=function(self) self:visible(false); end;
	Def.Sprite{
		InitCommand=function(self) self:blend("BlendMode_Add"); self:animate(false); self:zoom(0.9); self:diffusealpha(0); end;
		SFBMessageCommand=function(self) self:diffuse(CL); self:Load(path.."BigCount/"..(((TFB(FB-3)-TFB(FB-4)) < 0.3) and "M" or "").."3.png"); self:diffusealpha(0); end;
		SamMessageCommand=function(self) self:linear((TFB(FB-3)-TFB(FB-4))*0.25); self:diffusealpha(.7); end;
		SongMessageCommand=function(self) self:linear((TFB(FB-2)-TFB(FB-3))*0.25); self:diffusealpha(.0); end;
	};
};

Def.ActorFrame{
	InitCommand=function(self) self:Center(); end;
	SongMessageCommand=function(self) self:x(CX-100*0.4); self:decelerate((TFB(FB-2)-TFB(FB-3))); self:x(CX); end;
	NuengMessageCommand=function(self) self:x(CX); self:decelerate((TFB(FB-1)-TFB(FB-2))); self:x(CX+5); end;
	RIPRMessageCommand=function(self) self:visible(false); end;
	Def.Sprite{
		InitCommand=function(self) self:blend("BlendMode_Add"); self:animate(false); self:zoom(0.9); self:diffusealpha(0); end;
		SFBMessageCommand=function(self) self:diffuse(CL); self:Load(path.."BigCount/"..(((TFB(FB-2)-TFB(FB-3)) < 0.3) and "M" or "").."2.png"); self:diffusealpha(0); end;
		SongMessageCommand=function(self) self:linear((TFB(FB-2)-TFB(FB-3))*0.25); self:diffusealpha(.7); end;
		NuengMessageCommand=function(self) self:linear((TFB(FB-1)-TFB(FB-2))*0.25); self:diffusealpha(.0); end;
	};
};

Def.ActorFrame{
	InitCommand=function(self) self:Center(); end;
	NuengMessageCommand=function(self) self:y(CY+50*0.4); self:decelerate((TFB(FB-1)-TFB(FB-2))); self:y(CY); end;
	GoooMessageCommand=function(self) self:x(CX); self:decelerate((TFB(FB)-TFB(FB-1))); self:y(CY-5); end;
	RIPRMessageCommand=function(self) self:visible(false); end;
	Def.Sprite{
		InitCommand=function(self) self:blend("BlendMode_Add"); self:animate(false); self:zoom(0.9); self:diffusealpha(0); end;
		SFBMessageCommand=function(self) self:diffuse(CL); self:Load(path.."BigCount/"..(((TFB(FB-1)-TFB(FB-2)) < 0.3) and "M" or "").."1.png"); self:diffusealpha(0); end;
		NuengMessageCommand=function(self) self:linear((TFB(FB-1)-TFB(FB-2))*0.25); self:diffusealpha(.7); end;
		GoooMessageCommand=function(self) self:linear((TFB(FB)-TFB(FB-1))*0.25); self:diffusealpha(.0); end;
	};
};

--[[Def.Sprite{
SFBMessageCommand=function(self) self:blend("BlendMode_Add"); self:Center(); self:animate(false); self:diffuse(CL); self:zoom(0.9); self:diffusealpha(0); end;
SamMessageCommand=function(self) self:Load(path.."BigCount/"..(((TFB(FB-3)-TFB(FB-4)) < 0.3) and "M" or "").."3.png"); self:diffusealpha(0); self:x(CX+100*0.4); self:linear((TFB(FB-3)-TFB(FB-4))*0.22); self:diffusealpha(.7); self:x(CX+78*0.4); self:linear((TFB(FB-3)-TFB(FB-4))*0.56); self:x(CX+22*0.4); self:linear((TFB(FB-3)-TFB(FB-4))*0.22); self:diffusealpha(0); self:x(CX); end;
SongMessageCommand=function(self) self:Load(path.."BigCount/"..(((TFB(FB-3)-TFB(FB-4)) < 0.3) and "M" or "").."2.png"); self:diffusealpha(0); self:x(CX-100*0.4); self:linear((TFB(FB-2)-TFB(FB-3))*0.22); self:diffusealpha(.7); self:x(CX-78*0.4); self:linear((TFB(FB-2)-TFB(FB-3))*0.56); self:x(CX-22*0.4); self:linear((TFB(FB-2)-TFB(FB-3))*0.22); self:diffusealpha(0); self:x(CX); end;
NuengMessageCommand=function(self) self:Load(path.."BigCount/"..(((TFB(FB-3)-TFB(FB-4)) < 0.3) and "M" or "").."1.png"); self:diffusealpha(0); self:y(CY+100*0.4); self:linear((TFB(FB-1)-TFB(FB-2))*0.22); self:diffusealpha(.7); self:y(CY+78*0.4); self:linear((TFB(FB-1)-TFB(FB-2))*0.56); self:y(CY+22*0.4); self:linear((TFB(FB-1)-TFB(FB-2))*0.22); self:diffusealpha(0); self:y(CY); end;
GoooMessageCommand=function(self) self:decelerate((TFB(FB)-TFB(FB-1))/1.5); self:diffusealpha(0); end;
RIPRMessageCommand=function(self) self:visible(false); end;
};]]

Def.ActorFrame{
SFBMessageCommand=function(self) self:xy(PX,PY); self:diffuse(CL); end;
Def.Sprite{
OnCommand=function(self) self:x(-37); self:Load(path.."Cha3D/G.png"); self:zoomy(0); end;
GoooMessageCommand=function(self) self:decelerate((TFB(FB)-TFB(FB-1))/1.5); self:zoomy(1); end;
RIPRMessageCommand=function(self) self:decelerate((TFB(FB+1)-TFB(FB))/1.5); self:diffusealpha(0); end;
};
Def.Sprite{
OnCommand=function(self) self:x(37); self:Load(path.."Cha3D/O.png"); self:zoomy(0); end;
GoooMessageCommand=function(self) self:decelerate((TFB(FB)-TFB(FB-1))/1.5); self:zoomy(1); end;
RIPRMessageCommand=function(self) self:decelerate((TFB(FB+1)-TFB(FB))/1.5); self:diffusealpha(0); end;
};
Def.Sprite{
OnCommand=function(self) self:x(85); self:Load(path.."Cha3D/!.png"); self:zoomy(0); end;
GoooMessageCommand=function(self) self:decelerate((TFB(FB)-TFB(FB-1))/1.5); self:zoomy(1); end;
RIPRMessageCommand=function(self) self:decelerate((TFB(FB+1)-TFB(FB))/1.5); self:diffusealpha(0); end;
};
};





};
return Tune;