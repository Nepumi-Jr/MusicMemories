local Karkao = {0,0,0,0}
local Pc = 1;
--[[
1 = Not stop
2 = Pause
2.5 = Pause with Relese
3 = Resuming
]]
--Thatmean{U,D,Enter,Back}
local function SelectMusicOrCourse()
	if IsNetSMOnline() then
		return "ScreenNetSelectMusic"
	elseif GAMESTATE:IsCourseMode() then
		return "ScreenSelectCourse"
	else
		return "ScreenSelectMusic"
	end
end

local function NameString(str)
	return '-'..THEME:GetString('PauseMenu',str)..'-'
end

local Inputne = function( event )

	if not event then return end

	if event.type == "InputEventType_FirstPress" then
		
		if ((event.button == "MenuLeft") or (event.button == "Left")) and (event.PlayerNumber == PLAYER_1 or event.PlayerNumber == PLAYER_2) then
			Karkao[1] = 1
		end
		if ((event.button == "MenuRight") or (event.button == "Right")) and (event.PlayerNumber == PLAYER_1 or event.PlayerNumber == PLAYER_2) then
			Karkao[2] = 1
		end
		if (event.button == "Start" or
			event.button == "Center") and (event.PlayerNumber == PLAYER_1 or event.PlayerNumber == PLAYER_2) then
			Karkao[3] = 1
		end
		if GAMESTATE:GetCurrentGame():GetName() == "pump" then
		if (event.button == "Back" ) and (event.PlayerNumber == PLAYER_1 or event.PlayerNumber == PLAYER_2) then
			Karkao[4] = 1
		end
		if (event.button == "UpLeft" or
			event.button == "UpRight")	and (event.PlayerNumber == PLAYER_1 or event.PlayerNumber == PLAYER_2)
and Pc ~= 1	then
		Karkao[4] = 1
		end
		else
		if (event.button == "Back") and (event.PlayerNumber == PLAYER_1 or event.PlayerNumber == PLAYER_2) then
			Karkao[4] = 1
		end
		end
		
	end
	
	if event.type == "InputEventType_Release" then
		
		if ((event.button == "MenuLeft") or (event.button == "Left")) and (event.PlayerNumber == PLAYER_1 or event.PlayerNumber == PLAYER_2) then
			Karkao[1] = 0
		end
		if ((event.button == "MenuRight") or (event.button == "Right")) and (event.PlayerNumber == PLAYER_1 or event.PlayerNumber == PLAYER_2) then
			Karkao[2] = 0
		end
		if (event.button == "Start" or
			event.button == "Center") and (event.PlayerNumber == PLAYER_1 or event.PlayerNumber == PLAYER_2) then
			Karkao[3] = 0
		end
		if (event.button == "Back" or
			event.button == "UpLeft" or
			event.button == "UpRight") and (event.PlayerNumber == PLAYER_1 or event.PlayerNumber == PLAYER_2) then
			Karkao[4] = 0
		end
		
	end

end
local infoG ={};
local Wait3 = {0,0,0};
--That for Somehing What wait with animation
local C = 1;
--[[
1 = Resume
2 = Retry
3 = Back
]]
local BP = 8;--BP = x; If you Resume,We will Backup for x beat
--Ps. We will Determined How many BP for that song 
local T = 0;--That will work with BP
local LRe = {true,true};
local t = Def.ActorFrame{};
local Musi = false;
local NetNo = false;
local BatNo = false;
local FailNo = false;
local FailTig = false;
local ScaleBack = {8,6};
--How many Row and collum to use Fade back
local Ok = true;
t[#t+1] = Def.ActorFrame{
OnCommand=function(self)
SCREENMAN:GetTopScreen():AddInputCallback(Inputne)
self:Center()
end;
Def.Quad{--control panel
OnCommand=function(self) self:zoom(0); self:playcommand("Nep"); end;
CurrentSongChangedMessageCommand=function(self) self:playcommand("Nep"); end;
NepCommand=function(self)
if TP.Battle.IsBattle and Karkao[4] == 1 and not NetNo then
BatNo = true;
MESSAGEMAN:Broadcast("OopsBat")
elseif TP.Battle.IsBattle and Karkao[4] == 0 and NetNo then
BatNo = false;
elseif IsNetConnected() and Karkao[4] == 1 and not NetNo then
NetNo = true;
MESSAGEMAN:Broadcast("OopsNet")
elseif IsNetConnected() and Karkao[4] == 0 and NetNo then
NetNo = false;
elseif FailTig and Karkao[4] == 1 and not FailNo then
FailNo = true;
elseif FailTig and Karkao[4] == 0 and FailNo then
FailNo = false;
elseif not IsNetConnected() and not FailTig then
if Karkao[4] == 1 and Pc == 1 then
infoG = {
SCREENMAN:GetTopScreen():GetChild('Overlay'):GetVisible(),
SCREENMAN:GetTopScreen():GetChild('Overlay'):GetX(),
SCREENMAN:GetTopScreen():GetChild('Overlay'):GetY(),
SCREENMAN:GetTopScreen():GetChild('Overlay'):GetZ(),
SCREENMAN:GetTopScreen():GetChild('Overlay'):GetZoom(),
SCREENMAN:GetTopScreen():GetChild('Overlay'):GetZoomX(),
SCREENMAN:GetTopScreen():GetChild('Overlay'):GetZoomY(),
SCREENMAN:GetTopScreen():GetChild('Overlay'):GetZoomZ(),
SCREENMAN:GetTopScreen():GetChild('Overlay'):GetRotationX(),
SCREENMAN:GetTopScreen():GetChild('Overlay'):GetRotationY(),
SCREENMAN:GetTopScreen():GetChild('Overlay'):GetRotationZ(),
SCREENMAN:GetTopScreen():GetChild('Overlay'):GetZoomedHeight(),
SCREENMAN:GetTopScreen():GetChild('Overlay'):GetZoomedWidth(),
SCREENMAN:GetTopScreen():GetVisible(),
SCREENMAN:GetTopScreen():GetX(),
SCREENMAN:GetTopScreen():GetY(),
SCREENMAN:GetTopScreen():GetZ(),
SCREENMAN:GetTopScreen():GetZoom(),
SCREENMAN:GetTopScreen():GetZoomX(),
SCREENMAN:GetTopScreen():GetZoomY(),
SCREENMAN:GetTopScreen():GetZoomZ(),
SCREENMAN:GetTopScreen():GetRotationX(),
SCREENMAN:GetTopScreen():GetRotationY(),
SCREENMAN:GetTopScreen():GetRotationZ(),
SCREENMAN:GetTopScreen():GetZoomedHeight(),
SCREENMAN:GetTopScreen():GetZoomedWidth()
};
if not TP.Battle.IsBattle then
MESSAGEMAN:Broadcast("Yut")
end
Pc = 2
C = 1;
Ok = true;
SCREENMAN:GetTopScreen():GetChild('Overlay'):decelerate(1)
SCREENMAN:GetTopScreen():GetChild('Overlay'):visible(true)
SCREENMAN:GetTopScreen():GetChild('Overlay'):x(0);
SCREENMAN:GetTopScreen():GetChild('Overlay'):y(0);
SCREENMAN:GetTopScreen():GetChild('Overlay'):z(0);
SCREENMAN:GetTopScreen():GetChild('Overlay'):zoom(1);
SCREENMAN:GetTopScreen():GetChild('Overlay'):zoomx(1);
SCREENMAN:GetTopScreen():GetChild('Overlay'):zoomy(1);
SCREENMAN:GetTopScreen():GetChild('Overlay'):zoomz(1);
SCREENMAN:GetTopScreen():GetChild('Overlay'):rotationx(0);
SCREENMAN:GetTopScreen():GetChild('Overlay'):rotationy(0);
SCREENMAN:GetTopScreen():GetChild('Overlay'):rotationz(0);
SCREENMAN:GetTopScreen():GetChild('Overlay'):zoomtoheight(1);
SCREENMAN:GetTopScreen():GetChild('Overlay'):zoomtowidth(1);

SCREENMAN:GetTopScreen():decelerate(1)
SCREENMAN:GetTopScreen():visible(true)
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
--SOUND:PlayMusicPart(GAMESTATE:GetCurrentSong():GetMusicPath(), GAMESTATE:GetCurMusicSeconds()+0.1, 0.7, 0, 0.7, false, false,false)
elseif Karkao[4] == 0 and Pc == 2 then
Pc = 2.5;
elseif Karkao[4] == 1 and Pc == 2.5 then
Pc = 3	
MESSAGEMAN:Broadcast("Resume")

end
end

if math.floor(Pc) == 2 then
	if Karkao[1] == 1 and LRe[1] then
	LRe[1] = false;
	MESSAGEMAN:Broadcast("Arrow")
		if C == 1 then
		C = 3;
		MESSAGEMAN:Broadcast("BackK")
		MESSAGEMAN:Broadcast("ResM")
		elseif C == 2 then
		C = 1;
		MESSAGEMAN:Broadcast("ResK")
		MESSAGEMAN:Broadcast("RetM")
		elseif C == 3 then
		C = 2;
		MESSAGEMAN:Broadcast("RetK")
		MESSAGEMAN:Broadcast("BackM")
		end
	elseif Karkao[1] == 0 and not LRe[1] then
	LRe[1] = true
	end

	if Karkao[2] == 1 and LRe[2] then
	LRe[2] = false;
	MESSAGEMAN:Broadcast("Arrow")
		if C == 1 then
		C = 2;
		MESSAGEMAN:Broadcast("RetK")
		MESSAGEMAN:Broadcast("ResM")
		elseif C == 2 then
		C = 3;
		MESSAGEMAN:Broadcast("BackK")
		MESSAGEMAN:Broadcast("RetM")
		elseif C == 3 then
		C = 1;
		MESSAGEMAN:Broadcast("ResK")
		MESSAGEMAN:Broadcast("BackM")
		end
	elseif Karkao[2] == 0 and not LRe[2] then
	LRe[2] = true
	end

	if Karkao[3] == 1 then
	if Ok then
	MESSAGEMAN:Broadcast("Okay")
	Ok = false;
	end
		if C == 1 then
		Pc = 3	
		MESSAGEMAN:Broadcast("Resume")
		elseif C == 2 then
		
		MESSAGEMAN:Broadcast("RePeng")
		--RE SONG COMMAND HEREEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

		elseif C == 3 then
		MESSAGEMAN:Broadcast("Resume")
		SCREENMAN:GetTopScreen():SetPrevScreenName(SelectMusicOrCourse()):begin_backing_out()

	end
	end
end
self:sleep(1/30)
self:queuecommand("Nep")
end;
};

Def.Quad{
	InitCommand=function(self) self:visible(false); end;
	AFTERFAILMessageCommand=function() FailTig = true; end;
};

Def.Quad{
OnCommand=function(self) self:zoomx(9999); self:zoomy(0); self:diffuse(color("#00000088")); end;
YutMessageCommand=function(self) self:stoptweening(); self:decelerate(0.5); self:zoomy(SCREEN_CENTER_Y*2); end;
ResumeMessageCommand=function(self) self:stoptweening(); self:decelerate(0.5); self:zoomy(0); end;
};
Def.Quad{--control
OnCommand=function(self) self:visible(false); end;
YutMessageCommand=function() SCREENMAN:GetTopScreen():PauseGame(true) end;
ResumeMessageCommand=function(self) self:playcommand("Nepu"); end;
NepuCommand=function(self)
SCREENMAN:GetTopScreen():PauseGame(false) 
if Karkao[4] == 0 then
Pc = 1 
end
if Pc == 3 then
self:sleep(1/30)
self:queuecommand("Nepu")
end
end;
};
Def.ActorFrame{
InitCommand=function(self) self:x(50*(-2)); self:y(-110); self:diffusealpha(0); end;
YutMessageCommand=function(self) self:stoptweening(); self:x(100*(-2)); self:y(-125); self:diffusealpha(0); self:decelerate(0.5); self:x(50*(-2)); self:y(-110); self:diffusealpha(1); end;
ResumeMessageCommand=function(self) self:stoptweening(); self:x(50*(-2)); self:y(-110); self:diffusealpha(1); self:decelerate(0.5); self:x(100*(-2)); self:y(-125); self:diffusealpha(0); end;
LoadFont( "Common Large") ..{
InitCommand=function(self) self:rainbow(); self:settext('P'); end;
};
};
Def.ActorFrame{
InitCommand=function(self) self:x(50*(-1)); self:y(-110); self:diffusealpha(0); end;
YutMessageCommand=function(self) self:stoptweening(); self:x(100*(-1)); self:y(-125); self:diffusealpha(0); self:decelerate(0.5); self:x(50*(-1)); self:y(-110); self:diffusealpha(1); end;
ResumeMessageCommand=function(self) self:stoptweening(); self:x(50*(-1)); self:y(-110); self:diffusealpha(1); self:decelerate(0.5); self:x(100*(-1)); self:y(-125); self:diffusealpha(0); end;
LoadFont( "Common Large") ..{
InitCommand=function(self) self:rainbow(); self:effectoffset(1/5); self:settext('a'); end;
};
};
Def.ActorFrame{
InitCommand=function(self) self:x(50*(0)); self:y(-110); self:diffusealpha(0); end;
YutMessageCommand=function(self) self:stoptweening(); self:x(100*(0)); self:y(-125); self:diffusealpha(0); self:decelerate(0.5); self:x(50*(0)); self:y(-110); self:diffusealpha(1); end;
ResumeMessageCommand=function(self) self:stoptweening(); self:x(50*(0)); self:y(-110); self:diffusealpha(1); self:decelerate(0.5); self:x(100*(0)); self:y(-125); self:diffusealpha(0); end;
LoadFont( "Common Large") ..{
InitCommand=function(self) self:rainbow(); self:effectoffset(2/5); self:settext('u'); end;
};
};
Def.ActorFrame{
InitCommand=function(self) self:x(50*(1)); self:y(-110); self:diffusealpha(0); end;
YutMessageCommand=function(self) self:stoptweening(); self:x(100*(1)); self:y(-125); self:diffusealpha(0); self:decelerate(0.5); self:x(50*(1)); self:y(-110); self:diffusealpha(1); end;
ResumeMessageCommand=function(self) self:stoptweening(); self:x(50*(1)); self:y(-110); self:diffusealpha(1); self:decelerate(0.5); self:x(100*(1)); self:y(-125); self:diffusealpha(0); end;
LoadFont( "Common Large") ..{
InitCommand=function(self) self:rainbow(); self:effectoffset(3/5); self:settext('s'); end;
};
};
Def.ActorFrame{
InitCommand=function(self) self:x(50*(2)); self:y(-110); self:diffusealpha(0); end;
YutMessageCommand=function(self) self:stoptweening(); self:x(100*(2)); self:y(-125); self:diffusealpha(0); self:decelerate(0.5); self:x(50*(2)); self:y(-110); self:diffusealpha(1); end;
ResumeMessageCommand=function(self) self:stoptweening(); self:x(50*(2)); self:y(-110); self:diffusealpha(1); self:decelerate(0.5); self:x(100*(2)); self:y(-125); self:diffusealpha(0); end;
LoadFont( "Common Large") ..{
InitCommand=function(self) self:rainbow(); self:effectoffset(4/5); self:settext('e'); end;
};
};
LoadFont( "Common Normal") ..{
InitCommand=function(self) self:y(-10); self:zoom(0); self:settext(NameString("continue_playing")); self:diffuse(color("#FF995500")); end;
YutMessageCommand=function(self) self:stoptweening(); self:bounceend(0.5); self:zoom(2); self:diffuse(color("#55FF55FF")); end;
ResumeMessageCommand=function(self) self:stoptweening(); self:bounceend(0.5); self:zoom(0); self:diffuse(color("#FF995500")); end;
ResKMessageCommand=function(self) self:stoptweening(); self:decelerate(0.3); self:zoom(2); self:diffuse(color("#55FF55FF")); end;
ResMMessageCommand=function(self) self:stoptweening(); self:decelerate(0.3); self:zoom(1.7); self:diffuse(color("#FF9955FF")); end;
};
LoadFont( "Common Normal") ..{
InitCommand=function(self) self:y(50); self:zoom(0); self:settext(NameString("restart_song")); self:diffuse(color("#FF995500")); end;
YutMessageCommand=function(self) self:stoptweening(); self:bounceend(0.5); self:zoom(1.7); self:diffuse(color("#FF9955FF")); end;
ResumeMessageCommand=function(self) self:stoptweening(); self:bounceend(0.5); self:zoom(0); self:diffuse(color("#FF995500")); end;
RetKMessageCommand=function(self) self:stoptweening(); self:decelerate(0.3); self:zoom(2); self:diffuse(color("#55FF55FF")); end;
RetMMessageCommand=function(self) self:stoptweening(); self:decelerate(0.3); self:zoom(1.7); self:diffuse(color("#FF9955FF")); end;
};
LoadFont( "Common Normal") ..{
InitCommand=function(self) self:y(110); self:zoom(0); self:settext(NameString("forfeit_song")); self:diffuse(color("#FF995500")); end;
YutMessageCommand=function(self) self:stoptweening(); self:bounceend(0.5); self:zoom(1.7); self:diffuse(color("#FF9955FF")); end;
ResumeMessageCommand=function(self) self:stoptweening(); self:bounceend(0.5); self:zoom(0); self:diffuse(color("#FF995500")); end;
BackKMessageCommand=function(self) self:stoptweening(); self:decelerate(0.3); self:zoom(2); self:diffuse(color("#55FF55FF")); end;
BackMMessageCommand=function(self) self:stoptweening(); self:decelerate(0.3); self:zoom(1.7); self:diffuse(color("#FF9955FF")); end;
};
Def.Quad{--control Retry
OnCommand=function(self) self:visible(false); end;
RePengMessageCommand=function(self) self:playcommand('WonRetry'); end;
WonRetryCommand=function(self)
Wait3[2] = Wait3[2] + 1/30;
if Wait3[2] < 0.7 then
self:sleep(1/30):queuecommand("WonRetry")
SCREENMAN:GetTopScreen():PauseGame(true)
if not Musi then
--SOUND:PlayMusicPart(GAMESTATE:GetCurrentSong():GetMusicPath(), GAMESTATE:GetCurMusicSeconds(), 0.7, 0.7, 0.7, false, false,false)
Musi = true;
end
else
GAMESTATE:ApplyGameCommand('screen,ScreenGameplay');
end
end;
};

Def.ActorFrame{
OnCommand=function(self) self:xy(-SCREEN_CENTER_X,-SCREEN_CENTER_Y); end;
Def.Quad {
	InitCommand=function(self) self:diffusealpha(0); end;
	OnCommand=function(self)
			self:diffuse(color("#00000000"))
			self:Center()
			self:SetSize(SCREEN_WIDTH,SCREEN_HEIGHT)
	end;
	RePengMessageCommand=function(self) self:stoptweening(); self:decelerate(0.5); self:diffusealpha(1); end;
};
};
		LoadActor( THEME:GetPathS("Common","start") )..{
			OkayMessageCommand=function(self) self:play(); end;
		};
		LoadActor( THEME:GetPathS("Common","value") )..{
			ArrowMessageCommand=function(self) self:play(); end;
		};
LoadFont( "Common Large") ..{
InitCommand=function(self) self:x(-20); self:y(-200); self:zoom(0.5/1.4); self:settext(NameString("netOnline")); self:diffuse(color("#FF995500")); end;
OopsNetMessageCommand=function(self) self:stoptweening(); self:diffusealpha(1); self:decelerate(0.5); self:y(-150); self:sleep(1.5); self:decelerate(0.5); self:y(-200); self:diffusealpha(0); end;
};
LoadFont( "Common Large") ..{
InitCommand=function(self) self:x(-20); self:y(-200); self:zoom(0.5/1.4); self:settext(NameString("Battle")); self:diffuse(color("#FF995500")); end;
OopsBatMessageCommand=function(self) self:stoptweening(); self:diffusealpha(1); self:decelerate(0.5); self:y(-150); self:sleep(1.5); self:decelerate(0.5); self:y(-200); self:diffusealpha(0); end;
};
Def.Quad{
OnCommand=function(self) self:visible(false); end;
ResumeMessageCommand=function(self)
SCREENMAN:GetTopScreen():GetChild('Overlay'):decelerate(1)
SCREENMAN:GetTopScreen():GetChild('Overlay'):visible(infoG[1]);
SCREENMAN:GetTopScreen():GetChild('Overlay'):x(infoG[2]);
SCREENMAN:GetTopScreen():GetChild('Overlay'):y(infoG[3]);
SCREENMAN:GetTopScreen():GetChild('Overlay'):z(infoG[4]);
SCREENMAN:GetTopScreen():GetChild('Overlay'):zoom(infoG[5]);
SCREENMAN:GetTopScreen():GetChild('Overlay'):zoomx(infoG[6]);
SCREENMAN:GetTopScreen():GetChild('Overlay'):zoomy(infoG[7]);
SCREENMAN:GetTopScreen():GetChild('Overlay'):zoomz(infoG[8]);
SCREENMAN:GetTopScreen():GetChild('Overlay'):rotationx(infoG[9]);
SCREENMAN:GetTopScreen():GetChild('Overlay'):rotationy(infoG[10]);
SCREENMAN:GetTopScreen():GetChild('Overlay'):rotationz(infoG[11]);
SCREENMAN:GetTopScreen():GetChild('Overlay'):zoomtoheight(infoG[12]);
SCREENMAN:GetTopScreen():GetChild('Overlay'):zoomtowidth(infoG[13]);

SCREENMAN:GetTopScreen():decelerate(1)
SCREENMAN:GetTopScreen():visible(infoG[1+13]);
SCREENMAN:GetTopScreen():x(infoG[2+13]);
SCREENMAN:GetTopScreen():y(infoG[3+13]);
SCREENMAN:GetTopScreen():z(infoG[4+13]);
SCREENMAN:GetTopScreen():zoom(infoG[5+13]);
SCREENMAN:GetTopScreen():zoomx(infoG[6+13]);
SCREENMAN:GetTopScreen():zoomy(infoG[7+13]);
SCREENMAN:GetTopScreen():zoomz(infoG[8+13]);
SCREENMAN:GetTopScreen():rotationx(infoG[9+13]);
SCREENMAN:GetTopScreen():rotationy(infoG[10+13]);
SCREENMAN:GetTopScreen():rotationz(infoG[11+13]);
SCREENMAN:GetTopScreen():zoomtoheight(infoG[12+13]);
SCREENMAN:GetTopScreen():zoomtowidth(infoG[13+13]);
end;
};
};
return t;