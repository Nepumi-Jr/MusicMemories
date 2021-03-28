local yao1 = 0;
local Lim1 = 400;
local RealName1 = PN_Name(PLAYER_2);
local SamName1 = PN_Name(PLAYER_2);
function KodPercent(p)
if p < 10 then
return string.format("0%.2f",p).."%";
elseif p >= 10 and p < 100 then
return string.format("%.2f",p).."%";
elseif p >= 100 then
return "100%!!";
end
end

local IG;

local t = Def.ActorFrame{};
t[#t+1] = Def.ActorFrame{
Def.ActorFrame{
	Condition = not (GAMESTATE:GetPlayMode() == 'PlayMode_Rave' or GAMESTATE:GetPlayMode() == 'PlayMode_Battle');
	InitCommand=cmd(x,SCREEN_CENTER_X*2+2.5-175*1.25+75;y,25;zoom,0.8);
	BoomYeahMessageCommand=function(self,param)
		if param.pn == PLAYER_2 then
			self:zoom(0.9):decelerate(0.2):zoom(0.8)
		end
	end;
	LoadFont("Combo Numbers")..{
		Condition = (not(GAMESTATE:IsCourseMode() and (GAMESTATE:GetCurrentCourse():IsOni() or GAMESTATE:GetCurrentCourse():IsEndless())));
		InitCommand=cmd(zoom,0.4;visible,GAMESTATE:IsPlayerEnabled(PLAYER_2););
		OnCommand=function(self)

			SCREENMAN:GetTopScreen():GetChild('ScoreP2'):x(SCREEN_CENTER_X*2+2.5-175*1.25-40)
			SCREENMAN:GetTopScreen():GetChild('ScoreP2'):y(25)
			SCREENMAN:GetTopScreen():GetChild('ScoreP2'):zoom(1)
			--SCREENMAN:GetTopScreen():GetChild('ScoreP2'):visible(true);

			self:queuecommand("Judgment");
		end;
		JudgmentMessageCommand=function(self)
			self:sleep(0.05):queuecommand("RealJud")
		end;
		RealJudCommand=function(self)
			if TP.Battle.IsBattle then
				if (TP.Battle.Hidden and TP.Battle.Mode == "Ac") or (TP.Battle.Mode == "Dr" and TP.Battle.Hidden and not TP.Battle.IsfailorIsDraw) then
					self:settext("xx.xx%");
					SCREENMAN:GetTopScreen():GetChild('ScoreP2'):visible(false);
					self:diffuse(Color.Blue or {0,0,1,1}):diffusetopedge(ColorLightTone(Color.Blue or {0,0,1,1}));
				else
					self:settext(KodPercent(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()*100))
					if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints() <= STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints() and TP.Battle.Mode == "Ac" then
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
				if IG ~= STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetGrade() then
					IG = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetGrade()
					MESSAGEMAN:Broadcast("BoomYeah",{pn=PLAYER_2});
					SCREENMAN:GetTopScreen():GetChild('ScoreP2'):zoom(1.1):decelerate(0.2):zoom(1.0)
				end
				SCREENMAN:GetTopScreen():GetChild('ScoreP2'):diffuse(GameColor.Grade[IG]):diffusetopedge(ColorLightTone(GameColor.Grade[IG]));
				self:diffuse(GameColor.Grade[IG]):diffusetopedge(ColorLightTone(GameColor.Grade[IG]));
				self:settext(KodPercent(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()*100))
			end
		end;
		GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,-100;);
	};
	LoadFont("Combo Numbers")..{
		Condition = (GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():IsEndless());
		InitCommand=cmd(zoom,0.4;visible,GAMESTATE:IsPlayerEnabled(PLAYER_2););
		OnCommand=cmd(playcommand,"Tick");
		TickCommand=function(self)
			if IG ~= STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetGrade() then
				IG = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetGrade()
				MESSAGEMAN:Broadcast("BoomYeah",{pn=PLAYER_2});
			end
			self:diffuse(GameColor.Grade[IG]):diffusetopedge(ColorLightTone(GameColor.Grade[IG]));
			self:settext(SecondsToMMSS(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetSurvivalSeconds()))
		
			self:sleep(0.04):queuecommand("Tick");
		end;
		GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,-100;);
	};
};
};
t[#t+1] = LoadActor("Option.lua")..{
	InitCommand=cmd(x,-5;y,70;diffusealpha,1);
	OnCommand=cmd(sleep,math.max(0.001,GAMESTATE:GetCurrentSong():GetFirstSecond()-1);decelerate,1;diffusealpha,0.3);
	GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,-150;);
};


local x;
if GAMESTATE:IsCourseMode() then
x = GAMESTATE:GetCurrentTrail(PLAYER_2);
else
x = GAMESTATE:GetCurrentSteps(PLAYER_2);
end

t[#t+1] = Def.ActorFrame{
		 LoadFont("_squares bold 72px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+377;y,SCREEN_TOP+37;zoom,1;visible,GAMESTATE:IsPlayerEnabled(PLAYER_2);diffuse,PlayerColor(PLAYER_2));
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
		GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;x,SCREEN_RIGHT+80;);
	};
LoadFont("Common","Normal")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+377;y,SCREEN_TOP+17;zoom,0.75;diffuse,PlayerColor(PLAYER_2));
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
		GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,SCREEN_RIGHT+100;);
	};
};



return t;