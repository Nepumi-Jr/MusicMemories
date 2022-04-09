local symbol = {'C','L','E','A','R','E','D'};
local CCl = {Color.Black,
Color.Black,
Color.Black,
Color.Black,
Color.Black,
Color.Black,
Color.Black};
LoadActor("../_save/Battle.lua")
local playit = false;
if GAMESTATE:GetPlayMode() == "PlayMode_Nonstop" or GAMESTATE:GetPlayMode() == "PlayMode_Oni" or GAMESTATE:GetPlayMode() == "PlayMode_Endless" then
else
end


if TP.Battle.IsBattle then
local SOC;
local SOT1;
local SOT2;
local Re;
local Y = {0,0};
local Tim;
end


local Timu = 0;
local Yao = 2;
local SoundK = "Mario.mp3";
local Sped = 60;


local RY = false;
local AY = false;
local FCA = {false,false,false,false,false,false,false,false,false}


local out = Def.ActorFrame{
OnCommand=function(self) self:draworder(5000); self:z(-20); end;
StartTransitioningCommand=function(self)

	local SA = false;
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if LoadModule("Eva.CustomStageAward.lua")(pn) ~= "Nope" then
			SA = true;
			break
		end
	end

	if not SA then
		MESSAGEMAN:Broadcast("GETOUTOFGAMESM");
	end
if TP.Battle.IsBattle then
Tim = 0;
if GAMESTATE:IsCourseMode() then
SOC = GAMESTATE:GetCurrentCourse();
SOT1 = GAMESTATE:GetCurrentTrail(PLAYER_1)
SOT2 = GAMESTATE:GetCurrentTrail(PLAYER_2)
if GAMESTATE:GetCourseSongIndex() > 1 then
for i = 1,GAMESTATE:GetCourseSongIndex()-1 do
Tim = Tim + GAMESTATE:GetCurrentCourse():GetCourseEntry(i-1):GetSong():GetLastSecond()
end
end
Tim = Tim + GAMESTATE:GetCurMusicSeconds();
Y = {GAMESTATE:GetCourseSongIndex(),Tim}
else
Y = {1,GAMESTATE:GetCurMusicSeconds()};
SOC = GAMESTATE:GetCurrentSong();
SOT1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
SOT2 = GAMESTATE:GetCurrentSteps(PLAYER_2)
end

if TP.Battle.Mode == "Dr" then
if SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_1):IsFailing() then
Re = 2;
elseif SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_2):IsFailing() then
Re = 1;
else
if TP.Battle.IsfailorIsDraw then
Re = 0;
Y = {0,0}
else
if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()*100 > STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()*100 then
Re = 1;
elseif STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()*100 < STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()*100 then
Re = 2;
elseif STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()*100 ==  STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()*100 then
Re = 0;
end
Y={STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints(),STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()}

end
end
elseif TP.Battle.Mode == "Ac" then
if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()*100 > STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()*100 then
Re = 1;
elseif STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()*100 < STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()*100 then
Re = 2;
elseif STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()*100 == STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()*100 then
Re = 0;
end
Y={STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints(),STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()}
end

TP.Battle.Info[#TP.Battle.Info+1] = {SOC,SOT1,SOT2,Re,Y};
end
--End of Battle



local FULLLL = false;
if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W4') == 0 and
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W5') == 0 and
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_Miss') == 0 and
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetHoldNoteScores('HoldNoteScore_LetGo') == 0 and
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints() > 0 then
FULLLL = true;
end
elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores('TapNoteScore_W4') == 0 and
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores('TapNoteScore_W5') == 0 and
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores('TapNoteScore_Miss') == 0 and
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetHoldNoteScores('HoldNoteScore_LetGo') == 0 and
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints() > 0 then
FULLLL = true;
end
end

--End of FC


local meterr = 0;
if GAMESTATE:IsCourseMode() then
meterr = 999;
else
	if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	meterr = GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter()/2 + GAMESTATE:GetCurrentSteps(PLAYER_2):GetMeter()/2;
	elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	meterr = GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter();
	elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	meterr = GAMESTATE:GetCurrentSteps(PLAYER_2):GetMeter();
	end
end






local path = THEMEDIR().."/BGAnimations/ScreenGameplay out/"




--[[if true then
Yao = 1.140
SoundK = "mus_rimshot.ogg";
symbol = {'D','R','A','W','point','point','point'};
elseif true then
Yao = 2.472
SoundK = "Knock.mp3";
elseif true then
Yao = 1.386
SoundK = "FullwithSudden.mp3";
symbol = {'A','W','E','S','O','M','E'};
elseif true then
Yao = 4.627
SoundK = "Fulll.mp3";
symbol = {'A','W','E','S','O','M','E'};
end]]



if TP.Battle.IsBattle then
	if TP.Battle.Mode == "Dr" then
		if SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_1):IsFailing() or SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_2):IsFailing() then
		if not TP.Battle.Hidden then
			Yao = 4
			SoundK = "Fall.mp3";
			playit = true;
		else
			Yao = 2.472
			SoundK = "Knock.mp3";
			playit = true;
		end
		playit = true
		elseif TP.Battle.IsfailorIsDraw then
			symbol = {'D','R','A','W','point','point','point'};
		else
			symbol = {'R','E','S','U','I','T','S'};
		end
	else
			symbol = {'R','E','S','U','I','T','S'};
	end
else
	if GAMESTATE:GetPlayMode() == "PlayMode_Rave" or GAMESTATE:GetPlayMode() == "PlayMode_Battle" then
		symbol = {'R','E','S','U','I','T','S'};
	elseif FULLLL then
		symbol = {'A','W','E','S','O','M','E'};
		CCl = {Color.Red,
				Color.Orange,
				Color.Yellow,
				Color.Green,
				Color.SkyBlue,
				Color.Blue,
				Color.Purple};
	else
		if GAMESTATE:IsCourseMode() then
		symbol = {'F','I','N','I','S','H','point'};
		end
	end
end
MESSAGEMAN:Broadcast("Finmake") 


if playit then
SOUND:PlayOnce(path..SoundK);
end
--End of BATTLE





self:playcommand("Nepu")

end;

NepuCommand=function(self)



if SoundK == "Fall.mp3" then
if not RY then MESSAGEMAN:Broadcast("FallBat") RY = true; end

elseif SoundK == "cleared.mp3" then

if Timu >= 2.278-0.5 then
if not RY then MESSAGEMAN:Broadcast("FALLLR") RY = true; end
elseif Timu >= 0.527 then
if not AY then MESSAGEMAN:Broadcast("Hent") AY = true; end
end


elseif SoundK == "Knock.mp3" then
if not AY then MESSAGEMAN:Broadcast("KOG") AY = true; end



elseif SoundK == "Fulll.mp3" then
if Timu >= 2.934-0.5 then--FALL
if not FCA[1] then MESSAGEMAN:Broadcast("FALLLR") FCA[1] = true; end
elseif Timu >= 2.204 then--E
if not FCA[3] then MESSAGEMAN:Broadcast("FCAET") FCA[3] = true; end
elseif Timu >= 1.634 then--M
if not FCA[4] then MESSAGEMAN:Broadcast("FCAM") FCA[4] = true; end
elseif Timu >= 1.074 then--O
if not FCA[5] then MESSAGEMAN:Broadcast("FCAO") FCA[5] = true; end
elseif Timu >= 0.704 then--S
if not FCA[6] then MESSAGEMAN:Broadcast("FCAS") FCA[6] = true; end
elseif Timu >= 0.474 then--E
if not FCA[7] then MESSAGEMAN:Broadcast("FCAE") FCA[7] = true; end
elseif Timu >= 0.334 then--W
if not FCA[8] then MESSAGEMAN:Broadcast("FCAW") FCA[8] = true; end
elseif Timu >= 0.194 then--A
if not FCA[9] then MESSAGEMAN:Broadcast("FCAA") FCA[9] = true; end
end


elseif SoundK == "Mario.mp3" then
--NORMAL CLEAR

--[[if Timu >= 4 then
if not RY then MESSAGEMAN:Broadcast("FALLLR") RY = true; end
elseif Timu >= 2.5 then
if not AY then MESSAGEMAN:Broadcast("Hent") AY = true; end
end]]

local SA = false;
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	if LoadModule("Eva.CustomStageAward.lua")(pn) ~= "Nope" then
		SA = true;
		break
	end
end
	if not SA then
		if not RY then MESSAGEMAN:Broadcast("FastISLA") RY = true; end
	end



end







Timu = Timu + (1/30)
if Timu <= Yao then
self:sleep(1/30):queuecommand("Nepu")
end
end;
};


if TP.Battle.IsBattle and TP.Battle.Mode == "Dr" and not TP.Battle.Hidden then
	out[#out+1] = Def.Quad{
	FallBatMessageCommand=function(self) self:zoom(999999); self:diffuse(color("#00000000")); self:sleep(3); self:linear(1); self:diffuse(color("#000000FF")); end;
	};
end

local WID,WIDS = PLAYER_1,"PlayerP1";

out[#out+1] = Def.ActorFrame{

	Def.Quad{
		OnCommand=function(self) self:zoom(99999); self:diffuse({0,0,0,0}); end;
		FastISLAMessageCommand=function(self) self:decelerate(2); self:diffusealpha(1); end;
	};
	Def.Quad{
		OnCommand=function(self) self:FullScreen(); self:diffuse({0.7,0.7,0.7,0.5}); self:croptop(1); end;
		FcStageMessageCommand=function(self) self:sleep(3); self:decelerate(0.2); self:croptop(0); end;
	};
	Def.Quad{
		OnCommand=function(self) self:FullScreen(); self:diffuse({0.7,0.7,0.7,1}); self:croptop(1); end;
		FcStageMessageCommand=function(self) self:sleep(3+0.2); self:decelerate(0.2); self:croptop(0); end;
	};


	Def.Sprite{
		InitCommand=function(self)	self:x(SCREEN_CENTER_X + Sped*(1-4)):CenterY() :zoom(0) :diffuse(CCl[1]) end;
		FinmakeMessageCommand=function(self) self:Load(THEMEDIR().."/BGAnimations/ScreenGameplay out/"..symbol[1]..".png"); self:zoom(0); end;
		HentMessageCommand=function(self) self:bounceend(0.75); self:zoom(1); end;
		FCAAMessageCommand=function(self) self:vibrate(); self:zoom(20); self:linear(0.1); self:zoom(1); end;
		FCBAWMessageCommand=function(self) self:linear(0.1); self:zoom(1); end;
		YutMessageCommand=function(self) self:zoom(1.2); self:stopeffect(); end;
		FALLLRMessageCommand=function(self) self:finishtweening(); self:sleep(0.5); self:linear(1); self:diffusealpha(0); end;
	};
	Def.Sprite{
		InitCommand=function(self)	self:x(SCREEN_CENTER_X + Sped*(2-4)):CenterY() :zoom(0) :diffuse(CCl[2]) end;
		FinmakeMessageCommand=function(self) self:Load(THEMEDIR().."/BGAnimations/ScreenGameplay out/"..symbol[2]..".png"); self:zoom(0); end;
		FCAWMessageCommand=function(self) self:vibrate(); self:zoom(20); self:linear(0.1); self:zoom(1); end;
		FCBAWMessageCommand=function(self) self:linear(0.1); self:zoom(1); end;
		YutMessageCommand=function(self) self:zoom(1.2); self:stopeffect(); end;
		HentMessageCommand=function(self) self:bounceend(0.75); self:zoom(1); end;
		FALLLRMessageCommand=function(self) self:finishtweening(); self:sleep(0.5); self:linear(1); self:diffusealpha(0); end;
	};
	Def.Sprite{
		InitCommand=function(self)	self:x(SCREEN_CENTER_X + Sped*(3-4)):CenterY() :zoom(0) :diffuse(CCl[3]) end;
		FinmakeMessageCommand=function(self) self:Load(THEMEDIR().."/BGAnimations/ScreenGameplay out/"..symbol[3]..".png"); self:zoom(0); end;
		FCAEMessageCommand=function(self) self:vibrate(); self:zoom(20); self:linear(0.1); self:zoom(1); end;
		FCBEMessageCommand=function(self) self:linear(0.1); self:zoom(1); end;
		YutMessageCommand=function(self) self:zoom(1.2); self:stopeffect(); end;
		HentMessageCommand=function(self) self:bounceend(0.75); self:zoom(1); end;
		FALLLRMessageCommand=function(self) self:finishtweening(); self:sleep(0.5); self:linear(1); self:diffusealpha(0); end;
	};
	Def.Sprite{
		InitCommand=function(self)	self:x(SCREEN_CENTER_X + Sped*(4-4)):CenterY() :zoom(0) :diffuse(CCl[4]) end;
		FinmakeMessageCommand=function(self) self:Load(THEMEDIR().."/BGAnimations/ScreenGameplay out/"..symbol[4]..".png"); self:zoom(0); end;
		FCASMessageCommand=function(self) self:vibrate(); self:zoom(20); self:linear(0.1); self:zoom(1); end;
		FCBSMessageCommand=function(self) self:linear(0.1); self:zoom(1); end;
		YutMessageCommand=function(self) self:zoom(1.2); self:stopeffect(); end;
		HentMessageCommand=function(self) self:bounceend(0.75); self:zoom(1); end;
		FALLLRMessageCommand=function(self) self:finishtweening(); self:sleep(0.5); self:linear(1); self:diffusealpha(0); end;
	};
	Def.Sprite{
		InitCommand=function(self)	self:x(SCREEN_CENTER_X + Sped*(5-4)):CenterY() :zoom(0) :diffuse(CCl[5]) end;
		FinmakeMessageCommand=function(self) self:Load(THEMEDIR().."/BGAnimations/ScreenGameplay out/"..symbol[5]..".png"); self:zoom(0); end;
		FCAOMessageCommand=function(self) self:vibrate(); self:zoom(20); self:linear(0.1); self:zoom(1); end;
		FCBOMessageCommand=function(self) self:linear(0.1); self:zoom(1); end;
		YutMessageCommand=function(self) self:zoom(1.2); self:stopeffect(); end;
		HentMessageCommand=function(self) self:bounceend(0.75); self:zoom(1); end;
		FALLLRMessageCommand=function(self) self:finishtweening(); self:sleep(0.5); self:linear(1); self:diffusealpha(0); end;
	};
	Def.Sprite{
		InitCommand=function(self)	self:x(SCREEN_CENTER_X + Sped*(6-4)):CenterY() :zoom(0) :diffuse(CCl[6]) end;
		FinmakeMessageCommand=function(self) self:Load(THEMEDIR().."/BGAnimations/ScreenGameplay out/"..symbol[6]..".png"); self:zoom(0); end;
		FCAMMessageCommand=function(self) self:vibrate(); self:zoom(20); self:linear(0.1); self:zoom(1); end;
		FCBMEMessageCommand=function(self) self:linear(0.1); self:zoom(1); end;
		YutMessageCommand=function(self) self:zoom(1.2); self:stopeffect(); end;
		HentMessageCommand=function(self) self:bounceend(0.75); self:zoom(1); end;
		FALLLRMessageCommand=function(self) self:finishtweening(); self:sleep(0.5); self:linear(1); self:diffusealpha(0); end;
	};
	Def.Sprite{
		InitCommand=function(self)	self:x(SCREEN_CENTER_X + Sped*(7-4)):CenterY() :zoom(0) :diffuse(CCl[7]) end;
		FCAETMessageCommand=function(self) self:vibrate(); self:zoom(20); self:linear(0.1); self:zoom(1); end;
		FCBMEMessageCommand=function(self) self:linear(0.1); self:zoom(1); end;
		FinmakeMessageCommand=function(self) self:Load(THEMEDIR().."/BGAnimations/ScreenGameplay out/"..symbol[7]..".png"); self:zoom(0); end;
		YutMessageCommand=function(self) self:zoom(1.2); self:stopeffect(); end;
		HentMessageCommand=function(self) self:bounceend(0.75); self:zoom(1); end;
		FALLLRMessageCommand=function(self) self:finishtweening(); self:sleep(0.5); self:linear(1); self:diffusealpha(0); end;
	};

	
	
LoadActor("KnockOut.png")..{
InitCommand=function(self) self:Center(); self:FullScreen(); self:cropright(1); end;
KOGMessageCommand=function(self) self:sleep(0.25); self:linear(0.5); self:cropright(0); end
};
	Def.Quad{
		OnCommand=function(self) self:FullScreen(); self:diffuse(color("#00000000")); end;
		FALLLRMessageCommand=function(self) self:sleep(0.5); self:linear(2); self:diffusealpha(1); end;
	};


Def.ActorFrame{
	InitCommand=function(self)
	self:visible(false)
	end;
	FallBatMessageCommand=function(self)
if TP.Battle.IsBattle and TP.Battle.Mode == "Dr" and not TP.Battle.Hidden then
	if SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_1):IsFailing() or SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_1):GetLife() == 0 then
		WID,WIDS = PLAYER_1,"PlayerP1";
	elseif SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_2):IsFailing() or SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_2):GetLife() == 0 then
		WID,WIDS = PLAYER_2,"PlayerP2";
	end
end
	local Me = scale(math.random(0,1),0,1,-1,1);
	GAMESTATE:GetPlayerState(WID):GetPlayerOptions('ModsLevel_Song'):Dark(1,1.2);
	GAMESTATE:GetPlayerState(WID):GetPlayerOptions('ModsLevel_Song'):Tipsy(2,1.2);
	GAMESTATE:GetPlayerState(WID):GetPlayerOptions('ModsLevel_Song'):Drunk(2,1.2);
	GAMESTATE:GetPlayerState(WID):GetPlayerOptions('ModsLevel_Song'):Stealth(2,1.2);
	GAMESTATE:GetPlayerState(WID):GetPlayerOptions('ModsLevel_Song'):Tornado(1,1.2);
	GAMESTATE:GetPlayerState(WID):GetPlayerOptions('ModsLevel_Song'):Mini(0.05,1.2);
	GAMESTATE:GetPlayerState(WID):GetPlayerOptions('ModsLevel_Song'):Flip(-0.5,1.2);
	SCREENMAN:GetTopScreen():GetChild(WIDS):accelerate(0.7):rotationz(math.random(30)*Me):y(SCREEN_BOTTOM*1.5):addx(30*Me);
	self:x(SCREENMAN:GetTopScreen():GetChild(WIDS):GetX()):y(SCREENMAN:GetTopScreen():GetChild(WIDS):GetY()-50):visible(true):sleep(0.7):queuecommand("Ma")
	end;
	MaCommand=function(self) self:bob(); self:effectmagnitude(0,5,0); end;
	LoadFont("Common Normal")..{
	Text = "O";
	InitCommand = function(self) self:x(-50); self:y(-25); self:zoom(3); self:diffusebottomedge(Color.Red or color("#FF0000")); end;
	OnCommand = function(self) self:y(-SCREEN_CENTER_Y+50-50); self:rotationz(math.random(-10,10)); self:sleep(math.random(1,5)/10); self:bouncebegin(0.7); self:y(-25); self:rotationz(0); end;
	};
	LoadFont("Common Normal")..{
	Text = "h";
	InitCommand = function(self) self:x(0); self:y(-25); self:zoom(3); self:diffusebottomedge(Color.Red or color("#FF0000")); end;
	OnCommand = function(self) self:y(-SCREEN_CENTER_Y+50-50); self:rotationz(math.random(-10,10)); self:sleep(math.random(1,5)/10); self:bouncebegin(0.7); self:y(-25); self:rotationz(0); end;
	};
	LoadFont("Common Normal")..{
	Text = "N";
	InitCommand = function(self) self:x(0-20); self:y(25); self:zoom(3); self:diffusebottomedge(Color.Red or color("#FF0000")); end;
	OnCommand = function(self) self:y(-SCREEN_CENTER_Y+50-50); self:rotationz(math.random(-10,10)); self:sleep(math.random(1,5)/10); self:bouncebegin(0.7); self:y(25); self:rotationz(0); end;
	};
	LoadFont("Common Normal")..{
	Text = "o";
	InitCommand = function(self) self:x(50-30); self:y(25); self:zoom(3); self:diffusebottomedge(Color.Red or color("#FF0000")); end;
	OnCommand = function(self) self:y(-SCREEN_CENTER_Y+50-50); self:rotationz(math.random(-10,10)); self:sleep(math.random(1,5)/10); self:bouncebegin(0.7); self:y(25); self:rotationz(0); end;
	};
	LoadFont("Common Normal")..{
	Text = "!";
	InitCommand = function(self) self:x(80-30); self:y(25); self:zoom(3); self:diffusebottomedge(Color.Red or color("#FF0000")); end;
	OnCommand = function(self) self:y(-SCREEN_CENTER_Y+50-50); self:rotationz(math.random(-10,10)); self:sleep(math.random(1,5)/10); self:bouncebegin(0.7); self:y(25); self:rotationz(0); end;
	};
};
LoadActor("MAY")..{
FallBatMessageCommand=function(self) self:play(); end;
};
	Def.Quad{
		FinmakeMessageCommand=function(self)
			self:visible(false):zoom(250);
			SCREENMAN:GetTopScreen():stoptweening();
			SCREENMAN:GetTopScreen():decelerate(1);
			SCREENMAN:GetTopScreen():visible(true);
			SCREENMAN:GetTopScreen():x(0);
			SCREENMAN:GetTopScreen():y(0);
			SCREENMAN:GetTopScreen():z(0);
			SCREENMAN:GetTopScreen():zoom(1);
			SCREENMAN:GetTopScreen():zoomx(1);
			SCREENMAN:GetTopScreen():zoomy(1);
			SCREENMAN:GetTopScreen():zoomz(1);
			SCREENMAN:GetTopScreen():rotationx(0);
			SCREENMAN:GetTopScreen():rotationy(0);
			SCREENMAN:GetTopScreen():rotationz(0);
			SCREENMAN:GetTopScreen():zoomtoheight(1);
			SCREENMAN:GetTopScreen():zoomtowidth(1);
			SCREENMAN:GetTopScreen():stopeffect()
			

			self:sleep(0.25)
		end;
	};
};


return out;