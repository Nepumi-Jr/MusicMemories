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

local t = Def.ActorFrame{};
t[#t+1] = Def.ActorFrame{
--GetSurvivalSeconds
Def.ActorFrame{
	Condition = not (GAMESTATE:GetPlayMode() == 'PlayMode_Rave' or GAMESTATE:GetPlayMode() == 'PlayMode_Battle');
	InitCommand=cmd(x,xScore;y,25;zoom,0.8);
	BoomYeahMessageCommand=function(self,param)
		if param.pn == pn then
			self:zoom(0.9):decelerate(0.2):zoom(0.8)
		end
	end;
	LoadFont("Combo Numbers")..{
		Condition = (not(GAMESTATE:IsCourseMode() and (GAMESTATE:GetCurrentCourse():IsOni() or GAMESTATE:GetCurrentCourse():IsEndless())));
		InitCommand=cmd(zoom,0.4;visible,GAMESTATE:IsPlayerEnabled(pn););
		OnCommand=function(self)

			SCREENMAN:GetTopScreen():GetChild('ScoreP'..(pn == PLAYER_1 and "1" or "2")):x(xScore2)
			SCREENMAN:GetTopScreen():GetChild('ScoreP'..(pn == PLAYER_1 and "1" or "2")):y(25)
			SCREENMAN:GetTopScreen():GetChild('ScoreP'..(pn == PLAYER_1 and "1" or "2")):zoom(1)
			--SCREENMAN:GetTopScreen():GetChild('ScoreP1'):visible(true);

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
					self:settext(KodPercent(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPercentDancePoints()*100))
					if STATSMAN:GetCurStageStats():GetPlayerStageStats(pn == PLAYER_1 and PLAYER_2 or PLAYER_1):GetPercentDancePoints() <= STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPercentDancePoints() and TP.Battle.Mode == "Ac" then
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
				if IG ~= STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetGrade() then
					IG = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetGrade()
					MESSAGEMAN:Broadcast("BoomYeah",{pn=pn});
					SCREENMAN:GetTopScreen():GetChild('ScoreP'..(pn == PLAYER_1 and "1" or "2")):zoom(1.1):decelerate(0.2):zoom(1.0)
				end
				SCREENMAN:GetTopScreen():GetChild('ScoreP'..(pn == PLAYER_1 and "1" or "2")):diffuse(GameColor.Grade[IG]):diffusetopedge(ColorLightTone(GameColor.Grade[IG]));
				self:diffuse(GameColor.Grade[IG]):diffusetopedge(ColorLightTone(GameColor.Grade[IG]));
				self:settext(KodPercent(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPercentDancePoints()*100))
			end
		end;
		GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,-100;);
	};
	LoadFont("Combo Numbers")..{
		Condition = (GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():IsEndless());
		InitCommand=cmd(zoom,0.4;visible,GAMESTATE:IsPlayerEnabled(pn););
		OnCommand=cmd(playcommand,"Tick");
		TickCommand=function(self)
			if IG ~= STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetGrade() then
				IG = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetGrade()
				MESSAGEMAN:Broadcast("BoomYeah",{pn=pn});
			end
			self:diffuse(GameColor.Grade[IG]):diffusetopedge(ColorLightTone(GameColor.Grade[IG]));
			self:settext(SecondsToMMSS(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetSurvivalSeconds()))
		
			self:sleep(0.04):queuecommand("Tick");
		end;
		GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,-100;);
	};
};
};
t[#t+1] = LoadActor("Option.lua",pn)..{
	InitCommand=cmd(x,xOption;y,70;diffusealpha,1);
	OnCommand=cmd(sleep,math.max(0.001,GAMESTATE:GetCurrentSong():GetFirstSecond()-1);decelerate,1;diffusealpha,0.3);
	GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,-150;);
};


local x;
if GAMESTATE:IsCourseMode() then
x = GAMESTATE:GetCurrentTrail(pn);
else
x = GAMESTATE:GetCurrentSteps(pn);
end

t[#t+1] = Def.ActorFrame{
		 LoadFont("_squares bold 72px")..{
		InitCommand=cmd(x,xDiff;y,SCREEN_TOP+37;zoom,1;visible,GAMESTATE:IsPlayerEnabled(pn);diffuse,PlayerColor(pn));
		OnCommand=function(self)
			local zom = 0.75;
			if x:GetMeter() then

				if x:GetMeter() <= 9 then
				self:zoom(1*zom)
				self:settext(x:GetMeter())
				elseif x:GetMeter() <= 98 then
				self:zoom(0.8*zom)
				self:settext(x:GetMeter())
				else
				self:zoom(0.8*zom)
				self:settext("??")
				end
			end
		end;
		GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;x,pn == PLAYER_1 and -80 or SCREEN_RIGHT-80;);
	};
LoadFont("Common","Normal")..{
		InitCommand=cmd(x,xDiff;y,SCREEN_TOP+17;zoom,0.75;diffuse,PlayerColor(pn));
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
		GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,-100;);
	};
};



return t;