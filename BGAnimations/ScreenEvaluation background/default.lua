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
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;finishtweening;queuecommand,"ModifySongBackground");
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
if GAMESTATE:GetCurrentSong():GetDisplayMainTitle() == "Ring of Fortune" then
	t[#t+1] = LoadActor("IslaChan") .. {
		OnCommand=cmd(play);
	};

elseif string.match( string.lower(GAMESTATE:GetCurrentSong():GetDisplayFullTitle()), "megalovania") and STATSMAN:GetCurStageStats():AllFailed() then
	t[#t+1] = LoadActor("dog") .. {
		OnCommand=cmd(play);
	};
	t[#t+1] = LoadActor("fail-background")..{
		Condition =(string.match( PN_Name(PLAYER_1), "Isla") or string.match( PN_Name(PLAYER_2), "Isla"));
		InitCommand=cmd(FullScreen);
	};
elseif TP.Battle.IsBattle then
	t[#t+1] = LoadActor("Battle") .. {
		OnCommand=cmd(play);
	};
elseif STATSMAN:GetCurStageStats():AllFailed() then
	t[#t+1] = LoadActor("Plastic Memories - OST - What do you say") .. {
		OnCommand=cmd(play);
	};
	t[#t+1] = Def.Quad {
		InitCommand=cmd(Center;scaletoclipped,SCREEN_WIDTH+1,SCREEN_HEIGHT);
		OnCommand=cmd(rainbow;diffusealpha,0.1);
	};

	t[#t+1] = LoadActor("fail-background")..{
		Condition =(string.match( PN_Name(PLAYER_1), "Isla") or string.match( PN_Name(PLAYER_2), "Isla"));
		InitCommand=cmd(FullScreen);
	};
elseif OMW == "ISLA" or OMW == "BEAT" or OMW == "WOW" then
	--[[if URDOURBEST1 and URDOURBEST2 and IM then
		t[#t+1] = LoadActor("Plastic Memories - OST - Bye") .. {
			OnCommand=cmd(play);
		};
	else]]
		t[#t+1] = LoadActor("IslaChan") .. {
			OnCommand=cmd(play);
		};
	--end
else
	t[#t+1] = LoadActor("Plastic Memories OST 2 - 012 Changing mind") .. {
		OnCommand=cmd(play);
	};
	t[#t+1] = Def.Quad {
		InitCommand=cmd(Center;scaletoclipped,SCREEN_WIDTH+1,SCREEN_HEIGHT);
		OnCommand=cmd(diffuse,color("#FFFFFF");diffusebottomedge,color("#DDDDDD");diffusealpha,0.1);
	};

end
	t[#t+1]=LoadActor("Parti")..{
		Condition =(string.match( PN_Name(PLAYER_1), "Isla") or string.match( PN_Name(PLAYER_2), "Isla"));
		InitCommand=cmd(FullScreen;blend,'BlendMode_Add');
	};


return t
