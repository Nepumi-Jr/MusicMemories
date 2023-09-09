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
Artist = not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSong():GetDisplayArtist();

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


NS = GAMESTATE:GetCurrentStageIndex()+1;

t[#t+1] = LoadActor("Floor")..{OnCommand=cmd(rotationx,-90;zoom,0.75);};
t[#t+1] = LoadActor("Zight")..{OnCommand=cmd(z,-113;y,-188.5;vertalign,top;zoom,SCREEN_RIGHT/1900;zoomy,3);};
t[#t+1] = LoadActor("TABLE")..{OnCommand=cmd(zoom,0.25;rotationy,90);};
t[#t+1] = LoadActor("PAKKA")..{OnCommand=cmd(x,80;y,-188.5;zoom,3;rotationz,-30;rotationx,90);};

t[#t+1] = Def.ActorFrame{
		OnCommand=cmd(y,-188.5;z,20;zoom,0.08/0.2;rotationz,8;rotationx,-90);
	LoadActor("RNote")..{OnCommand=cmd(zoom,0.2;diffusealpha,1);};
	LoadFont("Common Normal")..{OnCommand=cmd(y,-167;zoom,0.6;settext,title;diffuse,{0,0,0,1});};
	LoadFont("Common Normal")..{OnCommand=cmd(y,-157;zoom,0.3;settext,SubTitle ~= "" and "-"..SubTitle.."-" or "";diffuse,{0,0,0,1});};
	LoadFont("Common Normal")..{OnCommand=cmd(x,-123;y,-153;horizalign,left;zoom,0.3;settext,Artist~= nil and "By "..Artist or "";diffuse,{0,0,0,1});};
	LoadFont("Common Normal")..{OnCommand=cmd(x,131;y,-153;horizalign,right;zoom,0.3;settext,#charter==0 and "Unknown Composer" or (#charter==2 and charter[1].." & "..charter[2] or charter[1]);diffuse,{0,0,0,1});};
	LoadFont("Common Normal")..{OnCommand=cmd(x,-114;y,-143;horizalign,left;zoom,0.3;settext,#BPM==2 and tostring(BPM[1]).."-"..tostring(BPM[2]) or tostring(BPM[1]);diffuse,{0,0,0,1});};
};


if GAMESTATE:IsCourseMode() then
t[#t+1] = Def.ActorFrame{
		OnCommand=cmd(x,-80;y,-188.5;z,20;zoom,0.08/0.2;rotationz,-50;rotationx,-90);
		LoadActor("Paper")..{OnCommand=cmd(zoom,0.2);};
LoadFont("Common Normal")..{OnCommand=cmd(y,-167;settext,"Content";diffuse,color("#000000"))}}
for na = 1,math.min(#CEN,21) do
t[#t+1] = Def.ActorFrame{
		OnCommand=cmd(x,-80;y,-188.5;z,20;zoom,0.08/0.2;rotationz,-50;rotationx,-90);LoadFont("Common Normal")..{
		OnCommand=cmd(x,-110;y,-160+15*na;horizalign,left;
		settextf,"No.%2d : %s (%s)",na,
		CEN[na]:IsSecret() and "?????????" or CEN[na]:GetSong():GetDisplayMainTitle(),
		CEN[na]:IsSecret() and "??:??" or SecondsToMMSS(CEN[na]:GetSong():MusicLengthSeconds());
		zoom,.5;diffuse,color("#000000"));};
		};
end
end

t[#t+1] = Def.ActorFrame{
		OnCommand=cmd(x,60;y,-188.5;z,50;zoom,0.08/0.2;rotationz,30;rotationx,-90);
		LoadActor("TimeP")..{OnCommand=cmd(zoom,0.2);};
LoadFont("Common Normal")..{OnCommand=cmd(x,-30;zoom,1.2;horizalign,left;settext,SecondsToMMSS(Time);diffuse,color("#000000FF"));};};



t[#t+1] = LoadActor("Light")..{OnCommand=cmd(y,-188.5;zoom,SCREEN_RIGHT/1899.7361/1.03;zoomx,SCREEN_RIGHT/1899.7361/1.03+.0135;rotationx,-90);};
t[#t+1] = LoadActor("Zight")..{OnCommand=cmd(z,113;y,-188.5;vertalign,top;zoom,SCREEN_RIGHT/1900;zoomy,3);};
t[#t+1] = LoadActor("Yight")..{OnCommand=cmd(x,-224.7;y,-188.5;vertalign,top;zoom,SCREEN_RIGHT/1900;zoomy,6;zoomx,1/3+0.1;rotationy,-90);};
t[#t+1] = LoadActor("LAMP")..{OnCommand=cmd(x,100;y,-188.5;z,-55;zoom,0.15;rotationx,-90);};


return t;