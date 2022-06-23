local function Diff2Cli(d,i)
CD = GameColor.Difficulty[d];
return CD[i]
end;

local CL;

local Meter;

local function BtS(x)
	return GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(x) or 0;
end



local path = THEME:GetCurrentThemeDirectory().."Graphics/_GraphFont/Cha3D/";

local NS = GAMESTATE:GetCurrentStageIndex()+1;

local RDText = "?????";
	if TP.Battle.IsBattle then
		RDText = FormatNumberAndSuffix(NS).." Round";
	elseif GAMESTATE:IsCourseMode() then
		RDText = "Ready?"
	elseif ToEnumShortString(GAMESTATE:GetCurrentStage()) == "Event" then
		--RDText = string.format(THEME:GetString("NewContent","nStage") or "%s MEMORIES",FormatNumberAndSuffix(NS))
		RDText = string.format("%s Memories",FormatNumberAndSuffix(NS))
	else
						local playMode = GAMESTATE:GetPlayMode()
						local sStage = ""
						sStage = GAMESTATE:GetCurrentStage()
						if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
						  sStage = playMode;
						end
		RDText = ToEnumShortString(sStage).." Stage";
	end


local PPeng;
if GAMESTATE:IsCourseMode() then
PPeng = GAMESTATE:GetCurrentCourse():GetCourseEntry(0):GetSong();
else
PPeng = GAMESTATE:GetCurrentSong();
end

if PPeng == nil then return Def.ActorFrame{}; end


local APoDC = false;
local RIPY = false;
local WY = false;



local wai = -80;
local d = 0.7;
local FB = round(round(PPeng:GetFirstBeat())/4)*4
if FB >= 8 then
wai = 0;
d = 0
end


local function tellme(s,i)
	local x = string.sub( s, i, i );
	if x == " " then return "Space"; end
	if x == "?" then return "Qua"; end
	return string.upper( x )
end;


local lenA,lenB;--Use like zom
local zom = .7;--Use for change scale in other font


local lim;--Use for make sure if that song so fast than command;(Use as Second)

local Tune = Def.ActorFrame{

--
Def.Quad{
OnCommand=function(self) self:sleep(0.1); self:queuecommand("GM"); end;--Use For Delay
--IDK Why SM use > 0 beat and then turn back to real beat :(
GMCommand=function(self)

	if GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter() then
		Meter = GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter();
	end
	if GAMESTATE:GetCurrentSteps(PLAYER_2):GetMeter() then
		if Meter then
			Meter  = Meter/2 + (GAMESTATE:GetCurrentSteps(PLAYER_2):GetMeter())/2
			else
			Meter = GAMESTATE:GetCurrentSteps(PLAYER_2):GetMeter();
		end
	end


		if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		CL = Meter2Color(GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter()/2+GAMESTATE:GetCurrentSteps(PLAYER_2):GetMeter()/2)
		elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
		CL = Meter2Color(GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter())
		elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		CL = Meter2Color(GAMESTATE:GetCurrentSteps(PLAYER_2):GetMeter())
		end
	lim = GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB)-GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB-4);


MESSAGEMAN:Broadcast("SFB")
end;
};

LoadFont("Common Normal")..{
InitCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y*0.65); self:rainbow(); end;
SFBMessageCommand=function(self)
self:playcommand("Nep")
end;
NepCommand=function(self)
if FB >= 8 then
	if GAMESTATE:GetSongBeat() >= FB-4 then
	if not RIPY then
	MESSAGEMAN:Broadcast("RIP")
	RIPY = true
	end
	elseif GAMESTATE:GetSongBeat() >= FB-8 and GAMESTATE:GetSongBeat() < FB-4 then
	if not APoDC then
	lenA = BtS(FB-5)-BtS(FB-8);
	lenB = BtS(FB-4)-BtS(FB-5);
	MESSAGEMAN:Broadcast("App")
	APoDC = true
	end
	else
	if not WY then
	MESSAGEMAN:Broadcast("Waitman")
	WY = true
	end
	end
else
	if GAMESTATE:GetSongBeat() >= FB then
	if not RIPY then
	MESSAGEMAN:Broadcast("RIP")
	RIPY = true
	end
	else
	if not APoDC then
	MESSAGEMAN:Broadcast("Dance")
	APoDC = true
	end
	end


end
if GAMESTATE:GetSongBeat() < FB+10 then
self:sleep(1/30):queuecommand("Nep")
end
end;
};

Def.ActorFrame{
OnCommand=function(self) self:y(wai); end;
Def.Quad{
OnCommand=function(self) self:visible(true); end;
DanceMessageCommand=function()
if IsNetConnected() and ((SCREENMAN:GetTopScreen():GetChild('PlayerP1') and SCREENMAN:GetTopScreen():GetChild('PlayerP1'):GetX() == SCREEN_CENTER_X)
			or (SCREENMAN:GetTopScreen():GetChild('PlayerP2') and SCREENMAN:GetTopScreen():GetChild('PlayerP2'):GetX() == SCREEN_CENTER_X)) then
	if SCREENMAN:GetTopScreen():GetChild('PlayerP1') then
		SCREENMAN:GetTopScreen():GetChild('PlayerP1'):decelerate(0.5)
		SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(-80)
	elseif SCREENMAN:GetTopScreen():GetChild('PlayerP2') then
		SCREENMAN:GetTopScreen():GetChild('PlayerP2'):decelerate(0.5)
		SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(-80)
	end
end
end;
AppMessageCommand=function()
if IsNetConnected() and ((SCREENMAN:GetTopScreen():GetChild('PlayerP1') and SCREENMAN:GetTopScreen():GetChild('PlayerP1'):GetX() == SCREEN_CENTER_X)
			or (SCREENMAN:GetTopScreen():GetChild('PlayerP2') and SCREENMAN:GetTopScreen():GetChild('PlayerP2'):GetX() == SCREEN_CENTER_X)) then
	if SCREENMAN:GetTopScreen():GetChild('PlayerP1') then
		SCREENMAN:GetTopScreen():GetChild('PlayerP1'):decelerate(0.5)
		SCREENMAN:GetTopScreen():GetChild('PlayerP1'):addx(-80)
	elseif SCREENMAN:GetTopScreen():GetChild('PlayerP2') then
		SCREENMAN:GetTopScreen():GetChild('PlayerP2'):decelerate(0.5)
		SCREENMAN:GetTopScreen():GetChild('PlayerP2'):addx(-80)
	end
end
end;
};
};
};
for i = 1,string.len( RDText ) do
	Tune[#Tune+1]=Def.ActorFrame{
		SFBMessageCommand=function(self) self:x(SCREEN_CENTER_X+(i-((string.len( RDText )+1)/2))*40); self:CenterY(); self:zoom(0.8); self:diffuse(Meter2Color(
				Meter
				)); end;
		AppMessageCommand=function(self) self:ease(lenA+lenB+0.1,80); self:x(SCREEN_CENTER_X+(i-((string.len( RDText )+1)/2))*55); self:zoom(0.7); end;
		DanceMessageCommand=function(self) self:x(SCREEN_CENTER_X+(i-((string.len( RDText )+1)/2))*60); self:zoom(0.65); end;
		Def.Sprite{
			InitCommand=function(self) self:zoom(0.75); self:Load(path..tellme(RDText, i)..".png"); self:diffusealpha(0); end;
			OnCommand=function(self) self:diffuseshift(); self:effectcolor1({1,1,1,1}); self:effectcolor2({.75,.75,.75,1}); self:effectoffset(math.random(0,10)/10); end;
			AppMessageCommand=function(self) self:linear(math.min(0.7,lenA)); self:diffusealpha(1); self:sleep(math.max(lenA-0.7,0.001)); self:decelerate(lenB); self:zoomx(0); end;
			DanceMessageCommand=function(self) self:diffusealpha(1); self:y(-115); end;
			RIPMessageCommand=function(self) self:decelerate(0.5); self:diffusealpha(0); end;
		};
	};
end





return Tune;