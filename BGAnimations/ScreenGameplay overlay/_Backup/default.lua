-- Gameplay overlay.
local A = 0;
local b = 0;
local courseTEST = {};
		local troll = 0;
local fake = 0;
local real = 0;
local start = 0;
local ratemod = string.match(GAMESTATE:GetSongOptionsString(), "%d.%d");
local ColorP1 = "#FFFF00";
local ColorP2 = "#55FF55";
local P = 0;
local RD = 0;
local TP = 0;
local toll = 0;
local toii = 0;
local fake = 0;
local real = 0;
local start = 0;
local Frame = 4;
local hat = 0;
local Once = false;
local Trollface = 50;
local whatnowP1 = "nope";
local whatnowP2 = "nope";
	local Real_Bpm = 0;
	local Fake_Bpm = 0;
	local R = 0;
	local G = 0;
	local B = 0;
local hip1={0,0}
local hip2={0,0}
local lifeP1 = 0;
local lifeP2 = 0;
local hitbutton = {0,0,0,0,0,0,0,0}
if ratemod then
	ratemod = tonumber(ratemod);
else
	ratemod = 1.0
end
local SOSAD = false;
local percentP2 = 0;
local percentP1 = 0;
LoadActor("../../_save/Battle.lua")								
----------------------------------------- A Lot Of Font Here -------------------------------------------------
local NumF = "_determination mono 24px"
local TextF = "Common Normal"
--------------------------------------------------------------------------------------------------------------

local Wario = {0,0,0,0};
local testa = 200;
local EmiliaWanttoPause = true;

local t = Def.ActorFrame{};

--LoadActor("../_save/SaveForDay")..{
	--OnCommand=function(self) end;
--};
--local Neppress = {back,L1,D1,U1,R1,L2,D2,U2,R2}
local Neppress = {0,0,0,0,0,0,0,0,0,0}
local pausegroup = {1,0,0,0,0,0,0}
local InputHandler = function( event )

	-- if (somehow) there's no event, bail
	if not event then return end

	if event.type == "InputEventType_FirstPress" then
		
		if event.button == "Back" then
			Neppress[1] = 1
		end
		
		if event.button == "Start" then
			Neppress[10] = 1
		end
		
		if event.button == "Left" and event.PlayerNumber == PLAYER_1 then
			Neppress[2] = 1
		end
		if event.button == "DownLeft" and event.PlayerNumber == PLAYER_1 then
			Neppress[2] = 1
		end
		if event.button == "Down" and event.PlayerNumber == PLAYER_1 then
			Neppress[3] = 1
		end
		if event.button == "Up" and event.PlayerNumber == PLAYER_1 then
			Neppress[4] = 1
		end
		if event.button == "Right" and event.PlayerNumber == PLAYER_1 then
			Neppress[5] = 1
		end
		if event.button == "DownRight" and event.PlayerNumber == PLAYER_1 then
			Neppress[5] = 1
		end
		if event.button == "Left" and event.PlayerNumber == PLAYER_2 then
			Neppress[6] = 1
		end
		if event.button == "DownLeft" and event.PlayerNumber == PLAYER_2 then
			Neppress[6] = 1
		end
		if event.button == "Down" and event.PlayerNumber == PLAYER_2 then
			Neppress[7] = 1
		end
		if event.button == "Up" and event.PlayerNumber == PLAYER_2 then
			Neppress[8] = 1
		end
		if event.button == "Right" and event.PlayerNumber == PLAYER_2 then
			Neppress[9] = 1
		end
		if event.button == "DownRight" and event.PlayerNumber == PLAYER_2 then
			Neppress[9] = 1
		end
		if event.button == "Center" then
			Neppress[10] = 1
		end
		
	end
	
	if event.type == "InputEventType_Release" then
		
		if event.button == "Back" then
			Neppress[1] = 0
		end
		
		if event.button == "Start" then
			Neppress[10] = 0
		end
		if event.button == "Center" then
			Neppress[10] = 0
		end
		if event.button == "DownLeft" and event.PlayerNumber == PLAYER_1 then
			Neppress[2] = 0
		end
		if event.button == "DownRight" and event.PlayerNumber == PLAYER_1 then
			Neppress[5] = 0
		end
		if event.button == "Left" and event.PlayerNumber == PLAYER_1 then
			Neppress[2] = 0
		end
		if event.button == "Down" and event.PlayerNumber == PLAYER_1 then
			Neppress[3] = 0
		end
		if event.button == "Up" and event.PlayerNumber == PLAYER_1 then
			Neppress[4] = 0
		end
		if event.button == "Right" and event.PlayerNumber == PLAYER_1 then
			Neppress[5] = 0
		end
		if event.button == "Left" and event.PlayerNumber == PLAYER_2 then
			Neppress[6] = 0
		end
		if event.button == "DownLeft" and event.PlayerNumber == PLAYER_2 then
			Neppress[6] = 0
		end
		if event.button == "Down" and event.PlayerNumber == PLAYER_2 then
			Neppress[7] = 0
		end
		if event.button == "Up" and event.PlayerNumber == PLAYER_2 then
			Neppress[8] = 0
		end
		if event.button == "Right" and event.PlayerNumber == PLAYER_2 then
			Neppress[9] = 0
		end
		if event.button == "DownRight" and event.PlayerNumber == PLAYER_2 then
			Neppress[9] = 0
		end
		
	end

end
--LoadActor("ReportAllSpectrumParameters")..{
--};

t[#t+1] = Def.ActorFrame{
Def.ActorFrame{
OnCommand=function(self) self:diffusealpha(0.25); end;
Def.Quad{
		InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(0); self:zoomtowidth(SCREEN_WIDTH); self:zoomtoheight(SCREEN_HEIGHT/3); end;
		OnCommand=function(self) self:playcommand("Nep"); end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Nep"); end;
		NepCommand=function(self)
		if GAMESTATE:IsHumanPlayer(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_2) then
			if GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Beginner" then
				self:diffuserightedge(color("#ffAAAA"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Easy" then
					self:diffuserightedge(color("#55ff55"))
				elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Medium" then
					self:diffuserightedge(color("#fFff22"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Hard" then
					self:diffuserightedge(color("#ff4444"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Challenge" then
					self:diffuserightedge(color("#CCCCff"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Edit" then
					self:diffuserightedge(color("#AAAAAA"))
				end
			if GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Beginner" then
				self:diffuseleftedge(color("#ffAAAA"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Easy" then
					self:diffuseleftedge(color("#55ff55"))
				elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Medium" then
					self:diffuseleftedge(color("#fFff22"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Hard" then
					self:diffuseleftedge(color("#ff4444"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Challenge" then
					self:diffuseleftedge(color("#CCCCff"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Edit" then
					self:diffuseleftedge(color("#AAAAAA"))
				end
		elseif GAMESTATE:IsHumanPlayer(PLAYER_1) then
			if GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Beginner" then
				self:diffuse(color("#ffAAAA"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Easy" then
				self:diffuse(color("#55ff55"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Medium" then
				self:diffuse(color("#fFff22"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Hard" then
				self:diffuse(color("#ff4444"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Challenge" then
				self:diffuse(color("#CCCCff"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Edit" then
				self:diffuse(color("#AAAAAA"))
				end
		elseif GAMESTATE:IsHumanPlayer(PLAYER_2) then
			if GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Beginner" then
					self:diffuse(color("#ffAAAA"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Easy" then
					self:diffuse(color("#55ff55"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Medium" then
					self:diffuse(color("#fFff22"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Hard" then
					self:diffuse(color("#ff4444"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Challenge" then
					self:diffuse(color("#CCCCff"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Edit" then
					self:diffuse(color("#AAAAAA"))
			end
			end
		end;
	};
};


LoadActor("Under lay.png")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:zoomtowidth(SCREEN_WIDTH); self:zoomtoheight(SCREEN_HEIGHT); end;
		OnCommand=function(self) self:queuecommand("Nep"); end;
		CurrentSongChangedMessageCommand=function(self) self:queuecommand("Nep"); end;
		NepCommand=function(self)
		if GAMESTATE:IsHumanPlayer(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_2) then
			if GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Beginner" then
				self:diffuserightedge(color("#ffAAAA"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Easy" then
					self:diffuserightedge(color("#55ff55"))
				elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Medium" then
					self:diffuserightedge(color("#fFff22"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Hard" then
					self:diffuserightedge(color("#ff4444"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Challenge" then
					self:diffuserightedge(color("#CCCCff"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Edit" then
					self:diffuserightedge(color("#AAAAAA"))
				end
			if GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Beginner" then
				self:diffuseleftedge(color("#ffAAAA"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Easy" then
					self:diffuseleftedge(color("#55ff55"))
				elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Medium" then
					self:diffuseleftedge(color("#fFff22"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Hard" then
					self:diffuseleftedge(color("#ff4444"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Challenge" then
					self:diffuseleftedge(color("#CCCCff"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Edit" then
					self:diffuseleftedge(color("#AAAAAA"))
				end
		elseif GAMESTATE:IsHumanPlayer(PLAYER_1) then
			if GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Beginner" then
				self:diffuse(color("#ffAAAA"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Easy" then
				self:diffuse(color("#55ff55"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Medium" then
				self:diffuse(color("#fFff22"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Hard" then
				self:diffuse(color("#ff4444"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Challenge" then
				self:diffuse(color("#CCCCff"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Edit" then
				self:diffuse(color("#AAAAAA"))
				end
		elseif GAMESTATE:IsHumanPlayer(PLAYER_2) then
			if GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Beginner" then
					self:diffuse(color("#ffAAAA"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Easy" then
					self:diffuse(color("#55ff55"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Medium" then
					self:diffuse(color("#fFff22"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Hard" then
					self:diffuse(color("#ff4444"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Challenge" then
					self:diffuse(color("#CCCCff"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Edit" then
					self:diffuse(color("#AAAAAA"))
			end
			end
		end;
};
LoadActor("Under lay.png")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:zoomtowidth(SCREEN_WIDTH); self:zoomtoheight(SCREEN_HEIGHT); end;
		OnCommand=function(self) self:playcommand('Super'); end;
		SuperCommand=function(self)
		if true then
		DB = math.abs(math.sin(GAMESTATE:GetSongBeat()*(3.14)))*0.396+0.6
		self:diffuse(color(DB..","..DB..","..DB..",1"))
		P = GAMESTATE:GetSongBeat() / GAMESTATE:GetCurrentSong():GetLastBeat()
		self:cropright(1-(P))
		self:sleep(1/60) 
		self:queuecommand('Super')
		end
		end;
};

LoadActor("Under aorrar.png")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:zoomtowidth(SCREEN_WIDTH); self:zoomtoheight(SCREEN_HEIGHT); self:diffuse(color("#FF000000")); self:playcommand("LL"); end;
		LLCommand=function(self)
		if (GAMESTATE:GetPlayMode() == "PlayMode_Rave") or (GAMESTATE:GetPlayerState(PLAYER_1):GetCurrentPlayerOptions():DrainSetting() == "DrainType_SuddenDeath" and GAMESTATE:IsPlayerEnabled(PLAYER_1)) or (GAMESTATE:GetPlayerState(PLAYER_2):GetCurrentPlayerOptions():DrainSetting() == "DrainType_SuddenDeath" and GAMESTATE:IsPlayerEnabled(PLAYER_2)) then
			if LoadModule("Easter.today.lua")() == "FOOL" then
			self:diffusealpha((1-(math.mod(GAMESTATE:GetSongBeat()+0.5,1)))/2)
			else
			self:diffusealpha((1-(math.mod(GAMESTATE:GetSongBeat(),1)))/2)
			end
		elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
			if LoadModule("Easter.today.lua")() == "FOOL" then
			if lifeP1 > lifeP2 and lifeP1 > 50 then
				self:diffusealpha(((lifeP1-50)*2)/100)
			elseif lifeP1 < lifeP2 and lifeP2 > 50 then
				self:diffusealpha(((lifeP2-50)*2)/100)
			end
			else
			if lifeP1 < lifeP2 and lifeP1/100 < 0.5 and not STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):FailPlayer() then
			self:diffusealpha(math.random(5,10)/10)
			elseif lifeP1 > lifeP2 and lifeP2/100 < 0.5 and not STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):FailPlayer() then
			self:diffusealpha(math.random(0,5)/10)
			end
			end
		elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
			if lifeP1/100 < 0.5 then
			self:diffusealpha(((50-lifeP1)*2)/100)
			else
			self:diffusealpha(0)
			end
		elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		if LoadModule("Easter.today.lua")() == "FOOL" then
			if lifeP2 > 50 then
			self:diffusealpha(((lifeP2-50)*2)/100)
			end
		else
			if lifeP2 < 50 then
			self:diffusealpha(((50-lifeP2)*2)/100)
			end
		end
		end
		self:sleep(0.05)
		self:queuecommand("LL")
		end;
};
LoadActor("Awesome.png")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:zoomtowidth(SCREEN_WIDTH); self:zoomtoheight(SCREEN_HEIGHT); end;
		JudgmentMessageCommand=function(self)
		if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
			if GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Beginner" then
				self:diffuserightedge(color("#ffAAAA"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Easy" then
					self:diffuserightedge(color("#55ff55"))
				elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Medium" then
					self:diffuserightedge(color("#fFff22"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Hard" then
					self:diffuserightedge(color("#ff4444"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Challenge" then
					self:diffuserightedge(color("#CCCCff"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Edit" then
					self:diffuserightedge(color("#AAAAAA"))
				end
			if GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Beginner" then
				self:diffuseleftedge(color("#ffAAAA"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Easy" then
					self:diffuseleftedge(color("#55ff55"))
				elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Medium" then
					self:diffuseleftedge(color("#fFff22"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Hard" then
					self:diffuseleftedge(color("#ff4444"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Challenge" then
					self:diffuseleftedge(color("#CCCCff"))
				elseif  GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Edit" then
					self:diffuseleftedge(color("#AAAAAA"))
				end
		if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
			if LoadModule("Easter.today.lua")() == "FOOL" then
			self:diffusealpha((1-(math.mod(GAMESTATE:GetSongBeat()+0.5,1)))/2)
			else
			self:diffusealpha((1-(math.mod(GAMESTATE:GetSongBeat(),1)))/2)
			end
		else
			if LoadModule("Easter.today.lua")() == "FOOL" then
			if lifeP1 < lifeP2 then
				self:diffusealpha(1-(lifeP1/100))
			elseif lifeP1 > lifeP2 then
				self:diffusealpha(1-(lifeP2/100))
			end
			else
			if lifeP1 > lifeP2 then
				self:diffusealpha(lifeP1/100)
			elseif lifeP1 < lifeP2 then
				self:diffusealpha(lifeP2/100)
			end
			end
		end
		elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
			if GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Beginner" then
				self:diffuse(color("#ffAAAA"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Easy" then
				self:diffuse(color("#55ff55"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Medium" then
				self:diffuse(color("#fFff22"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Hard" then
				self:diffuse(color("#ff4444"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Challenge" then
				self:diffuse(color("#CCCCff"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == "Difficulty_Edit" then
				self:diffuse(color("#AAAAAA"))
				end
		if LoadModule("Easter.today.lua")() == "FOOL" then
			self:diffusealpha(1-(lifeP1/100))
		else
			self:diffusealpha(lifeP1/100)
		end
		elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
			if GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Beginner" then
					self:diffuse(color("#ffAAAA"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Easy" then
					self:diffuse(color("#55ff55"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Medium" then
					self:diffuse(color("#fFff22"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Hard" then
					self:diffuse(color("#ff4444"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Challenge" then
					self:diffuse(color("#CCCCff"))
			elseif GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == "Difficulty_Edit" then
					self:diffuse(color("#AAAAAA"))
			end
		if LoadModule("Easter.today.lua")() == "FOOL" then
			self:diffusealpha(1-(lifeP1/100))
		else
			self:diffusealpha(lifeP1/100)
		end
			end
		end;
};
LoadActor("Under lay.png")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:zoomtowidth(SCREEN_WIDTH); self:zoomtoheight(SCREEN_HEIGHT); end;
		OnCommand=function(self) self:playcommand('Super'); end;
		SuperCommand=function(self)
		if Isbattle and not HiddenScore then
		--GAMESTATE:GetSongBeat() *100 / GAMESTATE:GetCurrentSong():GetLastBeat()
				Yo = (1-math.mod(GAMESTATE:GetSongBeat(),1))/3
				ReR = (GAMESTATE:GetSongBeat()/ GAMESTATE:GetCurrentSong():GetLastBeat())*2
		if GAMESTATE:GetSongBeat() *100 / GAMESTATE:GetCurrentSong():GetLastBeat() < 50 then
			self:diffuse(color(ReR+Yo..",1,0,1"))
		else
			self:diffuse(color("1,"..1-(GAMESTATE:GetSongBeat()/ GAMESTATE:GetCurrentSong():GetLastBeat() - 0.5)*2 +Yo..",0,1"))
		end
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

	Def.ActorFrame{
	OnCommand=function(self)
if MonthOfYear() == 12-1 then
if DayOfMonth() == 23 then
	self:diffusealpha(0.5);
	elseif DayOfMonth() == 24 then
	self:diffusealpha(0.75);
	elseif DayOfMonth() == 25 then
	self:diffusealpha(1);
	elseif DayOfMonth() == 26 then
	self:diffusealpha(1);
	self:effectclock("beat");
	self:diffuseramp();
	self:effectcolor1(1,0.7,0.7,1);
	self:effectcolor2(0.7,1,0.7,1);
	self:effectperiod(0.5)
	self:effecttiming(0.25,0.50,0,0.25)
	self:effectoffset(-0.25)
	else
	self:zoom(0);
	end
else
self:zoom(0);
end
end;
	

	LoadActor("blurredsnowFar.png")..{
		OnCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:customtexturerect(0,0,1,1); self:texcoordvelocity(1.40,-0.90); self:zoomtowidth(SCREEN_WIDTH); self:zoomtoheight(SCREEN_HEIGHT); end;
	};
	LoadActor("blurredsnow.png")..{
		OnCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:customtexturerect(0,0,1,1); self:texcoordvelocity(1.20,-0.90); self:zoomtowidth(SCREEN_WIDTH); self:zoomtoheight(SCREEN_HEIGHT); end;
	};
	LoadActor("blurredsnowNear.png")..{
		OnCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:customtexturerect(0,0,1,1); self:texcoordvelocity(1,-0.90); self:zoomtowidth(SCREEN_WIDTH); self:zoomtoheight(SCREEN_HEIGHT); end;
	};
	};
};
if false then
 t[#t+1] = Def.ActorFrame{
	Def.ActorFrame{
	OnCommand=function(self)
if MonthOfYear() == 10-1 and DayOfMonth() == 8 then
	self:diffuse(color("#55FF55"));--tor's bitchday!
	elseif MonthOfYear() == 12-1 and DayOfMonth() == 31 then
	self:diffuse(color("#55FFFF"));--new's year
	elseif MonthOfYear() == 10-1 and DayOfMonth() == 31 then
	self:diffuse(color("#FF2222"));--halloween day!
	elseif MonthOfYear() == 1-1 and DayOfMonth() == 2 then
	self:diffuse(color("#CE5AEF"));--kido
	elseif MonthOfYear() == 3-1 and DayOfMonth() == 28 then
	self:diffuse(color("#2BF973"));--seto
	elseif MonthOfYear() == 5-1 and DayOfMonth() == 10 then
	self:diffuse(color("#809399"));--kano
	elseif MonthOfYear() == 7-1 and DayOfMonth() == 21 then
	self:diffuse(color("#FEBBC4"));--mary
	elseif MonthOfYear() == 2-1 and DayOfMonth() == 14 then
	self:diffuse(color("#F8A555"));--momo
	elseif MonthOfYear() == 4-1 and DayOfMonth() == 30 then
	self:diffuse(color("#FB4959"));--shintaro
	elseif MonthOfYear() == 11-1 and DayOfMonth() == 4 then
	self:diffuse(color("#27F6E6"));--hibiya
	elseif MonthOfYear() == 12-1 and DayOfMonth() == 24 then
	self:diffuse(color("#F9FF65"));--konoha
	elseif MonthOfYear() == 8-1 and DayOfMonth() == 15 then
	self:diffuse(color("#FF5555"));--kagerou's day
	else
	self:diffuse(color("#E6C8EE"));
	end
end;
LoadActor("Hat.mp3")..{
		InitCommand=function(self) self:diffusealpha(0); end;
		OnCommand=function(self) self:playcommand('Hat'); end;
		HatCommand=function(self)
		--self:setstate(RD)
		real = (math.ceil(GAMESTATE:GetCurrentSong():GetFirstBeat()))/4
		fake = math.floor((math.ceil(GAMESTATE:GetCurrentSong():GetFirstBeat()))/4)
		
		if real == fake then
			start = real * 4
		else
			start = fake * 4
		end
		
		if GAMESTATE:GetSongBeat() >= start-8-0.25 and GAMESTATE:GetSongBeat() <= start-4-0.25 and hat == 0 then
		hat = 1
		elseif GAMESTATE:GetSongBeat() >= start-4-0.25 and GAMESTATE:GetSongBeat() <= start-3-0.25 and hat == 1 then
		self:play()
		hat = 2
		elseif GAMESTATE:GetSongBeat() >= start-3-0.25 and GAMESTATE:GetSongBeat() <= start-2-0.25 and hat == 2 then
		self:play()
		hat = 3
		elseif GAMESTATE:GetSongBeat() >= start-2-0.25 and GAMESTATE:GetSongBeat() <= start-1-0.25 and hat == 3 then
		self:play()
		hat = 4
		elseif GAMESTATE:GetSongBeat() >= start-1-0.25 and GAMESTATE:GetSongBeat() <= start-0.25 and hat == 4 then
		self:play()
		hat = 5
		end
		self:sleep(0.02)
		self:queuecommand('Hat')
		end;
};
Def.ActorFrame{
	InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); end;
LoadActor("Hcount 1x5.png")..{
		InitCommand=function(self) self:diffusealpha(0); end;
		OnCommand=function(self)
		self:animate(0);
		self:playcommand('James')
		end;
		JamesCommand=function(self)
		--self:setstate(RD)
		real = (math.ceil(GAMESTATE:GetCurrentSong():GetFirstBeat()))/4
		fake = math.floor((math.ceil(GAMESTATE:GetCurrentSong():GetFirstBeat()))/4)
		
		if real == fake then
			start = real * 4
		else
			start = fake * 4
		end
		
		if GAMESTATE:GetSongBeat() >= start-8 and GAMESTATE:GetSongBeat() <= start-4 and toll == 0 then
		toll = 1
		elseif GAMESTATE:GetSongBeat() >= start-4 and GAMESTATE:GetSongBeat() <= start-3 and toll == 1 then
		self:diffusealpha(1)
		self:rotationz(-10)
		self:zoom(2)
		self:linear(0.25)
		self:rotationz(0)
		self:zoom(1)
		Frame = 0
		toll = 2
		elseif GAMESTATE:GetSongBeat() >= start-3 and GAMESTATE:GetSongBeat() <= start-2 and toll == 2 then
		self:rotationz(15)
		self:zoom(2)
		self:linear(0.25)
		self:rotationz(0)
		self:zoom(1)
		Frame = 1
		toll = 3
		elseif GAMESTATE:GetSongBeat() >= start-2 and GAMESTATE:GetSongBeat() <= start-1 and toll == 3 then
		self:rotationz(-20)
		self:zoom(2)
		self:linear(0.25)
		self:rotationz(0)
		self:zoom(1)
		Frame = 2
		toll = 4
		elseif GAMESTATE:GetSongBeat() >= start-1 and GAMESTATE:GetSongBeat() <= start and toll == 4 then
		self:rotationz(25)
		self:zoom(2)
		self:linear(0.25)
		self:rotationz(0)
		self:zoom(1)
		Frame = 3
		toll = 5
		elseif GAMESTATE:GetSongBeat() >= start and toll == 5 then
		self:linear(0.25)
		self:diffusealpha(0)
		elseif GAMESTATE:GetSongBeat() >= start+4 then
		self:linear(0.25)
		self:diffusealpha(0)
		end
		self:sleep(0.02)
		self:setstate(Frame)
		if GAMESTATE:GetSongBeat() < start+10 then
		self:queuecommand('James')
		end
		end;
};
};
LoadActor("HReady.png")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:diffusealpha(0); end;
		OnCommand=function(self) self:playcommand('James'); end;
		JamesCommand=function(self)
		if GAMESTATE:GetSongBeat() >= start-8 and GAMESTATE:GetSongBeat() <= start-5 and toii == 0 then
		toii = 1
		self:linear(0.25)
		self:diffusealpha(1)
		elseif GAMESTATE:GetSongBeat() >= start-5 and GAMESTATE:GetSongBeat() <= start-4 and toii == 1 then
		toii = 2
		self:linear(0.25)
		self:diffusealpha(0)
		end
		if GAMESTATE:GetSongBeat() >= start +5 then
		self:diffusealpha(0)
		end
		
		self:sleep(0.02)
		self:queuecommand('James')
		end;
};
};
};
else
 t[#t+1] = Def.ActorFrame{
	Def.ActorFrame{
	OnCommand=function(self)
if MonthOfYear() == 10-1 and DayOfMonth() == 8 then
	self:diffuse(color("#55FF55"));--tor's bitchday!
	elseif MonthOfYear() == 12-1 and DayOfMonth() == 31 then
	self:diffuse(color("#55FFFF"));--new's year
	elseif MonthOfYear() == 10-1 and DayOfMonth() == 31 then
	self:diffuse(color("#FF2222"));--halloween day!
	elseif MonthOfYear() == 1-1 and DayOfMonth() == 2 then
	self:diffuse(color("#CE5AEF"));--kido
	elseif MonthOfYear() == 3-1 and DayOfMonth() == 28 then
	self:diffuse(color("#2BF973"));--seto
	elseif MonthOfYear() == 5-1 and DayOfMonth() == 10 then
	self:diffuse(color("#809399"));--kano
	elseif MonthOfYear() == 7-1 and DayOfMonth() == 21 then
	self:diffuse(color("#FEBBC4"));--mary
	elseif MonthOfYear() == 2-1 and DayOfMonth() == 14 then
	self:diffuse(color("#F8A555"));--momo
	elseif MonthOfYear() == 4-1 and DayOfMonth() == 30 then
	self:diffuse(color("#FB4959"));--shintaro
	elseif MonthOfYear() == 11-1 and DayOfMonth() == 4 then
	self:diffuse(color("#27F6E6"));--hibiya
	elseif MonthOfYear() == 12-1 and DayOfMonth() == 24 then
	self:diffuse(color("#F9FF65"));--konoha
	elseif MonthOfYear() == 8-1 and DayOfMonth() == 15 then
	self:diffuse(color("#FF5555"));--kagerou's day
	else
	self:diffuse(color("#E6C8EE"));
	end
end;
LoadActor("Hat.mp3")..{
		InitCommand=function(self) self:diffusealpha(0); end;
		OnCommand=function(self) self:playcommand('Hat'); end;
		HatCommand=function(self)
		--self:setstate(RD)
		real = (math.ceil(GAMESTATE:GetCurrentSong():GetFirstBeat()))/4
		fake = math.floor((math.ceil(GAMESTATE:GetCurrentSong():GetFirstBeat()))/4)
		
		if real == fake then
			start = real * 4
		else
			start = fake * 4
		end
		
		if GAMESTATE:GetSongBeat() >= start-8-0.25 and GAMESTATE:GetSongBeat() <= start-4-0.25 and hat == 0 then
		hat = 1
		elseif GAMESTATE:GetSongBeat() >= start-4-0.25 and GAMESTATE:GetSongBeat() <= start-3-0.25 and hat == 1 then
		self:play()
		hat = 2
		elseif GAMESTATE:GetSongBeat() >= start-3-0.25 and GAMESTATE:GetSongBeat() <= start-2-0.25 and hat == 2 then
		self:play()
		hat = 3
		elseif GAMESTATE:GetSongBeat() >= start-2-0.25 and GAMESTATE:GetSongBeat() <= start-1-0.25 and hat == 3 then
		self:play()
		hat = 4
		elseif GAMESTATE:GetSongBeat() >= start-1-0.25 and GAMESTATE:GetSongBeat() <= start-0.25 and hat == 4 then
		self:play()
		hat = 5
		end
		self:sleep(0.02)
		self:queuecommand('Hat')
		end;
};
Def.ActorFrame{
	InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); end;
LoadActor("count 1x5.png")..{
		InitCommand=function(self) self:diffusealpha(0); end;
		OnCommand=function(self)
		self:animate(0);
		self:playcommand('James')
		end;
		JamesCommand=function(self)
		--self:setstate(RD)
		real = (math.ceil(GAMESTATE:GetCurrentSong():GetFirstBeat()))/4
		fake = math.floor((math.ceil(GAMESTATE:GetCurrentSong():GetFirstBeat()))/4)
		
		if real == fake then
			start = real * 4
		else
			start = fake * 4
		end
		
		if GAMESTATE:GetSongBeat() >= start-8 and GAMESTATE:GetSongBeat() <= start-4 and toll == 0 then
		toll = 1
		elseif GAMESTATE:GetSongBeat() >= start-4 and GAMESTATE:GetSongBeat() <= start-3 and toll == 1 then
		self:diffusealpha(1)
		self:rotationz(-10)
		self:zoom(2)
		self:linear(0.25)
		self:rotationz(0)
		self:zoom(1)
		Frame = 0
		toll = 2
		elseif GAMESTATE:GetSongBeat() >= start-3 and GAMESTATE:GetSongBeat() <= start-2 and toll == 2 then
		self:rotationz(15)
		self:zoom(2)
		self:linear(0.25)
		self:rotationz(0)
		self:zoom(1)
		Frame = 1
		toll = 3
		elseif GAMESTATE:GetSongBeat() >= start-2 and GAMESTATE:GetSongBeat() <= start-1 and toll == 3 then
		self:rotationz(-20)
		self:zoom(2)
		self:linear(0.25)
		self:rotationz(0)
		self:zoom(1)
		Frame = 2
		toll = 4
		elseif GAMESTATE:GetSongBeat() >= start-1 and GAMESTATE:GetSongBeat() <= start and toll == 4 then
		self:rotationz(25)
		self:zoom(2)
		self:linear(0.25)
		self:rotationz(0)
		self:zoom(1)
		Frame = 3
		toll = 5
		elseif GAMESTATE:GetSongBeat() >= start and toll == 5 then
		self:linear(0.25)
		self:diffusealpha(0)
		elseif GAMESTATE:GetSongBeat() >= start+4 then
		self:linear(0.25)
		self:diffusealpha(0)
		end
		self:sleep(0.02)
		self:setstate(Frame)
		if GAMESTATE:GetSongBeat() < start+10 then
		self:queuecommand('James')
		end
		end;
};
};
LoadActor("Ready.png")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:diffusealpha(0); end;
		OnCommand=function(self) self:playcommand('James'); end;
		JamesCommand=function(self)
		if GAMESTATE:GetSongBeat() >= start-8 and GAMESTATE:GetSongBeat() <= start-5 and toii == 0 then
		self:linear(0.25)
		self:diffusealpha(1)
		toii = 1
		elseif GAMESTATE:GetSongBeat() >= start-5 and GAMESTATE:GetSongBeat() <= start-4 and toii == 1 then
		self:linear(0.25)
		self:diffusealpha(0)
		toii = 2
		elseif GAMESTATE:GetSongBeat() >= start+4 then
		self:linear(0.25)
		self:diffusealpha(0)
		end
		
		self:sleep(0.02)
		if GAMESTATE:GetSongBeat() < start+4 then
		self:queuecommand('James')
		end
		end;
};
};
};
end
t[#t+1]= Def.ActorFrame{----SCREENMAN:GetTopScreen():GetNextCourseSong()

Def.Quad {
OnCommand=function(self) self:x(SCREEN_CENTER_X*0.5-126); self:y(SCREEN_CENTER_Y-210.25); self:diffuse(color("#FF5555")); self:horizalign(left); self:zoomy(23.75); self:zoomx(246.5/2); self:zoom(0); end;
		HealthStateChangedMessageCommand=function(self,params)
			if(params.PlayerNumber == PLAYER_1) then
				if(params.HealthState == 'HealthState_Hot') then
					self:effectclock("beat");
					self:diffuseramp();
					self:effectcolor1(1,0.5,0.5,1);
					self:effectcolor2(1,0.3,0.3,1);
					self:effectperiod(0.5);
					self:effecttiming(0.25,0.50,0,0.25);
					self:effectoffset(-0.25);
					whatnowP1 = "full";
				else
					whatnowP1 = "nope";
					self:stopeffect();
					self:diffuse(color("#FF5555"));
				end;
			end;
		end;
	
		-- check life (LifeMeterBar)
		LifeChangedMessageCommand=function(self,params)
			if(params.Player == PLAYER_1) then
				lifeP1 = string.format('%.2f',params.LifeMeter:GetLife()*100);
				--hip1[1]= params.LifeMeter:GetTotalLives()
				--hip1[2]= params.LifeMeter:GetLivesLeft()
				self:finishtweening();
				self:bounceend(0.3);
				if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
				life = 100-life
				--self:zoomx(246.5*life/100)
				else
				--self:zoomx(246.5*life/100)
				end
			end;
		end;
};
Def.ActorFrame{
--InitCommand=function(self) SCREENMAN:GetTopScreen():GetChild('LifeP1') = self end;
Def.Quad {
OnCommand=function(self) self:x(SCREEN_CENTER_X*0.5-126); self:y(SCREEN_CENTER_Y-210.25); self:diffuse(color("#FF5555")); self:horizalign(left); self:zoomy(23.75); self:zoomx(246.5/2); self:playcommand('loop'); end;
		loopCommand=function(self)
		ttt = (math.mod(GAMESTATE:GetSongBeat(),1))*15
		if whatnowP1 == "full" then
					self:effectclock("beat");
					self:diffuseramp();
					self:effectcolor1(1,0.1,0.1,1);
					self:effectcolor2(1,0.5,0.5,1);
					self:effectperiod(0.5);
					self:effecttiming(0.25,0.50,0,0.25);
					self:effectoffset(-0.25);
		self:zoomx(246.5)
		if lifeP1/100 <= 0 then
		self:zoomx(0)
		self:stopeffect()
		end
		elseif lifeP1/100 <= 0 then
		self:stopeffect()
		self:zoomx(0)
		else
		self:stopeffect()
		self:zoomx(math.max(246.5*(lifeP1/100)-ttt,0))
		end
		self:diffuse(color("#FF5555"))
		self:sleep(0.02)
		self:queuecommand('loop')
		end;
};
};
LoadFont(NumF)..{
OnCommand=function(self) self:x(SCREEN_CENTER_X*0.5); self:y(SCREEN_CENTER_Y-210.25); self:diffuse(color("#00FF00")); self:playcommand('loop'); end;
		loopCommand=function(self)
		if not GAMESTATE:IsHumanPlayer(PLAYER_1) then
			self:settext("")
		else
		self:settext(lifeP1)
		end
		self:sleep(0.02)
		self:queuecommand('loop')
		end;

};



	


Def.Quad {
OnCommand=function(self) self:x(SCREEN_CENTER_X*0.5-126); self:y(SCREEN_CENTER_Y-210.25); self:diffuse(color("#FF5555")); self:horizalign(left); self:zoomy(23.75); self:zoomx(246.5/2); self:zoom(0); end;
		HealthStateChangedMessageCommand=function(self,params)
			if(params.PlayerNumber == PLAYER_2) then
				if(params.HealthState == 'HealthState_Hot') then
					self:effectclock("beat");
					self:diffuseramp();
					self:effectcolor1(1,0.5,0.5,1);
					self:effectcolor2(1,0.3,0.3,1);
					self:effectperiod(0.5);
					self:effecttiming(0.25,0.50,0,0.25);
					self:effectoffset(-0.25);
					whatnowP2 = "full";
				else
					whatnowP2 = "nope";
					self:stopeffect();
					self:diffuse(color("#FF5555"));
				end;
			end;
		end;
	
		-- check life (LifeMeterBar)
		LifeChangedMessageCommand=function(self,params)
			if(params.Player == PLAYER_2) then
				lifeP2 = string.format('%.2f',params.LifeMeter:GetLife()*100);
				self:finishtweening();
				self:bounceend(0.3);
				if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
				life = 100-life
				--self:zoomx(246.5*life/100)
				else
				--self:zoomx(246.5*life/100)
				end
			end;
		end;
};
Def.Quad {
OnCommand=function(self) self:x(SCREEN_CENTER_X*1.5-120); self:y(SCREEN_CENTER_Y-210.25); self:diffuse(color("#5555FF")); self:horizalign(left); self:zoomy(23.75); self:zoomx(246.5/2); self:playcommand('loop'); end;
		loopCommand=function(self)
		ttt = (math.mod(GAMESTATE:GetSongBeat(),1))*15
		if whatnowP2 == "full" then
					self:effectclock("beat");
					self:diffuseramp();
					self:effectcolor1(0.1,0.1,1,1);
					self:effectcolor2(0.5,0.5,1,1);
					self:effectperiod(0.5);
					self:effecttiming(0.25,0.50,0,0.25);
					self:effectoffset(-0.25);
		self:zoomx(246.5)
		elseif lifeP2/100 <= 0 then
		self:stopeffect()
		self:zoomx(0)
		else
		self:stopeffect()
		self:zoomx(math.max(246.5*(lifeP2/100)-ttt,0))
		end
		self:diffuse(color("#5555FF"))
		self:sleep(0.02)
		self:queuecommand('loop')
		end;
};
LoadFont(NumF)..{
OnCommand=function(self) self:x(SCREEN_CENTER_X*1.5+5); self:y(SCREEN_CENTER_Y-210.25); self:diffuse(color("#FF8800")); self:playcommand('loop'); end;
		loopCommand=function(self)
		self:settext(lifeP2)
		self:sleep(0.02)
		self:queuecommand('loop')
		end;

};
--SCREENMAN:GetTopScreen():GetChild('PlayerP2'):GetChild('Combo')
LoadFont(TextF)..{
InitCommand=function(self) self:x(SCREEN_CENTER_X-305); self:y(SCREEN_BOTTOM-40-383); self:zoom(0.8); end;
		OnCommand=function(self) self:playcommand("Nep"); end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Nep"); end;
		NepCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1));
			self:diffuse(color("#FF0000"));
			--Troll = GAMESTATE:GetCurrentSong():GetFirstSecond();
			--self:settext(Troll);
			self:zoom(0.8)
			self:maxheight(20)
			self:maxwidth(90)
			self:settext(":D")
		end;
};
LoadFont(TextF)..{
InitCommand=function(self) self:x(SCREEN_CENTER_X+305); self:y(SCREEN_BOTTOM-40-383); self:zoom(0.8); end;
		OnCommand=function(self) self:playcommand("Nep"); end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Nep"); end;
		NepCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2));
			self:diffuse(color("#5555FF"));
		end;
};
	
LoadFont("_digital-7 black mono 20px")..{
InitCommand=function(self) self:x(SCREEN_CENTER_X+100+55+60); self:y(SCREEN_BOTTOM-40-383); self:draworder(101); self:settext("0.00%"); end;
				OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2));
			self:diffuse(PlayerColor(PLAYER_2));
			self:settext("0.00%");
			self:diffusealpha(1);
			self:playcommand('loop')
		end;
		JudgmentMessageCommand=function(self)
			percentP2 = FormatPercentScore(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints())
			if Isbattle and HiddenScore then
			self:settext("??.??%")
			else
			self:settext(percentP2)
			end
		if (GAMESTATE:IsPlayerEnabled(PLAYER_1) and STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints() >= STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()) or (GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsPlayerEnabled(PLAYER_1)) or (Isbattle and HiddenScore) then
		self:pulse()
		self:effecttiming(0.25,0.25,0.25,0.25);
		self:effectmagnitude(1,1.25,1)
		self:effectclock("beat")
		else
		self:stopeffect()
		end
		end;
};
Def.ActorFrame{
	OnCommand=function(self) self:playcommand("NepuNepu"); end;
	NepuNepuCommand=function(self)
		self:x(SCREENMAN:GetTopScreen():GetChild('ScoreP1'):GetX()-212)
		self:y(SCREENMAN:GetTopScreen():GetChild('ScoreP1'):GetY()-99999997952)
		self:sleep(1/60)
		self:queuecommand("NepuNepu")
	end;
LoadFont("_digital-7 black mono 20px")..{
InitCommand=function(self) self:x(SCREEN_CENTER_X-100-55-60); self:y(SCREEN_BOTTOM-40-383); self:draworder(101); self:settext("0.00%"); self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1)); self:diffuse(PlayerColor(PLAYER_1)); end;
				JudgmentMessageCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1));
			self:diffuse(PlayerColor(PLAYER_1));
			self:settext("0.00%");
			self:diffusealpha(1);
			self:playcommand('loop')
		end;
		loopCommand=function(self)
			percentP1 = FormatPercentScore(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints())
			if Isbattle and HiddenScore then
			self:settext("??.??%")
			else
			self:settext(percentP1)
			end
		if (GAMESTATE:IsPlayerEnabled(PLAYER_2) and STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints() >= STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()) or (GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsPlayerEnabled(PLAYER_2)) or (Isbattle and HiddenScore) then
		self:pulse()
		self:effecttiming(0.25,0.25,0.25,0.25);
		self:effectmagnitude(1,1.25,1)
		self:effectclock("beat")
		else
		self:stopeffect()
		end
		end;
};
};
LoadFont(NumF)..{
InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_TOP+32); self:zoom(1); end;
		OnCommand=function(self) self:playcommand('James'); end;
		JamesCommand=function(self)
	if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	local pState = GAMESTATE:GetPlayerState(PLAYER_1);
	local songPosition = pState:GetSongPosition()
	local bpm = songPosition:GetCurBPS() * 60

	local pState2 = GAMESTATE:GetPlayerState(PLAYER_2);
	local songPosition2 = pState2:GetSongPosition()
	local bpm2 = songPosition2:GetCurBPS() * 60
	
	Fake_Bpm = (round(bpm) + round(bpm2)) / 2
	
	elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	
	local pState = GAMESTATE:GetPlayerState(PLAYER_1);
	local songPosition = pState:GetSongPosition()
	local bpm = songPosition:GetCurBPS() * 60

	
	Fake_Bpm = round(bpm)
	elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	local pState = GAMESTATE:GetPlayerState(PLAYER_2);
	local songPosition = pState:GetSongPosition()
	local bpm = songPosition:GetCurBPS() * 60
	
	
	Fake_Bpm = round(bpm)
	end
			if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
			if not Once then
				Real_Bpm = Fake_Bpm
				Once = true;
			else
				Real_Bpm = Trollface
			end
			    self:settext(Real_Bpm);
			elseif ratemod ~= 1 then
				Real_Bpm = Fake_Bpm * ratemod
				self:settext(Fake_Bpm.."x"..ratemod..'='..Real_Bpm);
			else
				Real_Bpm = Fake_Bpm
			    self:settext(Real_Bpm);
			end
			
			if Real_Bpm >= 600 then
				self:settext(Real_Bpm)
				self:rainbowscroll(true)
			end
		
		if Real_Bpm <= 100 then
		R = Real_Bpm/100
		B = Real_Bpm/100
		G = Real_Bpm/2000--0.05
		self:rainbowscroll(false)
		elseif Real_Bpm <= 150 then
		R = (100-((Real_Bpm-100)*0.5))/100--0.75 noi sut
		B = (100-((Real_Bpm-100)*2))/100
		G = (Real_Bpm-100)*0.02
		self:rainbowscroll(false)
		elseif Real_Bpm <= 300 then
		R = Real_Bpm/300--0.75 noi sut
		B = (300-((Real_Bpm-150)*2))/300
		G = (300-((Real_Bpm-150)*2))/300
		self:rainbowscroll(false)
		elseif Real_Bpm <= 600 then
		R = 1
		B = 0
		G = 0
		self:rainbowscroll(false)
		end
		
		YO = (1-math.mod(GAMESTATE:GetSongBeat(),1))/3
		
		a = math.min(R,1)
		b = math.min(G,1)
		c = math.min(B,1)
		self:diffuse(color(a+YO..","..b+YO..","..c+YO..",1"))
		self:sleep(0.005)
		self:queuecommand('James')
		end;
		StepP1MessageCommand=function(self)
		Trollface = math.random(50,400)
		end;
		StepP2MessageCommand=function(self)
		Trollface = math.random(50,400)
		end;
};
LoadActor("Old.lua")..{
OnCommand=function(self) end;
};
LoadActor("Harderdafault.lua")..{
InitCommand=function(self) end;
};
Def.Quad{
InitCommand=function(self) self:y(SCREEN_BOTTOM-5); self:horizalign(left); self:zoomx(SCREEN_RIGHT); self:zoomy(10); end;
		OnCommand=function(self) self:playcommand('Super'); end;
		SuperCommand=function(self)
		P = GAMESTATE:GetCurMusicSeconds() / GAMESTATE:GetCurrentSong():MusicLengthSeconds()
		self:cropright(1-P)
		self:sleep(1/60)
		self:fadetop(0.5);
		self:queuecommand('Super')
		end;
};
LoadActor("ColorofBAR2.lua")..{
InitCommand=function(self) self:y(SCREEN_BOTTOM-5); end;
};
--inputoverlay-key
--Neppress = {esc,L1,D1,U1,R1,L2,D2,U2,R2,enter}----------
------------------------------------
---------------I hate myself-----------------------------
--------P1--------
Def.ActorFrame{
InitCommand=function(self) self:zoom(0.75); self:x((43/2*0.75+5)); self:y(SCREEN_CENTER_Y); end;
Def.Quad{--control panel
OnCommand=function(self) self:zoom(0); self:playcommand("Nep"); end;
NepCommand=function(self)
self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1));
	if Neppress[2] == 1 then MESSAGEMAN:Broadcast("L1") else MESSAGEMAN:Broadcast("L1re") end
	if Neppress[3] == 1 then MESSAGEMAN:Broadcast("D1") else MESSAGEMAN:Broadcast("D1re") end
	if Neppress[4] == 1 then MESSAGEMAN:Broadcast("U1") else MESSAGEMAN:Broadcast("U1re") end
	if Neppress[5] == 1 then MESSAGEMAN:Broadcast("R1") else MESSAGEMAN:Broadcast("R1re") end
self:sleep(1/60)
self:queuecommand("Nep")
end;
};
LoadActor("inputoverlay-key.png")..{
L1MessageCommand=function(self) self:stoptweening(); self:linear(0.1); self:zoom(0.85); self:diffuse(color(ColorP1)); end;
L1reMessageCommand=function(self) self:stoptweening(); self:y(-23*3*1.25); self:linear(0.1); self:zoom(1); self:diffuse(color("#FFFFFF")); end;
};
LoadActor("inputoverlay-key.png")..{
OnCommand=function(self) self:y(-23*1*7.75); end;
D1MessageCommand=function(self) self:stoptweening(); self:linear(0.1); self:zoom(0.85); self:diffuse(color(ColorP1)); end;
D1reMessageCommand=function(self) self:stoptweening(); self:y(-23*1*1.25); self:linear(0.1); self:zoom(1); self:diffuse(color("#FFFFFF")); end;
};
LoadActor("inputoverlay-key.png")..{
OnCommand=function(self) self:y(23*1*7.75); end;
U1MessageCommand=function(self) self:stoptweening(); self:linear(0.1); self:zoom(0.85); self:diffuse(color(ColorP1)); end;
U1reMessageCommand=function(self) self:stoptweening(); self:y(23*1*1.25); self:linear(0.1); self:zoom(1); self:diffuse(color("#FFFFFF")); end;
};
LoadActor("inputoverlay-key.png")..{
OnCommand=function(self) self:y(23*3*7.75); end;
R1MessageCommand=function(self) self:stoptweening(); self:linear(0.1); self:zoom(0.85); self:diffuse(color(ColorP1)); end;
R1reMessageCommand=function(self) self:stoptweening(); self:y(23*3*1.25); self:linear(0.1); self:zoom(1); self:diffuse(color("#FFFFFF")); end;
};
LoadFont("_special elite 24px")..{
Text="L"; L1MessageCommand=function(self)
	if GAMESTATE:GetSongBeat() > GAMESTATE:GetCurrentSong():GetFirstBeat() then if not plused then
		hitbutton[1] = hitbutton[1] + 1 self:settext(hitbutton[1]) plused = true end else
		self:settext("L") end self:stoptweening() :linear(0.1) :zoom(0.85) :diffuse(color("#000000")) end; L1reMessageCommand=function(self) self:stoptweening() :y(-23*3*1.25) :linear(0.1) :zoom(1) :diffuse(color("#000000")) plused = false end;
};
LoadFont("_special elite 24px")..{
Text="D"; D1MessageCommand=function(self)
	if GAMESTATE:GetSongBeat() > GAMESTATE:GetCurrentSong():GetFirstBeat() then if not plused2 then
		hitbutton[2] = hitbutton[2] + 1 self:settext(hitbutton[2]) plused2 = true end else
		self:settext("D") end self:stoptweening() :linear(0.1) :zoom(0.85) :diffuse(color("#000000")) end; D1reMessageCommand=function(self) self:stoptweening() :y(-23*1*1.25) :linear(0.1) :zoom(1) :diffuse(color("#000000")) plused2 = false end;
};
LoadFont("_special elite 24px")..{
Text="U"; U1MessageCommand=function(self)
	if GAMESTATE:GetSongBeat() > GAMESTATE:GetCurrentSong():GetFirstBeat() then if not plused3 then
		hitbutton[3] = hitbutton[3] + 1 self:settext(hitbutton[3]) plused3 = true end else
		self:settext("U") end self:stoptweening() :linear(0.1) :zoom(0.85) :diffuse(color("#000000")) end; U1reMessageCommand=function(self) self:stoptweening() :y(-23*-1*1.25) :linear(0.1) :zoom(1) :diffuse(color("#000000")) plused3 = false end;
};
LoadFont("_special elite 24px")..{
Text="R"; R1MessageCommand=function(self)
	if GAMESTATE:GetSongBeat() > GAMESTATE:GetCurrentSong():GetFirstBeat() then if not plused4 then
		hitbutton[4] = hitbutton[4] + 1 self:settext(hitbutton[4]) plused4 = true end else
		self:settext("R") end self:stoptweening() :linear(0.1) :zoom(0.85) :diffuse(color("#000000")) end; R1reMessageCommand=function(self) self:stoptweening() :y(-23*-3*1.25) :linear(0.1) :zoom(1) :diffuse(color("#000000")) plused4 = false end;
};
};

Def.ActorFrame{
InitCommand=function(self) self:zoom(0.75); self:x(SCREEN_RIGHT-(43/2*0.75+5)); self:y(SCREEN_CENTER_Y); end;
Def.Quad{--control panel
OnCommand=function(self) self:zoom(0); self:playcommand("Nep"); end;
NepCommand=function(self)
self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2));
	if Neppress[6] == 1 then MESSAGEMAN:Broadcast("L2") else MESSAGEMAN:Broadcast("L2re") end
	if Neppress[7] == 1 then MESSAGEMAN:Broadcast("D2") else MESSAGEMAN:Broadcast("D2re") end
	if Neppress[8] == 1 then MESSAGEMAN:Broadcast("U2") else MESSAGEMAN:Broadcast("U2re") end
	if Neppress[9] == 1 then MESSAGEMAN:Broadcast("R2") else MESSAGEMAN:Broadcast("R2re") end
self:sleep(0.02)
self:queuecommand("Nep")
end;
};
LoadActor("inputoverlay-key.png")..{
L2MessageCommand=function(self) self:stoptweening(); self:linear(0.1); self:zoom(0.85); self:diffuse(color(ColorP2)); end;
L2reMessageCommand=function(self) self:stoptweening(); self:y(-23*3*1.25); self:linear(0.1); self:zoom(1); self:diffuse(color("#FFFFFF")); end;
};
LoadActor("inputoverlay-key.png")..{
OnCommand=function(self) self:y(-23*1*7.75); end;
D2MessageCommand=function(self) self:stoptweening(); self:linear(0.1); self:zoom(0.85); self:diffuse(color(ColorP2)); end;
D2reMessageCommand=function(self) self:stoptweening(); self:y(-23*1*1.25); self:linear(0.1); self:zoom(1); self:diffuse(color("#FFFFFF")); end;
};
LoadActor("inputoverlay-key.png")..{
OnCommand=function(self) self:y(23*1*7.75); end;
U2MessageCommand=function(self) self:stoptweening(); self:linear(0.1); self:zoom(0.85); self:diffuse(color(ColorP2)); end;
U2reMessageCommand=function(self) self:stoptweening(); self:y(23*1*1.25); self:linear(0.1); self:zoom(1); self:diffuse(color("#FFFFFF")); end;
};
LoadActor("inputoverlay-key.png")..{
OnCommand=function(self) self:y(23*3*7.75); end;
R2MessageCommand=function(self) self:stoptweening(); self:linear(0.1); self:zoom(0.85); self:diffuse(color(ColorP2)); end;
R2reMessageCommand=function(self) self:stoptweening(); self:y(23*3*1.25); self:linear(0.1); self:zoom(1); self:diffuse(color("#FFFFFF")); end;
};
LoadFont("_special elite 24px")..{
Text="L"; L2MessageCommand=function(self)
	if GAMESTATE:GetSongBeat() > GAMESTATE:GetCurrentSong():GetFirstBeat() then if not plused5 then
		hitbutton[5] = hitbutton[5] + 1 self:settext(hitbutton[5]) plused5 = true end else
		self:settext("L") end self:stoptweening() :linear(0.1) :zoom(0.85) :diffuse(color("#000000")) end; L2reMessageCommand=function(self) self:stoptweening() :y(-23*3*1.25) :linear(0.1) :zoom(1) :diffuse(color("#000000")) plused5 = false end;
};
LoadFont("_special elite 24px")..{
Text="D"; D2MessageCommand=function(self)
	if GAMESTATE:GetSongBeat() > GAMESTATE:GetCurrentSong():GetFirstBeat() then if not plused6 then
		hitbutton[6] = hitbutton[6] + 1 self:settext(hitbutton[6]) plused6 = true end else
		self:settext("D") end self:stoptweening() :linear(0.1) :zoom(0.85) :diffuse(color("#000000")) end; D2reMessageCommand=function(self) self:stoptweening() :y(-23*1*1.25) :linear(0.1) :zoom(1) :diffuse(color("#000000")) plused6 = false end;
};
LoadFont("_special elite 24px")..{
Text="U"; U2MessageCommand=function(self)
	if GAMESTATE:GetSongBeat() > GAMESTATE:GetCurrentSong():GetFirstBeat() then if not plused7 then
		hitbutton[7] = hitbutton[7] + 1 self:settext(hitbutton[7]) plused7 = true end else
		self:settext("U") end self:stoptweening() :linear(0.1) :zoom(0.85) :diffuse(color("#000000")) end; U2reMessageCommand=function(self) self:stoptweening() :y(-23*-1*1.25) :linear(0.1) :zoom(1) :diffuse(color("#000000")) plused7 = false end;
};
LoadFont("_special elite 24px")..{
Text="R"; R2MessageCommand=function(self)
	if GAMESTATE:GetSongBeat() > GAMESTATE:GetCurrentSong():GetFirstBeat() then if not plused8 then
		hitbutton[8] = hitbutton[8] + 1 self:settext(hitbutton[8]) plused8 = true end else
		self:settext("R") end self:stoptweening() :linear(0.1) :zoom(0.85) :diffuse(color("#000000")) end; R2reMessageCommand=function(self) self:stoptweening() :y(-23*-3*1.25) :linear(0.1) :zoom(1) :diffuse(color("#000000")) plused8 = false end;
};
};
Def.Quad{
InitCommand=function(self) self:zoom(99999); self:diffuse(color("#000000")); self:diffusealpha(0); end;
StopgameMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffusealpha(0.75); end;
contigameMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffusealpha(0); end;
};
LoadFont("_special elite 108px")..{
Text="Pause";
OnCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y*0.5); self:zoom(5); self:diffuse(color("#FFFF00")); self:diffusealpha(0); self:wag(); self:effectmagnitude(0,0,2); self:effectperiod(10); end;
StopgameMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffusealpha(1); self:zoom(1); end;
contigameMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffusealpha(0); self:zoom(5); end;
};
LoadFont("_special elite 24px")..{
Text="-Resume-";
OnCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y-30); self:zoom(5); self:diffuse(color("#E6C8EE")); self:diffusealpha(0); self:wag(); self:effectmagnitude(0,0,-2); self:effectperiod(10); self:effectoffset(1); end;
StopgameMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffusealpha(1); self:zoom(1.5); end;
contigameMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffusealpha(0); self:zoom(5); end;
YestoResumeMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffuse(color("#FFFF00")); self:diffusealpha(1); self:zoom(2); end;
NotoResumeMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffuse(color("#E6C8EE")); self:diffusealpha(1); self:zoom(1.5); end;
};
LoadFont("_special elite 24px")..{
Text="-Retry-";
OnCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y+15); self:zoom(5); self:diffuse(color("#E6C8EE")); self:diffusealpha(0); self:wag(); self:effectmagnitude(0,0,-2); self:effectperiod(10); self:effectoffset(3); end;
StopgameMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffusealpha(1); self:zoom(1.5); end;
contigameMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffusealpha(0); self:zoom(5); end;
YestoRetryMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffuse(color("#FFFF00")); self:diffusealpha(1); self:zoom(2); end;
NotoRetryMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffuse(color("#E6C8EE")); self:diffusealpha(1); self:zoom(1.5); end;
};
LoadFont("_special elite 24px")..{
Text="-Back-";
OnCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y+60); self:zoom(5); self:diffuse(color("#E6C8EE")); self:diffusealpha(0); self:wag(); self:effectmagnitude(0,0,-2); self:effectperiod(10); self:effectoffset(5); end;
StopgameMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffusealpha(1); self:zoom(1.5); end;
contigameMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffusealpha(0); self:zoom(5); end;
YestoBackMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffuse(color("#FFFF00")); self:diffusealpha(1); self:zoom(2); end;
NotoBackMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffuse(color("#E6C8EE")); self:diffusealpha(1); self:zoom(1.5); end;
};
LoadFont("_special elite 24px")..{
Text="Warning : You will restart from first song!";
OnCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y+150); self:zoom(5); self:diffuse(color("#E6C8EE")); self:diffusealpha(0); self:wag(); self:effectmagnitude(0,0,-2); self:effectperiod(10); self:effectoffset(5); end;
CrouseYBackMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffuse(color("#FFFF00")); self:diffusealpha(1); self:zoom(0.75); end;
CrouseNBackMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffuse(color("#E6C8EE")); self:diffusealpha(0); self:zoom(3); end;
};
LoadFont("_special elite 24px")..{
Text="You know you can't pause in mutiplayer,don't you?";
OnCommand=function(self) self:x(SCREEN_CENTER_X-100); self:y(SCREEN_CENTER_Y+180+10); self:diffuse(color("#E6C8EE")); self:diffusealpha(0); end;
MutiMessageCommand=function(self) self:stoptweening(); self:linear(0.25); self:diffuse(color("#E6C8EE")); self:diffusealpha(1); self:y(SCREEN_CENTER_Y+180); self:sleep(2); self:linear(0.25); self:diffusealpha(0); self:y(SCREEN_CENTER_Y+180+10); end;
};
Def.Quad{
InitCommand=function(self) self:zoom(999999); self:diffuse(color("#55555500")); end;
		OnCommand=function(self)
		SCREENMAN:GetTopScreen():AddInputCallback( InputHandler )
			self:playcommand('James')
			pausegroup[1] = 1 --Option
			pausegroup[2] = 0 --it mean process
			pausegroup[3] = 0 --Do once for UP
			pausegroup[4] = 0 --Do once for DOWN
			pausegroup[5] = 0 --Do once for Enter
			pausegroup[6] = 0 --Press kind of Left
			pausegroup[7] = 0 --Press kind of Right
		end;
		JamesCommand=function(self)
		if EmiliaWanttoPause then
		if IsNetConnected() then
		if Neppress[1] == 1 and pausegroup[2] == 0 then
		MESSAGEMAN:Broadcast("Muti")
		pausegroup[2] = 1
		elseif Neppress[1] == 0 and pausegroup [2] == 1 then
		pausegroup[2] = 0
		end
		else
		if Neppress[1] == 1 then
		if pausegroup[2] == 0 then
			pausegroup[2] = 1
		elseif	pausegroup[2] == 2 then
			pausegroup[2] = 3
		end
		
		
			if pausegroup[2] == 1 then
			MESSAGEMAN:Broadcast("Stopgame")
			SCREENMAN:GetTopScreen():PauseGame(true)
		if pausegroup[1] == 1 then
		MESSAGEMAN:Broadcast("YestoResume")
		elseif pausegroup[1] == 2 then
		MESSAGEMAN:Broadcast("YestoRetry")
		if GAMESTATE:IsCourseMode() then
		MESSAGEMAN:Broadcast("CrouseYBack")
		end
		elseif pausegroup[1] == 3 then
		MESSAGEMAN:Broadcast("YestoBack")
		end
			elseif pausegroup[2] == 3 then
			--MESSAGEMAN:Broadcast("Nope") i think silent is Better!
			MESSAGEMAN:Broadcast("contigame")
			SCREENMAN:GetTopScreen():PauseGame(false)
			end
		elseif Neppress[1] == 0 then
		if pausegroup[2] == 1 then
			pausegroup[2] = 2
		elseif	pausegroup[2] == 3 then
			pausegroup[2] = 0
		end
		end
		if Neppress[10] == 1 and pausegroup[5] == 0 and pausegroup[2] == 2 then
		pausegroup[5] = 1
		MESSAGEMAN:Broadcast("Okay")
		if pausegroup[1] == 1 then
			MESSAGEMAN:Broadcast("contigame")
			SCREENMAN:GetTopScreen():PauseGame(false)
			pausegroup = {1,0,0,0,0,0,0}
		elseif pausegroup[1] == 2 then
		GAMESTATE:ApplyGameCommand('screen,ScreenGameplay');--FADE
		MESSAGEMAN:Broadcast("FADE2")
		elseif pausegroup[1] == 3 then
		GAMESTATE:ApplyGameCommand('screen,ScreenSelectMusic');
		MESSAGEMAN:Broadcast("FADE")
		end
		elseif Neppress[10] == 0 and pausegroup[5] == 1 then
			pausegroup[5] = 0
		end
		-- kind of left
		if Neppress[2] == 1 or Neppress[4] == 1 or Neppress[6] == 1 or Neppress[8] == 1 then
			pausegroup[6] = 1
		else 
			pausegroup[6] = 0
		end
		
		-- left
		
		if pausegroup[6] == 1 and pausegroup[3] == 0 and pausegroup[2] == 2 then
		if pausegroup[1] == 1 then
			pausegroup[1] = 3
		else
		pausegroup[1] = pausegroup[1] - 1
		end
		
		pausegroup[3] = 1
		MESSAGEMAN:Broadcast("Arrow")
		if pausegroup[1] == 1 then
		MESSAGEMAN:Broadcast("NotoRetry")
		if GAMESTATE:IsCourseMode() then
		MESSAGEMAN:Broadcast("CrouseNBack")
		end
		MESSAGEMAN:Broadcast("YestoResume")
		elseif pausegroup[1] == 2 then
		MESSAGEMAN:Broadcast("YestoRetry")
		if GAMESTATE:IsCourseMode() then
		MESSAGEMAN:Broadcast("CrouseYBack")
		end
		MESSAGEMAN:Broadcast("NotoBack")
		elseif pausegroup[1] == 3 then
		MESSAGEMAN:Broadcast("YestoBack")
		MESSAGEMAN:Broadcast("NotoResume")
		end
		elseif pausegroup[6] == 0 and pausegroup[3] == 1 then
		pausegroup[3] = 0
		end
		-- kind of right
		if Neppress[3] == 1 or Neppress[5] == 1 or Neppress[7] == 1 or Neppress[9] == 1 then
			pausegroup[7] = 1
		else 
			pausegroup[7] = 0
		end
		
		
		-- right
		
		if pausegroup[7] == 1 and pausegroup[4] == 0 and pausegroup[2] == 2 then
		if pausegroup[1] == 3 then
			pausegroup[1] = 1
		else
		pausegroup[1] = pausegroup[1] + 1
		end
		
		pausegroup[4] = 1
		MESSAGEMAN:Broadcast("Arrow")
		if pausegroup[1] == 1 then
		MESSAGEMAN:Broadcast("NotoBack")
		MESSAGEMAN:Broadcast("YestoResume")
		elseif pausegroup[1] == 2 then
		MESSAGEMAN:Broadcast("YestoRetry")
		MESSAGEMAN:Broadcast("NotoResume")
		if GAMESTATE:IsCourseMode() then
		MESSAGEMAN:Broadcast("CrouseYBack")
		end
		elseif pausegroup[1] == 3 then
		MESSAGEMAN:Broadcast("YestoBack")
		MESSAGEMAN:Broadcast("NotoRetry")
		if GAMESTATE:IsCourseMode() then
		MESSAGEMAN:Broadcast("CrouseNBack")
		end
		end
		
		elseif pausegroup[7] == 0 and pausegroup[4] == 1 then
		pausegroup[4] = 0
		end
		end
		end
		
		self:sleep(0.02)
		self:queuecommand('James')
		end;
};
Def.Quad{
InitCommand=function(self) self:zoom(99999); self:diffuse(color("#000000")); self:diffusealpha(0); end;
FADEMessageCommand=function(self) self:stoptweening(); self:linear(0.5); self:diffusealpha(1); end;
};
Def.Sprite {
	InitCommand=function(self) self:Center(); self:draworder(1001); self:diffusealpha(0); end;
	BeginCommand=function(self) self:LoadFromCurrentSongBackground(); end;
	OnCommand=function(self)
		if PREFSMAN:GetPreference("StretchBackgrounds") then
			self:SetSize(SCREEN_WIDTH,SCREEN_HEIGHT)
		else
			self:scale_or_crop_background()
		end
		self:linear(1)
		self:addy(SCREEN_CENTER_Y)
		self:diffusealpha(0)
		self:rotationx(p*360)
		self:zoom(0.5)
	end;
	FADE2MessageCommand=function(self) self:stoptweening(); self:linear(0.5); self:diffusealpha(1); end;
};
LoadFont("_special elite 24px")..{
InitCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y+60); self:zoom(2); self:rainbow(); self:diffusealpha(0.5); end;
		OnCommand=function(self) self:playcommand('Emilia'); end;
		EmiliaCommand=function(self)
		if GAMESTATE:GetCurMusicSeconds() >= GAMESTATE:GetCurrentSong():GetLastSecond() then
		EmiliaWanttoPause = false
		elseif STATSMAN:GetCurStageStats():AllFailed() then
		EmiliaWanttoPause = false
		else
		EmiliaWanttoPause = true
		end
		player = Var "Player";
		--STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1) = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_1);
		--allYey = GAMESTATE:GetCurrentSteps(PLAYER_1):GetRadarValues(PLAYER_1);
		self:settext(player)
		--self:settext(FormatPercentScore(((STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()*100)*(allYey/(STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_Miss')+STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W5')+STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W4')+STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W3')+STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W2')+STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W1')))/100)))
		self:sleep(0.02)
		self:queuecommand("Emilia")
		end;
};
LoadFont("_special elite 24px")..{
InitCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y+60); self:zoom(2); self:rainbow(); self:diffusealpha(1); self:playcommand("Debuggg"); end;
		DebugggCommand=function(self)
		--self:x(SCREENMAN:GetTopScreen():GetChild('ScoreP1'):GetX())
		--[[for i=1,GAMESTATE:GetCurrentCourse():GetEstimatedNumStages() do
			courseTEST[i] = GAMESTATE:GetCurrentCourse():GetCourseEntry(i):GetSong():GetDisplayMainTitle()
		end
		found = FindInTable(GAMESTATE:GetCurrentSong():GetDisplayMainTitle(),courseTEST)
		self:settext(courseTEST[1])]]
		self:sleep(0.05)
		self:queuecommand("Debuggg")
		--self:settext(FormatPercentScore(((STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()*100)*(allYey/(STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_Miss')+STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W5')+STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W4')+STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W3')+STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W2')+STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W1')))/100)))
		end;
};
LoadFont("_special elite 24px")..{
InitCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y+60+50); self:zoom(2); self:rainbow(); self:diffusealpha(1); end;
		OnCommand=function(self)
		--self:x(SCREENMAN:GetTopScreen():GetChild('ScoreP1'):GetX())
		for i=1,GAMESTATE:GetCurrentCourse():GetEstimatedNumStages() do
			courseTEST[i] = GAMESTATE:GetCurrentCourse():GetCourseEntry(i-1):GetSong():GetDisplayMainTitle()
		end
		found = FindInTable(GAMESTATE:GetCurrentSong():GetDisplayMainTitle(),courseTEST)
		self:settext(found)
		--self:settext(FormatPercentScore(((STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()*100)*(allYey/(STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_Miss')+STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W5')+STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W4')+STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W3')+STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W2')+STATSMAN:GetCurStageStats(1):GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W1')))/100)))
		end;
};
		LoadActor( THEME:GetPathS("Common","start") )..{
			OkayMessageCommand=function(self) self:play(); end;
		};
		LoadActor( THEME:GetPathS("Common","cancel") )..{
			NopeMessageCommand=function(self) self:play(); end;
		};
		LoadActor( THEME:GetPathS("Common","value") )..{
			ArrowMessageCommand=function(self) self:play(); end;
		};
		Def.ActorFrame{
			OnCommand=function(self) self:y(SCREEN_BOTTOM-40); end;
Def.ActorFrame{
	OnCommand=function(self) self:x(SCREEN_CENTER_X); self:y(-30); self:diffusealpha(0); self:zoomx(0); self:sleep(0.15+0.15+0.15+0.15+0.15+0.15+2+3); self:diffusealpha(1); self:linear(0.11126465746435357); self:zoomx(1); end;
		LoadFont(TextF) .. {
			OnCommand=function(self) self:diffuse(color("#ff1100")); self:playcommand("Update"); end;
			CurrentSongChangedMessageCommand=function(self) self:playcommand("Update"); end;
			UpdateCommand=function(self)
				local text = ""
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				if song then
					text = song:GetDisplayFullTitle()
					self:y(20)
				end
				if course then
					text = course:GetDisplayFullTitle() .. " \n " .. text;
				end
				self:settext(string.upper(text));
			end;
		};
};
	};	
	LoadActor("Time.lua")..{
		OnCommand=function(self) end;
	};
	LoadFont("_special elite 108px")..{
			OnCommand=function(self) self:x(SCREEN_CENTER_X-90); self:y(SCREEN_BOTTOM-20); self:zoom(0.25); self:diffuse(color("#FF8800")); self:diffusebottomedge(ColorDarkTone(color("#FF8800"))); self:diffusetopedge(ColorLightTone(color("#FF8800"))); end;
			JudgmentMessageCommand=function(self)
			self:settext(P1Sc)
		if  (STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints() >= STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints() and Isbattle and not HiddenScore) or (HiddenScore and Isbattle) then
		self:pulse()
		self:effecttiming(0.25,0.25,0.25,0.25);
		self:effectmagnitude(1,1.25,1)
		self:effectclock("beat")
		else
		self:stopeffect()
		end
			end;
	};
	LoadFont("_special elite 108px")..{
			OnCommand=function(self) self:x(SCREEN_CENTER_X+90); self:y(SCREEN_BOTTOM-20); self:zoom(0.25); self:diffuse(color("#FF8800")); self:diffusebottomedge(ColorDarkTone(color("#FF8800"))); self:diffusetopedge(ColorLightTone(color("#FF8800"))); end;
			JudgmentMessageCommand=function(self)
			self:settext(P2Sc)
		if  (STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints() >= STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints() and Isbattle and not HiddenScore) or (HiddenScore and Isbattle) then
		self:pulse()
		self:effecttiming(0.25,0.25,0.25,0.25);
		self:effectmagnitude(1,1.25,1)
		self:effectclock("beat")
		else
		self:stopeffect()
		end
			self:sleep(0.02)
			self:queuecommand("Blanc")
			end;
	};
Def.ActorFrame{
	OnCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y+100); self:zoom(1.5); self:diffusealpha(0); self:playcommand("Hae"); end;
	HaeCommand=function(self)
	if ((GAMESTATE:GetPlayerState(PLAYER_1):GetCurrentPlayerOptions():DrainSetting() == "DrainType_SuddenDeath" and GAMESTATE:IsPlayerEnabled(PLAYER_1)) or (GAMESTATE:GetPlayerState(PLAYER_2):GetCurrentPlayerOptions():DrainSetting() == "DrainType_SuddenDeath" and GAMESTATE:IsPlayerEnabled(PLAYER_2))) then
		if GAMESTATE:GetCurrentSong():GetFirstSecond() >= GAMESTATE:GetCurMusicSeconds() then
		Wario[1] = GAMESTATE:GetCurrentSong():GetLastSecond() - GAMESTATE:GetCurrentSong():GetFirstSecond()
		else
		Wario[1] = math.max(GAMESTATE:GetCurrentSong():GetLastSecond() - GAMESTATE:GetCurMusicSeconds(),0)
		end
		Wario[2] = math.floor(Wario[1]/60)
		Wario[3] = math.floor((Wario[1] - Wario[2]*60)/10)
		Wario[4] = math.floor(Wario[1] - (Wario[2]*60 + Wario[3]*10))
		if GAMESTATE:GetSongBeat() >= start-8 and GAMESTATE:GetSongBeat() <= start-5 then
		self:y(SCREEN_CENTER_Y+100)
		self:linear(0.25)
		self:diffusealpha(1)
		elseif GAMESTATE:GetSongBeat() >= start-5 and GAMESTATE:GetSongBeat() <= start-4 then
		self:linear(0.25)
		self:y(SCREEN_CENTER_Y-130)
		self:zoom(1)
		elseif GAMESTATE:GetSongBeat() >= start+4 then
		self:linear(0.25)
		self:y(SCREEN_CENTER_Y-130)
		self:zoom(1)
		end
		if Wario[1] <= 30 and Wario[1] > 10 then
		self:diffuse(color("#FFFF00"))
		elseif Wario[1] <= 10 then
		self:diffuse(color("#FF0000"))
		end
	elseif GAMESTATE:GetCurrentCourse():IsNonstop() then
	Wario[1] = SCREENMAN:GetTopScreen():GetNextCourseSong():GetLastSecond()
	if Wario[1] - math.floor(Wario[1]) < 0.5 then
		Wario[1] = Wario[1] + 0.5
	end
		Wario[2] = math.floor(Wario[1]/60)
		Wario[3] = math.floor((Wario[1] - Wario[2]*60)/10)
		Wario[4] = math.floor(Wario[1] - (Wario[2]*60 + Wario[3]*10))
		if GAMESTATE:GetSongBeat() >= GAMESTATE:GetCurrentSong():GetLastBeat()-16 and FindInTable(GAMESTATE:GetCurrentSong():GetDisplayMainTitle(),courseTEST) < GAMESTATE:GetCurrentCourse():GetEstimatedNumStages() then
			self:y(SCREEN_CENTER_Y-130)
			self:linear(0.5)
			self:diffusealpha(1)
		else
			self:diffusealpha(0)
		end
	end
		if ((GAMESTATE:GetPlayerState(PLAYER_1):GetCurrentPlayerOptions():DrainSetting() == "DrainType_SuddenDeath" and GAMESTATE:IsPlayerEnabled(PLAYER_1)) or (GAMESTATE:GetPlayerState(PLAYER_2):GetCurrentPlayerOptions():DrainSetting() == "DrainType_SuddenDeath" and GAMESTATE:IsPlayerEnabled(PLAYER_2))) or GAMESTATE:GetCurrentCourse():IsNonstop() then
	self:sleep(0.1)
	self:queuecommand("Hae")
		else
		self:diffusealpha(0)
		end
	end;
Def.ActorFrame{
	OnCommand=function(self)
	if GAMESTATE:GetCurrentCourse():IsNonstop() then
		self:pulse()
		self:effecttiming(0.25,0.25,0.25,0.25);
		self:effectmagnitude(1,1.25,1)
		self:effectclock("beat")
	end
	end;
	LoadActor("WarioTime")..{
		OnCommand=function(self) self:x(50); self:zoom(0.25); self:playcommand("Wa"); end;
		WaCommand=function(self)
		self:animate(false)
		self:setstate(Wario[4])
		self:sleep(0.1)
		self:queuecommand("Wa")
		end;
	};
	LoadActor("WarioTime")..{
		OnCommand=function(self) self:x(25); self:zoom(0.25); self:playcommand("ri"); end;
		riCommand=function(self)
		self:animate(false)
		self:setstate(Wario[3])
		self:sleep(0.1)
		self:queuecommand("ri")
		end;
	};
	LoadActor("WarioTime")..{
		OnCommand=function(self) self:x(-25); self:zoom(0.25); self:playcommand("OO"); end;
		OOCommand=function(self)
		self:animate(false)
		self:setstate(Wario[2])
		self:sleep(0.1)
		self:queuecommand("OO")
		end;
	};
};
	LoadActor("Ticktock")..{
		OnCommand=function(self) self:zoom(0.25); self:playcommand("OO"); end;
		OOCommand=function(self)
		self:animate(false)
		if ( Wario[1] - math.floor(Wario[1]) >= 0.5) or (GAMESTATE:GetCurrentSong():GetFirstSecond() >= GAMESTATE:GetCurMusicSeconds()) then
			self:setstate(1)
		else
			self:setstate(0)
		end
		self:sleep(0.1)
		self:queuecommand("OO")
		end;
	};
};
	--[[
LoadActor("Ready.png")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:diffusealpha(0); end;
		OnCommand=function(self) self:playcommand('James'); end;
		JamesCommand=function(self)
		if GAMESTATE:GetSongBeat() >= start-8 and GAMESTATE:GetSongBeat() <= start-5 and toii == 0 then
		self:linear(0.25)
		self:diffusealpha(1)
		toii = 1
		elseif GAMESTATE:GetSongBeat() >= start-5 and GAMESTATE:GetSongBeat() <= start-4 and toii == 1 then
		self:linear(0.25)
		self:diffusealpha(0)
		toii = 2
		elseif GAMESTATE:GetSongBeat() >= start+4 then
		self:linear(0.25)
		self:diffusealpha(0)
		end
		
		self:sleep(0.02)
		if GAMESTATE:GetSongBeat() < start+4 then
		self:queuecommand('James')
		end
		end;
};]]
		
};
return t