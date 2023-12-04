local t = LoadFallbackB();
-- Legacy StepMania 4 Function
local function StepsDisplay(pn)
	local function set(self, player)
		self:SetFromGameState( player );
	end

	local t = Def.StepsDisplay {
		InitCommand=function(self) self:Load("StepsDisplay",GAMESTATE:GetPlayerState(pn)); end;
	};

	if pn == PLAYER_1 then
		t.CurrentStepsP1ChangedMessageCommand=function(self) set(self, pn); end;
		t.CurrentTrailP1ChangedMessageCommand=function(self) set(self, pn); end;
	else
		t.CurrentStepsP2ChangedMessageCommand=function(self) set(self, pn); end;
		t.CurrentTrailP2ChangedMessageCommand=function(self) set(self, pn); end;
	end

	return t;
end
t[#t+1] = StandardDecorationFromFileOptional("AlternateHelpDisplay","AlternateHelpDisplay");

local function PercentScore(pn)
	local t = LoadFont("Common normal")..{
		InitCommand=function(self) self:zoom(0.625); self:shadowlength(1); end;
		BeginCommand=function(self) self:playcommand("Set"); end;
		SetCommand=function(self)
			local SongOrCourse, StepsOrTrail;
			if GAMESTATE:IsCourseMode() then
				SongOrCourse = GAMESTATE:GetCurrentCourse();
				StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
				StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
			end;

			local profile, scorelist;
			local text = "";
			if SongOrCourse and StepsOrTrail then
				local st = StepsOrTrail:GetStepsType();
				local diff = StepsOrTrail:GetDifficulty();
				local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
				local cd = GetCustomDifficulty(st, diff, courseType);
				self:diffuse(CustomDifficultyToColor(cd));
				self:shadowcolor(CustomDifficultyToDarkColor(cd));

				if PROFILEMAN:IsPersistentProfile(pn) then
					-- player profile
					profile = PROFILEMAN:GetProfile(pn);
				else
					-- machine profile
					profile = PROFILEMAN:GetMachineProfile();
				end;

				scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
				assert(scorelist)
				local scores = scorelist:GetHighScores();
				local topscore = scores[1];
				if topscore then
					text = string.format("%.2f%%", topscore:GetPercentDP()*100.0);
					-- 100% hack
					if text == "100.00%" then
						text = "100%";
					end;
				else
					text = string.format("%.2f%%", 0);
				end;
			else
				text = "";
			end;
			self:settext(text);
		end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set"); end;
		CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set"); end;
	};

	if pn == PLAYER_1 then
		t.CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
		t.CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
	else
		t.CurrentStepsP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
		t.CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
	end

	return t;
end

-- Legacy StepMania 4 Function
for pn in ivalues(PlayerNumber) do
	local MetricsName = "StepsDisplay" .. PlayerNumberToString(pn);
	t[#t+1] = StepsDisplay(pn) .. {
		InitCommand=function(self) self:player(pn); self:name(MetricsName); ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen"); end;
		PlayerJoinedMessageCommand=function(self, params)
			if params.Player == pn then
				self:visible(true);
				(function(self) self:zoom(0); self:bounceend(0.3); self:zoom(1); end)(self);
			end;
		end;
		PlayerUnjoinedMessageCommand=function(self, params)
			if params.Player == pn then
				self:visible(true);
				(function(self) self:bouncebegin(0.3); self:zoom(0); end)(self);
			end;
		end;
	};
	if ShowStandardDecoration("PercentScore"..ToEnumShortString(pn)) then
		t[#t+1] = StandardDecorationFromTable("PercentScore"..ToEnumShortString(pn), PercentScore(pn));
	end;
end


t[#t+1] = StandardDecorationFromFileOptional("BannerFrame","BannerFrame");
t[#t+1] = StandardDecorationFromFileOptional("PaneDisplayFrameP1","PaneDisplayFrame");
t[#t+1] = StandardDecorationFromFileOptional("PaneDisplayFrameP2","PaneDisplayFrame");
t[#t+1] = StandardDecorationFromFileOptional("PaneDisplayTextP1","PaneDisplayTextP1");
t[#t+1] = StandardDecorationFromFileOptional("PaneDisplayTextP2","PaneDisplayTextP2");
t[#t+1] = StandardDecorationFromFileOptional("DifficultyList","DifficultyList");

t[#t+1] = StandardDecorationFromFileOptional("BPMDisplay","BPMDisplay");
t[#t+1] = StandardDecorationFromFileOptional("BPMLabel","BPMLabel");
t[#t+1] = StandardDecorationFromFileOptional("SegmentDisplay","SegmentDisplay");

t[#t+1] = StandardDecorationFromFileOptional("SongTime","SongTime") .. {
	SetCommand=function(self)
		local curSelection = nil;
		local length = 0.0;
		if GAMESTATE:IsCourseMode() then
			curSelection = GAMESTATE:GetCurrentCourse();
			self:playcommand("Reset");
			if curSelection then
				local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber());
				if trail then
					length = TrailUtil.GetTotalSeconds(trail);
				else
					length = 0.0;
				end;
			else
				length = 0.0;
			end;
		else
			curSelection = GAMESTATE:GetCurrentSong();
			self:playcommand("Reset");
			if curSelection then
				length = curSelection:MusicLengthSeconds();
				if curSelection:IsLong() then
					self:playcommand("Long");
				elseif curSelection:IsMarathon() then
					self:playcommand("Marathon");
				else
					self:playcommand("Reset");
				end
			else
				length = 0.0;
				self:playcommand("Reset");
			end;
		end;
		self:settext( SecondsToMSS(length) );
	end;
	CurrentSongChangedMessageCommand=function(self) self:playcommand("Set"); end;
	CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set"); end;
	CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
	CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
}

if not GAMESTATE:IsCourseMode() then
	local function CDTitleUpdate(self)
		local song = GAMESTATE:GetCurrentSong();
		local cdtitle = self:GetChild("CDTitle");
		local height = cdtitle:GetHeight();
		
		if song then
			if song:HasCDTitle() then
				cdtitle:visible(true);
				cdtitle:Load(song:GetCDTitlePath());
			else
				cdtitle:visible(false);
			end;
		else
			cdtitle:visible(false);
		end;
		
		self:zoom(scale(height,32,480,1,32/480))
	end;
	t[#t+1] = Def.ActorFrame {
		OnCommand=function(self) self:draworder(105); self:x(SCREEN_CENTER_X-295); self:y(SCREEN_CENTER_Y-145); self:rotationz(-5); self:zoom(0); self:sleep(0.5); self:decelerate(0.25); self:thump():effectmagnitude(0.5,0.55,0); self:effectclock("beat"); self:SetUpdateFunction(CDTitleUpdate); end;
		OffCommand=function(self) self:bouncebegin(0.15); self:zoomx(0); end;
		Def.Sprite {
			Name="CDTitle";
			OnCommand=function(self) self:draworder(106); self:shadowlength(1); self:zoom(0.75); self:diffusealpha(1); self:zoom(0); self:bounceend(0.35); self:zoom(0.75); end;
			BackCullCommand=function(self) self:diffuse(color("0.5,0.5,0.5,1")); end;
		};	
	};
	t[#t+1] = StandardDecorationFromFileOptional("NewSong","NewSong") .. {
	-- 	ShowCommand=THEME:GetMetric(Var "LoadingScreen", "NewSongShowCommand" );
	-- 	HideCommand=THEME:GetMetric(Var "LoadingScreen", "NewSongHideCommand" );
		InitCommand=function(self) self:playcommand("Set"); end;
		BeginCommand=function(self) self:playcommand("Set"); end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set"); end;
		SetCommand=function(self)
	-- 		local pTargetProfile;
			local sSong;
			-- Start!
			if GAMESTATE:GetCurrentSong() then
				if PROFILEMAN:IsSongNew(GAMESTATE:GetCurrentSong()) then
					self:playcommand("Show");
				else
					self:playcommand("Hide");
				end
			else
				self:playcommand("Hide");
			end
		end;
	};
	t[#t+1] = StandardDecorationFromFileOptional("StageDisplay","StageDisplay");
	t[#t+1] = Def.ActorFrame{
		InitCommand=function(self) self:playcommand("Set"); end;
		BeginCommand=function(self) self:playcommand("Set"); end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set"); end;
		SetCommand=function(self)
			local isLyric = false;
			-- Start!
			if GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong():HasLyrics() then
				isLyric = true;
			end

			self:visible(isLyric);
		end;
		LoadFont("LyricDisplay text")..{
			Text = THEME:GetString("ScreenSelectMusic","haslyrics");
			InitCommand = function(self)
				self:xy(SCREEN_CENTER_X - 55, SCREEN_CENTER_Y-60):zoom(0.6):horizalign(right)
				self:diffuse({0.5, 0.5, 0.5, 1}):strokecolor({0.2, 0.2, 0.2, 1}):textglowmode("TextGlowMode_Stroke");
			end;
		};
		LoadFont("LyricDisplay text")..{
			Text = THEME:GetString("ScreenSelectMusic","haslyrics");
			InitCommand = function(self)
				self:xy(SCREEN_CENTER_X - 55, SCREEN_CENTER_Y-60):zoom(0.6):horizalign(right)
				self:strokecolor(ColorTone({1,1,1,1})):textglowmode("TextGlowMode_Stroke");
			end;
			OnCommand = function(self)
				self:cropright(1):diffusealpha(1):sleep(0.2):linear(0.5):cropright(0):sleep(0.2):linear(0.3):diffusealpha(0):queuecommand("On");
			end;
		};
	};
end;

if GAMESTATE:IsCourseMode() then
	t[#t+1] = Def.ActorFrame {
		Def.Quad {
			InitCommand=function(self) self:x(THEME:GetMetric(Var "LoadingScreen","CourseContentsListX")); self:y(THEME:GetMetric(Var "LoadingScreen","CourseContentsListY") - 118); self:zoomto(256+32,192); end;
			OnCommand=function(self) self:diffuse(Color.Green); self:MaskSource(); end;
		};
		Def.Quad {
			InitCommand=function(self) self:x(THEME:GetMetric(Var "LoadingScreen","CourseContentsListX")); self:y(THEME:GetMetric(Var "LoadingScreen","CourseContentsListY") + 186); self:zoomto(256+32,64); end;
			OnCommand=function(self) self:diffuse(Color.Blue); self:MaskSource(); end;
		};
	};
	t[#t+1] = StandardDecorationFromFileOptional("CourseContentsList","CourseContentsList");
	t[#t+1] = StandardDecorationFromFileOptional("NumCourseSongs","NumCourseSongs")..{
		InitCommand=function(self) self:horizalign(right); end;
		SetCommand=function(self)
			local curSelection= nil;
			local sAppend = "";
			if GAMESTATE:IsCourseMode() then
				curSelection = GAMESTATE:GetCurrentCourse();
				if curSelection then
					sAppend = (curSelection:GetEstimatedNumStages() == 1) and "Stage" or "Stages";
					self:visible(true);
					self:settext( curSelection:GetEstimatedNumStages() .. " " .. sAppend);
				else
					self:visible(false);
				end;
			else
				self:visible(false);
			end;
		end;
		CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set"); end;
	};
end

t[#t+1] = StandardDecorationFromFileOptional("DifficultyDisplay","DifficultyDisplay");

t[#t+1] = StandardDecorationFromFileOptional("SortOrder","SortOrderText") .. {
	BeginCommand=function(self) self:playcommand("Set"); end;
	SortOrderChangedMessageCommand=function(self) self:playcommand("Set"); end;
	SetCommand=function(self)
		local s = GAMESTATE:GetSortOrder()
		if s ~= nil then
			local s = SortOrderToLocalizedString( s )
			self:GetChild("DisplayText")
			:finishtweening():settext( s ):x(10):diffusealpha(0):decelerate(0.3):diffusealpha(1):x(30)
			
			self:GetChild("Icon")
			:finishtweening():x(0):diffusealpha(0):decelerate(0.3):x(5):diffusealpha(1)
			self:GetChild("BG")
			:finishtweening():decelerate(0.6):zoomto( (self:GetChild("DisplayText"):GetWidth()+30)/0.8, 40 )
			self:playcommand("Sort")
		else
			return
		end
	end;
};


t[#t+1] = StandardDecorationFromFileOptional("SongOptionsFrame","SongOptionsFrame") .. {
    ShowPressStartForOptionsCommand=function(self) self:visible(true); self:diffuse(color("#555555")); self:fadeleft(0.3); self:cropleft(1); self:decelerate(0.5); self:cropleft(0); self:fadeleft(0); end;
    ShowEnteringOptionsCommand=function(self) self:sleep(0.5); self:decelerate(0.3); self:faderight(0.3); self:cropright(1); end;
	HidePressStartForOptionsCommand=function(self) self:decelerate(0.3); self:faderight(0.3); self:cropright(1); end;
};
t[#t+1] = StandardDecorationFromFileOptional("SongOptionsFrame","SongOptionsFrame") .. {
    ShowPressStartForOptionsCommand=function(self) self:visible(true); self:diffuse(GameColor.PlayerColors.PLAYER_1 or {1,0,0,1}); self:zoomy(3); self:y(SCREEN_CENTER_Y+36); self:fadeleft(0.3); self:cropleft(1); self:decelerate(0.5); self:cropleft(0); self:fadeleft(0); end;
    ShowEnteringOptionsCommand=function(self) self:sleep(0.5); self:decelerate(0.3); self:faderight(0.3); self:cropright(1); end;
	HidePressStartForOptionsCommand=function(self) self:decelerate(0.3); self:faderight(0.3); self:cropright(1); end;
};
t[#t+1] = StandardDecorationFromFileOptional("SongOptionsFrame","SongOptionsFrame") .. {
    ShowPressStartForOptionsCommand=function(self) self:visible(true); self:diffuse(GameColor.PlayerColors.PLAYER_2 or {0,1,0,1}); self:zoomy(3); self:y(SCREEN_CENTER_Y-36); self:fadeleft(0.3); self:cropleft(1); self:decelerate(0.5); self:cropleft(0); self:fadeleft(0); end;
    ShowEnteringOptionsCommand=function(self) self:sleep(0.5); self:decelerate(0.3); self:faderight(0.3); self:cropright(1); end;
	HidePressStartForOptionsCommand=function(self) self:decelerate(0.3); self:faderight(0.3); self:cropright(1); end;
};
t[#t+1] = StandardDecorationFromFileOptional("SongOptions","SongOptionsText") .. {
	ShowPressStartForOptionsCommand=function(self) self:visible(true); self:zoom(1.2); self:settext(THEME:GetString("ScreenSelectMusic","Press Start For Options")); self:decelerate(1.5); self:zoom(1); end;
	ShowEnteringOptionsCommand=function(self) self:settext(THEME:GetString("ScreenSelectMusic","Entering Options")); self:sleep(0.2); self:decelerate(0.2); self:diffusealpha(0); end;
	HidePressStartForOptionsCommand=function(self) self:decelerate(0.1); self:diffusealpha(0); end;
};
-- Sounds
t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathS("_switch","up")) .. {
		SelectMenuOpenedMessageCommand=function(self) self:stop(); self:play(); end;
	};
	LoadActor(THEME:GetPathS("_switch","down")) .. {
		SelectMenuClosedMessageCommand=function(self) self:stop(); self:play(); end;
	};
};

t[#t+1] = Def.Quad{
	InitCommand=function(self) self:visible(false); end;
	OnCommand=function()
		MESSAGEMAN:Broadcast("SystemRePoss",{state = "ProfileLoaded"});
	end;
};


return t
