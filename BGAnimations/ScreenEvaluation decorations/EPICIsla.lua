local ISLA_PQ = {};--<int,string>
local ILZ = 0;

local VI = false;

local function ISLA_SWAP(a,b)
	local tod = ISLA_PQ[a];
	ISLA_PQ[a] = ISLA_PQ[b];
	ISLA_PQ[b] = tod;
end;

local function ISLA_PQ_PUSH(x)
	ISLA_PQ[ILZ+1] = x;ILZ = ILZ+1;
	local ind = ILZ;

	while ind > 1 do
		if ISLA_PQ[ind][1] > ISLA_PQ[math.floor(ind/2)][1] then
			ISLA_SWAP(ind,math.floor(ind/2));
			ind = math.floor(ind/2);
		else
			return;
		end
	end

end;

local function ISLA_PQ_POP()
	local RRRR = ISLA_PQ[1];
	ISLA_PQ[1] = ISLA_PQ[ILZ];ILZ = ILZ-1;
	local ind = 1;

	while ind*2 <= ILZ do
		--SM(string.format("\n\n\n IND at %d",ind));

		if ind*2+1 <= ILZ then

			if ISLA_PQ[ind*2][1] > ISLA_PQ[ind*2+1][1] then
				if ISLA_PQ[ind*2][1] > ISLA_PQ[ind][1] then
					ISLA_SWAP(ind*2,ind);
					ind = ind*2;
				elseif ISLA_PQ[ind*2+1][1] > ISLA_PQ[ind][1] then
					ISLA_SWAP(ind*2+1,ind);
					ind = ind*2+1;
				else
					return RRRR;
				end
			elseif ISLA_PQ[ind*2+1][1] > ISLA_PQ[ind*2][1] then
				if ISLA_PQ[ind*2+1][1] > ISLA_PQ[ind][1] then
					ISLA_SWAP(ind*2+1,ind);
					ind = ind*2;
				elseif ISLA_PQ[ind*2][1] > ISLA_PQ[ind][1] then
					ISLA_SWAP(ind*2,ind);
					ind = ind*2;
				else
					return RRRR;
				end
			else
				return RRRR;
			end

		else
			if ISLA_PQ[ind*2][1] > ISLA_PQ[ind][1] then
				ISLA_SWAP(ind*2,ind);
				ind = ind*2;
			else
				return RRRR;
			end
		end
	end

	return RRRR;

end;


local ISMISSION1 = false;
local ISMISSION2 = false;
local ISLAC;

local BBEAT = true;

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

local ConA = {};
local ConAI = 1;
local ConB = {};
local ConBI = 1;

-- P1 START HEREEEEEEEEEEEE
local pn = PLAYER_1;
if GAMESTATE:IsPlayerEnabled(pn) then
	if ISMISSION1 then
		ISLA_PQ_PUSH({10000,"Mission Success!"});
		--table.insert( Content1,"MISSION_"..PnMissionState(PLAYER_1,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)));
	end
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPeakComboAward() then
		ISLAC = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPeakComboAward();
		ISLA_PQ_PUSH({20,"The "..string.sub(ISLAC,16,string.len(ISLAC)).." combos Destroyer!"});
		--table.insert( Content1,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPeakComboAward());
	end
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetStageAward() then
		ISLAC = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetStageAward()
		if ISLAC == "StageAward_80PercentW3" then
			ISLA_PQ_PUSH({18,"Clear with 80% Great..."});
		elseif ISLAC == "StageAward_90PercentW3" then
			ISLA_PQ_PUSH({32,"90% is Great..."});
		elseif ISLAC == "StageAward_100PercentW3" then
			ISLA_PQ_PUSH({12000,"Great Confirm 100%..."});
		elseif ISLAC == "StageAward_FullComboW1" then
			ISLA_PQ_PUSH({12000,"ALL FANTASTIC!!!"});
		elseif ISLAC == "StageAward_FullComboW2" then
			ISLA_PQ_PUSH({11000,"ALL PERFECT!!"});
		elseif ISLAC == "StageAward_FullComboW3" then
			ISLA_PQ_PUSH({10,"FullCombo By Great"});
		elseif ISLAC == "StageAward_OneW2" then
			ISLA_PQ_PUSH({11000,"ONE PERFECT WHYYY"});
		elseif ISLAC == "StageAward_OneW3" then
			ISLA_PQ_PUSH({500,"Almost ALL Perfect"});
		elseif ISLAC == "StageAward_SingleDigitW2" then
			ISLA_PQ_PUSH({50,"FullCombo By LESS 10 Perfect!"});
		elseif ISLAC == "StageAward_SingleDigitW3" then
			ISLA_PQ_PUSH({12,"FullCombo by Less 10 Great"});
		end
		VI = true;
		--
		--table.insert( Content1,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetStageAward());
	elseif STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_Miss") + STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_W5")+ STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_W4") == 1 then
		ISLA_PQ_PUSH({13000,"CHOCKED..."});
		VI = true;
	end
			--SM("\n\n\n\n\n"..tostring(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_Miss") + STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_W5")+ STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_W4")))
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPersonalHighScoreIndex() then
		--SM("\n\n\n\n ISLA : "..tostring(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPersonalHighScoreIndex()))
		if STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPersonalHighScoreIndex() == 0 then
			ISLA_PQ_PUSH({2,"New Personal Record"});
		end
	end
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetMachineHighScoreIndex() then
		--SM("\n\n\n\n ISLA : "..tostring(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetMachineHighScoreIndex()))
		if STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetMachineHighScoreIndex() == 0 then
			ISLA_PQ_PUSH({5,"New Machine Record"});
		end
	end

end

--SM("\n\n\n\n\nENDED BY "..ILZ);
local SAY_STATE = "Results";
local SAY_POWER = -1;

if #ISLA_PQ > 1 then
	SAY_STATE = ISLA_PQ[1][2]
	SAY_POWER = ISLA_PQ[1][1]
end

if ILZ >= 4 then
	
	for i = 1, 4 do
		local tod = ISLA_PQ_POP();
		ConA[#ConA+1] = tod[2];
	end
	for i = 1, ILZ do
		local tod = ISLA_PQ_POP();
	end
else
	for i = 1, ILZ do
		local tod = ISLA_PQ_POP();
		ConA[#ConA+1] = tod[2];
	end
end

-- P2 START HEREEEEEEEEEEEE
local pn = PLAYER_2;
if GAMESTATE:IsPlayerEnabled(pn) then
	if ISMISSION2 then
		ISLA_PQ_PUSH({10000,"Mission Success!"});
		--table.insert( Content1,"MISSION_"..PnMissionState(PLAYER_1,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)));
	end
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPeakComboAward() then
		ISLAC = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPeakComboAward();
		ISLA_PQ_PUSH({20,"The "..string.sub(ISLAC,16,string.len(ISLAC)).." combos Destroyer!"});
		--table.insert( Content1,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPeakComboAward());
	end
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetStageAward() then
		ISLAC = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetStageAward()
		if ISLAC == "StageAward_80PercentW3" then
			ISLA_PQ_PUSH({18,"Clear with 80% Great..."});
		elseif ISLAC == "StageAward_90PercentW3" then
			ISLA_PQ_PUSH({32,"90% is Great..."});
		elseif ISLAC == "StageAward_100PercentW3" then
			ISLA_PQ_PUSH({12000,"Great Confirm 100%..."});
		elseif ISLAC == "StageAward_FullComboW1" then
			ISLA_PQ_PUSH({12000,"ALL FANTASTIC!!!"});
		elseif ISLAC == "StageAward_FullComboW2" then
			ISLA_PQ_PUSH({11000,"ALL PERFECT!!"});
		elseif ISLAC == "StageAward_FullComboW3" then
			ISLA_PQ_PUSH({10,"FullCombo By Great"});
		elseif ISLAC == "StageAward_OneW2" then
			ISLA_PQ_PUSH({11000,"ONE PERFECT WHYYY"});
		elseif ISLAC == "StageAward_OneW3" then
			ISLA_PQ_PUSH({500,"Almost ALL Perfect"});
		elseif ISLAC == "StageAward_SingleDigitW2" then
			ISLA_PQ_PUSH({50,"FullCombo By LESS 10 Perfect!"});
		elseif ISLAC == "StageAward_SingleDigitW3" then
			ISLA_PQ_PUSH({12,"FullCombo by Less 10 Great"});
		end
		VI = true;
		--
		--table.insert( Content1,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetStageAward());
	elseif STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_Miss") + STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_W5")+ STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_W4") == 1 then
		ISLA_PQ_PUSH({13000,"CHOCKED..."});
		VI = true;
	end
			--SM("\n\n\n\n\n"..tostring(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_Miss") + STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_W5")+ STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_W4")))
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPersonalHighScoreIndex() then
		if STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPersonalHighScoreIndex() == 0 then
			ISLA_PQ_PUSH({2,"New Personal Record"});
		end
	end
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetMachineHighScoreIndex() then
		if STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetMachineHighScoreIndex() == 0 then
			ISLA_PQ_PUSH({5,"New Machine Record"});
		end
	end

end

if #ISLA_PQ > 1 then
	if ISLA_PQ[1][1] > SAY_POWER then
		SAY_STATE = ISLA_PQ[1][2]
		SAY_POWER = ISLA_PQ[1][1]
	end
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

SC = 0;
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	SC = math.max(SC,STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPercentDancePoints())
end



if ILZ >= 4 then
	for i = 1, 4 do
		local tod = ISLA_PQ_POP();
		ConB[#ConB+1] = tod[2];
	end
	for i = 1, ILZ do
		local tod = ISLA_PQ_POP();
	end
else
	for i = 1, ILZ do
		local tod = ISLA_PQ_POP();
		ConB[#ConB+1] = tod[2];
	end
end





local TICK = 3.649;

local BPM = 128;
local REST = 20;
local STR = REST;
local SP = 100;

local RI = false;

local CX = SCREEN_CENTER_X;
local CY = SCREEN_CENTER_Y;
if #ConA == 0 and #ConB == 0 then
	return Def.ActorFrame{};
else

local BGtod = LoadModule("Eva.StateTier.lua")();



if BGtod == "WOW" then
	BPM = 4*60/3.474;
	TICK = 60/BPM*8;
	STR = 35;
	REST = 35;
	SP = 60;
	VI = true;
	RI = true;
elseif BGtod == "BEAT" then
	TICK = 60/BPM*8;
	VI = true;
else
	STR = 0;
	REST = 0;
	VI = false;
end

if VI then
	TICK = 60/BPM*8;
else
	STR = 0;
	REST = 0;
end


local t = Def.ActorFrame{
	OnCommand=cmd(draworder,50025);
	Def.Quad{
		Condition = VI;
		OnCommand=cmd(visible,false;playcommand,"ISLALA");
		ISLALACommand=function(self)
			if STR > 0 then
				STR = STR - 0.02*SP;
			end
			self:sleep(0.02):queuecommand("ISLALA");
		end;
	};
	Def.Quad{
		Condition = VI;
		OnCommand=cmd(sleep,PREFSMAN:GetPreference("GlobalOffsetSeconds")*(-1) or 0;visible,false;playcommand,"ISLALA2");
		ISLALA2Command=function(self)
			STR = REST;
			self:sleep(60/BPM):queuecommand("ISLALA2");
		end;
	};
	Def.ActorFrame{
		OnCommand=cmd(SetUpdateFunction,function(self)
			local RSTR = math.ceil( STR )
			local Force = 0.1;
			if RSTR > 0 then
				--self:x(math.random(-RSTR,RSTR)*Force);
				SCREENMAN:GetTopScreen():x(math.random(-RSTR,RSTR)*Force);
				SCREENMAN:GetTopScreen():y(math.random(-RSTR,RSTR)*Force);
			else SCREENMAN:GetTopScreen():x(0):y(0)
			end
			end;);
	};

	LoadActor("IslaYey")..{
		Condition = OP();
		InitCommand=cmd(vertalign,top;x,CX*1.7;diffusealpha,0;zoom,0.25);
		OnCommand=cmd(decelerate,0.3;x,CX*1.1;diffusealpha,0.7;linear,TICK * (math.max(#ConB,#ConA));x,CX*0.9;decelerate,0.3;x,CX*0.3;diffusealpha,0;);
	};
	

	--A
	Def.ActorFrame{
		InitCommand=cmd(y,(#ConA == #ConA + #ConB) and CY or CY*0.75);
		Condition = (#ConA > 0);
		Def.Quad{
			InitCommand=cmd(CenterX;zoomy,150;zoomx,CX*2;fadetop,0.2;fadebottom,0.2;cropright,1;diffusealpha,0);
			OnCommand=cmd(decelerate,0.3;cropright,0;diffusealpha,0.7;sleep,TICK * (#ConA);decelerate,0.3;cropleft,1;diffusealpha,0;);
		};
		LoadFont("Common Normal")..{
			Text = "Player 1";
			InitCommand=cmd(x,30;y,-35;zoom,0.7;diffuse,{0,0,0,0};);
			OnCommand=cmd(decelerate,0.3;diffusealpha,1;sleep,TICK * (#ConA);decelerate,0.3;diffusealpha,0;);
		};
		Def.ActorFrame{
			OnCommand=cmd(linear,0.3;x,350;linear,TICK * (#ConA);x,CX*2-350;linear,0.3;x,CX*2);
			Def.ActorFrame{
				OnCommand=cmd(SetUpdateFunction,function(self)
				local RSTR = math.ceil( STR )
				local Force = 0.3;
				if RSTR > 0 then
					self:x(math.random(-RSTR,RSTR)*Force);
					self:y(math.random(-RSTR,RSTR)*Force);
					self:zoom(math.random(0,RSTR)/10*Force+1);
					self:rotationz(math.random(-RSTR,RSTR)/0.7*Force);
				else self:x(0):y(0):zoom(1):rotationz(0)
				end
				end;);
				LoadFont("Common Normal")..{
					InitCommand=cmd(diffuse,{0,0,0,0};zoom,2.5);
					OnCommand=cmd(sleep,0.3;playcommand,"ILALA");
					ILALACommand=function(self)
					
						if RI then
							self:rainbow():effectperiod(0.2)
						else
							self:stopeffect()
						end
					
						self:linear(TICK*0.15):settext(ConA[ConAI]):diffusealpha(1);ConAI = ConAI +1;
						self:sleep(TICK*0.7)
						self:linear(TICK*0.15):diffusealpha(0);
						if ConAI <= #ConA then
							self:queuecommand("ILALA");
						end
					end;
				};
			};
		};

	};

	--B
	Def.ActorFrame{
		InitCommand=cmd(y,(#ConB == #ConA + #ConB) and CY or CY*1.25);
		Condition = (#ConB > 0);
		Def.Quad{
			InitCommand=cmd(CenterX;zoomy,150;zoomx,CX*2;fadetop,0.2;fadebottom,0.2;cropright,1;diffusealpha,0);
			OnCommand=cmd(decelerate,0.3;cropright,0;diffusealpha,0.7;sleep,TICK * (#ConB);decelerate,0.3;cropleft,1;diffusealpha,0;);
		};
		LoadFont("Common Normal")..{
			Text = "Player 2";
			InitCommand=cmd(x,30;y,-35;zoom,0.7;diffuse,{0,0,0,0};);
			OnCommand=cmd(decelerate,0.3;diffusealpha,1;sleep,TICK * (#ConB);decelerate,0.3;diffusealpha,0;);
		};
		Def.ActorFrame{
			OnCommand=cmd(linear,0.3;x,350;linear,TICK * (#ConB);x,CX*2-350;linear,0.3;x,CX*2);
			Def.ActorFrame{
				OnCommand=cmd(SetUpdateFunction,function(self)
				local RSTR = math.ceil( STR )
				local Force = 0.3;
				if RSTR > 0 then
					self:x(math.random(-RSTR,RSTR)*Force);
					self:y(math.random(-RSTR,RSTR)*Force);
					self:zoom(math.random(0,RSTR)/10*Force+1);
					self:rotationz(math.random(-RSTR,RSTR)/0.7*Force);
				else self:x(0):y(0):zoom(1):rotationz(0)
				end
				end;);
				LoadFont("Common Normal")..{
					InitCommand=cmd(diffuse,{0,0,0,0};zoom,2.5);
					OnCommand=cmd(sleep,0.3;playcommand,"ILALA");
					ILALACommand=function(self)
					
						if RI then
							self:rainbow():effectperiod(0.2)
						else
							self:stopeffect()
						end
					
						self:linear(TICK*0.15):settext(ConB[ConBI]):diffusealpha(1);ConBI = ConBI +1;
						self:sleep(TICK*0.7)
						self:linear(TICK*0.15):diffusealpha(0);
						if ConBI <= #ConB then
							self:queuecommand("ILALA");
						end
					end;
				};
			};
		};

	};
};
return t;
end