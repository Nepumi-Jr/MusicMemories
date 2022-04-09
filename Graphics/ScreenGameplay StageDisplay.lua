--[[local curScreen = Var "LoadingScreen";
local curStage = GAMESTATE:GetCurrentStage();
local curStageIndex = GAMESTATE:GetCurrentStageIndex();
local playMode = GAMESTATE:GetPlayMode();

local tRemap = {
	Stage_1st		= 1,
	Stage_2nd		= 2,
	Stage_3rd		= 3,
	Stage_4th		= 4,
	Stage_5th		= 5,
	Stage_6th		= 6,
};
if tRemap[curStage] == PREFSMAN:GetPreference("SongsPerPlay") then
	curStage = "Stage_Final";
end

local t = Def.ActorFrame {
	LoadActor(THEME:GetPathB("_frame","3x3"),"rounded black",64,16);
	LoadFont("Common Normal") .. {
		InitCommand=function(self) self:y(-1); self:shadowlength(1); self:playcommand("Set"); end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set"); end;
		CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set"); end;
		CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
		CurrentStepsP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
		CurrentTraiP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
		CurrentTraiP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
		SetCommand=function(self)
			if GAMESTATE:IsCourseMode() then
				local stats = STATSMAN:GetCurStageStats()
				if not stats then
					return
				end
				local mpStats = stats:GetPlayerStageStats( GAMESTATE:GetMasterPlayerNumber() )
				local songsPlayed = mpStats:GetSongsPassed() + 1
				self:settextf("%i / %i", songsPlayed, GAMESTATE:GetCurrentCourse():GetEstimatedNumStages());
			else
				if GAMESTATE:IsEventMode() then
					self:settextf("Stage %s", curStageIndex+1);
				else
					if THEME:GetMetric(curScreen,"StageDisplayUseShortString") then
						self:settextf("%s", ToEnumShortString(curStage));
					else
						self:settextf("%s Stage", ToEnumShortString(curStage));
					end
				end
			end;
			self:zoom(0.675);
			self:diffuse(StageToColor(curStage));
			self:diffusetopedge(ColorLightTone(StageToColor(curStage)));
		end;
	};
};
return t]] --I hate you

