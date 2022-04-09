local function GraphDisplay( pn )
	local t = Def.ActorFrame {
		Def.GraphDisplay {
			InitCommand=function(self) self:Load("GraphDisplay"); end;
			OnCommand=function(self) self:x(-7.5); self:y(-25); self:zoomx(1.55); end;
			BeginCommand=function(self)
				local ss = SCREENMAN:GetTopScreen():GetStageStats();
				self:Set( ss, ss:GetPlayerStageStats(pn) );
				self:player( pn );
			end
		};
	};
	return t;
end



local function PercentScore( pn )
	local t = LoadFont("Common normal")..{
		InitCommand=function(self) self:zoom(0.625); self:shadowlength(1); self:player(pn); end;
		BeginCommand=function(self) self:playcommand("Set"); end;
		SetCommand=function(self)
			-- todo: color by difficulty
			local SongOrCourse, StepsOrTrail;
			if GAMESTATE:IsCourseMode() then
				SongOrCourse = GAMESTATE:GetCurrentCourse()
				StepsOrTrail = GAMESTATE:GetCurrentTrail(pn)
			else
				SongOrCourse = GAMESTATE:GetCurrentSong()
				StepsOrTrail = GAMESTATE:GetCurrentSteps(pn)
			end;
			if SongOrCourse and StepsOrTrail then
				local st = StepsOrTrail:GetStepsType();
				local diff = StepsOrTrail:GetDifficulty();
				local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
				local cd = GetCustomDifficulty(st, diff, courseType);
				self:diffuse(CustomDifficultyToColor(cd));
				self:shadowcolor(CustomDifficultyToDarkColor(cd));
			end

			local pss = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(pn);
			if pss then
				local pct = pss:GetPercentDancePoints();
				if pct == 1 then
					self:settext("100%");
				else
					self:settext(FormatPercentScore(pct));
				end;
			end;
		end;
	};
	return t;
end
----{W1,W2,W3,W4,W5,miss,W1+W2+W3+W4+W5,held,mine,maxcombo,letgo}
local P1Stat = {0,0,0,0,0,0,0,0,0,0,0}
local animetedP1 = {0,0,0,0,0,0,0,0,0,0,0}
if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
local Stat1=STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_1)
	P1Stat = {Stat1:GetTapNoteScores('TapNoteScore_W1'),Stat1:GetTapNoteScores('TapNoteScore_W2'),Stat1:GetTapNoteScores('TapNoteScore_W3'),Stat1:GetTapNoteScores('TapNoteScore_W4'),Stat1:GetTapNoteScores('TapNoteScore_W5'),Stat1:GetTapNoteScores('TapNoteScore_Miss'),Stat1:GetTapNoteScores('TapNoteScore_W5')+Stat1:GetTapNoteScores('TapNoteScore_W4')+Stat1:GetTapNoteScores('TapNoteScore_W3')+Stat1:GetTapNoteScores('TapNoteScore_W2')+Stat1:GetTapNoteScores('TapNoteScore_W1'),Stat1:GetHoldNoteScores('HoldNoteScore_Held'),Stat1:GetTapNoteScores('TapNoteScore_HitMine'),Stat1:MaxCombo(),Stat1:GetHoldNoteScores('HoldNoteScore_LetGo')}
	animetedP1 = P1Stat
end

local P2Stat = {0,0,0,0,0,0,0,0,0,0,0}
local animetedP2 = {0,0,0,0,0,0,0,0,0,0,0}
if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
local Stat2=STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_2)
	P2Stat = {Stat2:GetTapNoteScores('TapNoteScore_W1'),Stat2:GetTapNoteScores('TapNoteScore_W2'),Stat2:GetTapNoteScores('TapNoteScore_W3'),Stat2:GetTapNoteScores('TapNoteScore_W4'),Stat2:GetTapNoteScores('TapNoteScore_W5'),Stat2:GetTapNoteScores('TapNoteScore_Miss'),Stat2:GetTapNoteScores('TapNoteScore_W5')+Stat2:GetTapNoteScores('TapNoteScore_W4')+Stat2:GetTapNoteScores('TapNoteScore_W3')+Stat2:GetTapNoteScores('TapNoteScore_W2')+Stat2:GetTapNoteScores('TapNoteScore_W1'),Stat2:GetHoldNoteScores('HoldNoteScore_Held'),Stat2:GetTapNoteScores('TapNoteScore_HitMine'),Stat2:MaxCombo(),Stat2:GetHoldNoteScores('HoldNoteScore_LetGo')}
	animetedP2 = P2Stat
end
local jud1 = TP[ToEnumShortString(PLAYER_1)].ActiveModifiers.JudgmentGraphic or "tor12315za";
local jud2 = TP[ToEnumShortString(PLAYER_2)].ActiveModifiers.JudgmentGraphic or "tor12315za";
local frame1;
local percent = 0;
local vib = 20;
local nep = 0;
local whatx = 0;
local whaty = 0;
local GradeforP1 = "Normal 4x2.png"--in 589
local profileP1 = PROFILEMAN:GetProfile(PLAYER_1);
local nameP1 = profileP1:GetDisplayName();
local LVP1 = TP[ToEnumShortString(PLAYER_1)].Level.Level or 1
if nameP1 == "tor12315za" or nameP1 == "Neptune" or (MonthOfYear() == 10-1 and DayOfMonth() == 8) then
	GradeforP1 = "Tor 4x2.png"
elseif MonthOfYear() == 10-1 and DayOfMonth() == 31 then
	GradeforP1 = "Horror 4x2.png"
end
TP[ToEnumShortString(PLAYER_1)].Level.Level = LVP1 + 5
local GradeforP2 = "Normal 4x2.png"--in 589
local profileP2 = PROFILEMAN:GetProfile(PLAYER_2);
local nameP2 = profileP2:GetDisplayName();
if nameP2 == "tor12315za" or nameP2 == "Neptune" or (MonthOfYear() == 10-1 and DayOfMonth() == 8) then
	GradeforP2 = "Tor 4x2.png"
elseif MonthOfYear() == 10-1 and DayOfMonth() == 31 then
	GradeforP2 = "Horror 4x2.png"
end
local percentP1;
local percentP2;
percentP1 = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()
percentP2 = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()
LoadActor("../_save/Battle.lua")
local t = LoadFallbackB();
--t[#t+1] = StandardDecorationFromFileOptional("StageDisplay","StageDisplay");
	t[#t+1] = Def.ActorFrame{
		OnCommand=function(self) self:playcommand('loop'); end;
		loopCommand=function(self)
		psssss = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_1)
		if GAMESTATE:GetPlayMode() ~= "PlayMode_Rave" then
		if psssss:FullCombo() then
		nep = nep + 0.02
		whatx = math.random(-vib,vib)
		whaty = math.random(-vib,vib)
		self:x(whatx)
		self:y(whaty)
		if nep >= 16.188 then
		vib = vib - 1;
		end
		end
		elseif GAMESTATE:IsWinner(PLAYER_2) then
		nep = nep + 0.02
		if nep >= 2.249 then
		vib = vib - 1;
		whatx = math.random(-vib,vib)
		whaty = math.random(-vib,vib)
		self:x(whatx)
		self:y(whaty)
		end
		end
		self:sleep(0.02)
		self:queuecommand('loop')
		end;
	LoadActor("hrror.png") .. {
		InitCommand=function(self) self:Center(); self:zoom(0.5); self:cropright(0.5); end;
		OnCommand=function(self)
		if GAMESTATE:GetPlayMode() ~= "PlayMode_Rave" then
		self:player(0)
		end
		self:diffusetopedge(PlayerColor(PLAYER_1))
			local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
			local meter = steps:GetDifficulty()

			if meter then
			if meter == "Difficulty_Beginner" then
			self:diffusebottomedge(color("#FFAAAA"))
				elseif  meter == "Difficulty_Easy" then
			self:diffusebottomedge(color("#55ff55"))
				elseif meter == "Difficulty_Medium" then
			self:diffusebottomedge(color("#fFff22"))
				elseif  meter == "Difficulty_Hard" then
			self:diffusebottomedge(color("#ff4444"))
				elseif  meter == "Difficulty_Challenge" then
			self:diffusebottomedge(color("#CCCCff"))
				elseif  meter == "Difficulty_Edit" then
			self:diffusebottomedge(color("#AAAAAA"))
				end
			end
		end;
	};
LoadFont("_determination mono 24px") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X-105); self:y(SCREEN_CENTER_Y+152); self:zoom(0.4); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
			profile = PROFILEMAN:GetProfile(PLAYER_1);
			name = profile:GetTotalDancePoints();
			psssss = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_1)
			flowey = psssss:GetScore()
			frisk = FormatPercentScore(psssss:GetPercentDancePoints())
			self:settext(flowey.."\n"..frisk)
		end;
	};
		 LoadFont("_8-bit madness 72px")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-169); self:y(SCREEN_CENTER_Y+150); self:zoom(0.5); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
			local meter = steps:GetMeter()

			if meter then
				if meter == 1943951546 then
				self:settext("??")
				self:zoom(0.4)
				elseif meter >= 10 then
				self:zoom(0.4)
				self:settext(meter)
				elseif meter >= 100 then
				self:zoom(0.25)
				self:settext(meter)
				elseif meter >= 1000 then
				self:zoom(0.15)
				self:settext(meter)
				else
				self:settext(meter)
				self:zoom(0.5)
				end
			end
		end;
	};
LoadFont("_determination mono 24px") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X-230); self:y(SCREEN_CENTER_Y+153); self:zoom(0.5); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
			local meter = steps:GetDifficulty()

			if meter then
			if meter == "Difficulty_Beginner" then
			self:settext("Beginer");
			self:zoom(0.8);
				elseif  meter == "Difficulty_Easy" then
				self:settext("Easy");
				self:zoom(0.8);
				elseif meter == "Difficulty_Medium" then
				self:settext("Normal");
				self:zoom(0.8);
				elseif  meter == "Difficulty_Hard" then
				self:settext("Hard");
				self:zoom(0.8);
				elseif  meter == "Difficulty_Challenge" then
				self:settext("Expert");
				self:zoom(0.7);
				elseif  meter == "Difficulty_Edit" then
					if steps:GetDescription() then
					self:settext(steps:GetDescription());
					else
					self:settext("edit");
					end
				self:zoom(0.5);
				end
			end
		end;
	};
	
	
	
	
	
	
LoadFont("_determination mono 24px") .. {
		InitCommand=function(self) self:Center(); self:zoom(2); self:settext("Hello"); end;
	};
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X-167); self:y(SCREEN_CENTER_Y+102); self:zoom(0.75); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
			psssss = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_1)
			awesome = psssss:GetPeakComboAward()
			self:settext(awesome)
		end;
	};
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X-167); self:y(SCREEN_CENTER_Y-52); self:zoom(0.75); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
			psssss = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_1)
			awesome = psssss:GetStageAward()
			if awesome then
			self:rainbow()
			else
			self:stopeffect()
			end
			self:settext(THEME:GetString( "StageAward", ToEnumShortString( awesome ) ))
		end;
	};
LoadFont("common edit") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X-167); self:y(SCREEN_CENTER_Y-66); self:zoom(0.75); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
			psssss = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_1)
			awesome = psssss:GetStageAward()
			if awesome then
			self:y(SCREEN_CENTER_Y-66)
			self:rainbow()
			else
			self:stopeffect()
			self:y(SCREEN_CENTER_Y-59)
			end
			local profile = PROFILEMAN:GetProfile(PLAYER_1);
			local name = profile:GetDisplayName();
				if GAMESTATE:IsHumanPlayer(PLAYER_1) then
				if name then
				self:settext(name)
				elseif GAMESTATE:IsHumanPlayer(PLAYER_1) then
				self:settext("P1 guy")
				end
				else
				self:settext("Bad guy")
				end
		end;
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25); end;
			BeginCommand=function(self)
			self:visible(GAMESTATE:ShowW1())
		end;
		Def.ActorFrame{
			OnCommand=function(self) self:horizalign(right); end;
Def.Sprite{
		InitCommand=function(self) self:zoom(0.30); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
		self:pause();
		self:Load( THEME:GetPathG("", "_judgmentsSomechai/" .. jud1) );
		if frame1 then
			self:setstate(0*1)
		else
			self:setstate(0)
		end
		end;
	};
	};
	Def.ActorFrame{
			BeginCommand=function(self)
			self:diffuse(GameColor.Judgment["JudgmentLine_W1"])
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP1[1]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
	};
----{W1,W2,W3,W4,W5,miss,W1+W2+W3+W4+W5,held,mine,maxcombo,letgo}
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25+20*1); end;
		Def.ActorFrame{
			OnCommand=function(self) self:horizalign(right); end;
Def.Sprite{
		InitCommand=function(self) self:zoom(0.30); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
		self:pause();
		self:Load( THEME:GetPathG("", "_judgmentsSomechai/" .. jud1) );
		if self:GetNumStates() == 12 then
		frame1 = true
		else
		frame1 = false
		end
		if frame1 then
			self:setstate(2*1)
		else
			self:setstate(1)
		end
		end;
	};
	};
	Def.ActorFrame{
			BeginCommand=function(self)
			self:diffuse(GameColor.Judgment["JudgmentLine_W2"])
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			if percent < 100 then
			percent = percent + 1
			animetedP1 = {P1Stat[1]*percent/100,P1Stat[2]*percent/100,P1Stat[3]*percent/100,P1Stat[4]*percent/100,P1Stat[5]*percent/100,P1Stat[6]*percent/100,P1Stat[7]*percent/100,P1Stat[8]*percent/100,P1Stat[9]*percent/100,P1Stat[10]*percent/100,P1Stat[11]*percent/100}
			animetedP2 = {P2Stat[1]*percent/100,P2Stat[2]*percent/100,P2Stat[3]*percent/100,P2Stat[4]*percent/100,P2Stat[5]*percent/100,P2Stat[6]*percent/100,P2Stat[7]*percent/100,P2Stat[8]*percent/100,P2Stat[9]*percent/100,P2Stat[10]*percent/100,P2Stat[11]*percent/100}
			else
			animetedP2 = P2Stat
			animetedP1 = P1Stat
			end
			
			numberr = animetedP1[2]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25+20*2); end;
		Def.ActorFrame{
			OnCommand=function(self) self:horizalign(right); end;
Def.Sprite{
		InitCommand=function(self) self:zoom(0.30); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
		self:pause();
		self:Load( THEME:GetPathG("", "_judgmentsSomechai/" .. jud1) );
		if self:GetNumStates() == 12 then
		frame1 = true
		else
		frame1 = false
		end
		if frame1 then
			self:setstate(2*2)
		else
			self:setstate(2)
		end
		end;
	};
};
	Def.ActorFrame{
			BeginCommand=function(self)
			self:diffuse(GameColor.Judgment["JudgmentLine_W3"])
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP1[3]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25+20*3); end;
		Def.ActorFrame{
			OnCommand=function(self) self:horizalign(right); end;
Def.Sprite{
		InitCommand=function(self) self:zoom(0.30); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
		self:pause();
		self:Load( THEME:GetPathG("", "_judgmentsSomechai/" .. jud1) );
		if self:GetNumStates() == 12 then
		frame1 = true
		else
		frame1 = false
		end
		if frame1 then
			self:setstate(3*2)
		else
			self:setstate(3)
		end
		end;
	};
};
	Def.ActorFrame{
			BeginCommand=function(self)
			self:diffuse(GameColor.Judgment["JudgmentLine_W4"])
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP1[4]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
};
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25+20*2); end;
		Def.ActorFrame{
			OnCommand=function(self) self:horizalign(right); end;
Def.Sprite{
		InitCommand=function(self) self:zoom(0.30); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
		self:pause();
		self:Load( THEME:GetPathG("", "_judgmentsSomechai/" .. jud1) );
		if self:GetNumStates() == 12 then
		frame1 = true
		else
		frame1 = false
		end
		if frame1 then
			self:setstate(2*2)
		else
			self:setstate(2)
		end
		end;
	};
};
	Def.ActorFrame{
			BeginCommand=function(self)
			self:diffuse(GameColor.Judgment["JudgmentLine_W3"])
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP1[3]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25+20*4); end;
		Def.ActorFrame{
			OnCommand=function(self) self:horizalign(right); end;
Def.Sprite{
		InitCommand=function(self) self:zoom(0.30); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
		self:pause();
		self:Load( THEME:GetPathG("", "_judgmentsSomechai/" .. jud1) );
		if self:GetNumStates() == 12 then
		frame1 = true
		else
		frame1 = false
		end
		if frame1 then
			self:setstate(4*2)
		else
			self:setstate(4)
		end
		end;
	};
};
	Def.ActorFrame{
			BeginCommand=function(self)
			self:diffuse(GameColor.Judgment["JudgmentLine_W5"])
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP1[5]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
};
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25+20*2); end;
		Def.ActorFrame{
			OnCommand=function(self) self:horizalign(right); end;
Def.Sprite{
		InitCommand=function(self) self:zoom(0.30); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
		self:pause();
		self:Load( THEME:GetPathG("", "_judgmentsSomechai/" .. jud1) );
		if self:GetNumStates() == 12 then
		frame1 = true
		else
		frame1 = false
		end
		if frame1 then
			self:setstate(2*2)
		else
			self:setstate(2)
		end
		end;
	};
};
	Def.ActorFrame{
			BeginCommand=function(self)
			self:diffuse(GameColor.Judgment["JudgmentLine_W3"])
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP1[3]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25+20*5); end;
		Def.ActorFrame{
			OnCommand=function(self) self:horizalign(right); end;
Def.Sprite{
		InitCommand=function(self) self:zoom(0.30); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
		self:pause();
		self:Load( THEME:GetPathG("", "_judgmentsSomechai/" .. jud1) );
		if self:GetNumStates() == 12 then
		frame1 = true
		else
		frame1 = false
		end
		if frame1 then
			self:setstate(5*2)
		else
			self:setstate(5)
		end
		end;
	};
};
	Def.ActorFrame{
			BeginCommand=function(self)
			self:diffuse(GameColor.Judgment["JudgmentLine_Miss"])
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP1[6]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
};
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-95); self:y(SCREEN_CENTER_Y-25); end;
			BeginCommand=function(self)
			self:diffuse(color("#cccccc"))
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); self:horizalign(left); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
		self:settext("Tap")
		end;
	};
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(20); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP1[7]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-95); self:y(SCREEN_CENTER_Y-25+20*1); end;
			BeginCommand=function(self)
			self:diffuse(color("#cccccc"))
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); self:horizalign(left); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
		self:settext("Held")
		end;
	};
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(20); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP1[8]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-95); self:y(SCREEN_CENTER_Y-25+20*2); end;
			BeginCommand=function(self)
			self:diffuse(color("#cccccc"))
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); self:horizalign(left); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
		self:settext("Mine")
		end;
	};
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(20); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP1[9]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-95); self:y(SCREEN_CENTER_Y-25+20*3); end;
			BeginCommand=function(self)
			self:diffuse(color("#cccccc"))
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); self:horizalign(left); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
		self:settext("MaxCombo")
		end;
	};
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(20); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP1[10]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-95); self:y(SCREEN_CENTER_Y-25+20*4); end;
			BeginCommand=function(self)
			self:diffuse(color("#ff5555"))
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); self:horizalign(left); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
		self:settext("LetitGO")
		end;
	};
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(20); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP1[11]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
	
	
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-220); self:wag(); self:effectmagnitude(0,-45,0); self:effectperiod(math.random(15,25)); self:effectoffset(math.random(0,5)); end;
		OnCommand=function(self)
			if Isbattle then
				self:sleep(3)
				self:decelerate(1)
				self:x(SCREEN_CENTER_X-25)
				self:zoom(0.35)
				self:y(150)
			end
		end;
LoadActor(GradeforP1)..{
		InitCommand=function(self) self:y(SCREEN_CENTER_Y-150); self:diffusealpha(0.45); self:zoom(1.25*1.5); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
			if GradeforP1 == "Tor 4x2.png" then
			self:zoom(0.5*1.5)
			end
			psssss = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_1)
			Gade = psssss:GetGrade()
			self:pause();
				----------------------Fantastic
				if Gade == "Grade_Tier01" then
				self:setstate(0)
				elseif Gade == "Grade_Tier02" then
				self:setstate(1)
				elseif Gade == "Grade_Tier03" then
				self:setstate(2)
				elseif Gade == "Grade_Tier04" then
				self:setstate(3)
				elseif Gade == "Grade_Tier05" then
				self:setstate(4)
				elseif Gade == "Grade_Tier06" then
				self:setstate(5)
				elseif Gade == "Grade_Tier07" then
				self:setstate(6)
				else
				self:setstate(7)
				end
				
		end;
	};
LoadActor(GradeforP1)..{
		InitCommand=function(self) self:y(SCREEN_CENTER_Y-150); self:z(20); self:zoom(1.25); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
			if GradeforP1 == "Tor 4x2.png" then
			self:zoom(0.5)
			end
			psssss = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_1)
			Gade = psssss:GetGrade()
			self:pause();
				----------------------Fantastic
				if Gade == "Grade_Tier01" then
				self:setstate(0)
				elseif Gade == "Grade_Tier02" then
				self:setstate(1)
				elseif Gade == "Grade_Tier03" then
				self:setstate(2)
				elseif Gade == "Grade_Tier04" then
				self:setstate(3)
				elseif Gade == "Grade_Tier05" then
				self:setstate(4)
				elseif Gade == "Grade_Tier06" then
				self:setstate(5)
				elseif Gade == "Grade_Tier07" then
				self:setstate(6)
				else
				self:setstate(7)
				end
				
		end;
	};
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-220); self:wag(); self:effectmagnitude(0,-45,0); self:effectperiod(math.random(15,25)); self:effectoffset(math.random(0,5)); end;
		OnCommand=function(self)
			self:visible(Isbattle)
			if Isbattle then
				self:zoom(0)
				self:sleep(3)
				self:decelerate(1)
				self:zoom(1)
			end
		end;
	Def.ActorFrame{
		OnCommand=function(self) self:diffuse(color("#FFFFFF68")); end;
LoadFont("_special elite 108px") .. {
		InitCommand=function(self) self:y(SCREEN_CENTER_Y-150); self:diffusealpha(0.45); self:zoom(1*1.5); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
			if percentP1 > percentP2 then
			self:settext(P1Sc+1)
			self:diffuse(color("#FFFFFF68"))
			self:rainbowscroll(true)
			else
			self:settext(P1Sc)
			self:diffuse(color("#FF8800"))
			self:rainbowscroll(false)
			end
		end;
	};
	};
LoadFont("_special elite 108px") .. {
		InitCommand=function(self) self:y(SCREEN_CENTER_Y-150); self:z(20); self:zoom(1); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
		end;
		BeginCommand=function(self)
			if percentP1 > percentP2 then
			self:settext(P1Sc+1)
			self:diffuse(color("#FFFFFF"))
			self:rainbowscroll(true)
			else
			self:settext(P1Sc)
			self:diffuse(color("#FF8800"))
			self:rainbowscroll(false)
			end
		end;
	};
	};
	};
	
	----------------------------------------------
	-------------P2-------------------------------
	----------------------------------------------
	
	
	
	
	
	
	
		t[#t+1] = Def.ActorFrame{
				InitCommand=function(self) self:x(SCREEN_CENTER_X-100); end;
				OnCommand=function(self) self:playcommand('loop'); end;
		loopCommand=function(self)
		if GAMESTATE:GetPlayMode() ~= "PlayMode_Rave" then
		psssss2 = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_2)
		if psssss2:FullCombo() then
		nep = nep + 0.02
		whatx2 = math.random(-vib,vib)
		whaty2 = math.random(-vib,vib)
		self:x(SCREEN_CENTER_X-100+whatx2)
		self:y(whaty2)
		if nep >= 16.188 then
		vib = vib - 1;
		end
		end
		elseif GAMESTATE:IsWinner(PLAYER_1) then
		nep = nep + 0.02
		if nep >= 2.249 then
		vib = vib - 1;
		whatx2 = math.random(-vib,vib)
		whaty2 = math.random(-vib,vib)
		self:x(SCREEN_CENTER_X-100+whatx2)
		self:y(whaty2)
		end
		self:sleep(0.02)
		self:queuecommand('loop')
		end
		end;
	LoadActor("hrror.png") .. {
		InitCommand=function(self) self:Center(); self:zoom(0.5); self:cropright(0.5); end;
		OnCommand=function(self)
		if GAMESTATE:GetPlayMode() ~= "PlayMode_Rave" then
		self:player(1)
		end
		self:diffusetopedge(PlayerColor(PLAYER_2))
			local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
			local meter = steps:GetDifficulty()
			
			if meter then
			if meter == "Difficulty_Beginner" then
			self:diffusebottomedge(color("#FFAAAA"))
				elseif  meter == "Difficulty_Easy" then
			self:diffusebottomedge(color("#55ff55"))
				elseif meter == "Difficulty_Medium" then
			self:diffusebottomedge(color("#fFff22"))
				elseif  meter == "Difficulty_Hard" then
			self:diffusebottomedge(color("#ff4444"))
				elseif  meter == "Difficulty_Challenge" then
			self:diffusebottomedge(color("#CCCCff"))
				elseif  meter == "Difficulty_Edit" then
			self:diffusebottomedge(color("#AAAAAA"))
				end
			end
		end;
	};
		 LoadFont("_8-bit madness 72px")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-169); self:y(SCREEN_CENTER_Y+150); self:zoom(0.5); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
			local meter = steps:GetMeter()

			if meter then
				if meter == 1943951546 then
				self:settext("??")
				self:zoom(0.4)
				elseif meter >= 10 then
				self:zoom(0.4)
				self:settext(meter)
				elseif meter >= 100 then
				self:zoom(0.25)
				self:settext(meter)
				elseif meter >= 1000 then
				self:zoom(0.15)
				self:settext(meter)
				else
				self:settext(meter)
				self:zoom(0.5)
				end
			end
		end;
	};
LoadFont("_determination mono 24px") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X-230); self:y(SCREEN_CENTER_Y+153); self:zoom(0.5); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
			local meter = steps:GetDifficulty()

			if meter then
			if meter == "Difficulty_Beginner" then
			self:settext("Beginer");
			self:zoom(0.8);
				elseif  meter == "Difficulty_Easy" then
				self:settext("Easy");
				self:zoom(0.8);
				elseif meter == "Difficulty_Medium" then
				self:settext("Normal");
				self:zoom(0.8);
				elseif  meter == "Difficulty_Hard" then
				self:settext("Hard");
				self:zoom(0.8);
				elseif  meter == "Difficulty_Challenge" then
				self:settext("Expert");
				self:zoom(0.7);
				elseif  meter == "Difficulty_Edit" then
					if steps:GetDescription() then
					self:settext(steps:GetDescription());
					else
					self:settext("edit");
					end
				self:zoom(0.5);
				end
			end
		end;
	};
LoadFont("_determination mono 24px") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X-105); self:y(SCREEN_CENTER_Y+152); self:zoom(0.4); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
			psssss = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_2)
			flowey = psssss:GetScore()
			frisk = FormatPercentScore(psssss:GetPercentDancePoints())
			self:settext(flowey.."\n"..frisk)
		end;
	};
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X-167); self:y(SCREEN_CENTER_Y+102); self:zoom(0.75); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
			psssss = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_2)
			awesome = psssss:GetPeakComboAward()
			self:settext(awesome)
		end;
	};
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X-167); self:y(SCREEN_CENTER_Y-52); self:zoom(0.75); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
			psssss = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_2)
			awesome = psssss:GetStageAward()
			if awesome then
			self:rainbow()
			else
			self:stopeffect()
			end
			self:settext(THEME:GetString( "StageAward", ToEnumShortString( awesome ) ))
		end;
	};
LoadFont("common edit") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X-167); self:y(SCREEN_CENTER_Y-66); self:zoom(0.75); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
			psssss = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_2)
			awesome = psssss:GetStageAward()
			if awesome then
			self:y(SCREEN_CENTER_Y-66)
			self:rainbow()
			else
			self:stopeffect()
			self:y(SCREEN_CENTER_Y-59)
			end
			local profile = PROFILEMAN:GetProfile(PLAYER_2);
			local name = profile:GetDisplayName();
				if GAMESTATE:IsHumanPlayer(PLAYER_2) then
				if name then
				self:settext(name)
				elseif GAMESTATE:IsHumanPlayer(PLAYER_2) then
				self:settext("P2 guy")
				end
				else
				self:settext("Bad guy")
				end
				
		end;
	};
		Def.ActorFrame{
			OnCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25); self:horizalign(right); end;
			BeginCommand=function(self)
			self:visible(GAMESTATE:ShowW1())
		end;
Def.Sprite{
		InitCommand=function(self) self:zoom(0.30); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
		self:pause();
		self:Load( THEME:GetPathG("", "_judgmentsSomechai/" .. jud2) );
		if frame2 then
			self:setstate(0*2)
		else
			self:setstate(0)
		end
		end;
	};
};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25); end;
			BeginCommand=function(self)
			self:diffuse(GameColor.Judgment["JudgmentLine_W1"])
			self:visible(GAMESTATE:ShowW1())
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP2[1]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25+20*1); end;
			BeginCommand=function(self)
			self:diffuse(GameColor.Judgment["JudgmentLine_W2"])
		end;
		Def.ActorFrame{
			OnCommand=function(self) self:horizalign(right); end;
Def.Sprite{
		InitCommand=function(self) self:zoom(0.30); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
		self:pause();
		self:Load( THEME:GetPathG("", "_judgmentsSomechai/" .. jud2) );
		if self:GetNumStates() == 12 then
		frame2 = true
		else
		frame2 = false
		end
		if frame2 then
			self:setstate(1*2)
		else
			self:setstate(1)
		end
		end;
	};
};
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
			self:playcommand("neptune");
		
		end;
		neptuneCommand=function(self)
			numberr = animetedP2[2]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
		Def.ActorFrame{
			OnCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25+20*2); self:horizalign(right); end;
Def.Sprite{
		InitCommand=function(self) self:zoom(0.30); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
		self:pause();
		self:Load( THEME:GetPathG("", "_judgmentsSomechai/" .. jud2) );
		if frame2 then
			self:setstate(2*2)
		else
			self:setstate(2)
		end
		end;
	};
};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25+20*2); end;
			BeginCommand=function(self)
			self:diffuse(GameColor.Judgment["JudgmentLine_W3"])
		end;
LoadFont("common normal") .. {
	InitCommand=function(self) self:x(-55); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP2[3]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
		Def.ActorFrame{
			OnCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25+20*3); self:horizalign(right); end;
Def.Sprite{
		InitCommand=function(self) self:zoom(0.30); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
		self:pause();
		self:Load( THEME:GetPathG("", "_judgmentsSomechai/" .. jud2) );
		if frame2 then
			self:setstate(3*2)
		else
			self:setstate(3)
		end
		end;
	};
};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25+20*3); end;
			BeginCommand=function(self)
			self:diffuse(GameColor.Judgment["JudgmentLine_W4"])
		end;
LoadFont("common normal") .. {
	InitCommand=function(self) self:x(-55); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP2[4]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
		Def.ActorFrame{
			OnCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25+20*4); self:horizalign(right); end;
Def.Sprite{
		InitCommand=function(self) self:zoom(0.30); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
		self:pause();
		self:Load( THEME:GetPathG("", "_judgmentsSomechai/" .. jud2) );
		if frame2 then
			self:setstate(4*2)
		else
			self:setstate(4)
		end
		end;
	};
};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25+20*4); end;
			BeginCommand=function(self)
			self:diffuse(GameColor.Judgment["JudgmentLine_W5"])
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP2[5]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
		Def.ActorFrame{
			OnCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25+20*5); self:horizalign(right); end;
Def.Sprite{
		InitCommand=function(self) self:zoom(0.30); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
		self:pause();
		self:Load( THEME:GetPathG("", "_judgmentsSomechai/" .. jud2) );
		if frame2 then
			self:setstate(5*2)
		else
			self:setstate(5)
		end
		end;
	};
};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-190); self:y(SCREEN_CENTER_Y-25+20*5); end;
			BeginCommand=function(self)
			self:diffuse(GameColor.Judgment["JudgmentLine_Miss"])
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP2[6]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-95); self:y(SCREEN_CENTER_Y-25); end;
			BeginCommand=function(self)
			self:diffuse(color("#cccccc"))
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); self:horizalign(left); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
		self:settext("Tap")
		end;
	};
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(20); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP2[7]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-95); self:y(SCREEN_CENTER_Y-25+20*1); end;
			BeginCommand=function(self)
			self:diffuse(color("#cccccc"))
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); self:horizalign(left); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
		self:settext("Held")
		end;
	};
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(20); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP2[8]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-95); self:y(SCREEN_CENTER_Y-25+20*2); end;
			BeginCommand=function(self)
			self:diffuse(color("#cccccc"))
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); self:horizalign(left); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
		self:settext("Mine")
		end;
	};
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(20); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP2[9]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-95); self:y(SCREEN_CENTER_Y-25+20*3); end;
			BeginCommand=function(self)
			self:diffuse(color("#cccccc"))
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); self:horizalign(left); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
		self:settext("MaxCombo")
		end;
	};
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(20); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP2[10]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-95); self:y(SCREEN_CENTER_Y-25+20*4); end;
			BeginCommand=function(self)
			self:diffuse(color("#ff5555"))
		end;
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(-55); self:zoom(0.65); self:horizalign(left); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
		self:settext("LetitGO")
		end;
	};
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(20); self:zoom(0.65); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
			self:playcommand("neptune");
		end;
		neptuneCommand=function(self)
			numberr = animetedP2[11]
			realnumis = string.format("%.0f",numberr)
			if numberr == 0 then helo = "000"; elseif numberr < 10 then helo = "000"; elseif numberr < 100 then helo = "00"; elseif numberr < 1000 then helo = "0"; else helo = ""; end
			self:settext(helo..realnumis)
			if numberr == 0 then self:AddAttribute(0, {Length=4, Diffuse=color("#777777")}); elseif numberr < 10 then self:AddAttribute(0, {Length=3, Diffuse=color("#777777")}); elseif numberr < 100 then self:AddAttribute(0, {Length=2, Diffuse=color("#777777")}); elseif numberr < 1000 then self:AddAttribute(0, {Length=1, Diffuse=color("#777777")}); else self:AddAttribute(0, {Length=0, Diffuse=color("#777777")}); end
			--You mad bro
			self:sleep(0.02)
			self:queuecommand('neptune')
		end;
	};
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-220+110); self:wag(); self:effectmagnitude(0,45,0); self:effectperiod(math.random(15,25)); self:effectoffset(math.random(0,5)); end;
		OnCommand=function(self)
			if Isbattle then
				self:sleep(3)
				self:decelerate(1)
				self:x(125)
				self:zoom(0.35)
				self:y(150)
			end
		end;
LoadActor(GradeforP2)..{
		InitCommand=function(self) self:y(SCREEN_CENTER_Y-150); self:diffusealpha(0.45); self:zoom(1.25*1.5); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
			if GradeforP2 == "Tor 4x2.png" then
			self:zoom(0.5*1.5)
			end
			psssss = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_2)
			Gade = psssss:GetGrade()
			self:pause();
				----------------------Fantastic
				if Gade == "Grade_Tier01" then
				self:setstate(0)
				elseif Gade == "Grade_Tier02" then
				self:setstate(1)
				elseif Gade == "Grade_Tier03" then
				self:setstate(2)
				elseif Gade == "Grade_Tier04" then
				self:setstate(3)
				elseif Gade == "Grade_Tier05" then
				self:setstate(4)
				elseif Gade == "Grade_Tier06" then
				self:setstate(5)
				elseif Gade == "Grade_Tier07" then
				self:setstate(6)
				else
				self:setstate(7)
				end
		end;
	};
LoadActor(GradeforP2)..{
		InitCommand=function(self) self:y(SCREEN_CENTER_Y-150); self:z(20); self:zoom(1.25); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
			if GradeforP2 == "Tor 4x2.png" then
			self:zoom(0.5)
			end
			psssss = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(PLAYER_2)
			Gade = psssss:GetGrade()
			self:pause();
				----------------------Fantastic
				if Gade == "Grade_Tier01" then
				self:setstate(0)
				elseif Gade == "Grade_Tier02" then
				self:setstate(1)
				elseif Gade == "Grade_Tier03" then
				self:setstate(2)
				elseif Gade == "Grade_Tier04" then
				self:setstate(3)
				elseif Gade == "Grade_Tier05" then
				self:setstate(4)
				elseif Gade == "Grade_Tier06" then
				self:setstate(5)
				elseif Gade == "Grade_Tier07" then
				self:setstate(6)
				else
				self:setstate(7)
				end
				
		end;
	};
	};
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-220+110); self:wag(); self:effectmagnitude(0,-45,0); self:effectperiod(math.random(15,25)); self:effectoffset(math.random(0,5)); end;
		OnCommand=function(self)
			self:visible(Isbattle)
			if Isbattle then
				self:zoom(0)
				self:sleep(3)
				self:decelerate(1)
				self:zoom(1)
			end
		end;
	Def.ActorFrame{
		OnCommand=function(self) self:diffuse(color("#FFFFFF68")); end;
LoadFont("_special elite 108px") .. {
		InitCommand=function(self) self:y(SCREEN_CENTER_Y-150); self:diffusealpha(0.45); self:zoom(1*1.5); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
			if percentP1 < percentP2 then
				self:settext(P2Sc+1)
			self:diffuse(color("#FFFFFF68"))
			self:rainbowscroll(true)
			else
			self:settext(P2Sc)
			self:diffuse(color("#FF880068"))
			end
		end;
	};
	};
LoadFont("_special elite 108px") .. {
		InitCommand=function(self) self:y(SCREEN_CENTER_Y-150); self:z(20); self:zoom(1); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
		end;
		BeginCommand=function(self)
			if percentP1 < percentP2 then
				self:settext(P2Sc+1)
			self:diffuse(color("#FFFFFF"))
			self:rainbowscroll(true)
			else
			self:settext(P2Sc)
			self:diffuse(color("#FF8800"))
			end
		end;
	};
	};
	};
	--Alll rave STUFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF--
		t[#t+1] = Def.ActorFrame{
				InitCommand=function(self) end;
				OnCommand=function(self) self:playcommand('loop'); end;
		loopCommand=function(self)
		if GAMESTATE:GetPlayMode() ~= "PlayMode_Rave" then
		else
		if nep >= 2.249 then
		self:x(whatx)
		self:y(whaty)
		end
		self:sleep(0.02)
		self:queuecommand('loop')
		end
		end;	
		LoadActor("Lose")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y+50); self:zoom(2); end;
			OnCommand=function(self)
		if GAMESTATE:GetPlayMode() ~= "PlayMode_Rave" then
		self:diffusealpha(0)
		else
		self:diffusealpha(0)
		self:zoom(5)
		self:sleep(2.249-0.25)
		self:linear(0.25)
		self:zoom(2)
		if GAMESTATE:IsWinner(PLAYER_1) then
		self:diffuse(PlayerColor(PLAYER_2))
		self:addx(162.5555)
		elseif GAMESTATE:IsWinner(PLAYER_2) then
		self:diffuse(PlayerColor(PLAYER_1))
		self:addx(-162.5555)
		else
		self:diffusealpha(0)
		end
		end
		--+162.5555
			end;
		};
	};
	

	if ShowStandardDecoration("GraphDisplay") and GAMESTATE:GetPlayMode() ~= "PlayMode_Rave" then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		t[#t+1] = StandardDecorationFromTable( "GraphDisplay" .. ToEnumShortString(pn), GraphDisplay(pn) );
	end
end
	
	

t[#t+1] = StandardDecorationFromFileOptional("SongInformation","SongInformation") .. {
	BeginCommand=function(self)
		local SongOrCourse;
		if GAMESTATE:GetCurrentSong() then
			SongOrCourse = GAMESTATE:GetCurrentSong();
		elseif GAMESTATE:GetCurrentCourse() then
			SongOrCourse = GAMESTATE:GetCurrentCourse();
		else
			return
		end
		
		if SongOrCourse:HasBanner() then
			self:visible(false);
		else
			self:visible(true);
		end
	end;
	SetCommand=function(self)
		local c = self:GetChildren();
		local SongOrCourse;
		if GAMESTATE:GetCurrentSong() then
			SongOrCourse = GAMESTATE:GetCurrentSong();

			c.TextTitle:settext( SongOrCourse:GetDisplayMainTitle() or nil );
			c.TextSubtitle:settext( SongOrCourse:GetDisplaySubTitle() or nil );
			c.TextArtist:settext( SongOrCourse:GetDisplayArtist() or nil );

			if SongOrCourse:GetDisplaySubTitle() == "" then
				c.TextTitle:visible(true);
				c.TextTitle:y(-16.5/2);
				c.TextSubtitle:visible(false);
				c.TextSubtitle:y(0);
				c.TextArtist:visible(true);
				c.TextArtist:y(18/2);
			else
				c.TextTitle:visible(true);
				c.TextTitle:y(-16.5);
				c.TextSubtitle:visible(true);
				c.TextSubtitle:y(0);
				c.TextArtist:visible(true);
				c.TextArtist:y(18);
			end
-- 			self:playcommand("Tick");
		elseif GAMESTATE:GetCurrentCourse() then
			SongOrCourse = GAMESTATE:GetCurrentCourse();
			
			c.TextTitle:settext( SongOrCourse:GetDisplayMainTitle() or nil );
			c.TextSubtitle:settext( SongOrCourse:GetDisplaySubTitle() or nil );
			c.TextArtist:settext( SongOrCourse:GetDisplayArtist() or nil );
			
-- 			self:playcommand("Tick");
		else
			SongOrCourse = nil;
			
			c.TextTitle:settext("");
			c.TextSubtitle:settext("");
			c.TextArtist:settext("");
			
			self:playcommand("Hide")
		end
	end;
-- 	OnCommand=function(self) self:playcommand("Set"); end;
	CurrentSongChangedMessageCommand=function(self) self:playcommand("Set"); end;
	CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set"); end;
	DisplayLanguageChangedMessageCommand=function(self) self:playcommand("Set"); end;
};
--t[#t+1] = StandardDecorationFromFileOptional("LifeDifficulty","LifeDifficulty");
--t[#t+1] = StandardDecorationFromFileOptional("TimingDifficulty","TimingDifficulty");
t[#t+1] = StandardDecorationFromFileOptional("GameType","GameType");
t[#t+1] = Def.ActorFrame {
	Condition=GAMESTATE:HasEarnedExtraStage() and GAMESTATE:IsExtraStage() and not GAMESTATE:IsExtraStage2();
	InitCommand=function(self) self:draworder(105); end;
	LoadActor( THEME:GetPathS("ScreenEvaluation","try Extra1" ) ) .. {
		Condition=THEME:GetMetric( Var "LoadingScreen","Summary" ) == false;
		OnCommand=function(self) self:play(); end;
	};
	LoadActor( THEME:GetPathG("ScreenStageInformation","Stage extra1" ) ) .. {
		Condition=THEME:GetMetric( Var "LoadingScreen","Summary" ) == false;
		InitCommand=function(self) self:Center(); end;
		OnCommand=function(self) self:diffusealpha(0); self:zoom(0.85); self:bounceend(1); self:zoom(1); self:diffusealpha(1); self:sleep(0); self:glow(Color("White")); self:decelerate(1); self:glow(Color("Invisible")); self:smooth(0.35); self:zoom(0.25); self:y(SCREEN_BOTTOM-72); end;
	};
};
t[#t+1] = Def.ActorFrame {
	Condition=GAMESTATE:HasEarnedExtraStage() and not GAMESTATE:IsExtraStage() and GAMESTATE:IsExtraStage2();
	InitCommand=function(self) self:draworder(105); end;
	LoadActor( THEME:GetPathS("ScreenEvaluation","try Extra2" ) ) .. {
		Condition=THEME:GetMetric( Var "LoadingScreen","Summary" ) == false;
		OnCommand=function(self) self:play(); end;
	};
	LoadActor( THEME:GetPathG("ScreenStageInformation","Stage extra2" ) ) .. {
		Condition=THEME:GetMetric( Var "LoadingScreen","Summary" ) == false;
		InitCommand=function(self) self:Center(); end;
		OnCommand=function(self) self:diffusealpha(0); self:zoom(0.85); self:bounceend(1); self:zoom(1); self:diffusealpha(1); self:sleep(0); self:glow(Color("White")); self:decelerate(1); self:glow(Color("Invisible")); self:smooth(0.35); self:zoom(0.25); self:y(SCREEN_BOTTOM-72); end;
	};
};
return t
