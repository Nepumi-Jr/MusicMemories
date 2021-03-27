local lim = 1000;
local NEPcmd = {};
local HUAJAIP = {false,false};
local Ter = false;
local HNUM = {6969,6969};
local SAO = {};for i=1,lim do SAO[i] = 7 end
local SEG_HARD = {}for i=1,lim do SEG_HARD[i] = 0 end


local function WHATTABLE(S)
	local Talk = "";
	if type(S) ~= "table" then
		return tostring(S);
	else
		local crt = 1;
		Talk = "#"..tostring(#S)..":{";
		for Con in ivalues(S) do
			Talk = Talk..WHATTABLE(Con)..",";
			crt = crt + 1;
			if crt == 10 then crt = 1; Talk = Talk.."\n"; end
		end
		Talk = Talk.."}";
		return Talk;
	end
end;

local TS;
	if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		TS = "PA"
	elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
		TS = "P1"
	elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		TS = "P2"
	end
local nsP,msP = 1,2; if TS == "P1" then msP = 1 elseif TS == "P2" then nsP = 2 end

--SAO Has 0 - 10

--GAIN STEP STUFF
--SOURCE: https://github.com/JonathanKnepp/SM5StreamParser

local function HelpAutogen(St,value)
	local all = {}
	
	for nep in string.gmatch(St,"([^-]+)") do
		table.insert(all,nep)
	end
	
	local gam = all[1]
	

	if string.lower(gam) == "dance" then
		if value == 1 then
			return "pump".."-"..all[2]
		end
	elseif string.lower(gam) == "pump" then
		if value == 1 then
			return "dance".."-"..all[2]
		end
	end
end

-- Utility function to replace regex special characters with escaped characters
local function regexEncode(var)
	return (var:gsub('%%', '%%%'):gsub('%^', '%%^'):gsub('%$', '%%$'):gsub('%(', '%%('):gsub('%)', '%%)'):gsub('%.', '%%.'):gsub('%[', '%%['):gsub('%]', '%%]'):gsub('%*', '%%*'):gsub('%+', '%%+'):gsub('%-', '%%-'):gsub('%?', '%%?'))
end

local GOFML = false;--Get Out Of My Life


local function OPFil()
--GET INFORMATION
local files = FILEMAN:GetDirListing(GAMESTATE:GetCurrentSong():GetSongDir())
local STUFF;

	for file in ivalues(files) do
		if file:find(".+%.[sS][sS][cC]$") then
			-- Finding a .ssc file is preferable.
			-- If we find one, stop looking.
			fileN = file
			fileT = "ssc"
			break
		elseif file:find(".+%.[sS][mM]$") then
			-- Don't break if we find a .sm file first;
			-- there might still be a .ssc file waiting.
			fileN = file
			fileT = "sm"
		end
	end
	if (not (fileN and fileT)) or fileT =="dwi" then return nil 
	else return {fileN,fileT} end
end
	
local function GetCh(x)
	
	if x == nil then return nil; end
	
	local fileN=x[1];
	local fileT=x[2];
	local MSP = {"",""};
	-- create a generic RageFile that we'll use to read the contents
	-- of the desired .ssc or .sm file
	local f = RageFileUtil.CreateRageFile()

	-- the second argument here (the 1) signifies
	-- that we are opening the file in read-only mode
	if f:Open(GAMESTATE:GetCurrentSong():GetSongDir() .. fileN, 1) then
		STUFF = f:Read()
	end

	-- destroy the generic RageFile now that we have the contents
	f:destroy()

	--
	
	for i = nsP,msP do--Get from EVERY PLAYER!
		local step = GAMESTATE:GetCurrentSteps(_G['PLAYER_'..i]);
		local stepkwa = ToEnumShortString( step:GetStepsType() ):gsub("_", "-"):lower()
		local dif = ToEnumShortString( step:GetDifficulty() )
		local des = step:GetDescription()
		--GET STRING NOW
			if fileT == "ssc" then
				-- SSC File
				-- Loop through each chart in the SSC file
				for chart in STUFF:gmatch("#NOTEDATA.-#NOTES:[^;]*") do
					-- Find the chart that matches our difficulty and game type
					local DLC=true;
					if dif == "Edit" then
						DLC = (chart:match("#DESCRIPTION:"..regexEncode(des)))
					end
					
					if(chart:match("#STEPSTYPE:"..regexEncode(stepkwa)) and chart:match("#DIFFICULTY:"..regexEncode(dif)) and DLC) then
						--Find just the notes and remove comments
						MSP[i] = chart:match("#NOTES:[\r\n]+([^;]*)\n?$"):gsub("//[^\r\n]*","") .. ";"						
					end
				end
				
				if MSP[i] == "" then--FIRST CYCLE Can't find
					
					for chart in STUFF:gmatch("#NOTEDATA.-#NOTES:[^;]*") do
					-- Find the chart that matches our difficulty and game type
					local DLC=true;
					if dif == "Edit" then
						DLC = (chart:match("#DESCRIPTION:"..regexEncode(des)))
					end
					
					if(chart:match("#STEPSTYPE:"..regexEncode(HelpAutogen(stepkwa,1))) and chart:match("#DIFFICULTY:"..regexEncode(dif)) and DLC) then
						MSP[i] = chart:match("#NOTES:[\r\n]+([^;]*)\n?$"):gsub("//[^\r\n]*","") .. ";"
					end
					end
				
				end
				
				if MSP[i] == "" then--2ND CYCLE Can't find
					
					for chart in STUFF:gmatch("#NOTEDATA.-#NOTES:[^;]*") do
				if (chart:match("#STEPSTYPE:"..regexEncode(stepkwa)) and chart:match("#DIFFICULTY:"..regexEncode(dif))) then
						--Find just the notes and remove comments
						MSP[i] = chart:match("#NOTES:[\r\n]+([^;]*)\n?$"):gsub("//[^\r\n]*","") .. ";"
				end
				end
				end
				
				if not MSP[i] then--3ND CYCLE Can't find
					
					for chart in STUFF:gmatch("#NOTEDATA.-#NOTES:[^;]*") do
				if (chart:match("#STEPSTYPE:"..regexEncode(HelpAutogen(stepkwa,1))) and chart:match("#DIFFICULTY:"..regexEncode(dif))) then
						--Find just the notes and remove comments
						MSP[i] = chart:match("#NOTES:[\r\n]+([^;]*)\n?$"):gsub("//[^\r\n]*","") .. ";"
				end
				end
				end
				
				
			elseif fileT == "sm" then
				-- SM FILE
				-- Loop through each chart in the SM file
				for chart in STUFF:gmatch("#NOTES[^;]*") do
					-- split the entire chart string into pieces on ":"
					local pieces = {}
					for str in chart:gmatch("[^:]+") do
						pieces[#pieces+1] = str
					end

					-- the pieces table should contain 7 numerically indexed items
					-- 2, 4, and 7 are the indices we care about for finding the correct chart
					-- index 2 will contain the steps_type (like "dance-single")
					-- index 4 will contain the difficulty (like "challenge")

					-- use gsub to scrub out line breaks (and other irrelevant characters?)
					local st = pieces[2]:gsub("[^%w-]", "")
					local diff = pieces[4]:gsub("[^%w]", "")
					local DLC=true;
					if dif == "Edit" then
						DLC = ((pieces[3]:gsub("[^%w]", ""))==des)
					end
					
					-- if this particular chart's steps_type matches the desired StepsType
					-- and its difficulty string matches the desired Difficulty
					if (st == stepkwa) and (diff == dif) and DLC then
						-- then index 7 contains the notedata that we're looking for
						-- use gsub to remove comments, store the resulting string,
						-- and break out of the chart loop now
						MSP[i] = pieces[7]:gsub("//[^\r\n]*","") .. ";"
						break
					end
				end
			end
	end
	return MSP
end

local function CalSC(x)
	
	if x == nil then return nil end;
	local BEAT = {{},{}};
	local MSP = x;
	
	
	for i = nsP,msP do--SET to EVERY PLAYER!
		if MSP[i] then
		local SCHOD = 0;
		local IND = 0;
		local CHUCK = {};
		local CHI = 1;
		for bt in  MSP[i]:gmatch("[^\r\n]+") do--EVERY Line
			if(bt:match("^[,;]%s*")) then --ENDO of MES or All
				
				local FCHI = round(CHI/4)*4;
				local SS = 0;
				
				for j = 1 , FCHI do
					if j < CHI then SS = SS + CHUCK[j]; end
				
					if math.mod(j,FCHI/4) == 0 then
						IND = IND + 1;
						BEAT[i][IND] = SS;SS = 0;
					end
					
				end;
				CHI = 1;
			
			else
			--1 is NOTE
			--2 is OpenHold
			--3 is EndedHold/Roll
			--4 is OpenRoll
			--L is Lift
			--F is Fake
			--M is Mine
				for j = 1,string.len(bt) do
					if	string.sub(bt,j,j) == "1" or
						string.sub(bt,j,j) == "2" or
						string.sub(bt,j,j) == "4" then
						SCHOD = SCHOD + 1;
					elseif	string.sub(bt,j,j) == "F" then
						SCHOD = SCHOD + 0.1;
					elseif	string.sub(bt,j,j) == "M"  then
						SCHOD = SCHOD + 0.5;
					elseif	string.sub(bt,j,j) == "L"   then
						SCHOD = SCHOD + 1.5;
					end
				end
				CHUCK[CHI] = SCHOD;
				SCHOD = 0;
				CHI = CHI +1;
			end
		end
		
		local step = GAMESTATE:GetCurrentSteps(_G['PLAYER_'..i]);
		local Timai = step:GetTimingData():GetWarps();--REMOVE WARP
		if #Timai ~= 0 then
		for x = 1,#Timai do
			local YAG = split("=", Timai[x]) 
				for LG = tonumber(YAG[1]),tonumber(YAG[1]+YAG[2]) do
					BEAT[i][LG] = (BEAT[i][LG] or 0) * 0.05 ;
				end
		end end
		end
	end
	return BEAT;
end
	
local function ConV(x)
	if x == nil then return nil end;
	--WHATTABLE(x);
	
	local Sec = {{},{}};
	local Mes = x;--AKA BEAT
	
	for i = nsP,msP do
		if Mes[i] then
		
		local nTD = GAMESTATE:GetCurrentSteps(_G['PLAYER_'..i]):GetTimingData();
		local Pre = 1;--As Preieoveovioe Beat
		
		for M = 1,lim do
		--(ALMOST) PERCENTILE
		local TUM = nTD:GetBeatFromElapsedTime((M/lim)*GAMESTATE:GetCurrentSong():GetLastSecond());
			
			local ss = 0;
			
			--Check Pre;
			if math.floor(Pre) ~= Pre then ss = scale(Pre-math.floor(Pre),0,1,Mes[i][math.floor(Pre)] or 0,Mes[i][math.floor(Pre)+1] or 0) Pre = math.floor(Pre)+1 end
			
			for j = Pre,math.floor(TUM) do
				--SM("\n\n\n\n\n\n\n\n\n\n\n Last call j = "..j.." but # is "..(#Mes[i]));
				if j > #Mes[i] then
					ss = ss + (Mes[i][#Mes[i]] or 0);
				else
					
				
					ss = ss +  (Mes[i][j] or 0);
				end
			end
			
			--Check End;
			if math.floor(TUM)+1 <= #Mes[i] and math.floor(TUM) ~= TUM then 
			ss = ss + scale(TUM-math.floor(TUM),0,1,
			Mes[i][math.floor(TUM)] or 0,
			Mes[i][math.floor(TUM)+1] or 0) 
			end
			
			Sec[i][M] = ss;
			
			SEG_HARD[M] = SEG_HARD[M] + ss;
			
			Pre = TUM;
			
		
		end
		end
	end
	return Sec;
end
	
local function Regis(x)
	
	if x == nil then return nil; end;
	--SM("\n\n\n\n Segment is \n"..WHATTABLE(x));
	local Sec = x;
	local Rec = {{},{}};
	--SCREENMAN:SystemMessage("\n\n\n\n\n\n\n\n\n****Nep:"..tostring(#x[1]))
	
	for i = nsP,msP do
		if Sec[i] then
		local X=0;
			for M = 1,lim do
				X = X + (Sec[i][M]/lim);
			end
			for M = 1,lim do
				Rec[i][M] = math.min(math.max((Sec[i][M]-X)+5,0),10)
			end
		end
	end
	return Rec
end

--SCREENMAN:SystemMessage("\n"..tostring(
	--						Regis(ConV(CalSC(GetCh(OPFil()))))
		--					));






local M = Def.ActorFrame{
	OnCommand=function(self)
	
	local Rec = Regis(ConV(CalSC(GetCh(OPFil()))));
	
	if Rec ~= nil and true then--NOT TODAY!
	
	
	for M = 1,lim do
	local sum = 0
		for i = nsP,msP do
			if Rec[i] then
			sum = sum + (Rec[i][M])/((msP-nsP)+1)
			end
		end
		SAO[M] = sum;
	end
	
	
	end
	
	end;
};

local FIRE = {false,false};
local ms = -1
local ns = math.huge;

	M[#M+1] = Def.ActorFrame{
		OnCommand=function(self)
			
			for i = 1,lim do
				ms = math.max(ms,SEG_HARD[i]);
				ns = math.min(ns,SEG_HARD[i]);
			end
			
			
			local WHITE = Color.White or {1,1,1,1};
			local RED = Color.Red or {1,0,0,1};
			local WR = {
					(RED[1]+WHITE[1])/2,
					(RED[2]+WHITE[2])/2,
					(RED[3]+WHITE[3])/2,
					1
				}
			local GREEN = Color.Green or {1,0,0,1};
			local WG = {
					(GREEN[1]+WHITE[1])/2,
					(GREEN[2]+WHITE[2])/2,
					(GREEN[3]+WHITE[3])/2,
					1
				}
			
			if ms == ns then
				self:diffuse(WR)
			else
			local xt = function(self)
					PER = GAMESTATE:GetCurMusicSeconds()*lim/GAMESTATE:GetCurrentSong():GetLastSecond();
					local ind = math.max(math.min(PER,#SEG_HARD-1),1)+1;
					
					local SCH = SEG_HARD[math.floor(ind)];
					if ind < #SEG_HARD then
						SCH = scale(ind-math.floor(ind),0,1,SEG_HARD[math.floor(ind)],SEG_HARD[math.floor(ind)+1]);
					end
					
					
					
					local SCHP = scale(SCH,ns,ms,0,1);
					
					--SM(string.format("\n\n\n Scale [%.1f,%.1f] and %.1f P%.1f is %.1f",ns,ms,SCH,PER,SCHP));
					
					if SCHP > 0.85 then
						self:diffuse({
							scale(SCHP,0.7,1,WHITE[1],WR[1]),
							scale(SCHP,0.7,1,WHITE[2],WR[2]),
							scale(SCHP,0.7,1,WHITE[3],WR[3]),
							1
						})
					elseif SCHP < 0.1 then
						self:diffuse({
							scale(SCHP,0,0.15,WG[1],WHITE[1]),
							scale(SCHP,0,0.15,WG[2],WHITE[2]),
							scale(SCHP,0,0.15,WG[3],WHITE[3]),
							1
						})
					else
						self:diffuse(WHITE);
					end
					
					
					
			end;
				self:SetUpdateFunction(
					xt
				);
			end
			
			
		end;
		Def.ActorFrame{
		OnCommand=cmd(diffuseshift;effectcolor1,{1,1,1,1};effectcolor2,{1,1,1,0.7};effectclock,"beat");
			Def.Quad{
			InitCommand=cmd(diffuse,{0,0,0,1};CenterX;y,SCREEN_BOTTOM-((1/9)*SCREEN_BOTTOM/2)+10;zoomx,SCREEN_RIGHT;zoomy,(1/9)*SCREEN_BOTTOM;diffuse,{0,0,0,1};fadetop,0.8);
			HealthStateChangedMessageCommand=function(self,params)
				
				--SM("\n\nISLA : Change HealthState of "..tostring(params.PlayerNumber).." as "..tostring(params.HealthState)..
				--"\n"..string.format("FIRE[%d] = %s<%s==%s>",(params.PlayerNumber == PlayerNumber_P1) and 1 or 2,tostring(params.HealthState == "HealthState_Hot"),tostring(params.HealthState),"HealthState_Hot"));
				
				FIRE[(tostring(params.PlayerNumber) == "PlayerNumber_P1") and 1 or 2] = (params.HealthState == "HealthState_Hot");
				
				local ISLA = true;
				
				for player in ivalues(GAMESTATE:GetHumanPlayers()) do
					ISLA = (ISLA and FIRE[player == PLAYER_1 and 1 or 2]);
				end
				
				self:stoptweening();
				
				if ISLA then
					self:accelerate(35);
					self:diffuse({0.85,.85,.85,0.7});
				else
					self:decelerate(2.5);
					self:diffuse({0,0,0,1});
				end
				
				
				
			end;
			};
		};
	};


for i = 1,lim do
	M[#M+1] = Def.Quad{
		InitCommand=cmd(x,((i-1)/lim)*SCREEN_RIGHT;y,SCREEN_BOTTOM;horizalign,left;vertalign,bottom;zoomx,SCREEN_RIGHT/lim;zoomy,math.random(5,20);diffuse,{1,1,1,0});
		OnCommand=function(self) NEPcmd[i] = self end;
	};
end
local NOWT;
	M[#M+1] = Def.Quad{
		InitCommand=cmd(visible,true);
		OnCommand=cmd(queuecommand,"Reloading");
		
		ReloadingCommand=function(self)
		for i = 1,lim do
				NEPcmd[i]:zoomy(2+SAO[i]/10*7.5):diffuse({1,1,1,0.3})
		end
		
		local PER=0;
			PER = GAMESTATE:GetCurrentSong():GetFirstSecond()/GAMESTATE:GetCurrentSong():GetLastSecond();
		for i = 1,((PER)*lim) do
				NEPcmd[i]:diffuse(Color.Orange);
				NEPcmd[i]:diffusealpha(0.3);
		end
			NOWT = 0;
			self:playcommand("CAT");
		end;
		CATCommand=function(self)
			local CL = {1,1,1,1};
			local PER=0;
			
			PER = GAMESTATE:GetCurrentSong():GetFirstSecond()/GAMESTATE:GetCurrentSong():GetLastSecond();
			
			
			if NOWT < (PER)*lim then
				CL = Color.Orange;
			else
			
			if TS == "PA" then
			
			elseif TS == "P1" then
				local OP = GAMESTATE:GetPlayerState(PLAYER_1):GetCurrentPlayerOptions();
				local GL = SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_1):GetLife()*100;
				
				if OP:LifeSetting()=="LifeType_Battery" then
					CL = Color.Blue;
					if HUAJAIP[1] then HUAJAIP[1] = false; CL = {1,0,0,1}; Ter = true; 
					end
				elseif OP:LifeSetting()=="LifeType_Time" then
					CL = Color.Blue;
				elseif OP:LifeSetting()=="LifeType_Bar" then
				
					if OP:DrainSetting() == "DrainType_SuddenDeath" then
						CL = Color.Red;
					else
						local REDTO = {1,0.1,0.1,1};
						local GREENTO = {0.1,1,0.1,1};
						if GL >= 50 then
							CL = {
							scale(GL,50,100,REDTO[1],GREENTO[1]),
							GREENTO[2],GREENTO[3],1
							}
						else
							CL = {
							REDTO[1],
							scale(GL,0,50,REDTO[2],GREENTO[2])
							,GREENTO[3],1
							}
						end
						
					end
					
				end
				
			end
			end
		
			if GAMESTATE:GetCurMusicSeconds() >= NOWT/lim*GAMESTATE:GetCurrentSong():GetLastSecond()  then
				local POS = GAMESTATE:GetCurMusicSeconds()/GAMESTATE:GetCurrentSong():GetLastSecond()*(lim+1);
				if math.floor(POS)-1 >= NOWT+1 then
					for NOWT = (NOWT+1),(math.floor(POS)-1) do
						if Ter then 
							NEPcmd[NOWT]:diffuse({1,0,0,1})
							Ter = false;
						else
							NEPcmd[NOWT]:diffuse(CL)
						end
					end
					NOWT = math.floor(POS)-1;
				end
			end
			if NOWT < lim then
			self:sleep(1/60):queuecommand("CAT");
			end
		end;	
	}
	
	M[#M+1] = Def.Quad{
		OnCommand=cmd(visible,false);
		LifeChangedMessageCommand=function(self,param)
			if param.Player == PLAYER_1 then if HNUM[1] == 6969 then HNUM[1] = param.LivesLeft elseif HNUM[1] ~= param.LivesLeft then HUAJAIP[1] = true HNUM[1] = param.LivesLeft end end
			if param.Player == PLAYER_2 then if HNUM[2] == 6969 then HNUM[2] = param.LivesLeft elseif HNUM[2] ~= param.LivesLeft then HUAJAIP[2] = true HNUM[2] = param.LivesLeft end end
		end;
	}



return M;