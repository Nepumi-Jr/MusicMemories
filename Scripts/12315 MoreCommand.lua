
function THEMEDIR()
	return THEME:GetCurrentThemeDirectory()
end

function PN_Name(pn)
	if PROFILEMAN:GetProfile(pn):GetDisplayName() then
		return PROFILEMAN:GetProfile(pn):GetDisplayName();
	elseif GAMESTATE:IsHumanPlayer(pn) then
		return "Player"..(pn+1).."...";
	else
		return "Someone...";
	end

end



function Nighty(Timu)

    if ThemePrefs.Get("BackgroundTheme") < 2 then
        return ThemePrefs.Get("BackgroundTheme")
    end

	Timu = Timu or (Hour()*60+Minute()+Second()/60)
	Timu = math.mod(Timu,60*24)

	if Timu <= 5*60 then
		--Night
		return 1
	elseif Timu <= 6*60 then
		--Night -> Day
		return scale(Timu,5*60,6*60,1,0)
	elseif Timu <= 19*60 then
		--Day
		return 0
	elseif Timu <= 20*60 then
		--Day -> Night
		return scale(Timu,19*60,20*60,0,1)
	else
		--Night
		return 1
	end

	


end



function OP()
	local ENTITY = {PLAYER_1,PLAYER_2};

	for i = 1,#ENTITY do
		if GAMESTATE:IsPlayerEnabled(ENTITY[i]) then
			if string.match( PN_Name(ENTITY[i]), "Isla") then
				return true;
			end
		end
	end
	return false;

end

function AdvRandom(x)
	local sum = 0;
	for i=1,#x do
		sum = sum + x[i][2];
	end
	local se = math.random(1,sum);
	for i=1,#x do
		if se <= x[i][2] then
			return x[i][1];
		else
			se = se - x[i][2];
		end
	end
		return "ERR";
end

function EASTER()
	if todayis(1,4) then
		return "FOOL";
	end
	return "None";
end

function Score2Grade(S,PS)
	if PS:GetTapNoteScores('TapNoteScore_W5') + PS:GetTapNoteScores('TapNoteScore_W4') + PS:GetTapNoteScores('TapNoteScore_W3') + PS:GetTapNoteScores('TapNoteScore_Miss') + PS:GetHoldNoteScores('HoldNoteScore_LetGo')+PS:GetTapNoteScores('TapNoteScore_W2')  <= 0 then
	return "SS"
	elseif PS:GetTapNoteScores('TapNoteScore_W5') + PS:GetTapNoteScores('TapNoteScore_W4') + PS:GetTapNoteScores('TapNoteScore_W3') + PS:GetHoldNoteScores('HoldNoteScore_LetGo')  <= 0 then
	return "S"
	elseif S >= 93 then
	return "A+"
	elseif S >= 80 then
	return "A"
	elseif S >= 65 then
	return "B"
	elseif S >= 45 then
	return "C"
	elseif S < 45 then
	return "D"
	end
end;

function EVA_RANKBGM()
	local tod = 0;
	for player in ivalues(GAMESTATE:GetHumanPlayers()) do
		local ISLAC = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetStageAward()
		local ISLAF = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPeakComboAward()
		if ISLAC == "StageAward_FullComboW2" or
		ISLAC == "StageAward_SingleDigitW2" or
		ISLAC == "StageAward_OneW2" or
		ISLAC == "StageAward_FullComboW1" or
		ISLAC == "StageAward_80PercentW3" or
		ISLAC == "StageAward_90PercentW3" or
		ISLAC == "StageAward_100PercentW3" then
			tod = math.max(tod,3);
		end
		if ISLAC == "StageAward_FullComboW3" or
		ISLAC == "StageAward_SingleDigitW3" or
		ISLAC == "StageAward_OneW3" then
			if ISLAF ~= "" then
				tod = math.max(tod,3);
			else
				tod = math.max(tod,2);
			end
		end
		
		if STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_Miss") +
		STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W5") +
		STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_W4") <= 1 then
			if ISLAF ~= "" then
				tod = math.max(tod,3);
			else
				tod = math.max(tod,2);
			end
		end
		
		if STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPersonalHighScoreIndex() == 0 then
			tod = math.max(tod,1);
		end
		
		if STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetMachineHighScoreIndex() == 0 then
			tod = math.max(tod,1);
		end
	end
	
	if tod == 0 then
		return "NORMAL";
	elseif tod == 1 then
		return "ISLA";
	elseif tod >= 2 then
		return "BEAT";
	elseif tod == 3 then
		return "WOW";
	end
end




function SMPairs(t)
	local temp = ""
	for k,v in pairs(t) do
		temp = temp .. "key: " .. tostring(k) .. ", val: " .. tostring(v) .."\n"
	end
	SCREENMAN:SystemMessage(temp)
end


function SM(str)
	SCREENMAN:SystemMessage(tostring(str))
end

function FindInTable(needle, haystack)
	for i = 1, #haystack do
		if needle == haystack[i] then
			return i
		end
	end
	return nil
end


function kindof(ne,wh,eq,no)
for i = 1, #wh do
if ne == wh[i] then
	return eq
end
end
	return no
end

function moreorless(n,lm,ty)
	ip = kindof(ty,{"More","more","MORE"},"More")
	ip = kindof(ty,{"Less","less","LESS"},"Less")
	if ty == "More" then
	if n > lm then
		return n
	elseif n <= lm then
		return lm
	end
	elseif ty == "Less" then
	if n > lm then
		return lm
	elseif n <= lm then
		return n
	end
	end
end

function Foolday()
	if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
		return true
	end
	return false
end

function todayis(a,b)
	if MonthOfYear() == b-1 and DayOfMonth() == a then
		return true
	end
	return false
end

function ReP1()
SCREENMAN:GetTopScreen():GetChild('PlayerP1'):x(241)
SCREENMAN:GetTopScreen():GetChild('PlayerP1'):y(260)
SCREENMAN:GetTopScreen():GetChild('PlayerP1'):z(0)
SCREENMAN:GetTopScreen():GetChild('PlayerP1'):zoom(1)
SCREENMAN:GetTopScreen():GetChild('PlayerP1'):zoomx(1)
SCREENMAN:GetTopScreen():GetChild('PlayerP1'):zoomy(1)
SCREENMAN:GetTopScreen():GetChild('PlayerP1'):zoomz(1)
SCREENMAN:GetTopScreen():GetChild('PlayerP1'):zoomtoheight(1)
SCREENMAN:GetTopScreen():GetChild('PlayerP1'):zoomtowidth(1)
SCREENMAN:GetTopScreen():GetChild('PlayerP1'):rotationx(0)
SCREENMAN:GetTopScreen():GetChild('PlayerP1'):rotationy(0)
SCREENMAN:GetTopScreen():GetChild('PlayerP1'):rotationz(0)
SCREENMAN:GetTopScreen():GetChild('PlayerP1'):diffuse(color("#FFFFFFFF"))
SCREENMAN:GetTopScreen():GetChild('PlayerP1'):visible(true)
SCREENMAN:GetTopScreen():GetChild('PlayerP1'):hidden(false)
end

function ReL1()
SCREENMAN:GetTopScreen():GetChild('LifeP1'):x(211.5)
SCREENMAN:GetTopScreen():GetChild('LifeP1'):y(30)
SCREENMAN:GetTopScreen():GetChild('LifeP1'):z(0)
SCREENMAN:GetTopScreen():GetChild('LifeP1'):zoom(1)
SCREENMAN:GetTopScreen():GetChild('LifeP1'):zoomx(1)
SCREENMAN:GetTopScreen():GetChild('LifeP1'):zoomy(1)
SCREENMAN:GetTopScreen():GetChild('LifeP1'):zoomz(1)
SCREENMAN:GetTopScreen():GetChild('LifeP1'):zoomtoheight(1)
SCREENMAN:GetTopScreen():GetChild('LifeP1'):zoomtowidth(1)
SCREENMAN:GetTopScreen():GetChild('LifeP1'):rotationx(0)
SCREENMAN:GetTopScreen():GetChild('LifeP1'):rotationy(0)
SCREENMAN:GetTopScreen():GetChild('LifeP1'):rotationz(0)
SCREENMAN:GetTopScreen():GetChild('LifeP1'):diffuse(color("#FFFFFFFF"))
SCREENMAN:GetTopScreen():GetChild('LifeP1'):visible(true)
SCREENMAN:GetTopScreen():GetChild('LifeP1'):hidden(false)
end

function ReP2()
SCREENMAN:GetTopScreen():GetChild('PlayerP2'):x(612.25)
SCREENMAN:GetTopScreen():GetChild('PlayerP2'):y(260)
SCREENMAN:GetTopScreen():GetChild('PlayerP2'):z(0)
SCREENMAN:GetTopScreen():GetChild('PlayerP2'):zoom(1)
SCREENMAN:GetTopScreen():GetChild('PlayerP2'):zoomx(1)
SCREENMAN:GetTopScreen():GetChild('PlayerP2'):zoomy(1)
SCREENMAN:GetTopScreen():GetChild('PlayerP2'):zoomz(1)
SCREENMAN:GetTopScreen():GetChild('PlayerP2'):zoomtoheight(1)
SCREENMAN:GetTopScreen():GetChild('PlayerP2'):zoomtowidth(1)
SCREENMAN:GetTopScreen():GetChild('PlayerP2'):rotationx(0)
SCREENMAN:GetTopScreen():GetChild('PlayerP2'):rotationy(0)
SCREENMAN:GetTopScreen():GetChild('PlayerP2'):rotationz(0)
SCREENMAN:GetTopScreen():GetChild('PlayerP2'):diffuse(color("#FFFFFFFF"))
SCREENMAN:GetTopScreen():GetChild('PlayerP2'):visible(true)
SCREENMAN:GetTopScreen():GetChild('PlayerP2'):hidden(false)
end

function ReL2()
SCREENMAN:GetTopScreen():GetChild('LifeP2'):x(642.5)
SCREENMAN:GetTopScreen():GetChild('LifeP2'):y(30)
SCREENMAN:GetTopScreen():GetChild('LifeP2'):z(0)
SCREENMAN:GetTopScreen():GetChild('LifeP2'):zoom(1)
SCREENMAN:GetTopScreen():GetChild('LifeP2'):zoomx(1)
SCREENMAN:GetTopScreen():GetChild('LifeP2'):zoomy(1)
SCREENMAN:GetTopScreen():GetChild('LifeP2'):zoomz(1)
SCREENMAN:GetTopScreen():GetChild('LifeP2'):zoomtoheight(1)
SCREENMAN:GetTopScreen():GetChild('LifeP2'):zoomtowidth(1)
SCREENMAN:GetTopScreen():GetChild('LifeP2'):rotationx(0)
SCREENMAN:GetTopScreen():GetChild('LifeP2'):rotationy(0)
SCREENMAN:GetTopScreen():GetChild('LifeP2'):rotationz(0)
SCREENMAN:GetTopScreen():GetChild('LifeP2'):diffuse(color("#FFFFFFFF"))
SCREENMAN:GetTopScreen():GetChild('LifeP2'):visible(true)
SCREENMAN:GetTopScreen():GetChild('LifeP2'):hidden(false)
end

function ReOverlay()
Lazy = {SCREENMAN:GetTopScreen(),SCREENMAN:GetTopScreen():GetChild('Overlay'),SCREENMAN:GetTopScreen():GetChild('Underlay'),SCREENMAN:GetTopScreen():GetChild('SongBackground'),SCREENMAN:GetTopScreen():GetChild('SongForeground')}
for i=1,#Lazy do
Lazy[i]:x(0)
Lazy[i]:y(0)
Lazy[i]:z(0)
Lazy[i]:zoom(1)
Lazy[i]:zoomx(1)
Lazy[i]:zoomy(1)
Lazy[i]:zoomz(1)
Lazy[i]:zoomtoheight(1)
Lazy[i]:zoomtowidth(1)
Lazy[i]:rotationx(0)
Lazy[i]:rotationy(0)
Lazy[i]:rotationz(0)
Lazy[i]:diffuse(color("#FFFFFFFF"))
Lazy[i]:visible(true)
Lazy[i]:hidden(false)
end
end


function Resetallcmd()
ReOverlay()
ReL2()
ReP2()
ReL1()
ReP1()
end

function TFO(s,t,f)
if s then
	return t
else
	return f
end
end

function TTS(t)
local op = {};
	for i = 1,string.len(t) do
		op[i] = string.sub(t,i,i)
	end
	return op
end


function GradeTIER(g)
local O = "";
if g == "Grade_Tier01" then
 O = "SS"
elseif g == "Grade_Tier02" then
O = "S"
elseif g == "Grade_Tier03" then
O = "A+"
elseif g == "Grade_Tier04" then
O = "A"
elseif g == "Grade_Tier05" then
O = "B"
elseif g == "Grade_Tier06" then
O = "C"
elseif g == "Grade_Tier07" then
O = "D"
elseif g == "Grade_Failed" then
O = "F"
end
return O
end

function GTT(g)
	return GradeTIER(g);
end

function DTT(p)
local d
if p == 1 then
	d = GAMESTATE:GetCurrentSteps(PLAYER_1)
elseif p == 2 then
	d = GAMESTATE:GetCurrentSteps(PLAYER_2)
end

local O = "";
if d:GetDifficulty() == "Difficulty_Beginner" then
O = "Beginer"
elseif d:GetDifficulty() == "Difficulty_Easy" then
O = "Easy"
elseif d:GetDifficulty() == "Difficulty_Medium" then
O = "Normal"
elseif d:GetDifficulty() == "Difficulty_Hard" then
O = "Hard"
elseif d:GetDifficulty() == "Difficulty_Challenge" then
O = "Metal"
elseif d:GetDifficulty() == "Difficulty_Edit" then
if d:GetDescription() then
O = d:GetDescription()
else
O = "Workshop"
end
end
return O
end

function CTD(P)
    local O = ""
    if DTT(P) == "Beginer" then
        O = color("#ffAAAA")
    elseif DTT(P) == "Easy" then
        O = color("#55ff55")
    elseif DTT(P) == "Normal" then
        O = color("#fFff22")
    elseif DTT(P) == "Hard" then
        O = color("#ff4444")
    elseif DTT(P) == "Metal" then
        O = color("#CCCCff")
    else
        O = color("#AAAAAA")
    end
    return O
end	

function GM(P)
if GAMESTATE:IsCourseMode() then
	if P == 1 then
	return GAMESTATE:GetCurrentTrail(PLAYER_1):GetMeter()
	elseif P == 2 then
	return GAMESTATE:GetCurrentTrail(PLAYER_2):GetMeter()
	end
else
	if P == 1 then
	return GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter()
	elseif P == 2 then
	return GAMESTATE:GetCurrentSteps(PLAYER_2):GetMeter()
	end
end
return "Error!!!"
end

function MCBT(XX,YY,CeeBG,CeeFG,CeeCT,CeeT,Cees,Te,Su)
local L = Def.ActorFrame{};
local SSeeeettttt = TTS(Te);
L[#L+1] = Def.ActorFrame{
	OnCommand=cmd(x,0;y,0);
LoadActor(THEME:GetPathG("MC","BG"))..{
	OnCommand=cmd(diffuse,CeeBG);
};
LoadActor(THEME:GetPathG("MC","CT"))..{
	OnCommand=cmd(diffuse,CeeCT);
};
LoadActor(THEME:GetPathG("MC","FG"))..{
	OnCommand=cmd(diffuse,CeeFG);
};
};
local NormalText = "";
for i = 1 , math.min(#SSeeeettttt,5) do
if #SSeeeettttt > 5 then
NormalText = NormalText..SSeeeettttt[((#SSeeeettttt-5)+i)]
else
NormalText = NormalText..SSeeeettttt[i]
end
end
L[#L+1] = LoadFont("Common Large")..{
	Text = NormalText;
	InitCommand=cmd(x,0+125;y,0-75;horizalign,right;zoom,0.7);
	OnCommand=cmd(diffuse,CeeT);
};
if #SSeeeettttt > 5 then
for i = 1,#SSeeeettttt - 5 do
L[#L+1] = Def.ActorFrame{
	InitCommand=cmd(x,0+100-150;y,0-75+125;rotationz,-32.8*i);
LoadFont("Common Large")..{
	Text=SSeeeettttt[(#SSeeeettttt - 5) - i +1];
	InitCommand=cmd(y,-125;zoom,0.7);
	OnCommand=cmd(diffuse,CeeT);
};
};
end
end
L[#L+1] = LoadFont("Common Large")..{
	Text = Su;
	InitCommand=cmd(x,0-75;y,0+25;horizalign,left;zoom,0.45);
	OnCommand=cmd(diffuse,Cees);
};
return L
end;

function StatText(a)
local re;
if TP.Battle.IsBattle and TP.Battle.Mode == "Dr" then
re = {false,false};
elseif TP.Battle.IsBattle and TP.Battle.Mode == "Ac" then
re = {true,false};
else
re = {true,true};
end
return re[a];
end;

function Pn_Option_1_Lines()
	if TP.Battle.IsBattle then
		return "1,8,HA,SC,16,SF,18,MI,3A,19,NextScreenBat"
	else
		return "1,8,HA,SC,12,16,SF,18,MI,3A,19,NextScreen"
	end
	
end


function ModeSelect()
    if TP.Battle.IsBattle then
        return "Normal,Nonstop"
    else
        return "Normal,Rave,Nonstop,Oni,Endless";
    end
end;


function SM( arg )

	-- if a table has been passed in
	if type( arg ) == "table" then

		-- recurively print its contents to a string
		local msg = TableToString_Recursive(arg)
		-- and SystemMessage() that string
		SCREENMAN:SystemMessage( msg )

		-- tables as strings spill off SM's screen height quickly,
		-- so we might as well also do a proper Trace() to ./Logs/log.txt
		Trace( msg )
	else
		SCREENMAN:SystemMessage( tostring(arg) )
	end
end



function TableToString(S)
	local Talk = "";
	if type(S) ~= "table" then
		return tostring(S);
	else
		local crt = 1;
		Talk = "#"..tostring(#S)..":{";
		for Con in ivalues(S) do
			Talk = Talk..TableToString(Con)..",";
			crt = crt + 1;
			if crt == 10 then crt = 1; Talk = Talk.."\n"; end
		end
		Talk = Talk.."}";
		return Talk;
	end
end


function TableToStringAdv(S)
	local Talk = "";
	if type(S) ~= "table" then
		return tostring(S);
	else
		local crt = 1;
		Talk = "#"..tostring(#S)..":{";
		for k, v in pairs(S) do
			Talk = Talk..k..":"..TableToString(v)..", ";
			crt = crt + 1;
			if crt == 10 then crt = 1; Talk = Talk.."\n"; end
		end
		Talk = Talk.."}";
		return Talk;
	end
end


function RPC_Update(Con)
	
	local str = "{"
	
	
	for k, v in pairs(Con) do
		if type(v) == "number" then
			if k == "ed" then
				str = str.."\"end\":"..tostring(v)..",";
			else 
				str = str.."\""..k.."\":"..tostring(v)..",";
			end
		elseif type(v) == "string" then
			str = str.."\""..k.."\":\""..v.."\",";
		else
			str = str.."\""..k.."\":["..v[1]..","..v[2].."],";
		end
		
	end
	
	str = string.sub(str,1,string.len(str)-1) .. "}"
	
	local path = "/FIFO/";
	local f = RageFileUtil.CreateRageFile()
	if f:Open(path.."RPC.memories", 2) then
		f:Write(str)
	else
		local fError = f:GetError()
		Trace( "[FileUtils] Error writing to ".. path.."RPC.memories" ..": ".. fError )
		SM("\n\n\n\nERROR\n".."[FileUtils] Error writing to ".. path.."RPC.memories" ..": ".. fError)
		f:ClearError()
	end
	if f:Open(path.."YeyTest.in", 2) then
		f:Write(str)
	else
		local fError = f:GetError()
		Trace( "[FileUtils] Error writing to ".. path.."RPC.memories" ..": ".. fError )
		SM("\n\n\n\nERROR\n".."[FileUtils] Error writing to ".. path.."RPC.memories" ..": ".. fError)
		f:ClearError()
	end
	f:destroy()
end

function GetPicJudPath(namae)
	
	if namae == "!!default!!" then
		return THEME:GetPathG("Judge","Memory")
	elseif namae == "None" then
		return THEME:GetPathG("","_blank")
	elseif namae == "SM5ProTiming" then
		return THEME:GetPathG("","Sm5")
	else
		if FILEMAN:DoesFileExist(THEMEDIR().."/Resource/JudF/"..namae) then
			return THEMEDIR().."/Resource/JudF/"..namae
		elseif FILEMAN:DoesFileExist("/Appearance/Judgments/"..namae) then
			return "/Appearance/Judgments/"..namae
		else
			return THEME:GetPathG("Judge","Memory")
		end
	end
	
	return THEME:GetPathG("Judge","Memory")


end


function CurStageAward(pn)

    local stageStat = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)

	local W1 = stageStat:GetTapNoteScores("TapNoteScore_W1")
	local W2 = stageStat:GetTapNoteScores("TapNoteScore_W2")
	local W3 = stageStat:GetTapNoteScores("TapNoteScore_W3")
	local W4 = stageStat:GetTapNoteScores("TapNoteScore_W4")
	local W5 = stageStat:GetTapNoteScores("TapNoteScore_W5")
	local Mi = stageStat:GetTapNoteScores("TapNoteScore_Miss")
	local Cp = stageStat:GetTapNoteScores("TapNoteScore_CheckpointHit")
	local Cm = stageStat:GetTapNoteScores("TapNoteScore_CheckpointMiss")

	local Hd = stageStat:GetHoldNoteScores("HoldNoteScore_Held")
	local Lg = stageStat:GetHoldNoteScores("HoldNoteScore_LetGo")


	if W2+W3+W4+W5+Mi+Cm+Lg == 0 then
		return "StageAward_FullComboW1"
	elseif W3+W4+W5+Mi+Cm+Lg == 0 and W2 == 1 then
		return "StageAward_OneW2"
	elseif W3+W4+W5+Mi+Cm+Lg == 0 and W2 < 10 then
		return "StageAward_SingleDigitW2"
	elseif W3+W4+W5+Mi+Cm+Lg == 0 then
		return "StageAward_FullComboW2"
	elseif W4+W5+Mi+Cm+Lg == 0 and W3 == 1 then
		return "StageAward_OneW3"
	elseif W4+W5+Mi+Cm+Lg == 0 and W3 < 10 then
		return "StageAward_SingleDigitW3"
	elseif W4+W5+Mi+Cm+Lg == 0 then
		return "StageAward_FullComboW3"
	elseif W4+W5+Mi+Cm+Lg == 1 then
		return "StageAward_Choke"
	elseif Mi+Lg+Cm == 0 then
		return "StageAward_NoMiss"
	end
	return "Nope"


end


function printf(SF,...)
	SCREENMAN:SystemMessage("\n\n\n\n\n"..string.format(tostring(SF),...))
end


function getJudgeAnimation(judgeName)--eg OutFox [double] 2x6 (res 640x516).png
	--Default
	local result = {
        W1LateCommand = THEME:GetMetric( "Judgment", "W1LateCommand");
		W2LateCommand = THEME:GetMetric( "Judgment", "W2LateCommand");
		W3LateCommand = THEME:GetMetric( "Judgment", "W3LateCommand");
		W4LateCommand = THEME:GetMetric( "Judgment", "W4LateCommand");
		W5LateCommand = THEME:GetMetric( "Judgment", "W5LateCommand");
		MissLateCommand = THEME:GetMetric( "Judgment", "MissLateCommand");
	
		W1EarlyCommand = THEME:GetMetric( "Judgment", "W1EarlyCommand");
		W2EarlyCommand = THEME:GetMetric( "Judgment", "W2EarlyCommand");
		W3EarlyCommand = THEME:GetMetric( "Judgment", "W3EarlyCommand");
		W4EarlyCommand = THEME:GetMetric( "Judgment", "W4EarlyCommand");
		W5EarlyCommand = THEME:GetMetric( "Judgment", "W5EarlyCommand");
		MissEarlyCommand = THEME:GetMetric( "Judgment", "MissEarlyCommand");
	};

	if not ThemePrefs.Get("CustomJudgeAnimation") then
		return result
	end
	

	local JudAni = JudgeFileShortName(judgeName)
	
	local path = "/Appearance/Judgments/";
	local files = FILEMAN:GetDirListing(path)

	--Check in Appearance/Judgments/
	for k,filename in ipairs(files) do
		if string.match(filename, ".lua") and string.match(filename,JudAni) then
			
			local data = LoadActor(path..filename)
			
			for k,v in pairs(result) do
				if data[k] ~= nil then
					result[k] = data[k]
				end
			end

			break
		end
	end
	
	local path = "/"..THEMEDIR().."Resource/JudF/Animate/";
	local files = FILEMAN:GetDirListing(path)

	--Check in mytheme/Resource/JudF/Animate/ (First Priority :) )
	for k,filename in ipairs(files) do
		if string.match(filename, ".lua") and string.match(filename,JudAni) then
			
			local data = LoadActor(path..filename)
			
			for k,v in pairs(result) do
				if data[k] ~= nil then
					result[k] = data[k]
				end
			end

			break
		end
	end

	return result

end

--[[function LimText(St,lim,mod,fo,zom,n)
St = String
lim = How much limit in pixel
================MOD(E)=============
P = String and end with "..."(eg. Minecra... )
C = Cut all left off (eg. Minecra )
N = like mode C and split to other line
	to use N mode must use number after zom (eg.	LimText("Minecraft",200,"N",nil,nil,1) --->	Minecra
												LimText("Minecraft",200,"N",nil,nil,2) --->	ft
												LimText("Minecraft",200,"N",nil,nil,3) --->	        
	)
fo = font
zom = zoom
n = use for mode N

	if string.upper(mod) == "P" or string.upper(mod) == "C" then
	local tal = string.len(St)
	local re = "";
Def.ActorFrame{
LoadFont(fo or "Common Normal")..{
	InitCommand=cmd(x,-9999;visible,false;zoom,zom or 1;settext,St);
	OnCommand=cmd(playcommand,"NepText");
	NepTextCommand=function(self)
	if (self:GetWidth() >= lim) and tal ~= 0 then
		tal = tal - 1
		if string.upper(mod) == "P" then
			self:settext(string.sub(St,1,tal).."...")
		else string.upper(mod) == "C" then
			self:settext(string.sub(St,1,tal))
		end
		self:sleep(0.01)
		self:queuecommand("NepText")
	else
		if tal == 0 then
			re = ""
		else
			if string.upper(mod) == "P" then
				re = string.sub(St,1,tal).."..."
			elseif string.upper(mod) == "C" then
				re = string.sub(St,1,tal)
			end
		end
	end
	end;
};
};
return re;
elseif string.upper(mod) == "N" then
return "Comming soooooon!";
else
return "Error";
end
end]]