
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
		
MESSAGEMAN:Broadcast("SFB")
end;
};



LoadFont("Common Normal")..{
InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y*0.4;settext,"";rainbow);
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
	InitCommand=cmd(Center);
	SamMessageCommand=cmd(x,CX+100*0.4;
	decelerate,(TFB(FB-3)-TFB(FB-4));x,CX
	);
	SongMessageCommand=cmd(x,CX;
	decelerate,(TFB(FB-2)-TFB(FB-3));x,CX-5
	);
	RIPRMessageCommand=cmd(visible,false);
	Def.Sprite{
		InitCommand=cmd(blend,"BlendMode_Add";animate,false;zoom,0.9;diffusealpha,0);
		SFBMessageCommand=cmd(diffuse,CL;Load,path.."BigCount/"..(((TFB(FB-3)-TFB(FB-4)) < 0.3) and "M" or "").."3.png";diffusealpha,0;);
		SamMessageCommand=cmd(
		linear,(TFB(FB-3)-TFB(FB-4))*0.25;diffusealpha,.7;);
		SongMessageCommand=cmd(
		linear,(TFB(FB-2)-TFB(FB-3))*0.25;diffusealpha,.0;
		);
	};
};

Def.ActorFrame{
	InitCommand=cmd(Center);
	SongMessageCommand=cmd(x,CX-100*0.4;
	decelerate,(TFB(FB-2)-TFB(FB-3));x,CX
	);
	NuengMessageCommand=cmd(x,CX;
	decelerate,(TFB(FB-1)-TFB(FB-2));x,CX+5
	);
	RIPRMessageCommand=cmd(visible,false);
	Def.Sprite{
		InitCommand=cmd(blend,"BlendMode_Add";animate,false;zoom,0.9;diffusealpha,0);
		SFBMessageCommand=cmd(diffuse,CL;Load,path.."BigCount/"..(((TFB(FB-2)-TFB(FB-3)) < 0.3) and "M" or "").."2.png";diffusealpha,0;);
		SongMessageCommand=cmd(
		linear,(TFB(FB-2)-TFB(FB-3))*0.25;diffusealpha,.7;);
		NuengMessageCommand=cmd(
		linear,(TFB(FB-1)-TFB(FB-2))*0.25;diffusealpha,.0;
		);
	};
};

Def.ActorFrame{
	InitCommand=cmd(Center);
	NuengMessageCommand=cmd(y,CY+50*0.4;
	decelerate,(TFB(FB-1)-TFB(FB-2));y,CY
	);
	GoooMessageCommand=cmd(x,CX;
	decelerate,(TFB(FB)-TFB(FB-1));y,CY-5
	);
	RIPRMessageCommand=cmd(visible,false);
	Def.Sprite{
		InitCommand=cmd(blend,"BlendMode_Add";animate,false;zoom,0.9;diffusealpha,0);
		SFBMessageCommand=cmd(diffuse,CL;Load,path.."BigCount/"..(((TFB(FB-1)-TFB(FB-2)) < 0.3) and "M" or "").."1.png";diffusealpha,0;);
		NuengMessageCommand=cmd(
		linear,(TFB(FB-1)-TFB(FB-2))*0.25;diffusealpha,.7;);
		GoooMessageCommand=cmd(
		linear,(TFB(FB)-TFB(FB-1))*0.25;diffusealpha,.0;
		);
	};
};

--[[Def.Sprite{
SFBMessageCommand=cmd(blend,"BlendMode_Add";Center;animate,false;diffuse,CL;zoom,0.9;diffusealpha,0);
SamMessageCommand=cmd(Load,path.."BigCount/"..(((TFB(FB-3)-TFB(FB-4)) < 0.3) and "M" or "").."3.png";diffusealpha,0;
	x,CX+100*0.4;linear,(TFB(FB-3)-TFB(FB-4))*0.22;diffusealpha,.7;
	x,CX+78*0.4;linear,(TFB(FB-3)-TFB(FB-4))*0.56;
	x,CX+22*0.4;linear,(TFB(FB-3)-TFB(FB-4))*0.22;diffusealpha,0;x,CX;);
SongMessageCommand=cmd(Load,path.."BigCount/"..(((TFB(FB-3)-TFB(FB-4)) < 0.3) and "M" or "").."2.png";diffusealpha,0;
	x,CX-100*0.4;linear,(TFB(FB-2)-TFB(FB-3))*0.22;diffusealpha,.7;
	x,CX-78*0.4;linear,(TFB(FB-2)-TFB(FB-3))*0.56;
	x,CX-22*0.4;linear,(TFB(FB-2)-TFB(FB-3))*0.22;diffusealpha,0;x,CX;);
NuengMessageCommand=cmd(Load,path.."BigCount/"..(((TFB(FB-3)-TFB(FB-4)) < 0.3) and "M" or "").."1.png";diffusealpha,0;
	y,CY+100*0.4;linear,(TFB(FB-1)-TFB(FB-2))*0.22;diffusealpha,.7;
	y,CY+78*0.4;linear,(TFB(FB-1)-TFB(FB-2))*0.56;
	y,CY+22*0.4;linear,(TFB(FB-1)-TFB(FB-2))*0.22;diffusealpha,0;y,CY;);
GoooMessageCommand=cmd(decelerate,(TFB(FB)-TFB(FB-1))/1.5;diffusealpha,0);
RIPRMessageCommand=cmd(visible,false);
};]]

Def.ActorFrame{
SFBMessageCommand=cmd(xy,PX,PY;diffuse,CL;);
Def.Sprite{
OnCommand=cmd(x,-37;Load,path.."Cha3D/G.png";zoomy,0);
GoooMessageCommand=cmd(decelerate,(TFB(FB)-TFB(FB-1))/1.5;zoomy,1);
RIPRMessageCommand=cmd(decelerate,(TFB(FB+1)-TFB(FB))/1.5;diffusealpha,0);
};
Def.Sprite{
OnCommand=cmd(x,37;Load,path.."Cha3D/O.png";zoomy,0);
GoooMessageCommand=cmd(decelerate,(TFB(FB)-TFB(FB-1))/1.5;zoomy,1);
RIPRMessageCommand=cmd(decelerate,(TFB(FB+1)-TFB(FB))/1.5;diffusealpha,0);
};
Def.Sprite{
OnCommand=cmd(x,85;Load,path.."Cha3D/!.png";zoomy,0);
GoooMessageCommand=cmd(decelerate,(TFB(FB)-TFB(FB-1))/1.5;zoomy,1);
RIPRMessageCommand=cmd(decelerate,(TFB(FB+1)-TFB(FB))/1.5;diffusealpha,0);
};
};





};
return Tune;