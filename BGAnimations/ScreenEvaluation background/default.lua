 local nep = 0;
local check = false;
local checkM = false;
local psss1 = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_1)
local psss2 = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_2)
local percentP1;
local percentP2;

local OMW = LoadModule("Eva.StateTier.lua")();
--OMW = "WOW";

local URDOURBEST1 = true;
local URDOURBEST2 = true;


local Content1 = {};
local Content2 = {};
local ISMISSION1 = false;
local ISMISSION2 = false;
local IM = false;

if not GAMESTATE:IsCourseMode() then
	local path=GAMESTATE:GetCurrentSong():GetSongDir();
	if path then
		if FILEMAN:DoesFileExist(path.."MissionTag.lua") then
			LoadActor("../../../../"..path.."MissionTag");
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) and PnMissionState(PLAYER_1,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)) ~= "NotMission" then
				ISMISSION1 = true;
			end
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) and PnMissionState(PLAYER_2,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)) ~= "NotMission" then
				ISMISSION2 = true;
			end
		end
	end
end

if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	--[[if ISMISSION1 then
		--table.insert( Content1,"MISSION_"..PnMissionState(PLAYER_1,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)));
		OMW = true;
		if PnMissionState(PLAYER_1,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)) == "FAIL" then
			URDOURBEST1 = true;
		else 
			
			URDOURBEST1 = false;
		end
		IM = true;
	else
		URDOURBEST1 = true;
	end]]
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPeakComboAward() then
		--OMW = true;
		--TGO("YEY");
	end
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetStageAward() then
		--OMW = true;
		--TGO("OMW");
	end
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPersonalHighScoreIndex() then
		if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPersonalHighScoreIndex() == 0 then
			--ISLA_PQ_PUSH({2,"New Personal Record"});
			--TGO("YEY");
		end
	end
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetMachineHighScoreIndex() then
		if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetMachineHighScoreIndex() == 0 then
			--ISLA_PQ_PUSH({5,"New Machine Record"});
			--TGO("YEY");
		end
	end
	local ppn = PLAYER_1
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(ppn):GetTapNoteScores("TapNoteScore_Miss") + STATSMAN:GetCurStageStats():GetPlayerStageStats(ppn):GetTapNoteScores("TapNoteScore_W5")+ STATSMAN:GetCurStageStats():GetPlayerStageStats(ppn):GetTapNoteScores("TapNoteScore_W4") == 1 then
		--TGO("OMW");
	end
end

if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	--[[if ISMISSION2 then
		--table.insert( Content2,"MISSION_"..PnMissionState(PLAYER_2,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)));
		OMW = true;
		if PnMissionState(PLAYER_2,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)) == "FAIL" then
			URDOURBEST2 = true;
		else 
			URDOURBEST2 = false;
		end
		IM = true;
	else
		URDOURBEST2 = true;
	end]]
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPeakComboAward() then
		--table.insert( Content2,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPeakComboAward());
		--TGO("YEY");
	end
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetStageAward() then
		--table.insert( Content2,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetStageAward());
		--TGO("OMW");
	end
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPersonalHighScoreIndex() then
		if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPersonalHighScoreIndex() == 0 then
			--ISLA_PQ_PUSH({2,"New Personal Record"});
			--TGO("YEY");
		end
	end
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetMachineHighScoreIndex() then
		if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetMachineHighScoreIndex() == 0 then
			--ISLA_PQ_PUSH({5,"New Machine Record"});
			--TGO("YEY");
		end
	end
	local ppn = PLAYER_2
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(ppn):GetTapNoteScores("TapNoteScore_Miss") + STATSMAN:GetCurStageStats():GetPlayerStageStats(ppn):GetTapNoteScores("TapNoteScore_W5")+ STATSMAN:GetCurStageStats():GetPlayerStageStats(ppn):GetTapNoteScores("TapNoteScore_W4") == 1 then
		--TGO("YEY");
	end
end




percentP1 = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()
percentP2 = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()
local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame {
	Def.Sprite {
		OnCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:finishtweening(); self:queuecommand("ModifySongBackground"); end;
		ModifySongBackgroundCommand=function(self)
			if GAMESTATE:GetCurrentSong() then
				if GAMESTATE:GetCurrentSong():GetBackgroundPath() then
					self:visible(true);
					self:LoadBackground(GAMESTATE:GetCurrentSong():GetBackgroundPath());
					self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
				else
					self:visible(false);
				end;
			else
				self:visible(false);
			end;
		end;	
	};


	};
	t[#t+1] = LoadActor("BlurBG.lua");

if STATSMAN:GetCurStageStats():AllFailed() then
	t[#t+1] = Def.Quad {
		InitCommand=function(self) self:Center(); self:scaletoclipped(SCREEN_WIDTH+1,SCREEN_HEIGHT); end;
		OnCommand=function(self) self:rainbow(); self:diffusealpha(0.1); end;
	};

	t[#t+1] = LoadActor("fail-background")..{
		Condition =(string.match( getPlayerName(PLAYER_1), "Isla") or string.match( getPlayerName(PLAYER_2), "Isla"));
		InitCommand=function(self) self:FullScreen(); end;
	};
else
	t[#t+1] = Def.Quad {
		InitCommand=function(self) self:Center(); self:scaletoclipped(SCREEN_WIDTH+1,SCREEN_HEIGHT); end;
		OnCommand=function(self) self:diffuse(color("#FFFFFF")); self:diffusebottomedge(color("#DDDDDD")); self:diffusealpha(0.1); end;
	};

end
	t[#t+1]=LoadActor("Parti")..{
		Condition =(string.match( getPlayerName(PLAYER_1), "Isla") or string.match( getPlayerName(PLAYER_2), "Isla"));
		InitCommand=function(self) self:FullScreen(); self:blend('BlendMode_Add'); end;
	};


return t
