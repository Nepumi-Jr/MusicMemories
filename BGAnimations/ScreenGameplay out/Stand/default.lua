local t = Def.ActorFrame{};

local title = "NO!";
local SubTitle;
local Artist;
local charter={};
local BPM={};
local Time;

title = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():GetDisplayFullTitle() or GAMESTATE:GetCurrentSong():GetDisplayMainTitle()
SubTitle = GAMESTATE:IsCourseMode() and ToEnumShortString( GAMESTATE:GetCurrentCourse():GetCourseType() ) or GAMESTATE:GetCurrentSong():GetDisplaySubTitle();

if GAMESTATE:IsPlayerEnabled(PLAYER_1) then 
if not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSteps(PLAYER_1):GetAuthorCredit() ~= "" then
charter[#charter+1] = GAMESTATE:GetCurrentSteps(PLAYER_1):GetAuthorCredit() 
end
if GAMESTATE:IsCourseMode() then
BPM[1] = 600;BPM[2]=600;
else
local BPMA = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDisplayBpms();
BPM[1] = BPMA[1];BPM[2] = BPMA[2];
end
end

if GAMESTATE:IsPlayerEnabled(PLAYER_2) then 
if not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSteps(PLAYER_2):GetAuthorCredit() ~= "" then
charter[#charter+1] = GAMESTATE:GetCurrentSteps(PLAYER_2):GetAuthorCredit() 
end
if GAMESTATE:IsCourseMode() then
BPM[1] = 600;BPM[2]=600;
else
	local BPMB = GAMESTATE:GetCurrentSteps(PLAYER_2):GetDisplayBpms();
BPM[1] = math.min(BPMB[1],BPM[1]);BPM[2] = math.max(BPMB[2],BPM[2]);
end
end


if BPM[1] == BPM[2] then table.remove(BPM,1) end

if GAMESTATE:IsCourseMode() then
if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
Time = (GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentTrail(PLAYER_1):GetStepsType())+GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentTrail(PLAYER_2):GetStepsType()))/2;
elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
Time = GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentTrail(PLAYER_1):GetStepsType())
elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
Time = GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentTrail(PLAYER_2):GetStepsType())
end
else
Time = GAMESTATE:GetCurrentSong():MusicLengthSeconds();
end


local Text1 = "Sample";
local Text2 = "";
local Sped = 65;
local See1;
See1 = color("#FF8800")
local See2;
See2 = color("#22FFAA")



NS = GAMESTATE:GetCurrentStageIndex()+1;

if IsNetConnected() then
	Text1 = "Online Mode";
	See1 = GameColor.Stage["Stage_Event"]
	See2 = NumStageColor(NS)
	Text2 = FormatNumberAndSuffix(NS).." Stage";
	Fasst = 0.5;
elseif TP.Battle.IsBattle then--BattleTor
	Text1 = "Battle Mode";
	See1 = ModeIconColors["Rave"]
	See2 = NumStageColor(NS)
	Text2 = FormatNumberAndSuffix(NS).." Round";
	Fasst = 0.5;
elseif ToEnumShortString(GAMESTATE:GetCurrentStage()) == "Event" then--if EventMode
	Text1 = "Event Mode";
	See1 = GameColor.Stage["Stage_Event"]
		if GAMESTATE:IsCourseMode() then -- Course
			if GAMESTATE:GetCurrentCourse():IsNonstop()  then
				See2 = ModeIconColors["Nonstop"]
				Text2 = "NonStop!!";
			elseif GAMESTATE:GetCurrentCourse():IsOni()  then
				See2 = ModeIconColors["Oni"]
				Text2 = "SurVIVE!!!";
			elseif GAMESTATE:GetCurrentCourse():IsEndless() then
				See2 = ModeIconColors["Endless"]
				Text2 = "Endless!";
			end
		elseif playMode == 'PlayMode_Rave' or playMode == 'PlayMode_Battle' then--Rave
			See2 = ModeIconColors["Rave"]
			Text2 = "Magic Dance";
		else
			See2 = NumStageColor(NS)
			Text2 = FormatNumberAndSuffix(NS).." Stage";
		end
	Fasst = 0.5;
else
	if GAMESTATE:IsCourseMode() then -- Course
		if GAMESTATE:GetCurrentCourse():IsNonstop() then
			See1 = ModeIconColors["Nonstop"]
			Text1 = "NonStop!!";
		elseif GAMESTATE:GetCurrentCourse():IsOni() then
			See1 = ModeIconColors["Oni"]
			Text1 = "SurVIVE!!!";
		elseif GAMESTATE:GetCurrentCourse():IsEndless() then
			See1 = ModeIconColors["Endless"]
			Text1 = "Endless!";
		end
	elseif playMode == 'PlayMode_Rave' or playMode == 'PlayMode_Battle' then--Rave
		See1 = ModeIconColors["Rave"]
		Text1 = "Magic Dance";
	else
local playMode = GAMESTATE:GetPlayMode()

local sStage = ""
sStage = GAMESTATE:GetCurrentStage()

if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
  sStage = playMode;
end;
		See1 = NumStageColor(NS)
		Text1 = ToEnumShortString(sStage).." Stage";
	end
end


t[#t+1] = LoadActor("Floor")..{OnCommand=function(self) self:rotationx(-90); self:zoom(0.45); end;};

t[#t+1] = LoadActor("MUSIC_STAND.lua")..{
	OnCommand=function(self) self:zoom(5); end;
};

t[#t+1] = Def.ActorFrame{
		OnCommand=function(self) self:y(-195); self:z(-5); self:zoom(0.16); self:rotationx(-15); end;
	LoadActor("RNote")..{OnCommand=function(self) self:zoom(0.2); self:diffusealpha(1); end;};
	LoadFont("Common Normal")..{OnCommand=function(self) self:y(-167); self:zoom(0.6); self:settext(title); self:diffuse({0,0,0,1}); end;};
	LoadFont("Common Normal")..{OnCommand=function(self) self:y(-157); self:zoom(0.3); self:settext(SubTitle ~= "" and "-"..SubTitle.."-" or ""); self:diffuse({0,0,0,1}); end;};
	LoadFont("Common Normal")..{OnCommand=function(self) self:x(-123); self:y(-153); self:horizalign(left); self:zoom(0.3); self:settext(Artist~= nil and "By "..Artist or ""); self:diffuse({0,0,0,1}); end;};
	LoadFont("Common Normal")..{OnCommand=function(self) self:x(131); self:y(-153); self:horizalign(right); self:zoom(0.3); self:settext(#charter==0 and "Unknown Composer" or (#charter==2 and charter[1].." & "..charter[2] or charter[1])); self:diffuse({0,0,0,1}); end;};
	LoadFont("Common Normal")..{OnCommand=function(self) self:x(-114); self:y(-143); self:horizalign(left); self:zoom(0.3); self:settext(#BPM==2 and tostring(BPM[1]).."-"..tostring(BPM[2]) or tostring(BPM[1])); self:diffuse({0,0,0,1}); end;};
};








return t;