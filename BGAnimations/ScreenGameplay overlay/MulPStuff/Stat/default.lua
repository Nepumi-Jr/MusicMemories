local pn = ...
local function KodPercent(p)
    if p < 10 then
        return string.format("0%.2f",p).."%";
    elseif p >= 10 and p < 100 then
        return string.format("%.2f",p).."%";
    elseif p >= 100 then
        return "100%!!";
    end
end

local xScore;
local xOption;
local xDiff;
local xScore2;

if pn == PLAYER_1 then
    xScore = SCREEN_CENTER_X-141.25;
    xScore2 = SCREEN_CENTER_X-256.25;
    xOption = 5;
    xDiff = SCREEN_CENTER_X-377;
else
    xScore = SCREEN_CENTER_X*2+2.5-175*1.25+75;
    xScore2 = SCREEN_CENTER_X*2-256.25;
    xOption = -15+SCREEN_RIGHT-10;
    xDiff = SCREEN_CENTER_X+377;
end


local IG;
local curStageState = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn);
local nowScoring = 0;

local timeDelta = 0;
local lastTimeUpdate = -69;


local palentUpdateFunc = function(self)
	local c = self:GetChildren();
	local thisTime = GetTimeSinceStart()

	if lastTimeUpdate ~= -69 then
		timeDelta = thisTime - lastTimeUpdate;
	end
	lastTimeUpdate = thisTime;

	
	if IG ~= curStageState:GetGrade() then
		IG = curStageState:GetGrade()
		if c.OuterScore then
			c.OuterScore:playcommand("BoomYeah")
		end
		if c.OuterScore2 then
			c.OuterScore2:playcommand("BoomYeah")
		end
	end

	if c.OuterScore and c.OuterScore:GetChild("Score") then
		c.OuterScore:GetChild("Score"):queuecommand("reloadScore")
	end

	if c.OuterScore2 and c.OuterScore2:GetChild("TimeSur") then
		c.OuterScore2:GetChild("TimeSur"):queuecommand("Tick")
	end
	
end;

local t = Def.ActorFrame{};
t[#t+1] = Def.ActorFrame{
	OnCommand=function(self) 
		self:SetUpdateFunction(palentUpdateFunc);
	end;
	OffCommand=function(self)
		self:SetUpdateFunction(nil)
	end;
	Def.ActorFrame{
		Name = "OuterScore";
		Condition = not (GAMESTATE:GetPlayMode() == 'PlayMode_Rave' or GAMESTATE:GetPlayMode() == 'PlayMode_Battle');
		InitCommand=function(self) self:x(xScore2); self:y(25); self:zoom(0.8); end;
		BoomYeahCommand=function(self)
			self:zoom(0.9):decelerate(0.2):zoom(0.8)
		end;
		LoadFont("Combo Numbers")..{
			Name = "Score";
			Condition = (not(GAMESTATE:IsCourseMode() and (GAMESTATE:GetCurrentCourse():IsOni())));
			InitCommand=function(self) self:zoom(0.35); self:visible(GAMESTATE:IsPlayerEnabled(pn)); end;
			reloadScoreCommand=function(self)
				if TP.Battle.IsBattle then
					if (TP.Battle.Hidden and TP.Battle.Mode == "Ac") or (TP.Battle.Mode == "Dr" and TP.Battle.Hidden and not TP.Battle.IsfailorIsDraw) then
						self:settext("---,---,---");
						SCREENMAN:GetTopScreen():GetChild('ScoreP'..(pn == PLAYER_1 and "1" or "2")):visible(false);
						self:diffuse(Color.Blue or {0,0,1,1}):diffusetopedge(ColorLightTone(Color.Blue or {0,0,1,1}));
					else
						self:settext(KodPercent(curStageState:GetPercentDancePoints()*100))
						if STATSMAN:GetCurStageStats():GetPlayerStageStats(pn == PLAYER_1 and PLAYER_2 or PLAYER_1):GetPercentDancePoints() <= curStageState:GetPercentDancePoints() and TP.Battle.Mode == "Ac" then
							self:diffuse(Color.Green or {0,1,0,1}):diffusetopedge(ColorLightTone(Color.Green or {0,1,0,1}));
						else
							self:diffuse(Color.Red or {1,0,0,1}):diffusetopedge(ColorLightTone(Color.Red or {1,0,0,1}));
						end
					end
				else
					self:diffuse(GameColor.Grade[IG]):diffusetopedge(ColorLightTone(GameColor.Grade[IG]));
					nowScoring = nowScoring + ((curStageState:GetScore() - nowScoring) * 30 * timeDelta);
					--printf("%d", curStageState:GetScore())
					if ((curStageState:GetScore() - nowScoring) * 0.5) >= 0.01 then
						local digits = math.floor(math.log10(nowScoring))
						local thatString = string.format( "%09d",round(nowScoring))
						for i = string.len(thatString) + 1 - 3, 2,-3 do
							thatString = string.sub(thatString,1,i-1)..','..string.sub(thatString,i,string.len(thatString))
						end
						self:settext(thatString)
						
						if digits <= 9 then
							self:AddAttribute(0,{Length = 10-digits - math.floor(digits/3); Diffuse = ColorDarkTone(GameColor.Grade[IG]);})
						end
						self:zoom(0.35*11/string.len(thatString))
					elseif curStageState:GetScore() == 0 then
						self:AddAttribute(0,{Length = 10; Diffuse = ColorDarkTone(GameColor.Grade[IG]);})
						self:settext("000,000,000")
					end
				end
			end;
			GETOUTOFGAMESMMessageCommand=function(self) 
				
				local finalScore = curStageState:GetScore();
				local digits = math.floor(math.log10(finalScore))
				local thatString = string.format( "%09d",round(finalScore))
				for i = string.len(thatString) + 1 - 3, 2,-3 do
					thatString = string.sub(thatString,1,i-1)..','..string.sub(thatString,i,string.len(thatString))
				end
				self:settext(thatString)
				
				if digits <= 9 then
					self:AddAttribute(0,{Length = 10-digits - math.floor(digits/3); Diffuse = ColorDarkTone(GameColor.Grade[IG]);})
				end
				
				self:zoom(0.35*11/string.len(thatString))
				self:sleep(.75); self:accelerate(0.5); self:y(-100);
			end;
		};
	};
	Def.ActorFrame{
		Name = "OuterScore2";
		Condition = not (GAMESTATE:GetPlayMode() == 'PlayMode_Rave' or GAMESTATE:GetPlayMode() == 'PlayMode_Battle');
		InitCommand=function(self) self:x(xScore); self:y(25); self:zoom(0.8); end;
		BoomYeahCommand=function(self)
			self:zoom(0.9):decelerate(0.2):zoom(0.8)
		end;
		LoadFont("Combo Numbers")..{
			Name = "Percent";
			Condition = (not(GAMESTATE:IsCourseMode() and (GAMESTATE:GetCurrentCourse():IsOni() or GAMESTATE:GetCurrentCourse():IsEndless())));
			InitCommand=function(self) self:zoom(0.4); self:visible(GAMESTATE:IsPlayerEnabled(pn)); end;
			OnCommand=function(self)
				self:queuecommand("Judgment");
			end;
			JudgmentMessageCommand=function(self)
				self:sleep(0.05):queuecommand("RealJud")
			end;
			RealJudCommand=function(self)
				if TP.Battle.IsBattle then
					if (TP.Battle.Hidden and TP.Battle.Mode == "Ac") or (TP.Battle.Mode == "Dr" and TP.Battle.Hidden and not TP.Battle.IsfailorIsDraw) then
						self:settext("xx.xx%");
						SCREENMAN:GetTopScreen():GetChild('ScoreP'..(pn == PLAYER_1 and "1" or "2")):visible(false);
						self:diffuse(Color.Blue or {0,0,1,1}):diffusetopedge(ColorLightTone(Color.Blue or {0,0,1,1}));
					else
						self:settext(KodPercent(curStageState:GetPercentDancePoints()*100))
						if STATSMAN:GetCurStageStats():GetPlayerStageStats(pn == PLAYER_1 and PLAYER_2 or PLAYER_1):GetPercentDancePoints() <= curStageState:GetPercentDancePoints() and TP.Battle.Mode == "Ac" then
							self:pulse()
							self:effecttiming(0.25,0.25,0.25,0.25);
							self:effectmagnitude(1,1.15,1)
							self:effectclock("beat")
							self:diffuse(Color.Green or {0,1,0,1}):diffusetopedge(ColorLightTone(Color.Green or {0,1,0,1}));
						else
							self:diffuse(Color.Red or {1,0,0,1}):diffusetopedge(ColorLightTone(Color.Red or {1,0,0,1}));
							self:stopeffect()
						end
					end
				else
					self:diffuse(GameColor.Grade[IG]):diffusetopedge(ColorLightTone(GameColor.Grade[IG]));
					self:settext(KodPercent(curStageState:GetPercentDancePoints()*100))
				end
			end;
			GETOUTOFGAMESMMessageCommand=function(self) self:sleep(.75); self:accelerate(0.5); self:y(-100); end;
		};
		LoadFont("Combo Numbers")..{
			Name = "TimeSur";
			Condition = (GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():IsEndless());
			InitCommand=function(self) self:zoom(0.4); self:visible(GAMESTATE:IsPlayerEnabled(pn)); end;
			TickCommand=function(self)
				self:diffuse(GameColor.Grade[IG]):diffusetopedge(ColorLightTone(GameColor.Grade[IG]));
				self:settext(SecondsToMMSS(curStageState:GetSurvivalSeconds()))
			
			end;
			GETOUTOFGAMESMMessageCommand=function(self) self:sleep(.75); self:accelerate(0.5); self:y(-100); end;
		};
	};
};
t[#t+1] = LoadActor("Option.lua",pn)..{
	InitCommand=function(self) self:x(xOption); self:y(70); self:diffusealpha(1); end;
	OnCommand=function(self) self:sleep(math.max(0.001,GAMESTATE:GetCurrentSong():GetFirstSecond()-1)); self:decelerate(1); self:diffusealpha(0.3); end;
	GETOUTOFGAMESMMessageCommand=function(self) self:sleep(.75); self:accelerate(0.5); self:y(-150); end;
};


local x;
if GAMESTATE:IsCourseMode() then
x = GAMESTATE:GetCurrentTrail(pn);
else
x = GAMESTATE:GetCurrentSteps(pn);
end

t[#t+1] = Def.ActorFrame{
		 LoadFont("Combo Number")..{
		InitCommand=function(self) self:x(xDiff); self:y(SCREEN_TOP+47); self:zoom(1); self:visible(GAMESTATE:IsPlayerEnabled(pn)); self:diffuse(PlayerColor(pn)); end;
		OnCommand=function(self)
			local zom = 0.75;
			if x:GetMeter() then
                
                local meter = x:GetMeter()

				if meter <= 9 then
				self:zoom(0.9*zom)
				self:settext(meter)
				elseif meter <= 98 then
				self:zoom(0.8*zom)
				self:settext(meter)
				else
				self:zoom(0.8*zom)
				self:settext("??")
				end
			end
		end;
		GETOUTOFGAMESMMessageCommand=function(self) self:sleep(.75); self:accelerate(0.5); self:x(pn == PLAYER_1 and -80 or SCREEN_RIGHT-80); end;
	};
LoadFont("Common","Normal")..{
		InitCommand=function(self) self:x(xDiff); self:y(SCREEN_TOP+17); self:zoom(0.75); self:diffuse(PlayerColor(pn)); end;
		OnCommand=function(self)
		local DIFFU = ""
		if x:GetDifficulty() then
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
			self:settext(DIFFU)
			self:maxwidth(70)
		end
		end;
		GETOUTOFGAMESMMessageCommand=function(self) self:sleep(.75); self:accelerate(0.5); self:y(-100); end;
	};
};



return t;