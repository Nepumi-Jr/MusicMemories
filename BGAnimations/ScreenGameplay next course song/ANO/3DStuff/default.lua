local t = Def.ActorFrame{};

local title = "NO!";
local SubTitle;
local Artist;
local charter={};
local BPM={"???","???"};
local Time;
local CEN;
if GAMESTATE:IsCourseMode() then
CEN = GAMESTATE:GetCurrentCourse():GetCourseEntries()
end

title = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():GetDisplayFullTitle() or GAMESTATE:GetCurrentSong():GetDisplayMainTitle()
SubTitle = GAMESTATE:IsCourseMode() and ToEnumShortString( GAMESTATE:GetCurrentCourse():GetCourseType() ) or GAMESTATE:GetCurrentSong():GetDisplaySubTitle();

if GAMESTATE:IsPlayerEnabled(PLAYER_1) then 
if not GAMESTATE:IsCourseMode() then
if GAMESTATE:GetCurrentSteps(PLAYER_1):GetAuthorCredit() ~= "" then
charter[#charter+1] = GAMESTATE:GetCurrentSteps(PLAYER_1):GetAuthorCredit() 
end
local BPMA = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDisplayBpms();
BPM[1] = round(BPMA[1]);BPM[2] = round(BPMA[2]);
end
end

if GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsCourseMode() then 
if not GAMESTATE:IsCourseMode() then
if GAMESTATE:GetCurrentSteps(PLAYER_2):GetAuthorCredit() ~= "" then
charter[#charter+1] = GAMESTATE:GetCurrentSteps(PLAYER_2):GetAuthorCredit() 
end
local BPMB = GAMESTATE:GetCurrentSteps(PLAYER_2):GetDisplayBpms();
if BPM[1] == "???" then BPM[1] = BPMB[1]; else BPM[1] = round(math.min(BPMB[1],BPM[1])); end
if BPM[2] == "???" then BPM[2] = BPMB[2]; else BPM[2] = round(math.max(BPMB[2],BPM[2])); end
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

t[#t+1] = LoadActor("Floor")..{OnCommand=function(self) self:rotationx(-90); self:zoom(0.75); end;};
t[#t+1] = LoadActor("Zight")..{OnCommand=function(self) self:z(-113); self:y(-188.5); self:vertalign(top); self:zoom(SCREEN_RIGHT/1900); self:zoomy(3); end;};
t[#t+1] = LoadActor("TABLE")..{OnCommand=function(self) self:zoom(0.25); self:rotationy(90); end;};
t[#t+1] = LoadActor("PAKKA")..{OnCommand=function(self) self:x(80); self:y(-188.5); self:zoom(3); self:rotationz(-30); self:rotationx(90); end;};

t[#t+1] = Def.ActorFrame{
		OnCommand=function(self) self:y(-188.5); self:z(20); self:zoom(0.08/0.2); self:rotationz(8); self:rotationx(-90); end;
	LoadActor("RNote")..{OnCommand=function(self) self:zoom(0.2); self:diffusealpha(1); end;};
	LoadFont("Common Normal")..{OnCommand=function(self) self:y(-167); self:zoom(0.6); self:settext(title); self:diffuse({0,0,0,1}); end;};
	LoadFont("Common Normal")..{OnCommand=function(self) self:y(-157); self:zoom(0.3); self:settext(SubTitle ~= "" and "-"..SubTitle.."-" or ""); self:diffuse({0,0,0,1}); end;};
	LoadFont("Common Normal")..{OnCommand=function(self) self:x(-123); self:y(-153); self:horizalign(left); self:zoom(0.3); self:settext(Artist~= nil and "By "..Artist or ""); self:diffuse({0,0,0,1}); end;};
	LoadFont("Common Normal")..{OnCommand=function(self) self:x(131); self:y(-153); self:horizalign(right); self:zoom(0.3); self:settext(#charter==0 and "Unknown Composer" or (#charter==2 and charter[1].." & "..charter[2] or charter[1])); self:diffuse({0,0,0,1}); end;};
	LoadFont("Common Normal")..{OnCommand=function(self) self:x(-114); self:y(-143); self:horizalign(left); self:zoom(0.3); self:settext(#BPM==2 and tostring(BPM[1]).."-"..tostring(BPM[2]) or tostring(BPM[1])); self:diffuse({0,0,0,1}); end;};
};


if GAMESTATE:IsCourseMode() then
t[#t+1] = Def.ActorFrame{
		OnCommand=function(self) self:x(-80); self:y(-188.5); self:z(20); self:zoom(0.08/0.2); self:rotationz(-50); self:rotationx(-90); end;
		LoadActor("Paper")..{OnCommand=function(self) self:zoom(0.2); end;};
LoadFont("Common Normal")..{OnCommand=function(self) self:y(-167); self:settext("Content"); self:diffuse(color("#000000")); end}}
for na = 1,math.min(#CEN,21) do
t[#t+1] = Def.ActorFrame{
		OnCommand=function(self) self:x(-80); self:y(-188.5); self:z(20); self:zoom(0.08/0.2); self:rotationz(-50); self:rotationx(-90); end;LoadFont("Common Normal")..{
		OnCommand=function(self) self:x(-110); self:y(-160+15*na); self:horizalign(left); self:settextf("No.%2d : %s (%s)",na,
		CEN[na]:IsSecret() and "?????????" or CEN[na]:GetSong():GetDisplayMainTitle(),
		CEN[na]:IsSecret() and "??:??" or SecondsToMMSS(CEN[na]:GetSong():MusicLengthSeconds())); self:zoom(.5); self:diffuse(color("#000000")); end;};
		Def.Quad{
			OnCommand=function(self) self:y(-160+15*na); self:zoomy(1); self:zoomx(115*2); self:diffuse(color("#000000")); end;
			CurrentSongChangedMessageCommand=function(self) self:visible(GAMESTATE:GetCourseSongIndex()+2 > na); end;
		};	
		};
end
end

t[#t+1] = Def.ActorFrame{
		OnCommand=function(self) self:x(60); self:y(-188.5); self:z(50); self:zoom(0.08/0.2); self:rotationz(30); self:rotationx(-90); end;
		LoadActor("TimeP")..{OnCommand=function(self) self:zoom(0.2); end;};
LoadFont("Common Normal")..{OnCommand=function(self) self:x(-30); self:zoom(1.2); self:horizalign(left); self:settext(SecondsToMMSS(Time)); self:diffuse(color("#000000FF")); end;};};



for i = 1,string.len(Text1) do
	t[#t+1] = Def.ActorFrame{OnCommand=function(self) self:x(-40); self:y(-188.5); self:z(-60); self:rotationz(-10); self:rotationx(-90); end;LoadFont("_special elite 108px")..{OnCommand=function(self) self:x((13)*(i-((string.len(Text1)+1)/2))+math.random(-4,4)); self:y(math.random(-4,4)); self:rotationz(math.random(-10,10)); self:zoom(0.2); self:settext(string.sub(Text1,i,i)); self:diffuse(ColorLightTone(See1)); self:diffusebottomedge(See1); end;};};
end

for i = 1,string.len(Text2) do
	t[#t+1] = Def.ActorFrame{OnCommand=function(self) self:x(40); self:y(-188.5); self:z(60); self:rotationz(-10); self:rotationx(-90); end;LoadFont("_special elite 108px")..{OnCommand=function(self) self:x((13)*(i-((string.len(Text2)+1)/2))+math.random(-4,4)); self:y(math.random(-4,4)); self:rotationz(math.random(-10,10)); self:zoom(0.15); self:settext(string.sub(Text2,i,i)); self:diffuse(See2); self:diffusebottomedge(ColorDarkTone(See2)); end;};};
end


t[#t+1] = LoadActor("Light")..{OnCommand=function(self) self:y(-188.5); self:zoom(SCREEN_RIGHT/1899.7361/1.03); self:zoomx(SCREEN_RIGHT/1899.7361/1.03+.0135); self:rotationx(-90); end;};
t[#t+1] = LoadActor("Zight")..{OnCommand=function(self) self:z(113); self:y(-188.5); self:vertalign(top); self:zoom(SCREEN_RIGHT/1900); self:zoomy(3); end;};
t[#t+1] = LoadActor("Yight")..{OnCommand=function(self) self:x(-224.7); self:y(-188.5); self:vertalign(top); self:zoom(SCREEN_RIGHT/1900); self:zoomy(6); self:zoomx(1/3+0.1); self:rotationy(-90); end;};
t[#t+1] = LoadActor("LAMP")..{OnCommand=function(self) self:x(100); self:y(-188.5); self:z(-55); self:zoom(0.15); self:rotationx(-90); end;};


return t;