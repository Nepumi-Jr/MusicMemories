local t = Def.ActorFrame{};
local Title;
local Sub;
local Time;
local N_CL;
local Tog_LEN = 0;



local function NOW_DAY()
	return Hour()*60*60+Minute()*60+Second()
end


t[#t+1] = LoadFont("Common Normal") .. {
	InitCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y+200); self:zoom(1.3); self:strokecolor({0,0,0,1}); end;
	OnCommand=function(self) self:queuecommand("BOI"); end;
	CurrentSongChangedMessageCommand=function(self) self:queuecommand("BOI"); end;
	BOICommand=function(self)
	
		self:finishtweening()
	
		local NS = GAMESTATE:GetCurrentStageIndex()+1;
		if IsNetConnected() then
			N_CL = Color.Green;
		elseif TP.Battle.IsBattle then
			N_CL = ModeIconColors["Rave"];
		elseif GAMESTATE:IsCourseMode() then
			if GAMESTATE:GetCurrentCourse():IsNonstop()  then
				N_CL = ModeIconColors["Nonstop"];
			elseif GAMESTATE:GetCurrentCourse():IsOni()  then
				N_CL = ModeIconColors["Oni"];
			elseif GAMESTATE:GetCurrentCourse():IsEndless() then
				N_CL = ModeIconColors["Endless"];
			end
		elseif ToEnumShortString(GAMESTATE:GetCurrentStage()) == "Event" then
			N_CL = NumStageColor(NS);
		else
			N_CL = NumStageColor(NS);
		end
		
		local discordTitle;
		local playerMasterName = GAMESTATE:GetPlayerDisplayName(GAMESTATE:GetMasterPlayerNumber())
		local songTitle = PREFSMAN:GetPreference("ShowNativeLanguage") and GAMESTATE:GetCurrentSong():GetDisplayMainTitle() or GAMESTATE:GetCurrentSong():GetTranslitFullTitle()
		local discordStatusStr = THEME:GetString('DiscordRich',"State_PlaySong")

		if GAMESTATE:IsCourseMode() then
			local courseTitle = GAMESTATE:GetCurrentCourse():GetDisplayFullTitle()
			local nowStage = tostring(GAMESTATE:GetCourseSongIndex() + 1);
			local totalStage = "??"
			if GAMESTATE:GetCurrentCourse():GetNumCourseEntries() then
				totalStage = tostring(GAMESTATE:GetCurrentCourse():GetNumCourseEntries())
			end

			discordTitle = string.format("%s - %s (%s of %s)", songTitle, courseTitle, nowStage, totalStage)
			self:settext(GAMESTATE:GetCurrentCourse():GetDisplayFullTitle())
		else
			discordTitle = songTitle .. " - " .. GAMESTATE:GetCurrentSong():GetGroupName()
			self:settext(GAMESTATE:GetCurrentSong():GetDisplayFullTitle())
		end
		
		GAMESTATE:UpdateDiscordProfile(playerMasterName)
		GAMESTATE:UpdateDiscordSongPlaying(discordStatusStr,discordTitle,GAMESTATE:GetCurrentSong():GetLastSecond() + 4)
		
		Tog_LEN = math.max((GAMESTATE:GetCurrentSong():GetFirstSecond() or 1)- 1,0);
		
		
		
		self:diffuse(N_CL)
		
		if GAMESTATE:IsCourseMode() then
			self:zoom(0.7):diffusealpha(0.7):y(SCREEN_CENTER_Y+210)
			self:zoomx(0)
			self:sleep(Tog_LEN):decelerate(1):zoomx(0.7)
		else
			self:sleep(Tog_LEN):decelerate(1):zoom(0.7):diffusealpha(0.7):y(SCREEN_CENTER_Y+220)
		end
	end;
};

t[#t+1] = LoadFont("Common Normal") .. {
	InitCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y+218); self:zoom(0.5); self:strokecolor({0,0,0,1}); end;
	OnCommand=function(self) self:queuecommand("BOI"); end;
	CurrentSongChangedMessageCommand=function(self) self:queuecommand("BOI"); end;
	BOICommand=function(self)
		self:finishtweening()
		if GAMESTATE:IsCourseMode() then
			self:settext(GAMESTATE:GetCurrentSong():GetDisplayFullTitle())
		else
			self:settext(GAMESTATE:GetCurrentSong():GetDisplayArtist())
		end
		self:diffuse(N_CL)
		if GAMESTATE:IsCourseMode() then
			self:zoom(0.4):diffusealpha(0.7):y(SCREEN_BOTTOM-15)
			self:zoomx(0)
			self:sleep(Tog_LEN):decelerate(1):zoomx(0.4)
		else
			self:sleep(Tog_LEN):decelerate(1):diffusealpha(0)
		end
	end;
};





return t;