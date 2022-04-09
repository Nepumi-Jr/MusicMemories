local Knocked = false;
local t = Def.ActorFrame{
	OnCommand=function(self) self:y(-10); end;
LoadActor("../Border/Under lay2.png")..{
		InitCommand=function(self) self:FullScreen(); self:y(SCREEN_CENTER_Y+10); self:SetTextureFiltering(false); end;
		OnCommand=function(self) self:playcommand('Super'); end;
		SuperCommand=function(self)
		if TP.Battle.Mode == "Ac" and not TP.Battle.IsfailorIsDraw then
		GAMESTATE:GetPlayerState(PLAYER_1):GetPlayerOptions('ModsLevel_Song'):FailSetting('FailType_Off')
		GAMESTATE:GetPlayerState(PLAYER_2):GetPlayerOptions('ModsLevel_Song'):FailSetting('FailType_Off')
		end
		if TP.Battle.IsBattle and TP.Battle.Mode == "Ac" and not TP.Battle.Hidden then
		--GAMESTATE:GetSongBeat() *100 / GAMESTATE:GetCurrentSong():GetLastBeat()
				Yo = (1-math.mod(GAMESTATE:GetSongBeat(),1))/3
				ReR = (GAMESTATE:GetSongBeat()/ GAMESTATE:GetCurrentSong():GetLastBeat())*2
				delta = math.abs(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()-STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints())*15
				self:diffuse({
				scale(delta,0.5,1.5,0,1),
				scale(delta,1.5,2.5,1,0),
				0.3,1})
		if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints() > STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints() then
		self:cropright(0.5)
		self:cropleft(0.5-(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()-STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints())*15)
		elseif STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints() > STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints() then
		self:cropright(0.5-(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()-STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints())*15)
		self:cropleft(0.5)
		elseif STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints() == STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints() then
		self:cropright(0.5)
		self:cropleft(0.5)
		end
		self:sleep(1/60) 
		self:queuecommand('Super')
		else
		self:diffusealpha(0)
		end
		end;
};
Def.Quad{
InitCommand=function(self) self:visible(false); end;
OnCommand=function(self) self:playcommand("KO"); end;
KOCommand=function(self)
if TP.Battle.IsBattle and TP.Battle.Mode == "Dr" then
if (SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_1):IsFailing() or SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_2):IsFailing()) then
if not Knocked then
Knocked = true
SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_DoNextScreen")
end
SCREENMAN:GetTopScreen():PauseGame(true)
else
end
self:sleep(0.02):queuecommand("KO")
end
end;
};
};
return t;