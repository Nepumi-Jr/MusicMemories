local t = Def.ActorFrame{};
local Title;
local Sub;
local Time;
local N_CL;
local Tog_LEN = 0;

ratemod = string.match(GAMESTATE:GetSongOptionsString(), "%d.%d");
if ratemod then
	ratemod = tonumber(ratemod);
else
	ratemod = 1.0
end


local function GetDiff()
	local DIFFU =nil;
	local METER = -1;
	
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if GAMESTATE:IsCourseMode() then
			x = GAMESTATE:GetCurrentTrail(pn);
		else
			x = GAMESTATE:GetCurrentSteps(pn);
		end
		if x:GetMeter() > METER then
			METER = x:GetMeter()
			DIFFU = THEME:GetString("CustomDifficulty",ToEnumShortString(x:GetDifficulty()))
			if  x:GetDifficulty() == "Difficulty_Edit" then
				if x:GetDescription() ~= "" then
					if string.len(x:GetDescription()) > 6 then
						DIFFU = string.sub(x:GetDescription(),1,5).."..."
					else
						DIFFU = x:GetDescription();
					end
				end
			end
		end
	end
	
	if METER >= 99 then METER = "??" else METER = tostring(METER) end
	if DIFFU then
		return DIFFU.."("..METER..")"
	else
		return "??????"
	end
end;

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
		
		if GAMESTATE:IsCourseMode() then
            --TODO : RPC_Update here
			
			self:settext(GAMESTATE:GetCurrentCourse():GetDisplayFullTitle())
		else
            --TODO : RPC_Update here
			self:settext(GAMESTATE:GetCurrentSong():GetDisplayFullTitle())
		end
		
		Tog_LEN = math.max((GAMESTATE:GetCurrentSong():GetFirstSecond() or 1)- 1,0);
		
		local player = GAMESTATE:GetMasterPlayerNumber()
		local title = PREFSMAN:GetPreference("ShowNativeLanguage") and GAMESTATE:GetCurrentSong():GetDisplayMainTitle() or GAMESTATE:GetCurrentSong():GetTranslitFullTitle()
		local songname = title .. " - " .. GAMESTATE:GetCurrentSong():GetGroupName()
		local status = THEME:GetString('DiscordRich',"State_PlaySong")
		GAMESTATE:UpdateDiscordProfile(GAMESTATE:GetPlayerDisplayName(player))
		GAMESTATE:UpdateDiscordSongPlaying(status,songname,GAMESTATE:GetCurrentSong():GetLastSecond())
		
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
		self:diffuseshift():effectcolor1(N_CL):effectcolor2(ColorMidTone(N_CL)):effectperiod(2):effectclock("beat")
		
		
		
		if GAMESTATE:IsCourseMode() then
			self:zoom(0.35):diffusealpha(0.7):y(SCREEN_BOTTOM+50)
			self:zoomx(0)
			self:sleep(Tog_LEN):decelerate(1):zoomx(0.35)
		else
			self:sleep(Tog_LEN):decelerate(1):diffusealpha(0)
		end
	end;
};





return t;