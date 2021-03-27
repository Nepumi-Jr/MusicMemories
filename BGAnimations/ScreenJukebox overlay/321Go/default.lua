
local PPeng;
if GAMESTATE:IsCourseMode() then
PPeng = GAMESTATE:GetCurrentCourse():GetCourseEntry(0):GetSong();
else
PPeng = GAMESTATE:GetCurrentSong();
end


local FB = round(round(PPeng:GetFirstBeat())/4)*4


local Y = {false,false,false,false,false}


local function Diff2Cli(d,i)
CD = GameColor.Difficulty[d];
return CD[i]
end;

local CL = {1,1,1,1};




local Tune = Def.ActorFrame{

Def.Quad{
OnCommand=cmd(sleep,0.1;queuecommand,"GM");--Use For Delay
--IDK Why SM use > 0 beat and then turn back to real beat :(
GMCommand=function(self)
		if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		CL = Meter2Color(GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter()/2+GAMESTATE:GetCurrentSteps(PLAYER_2):GetMeter()/2)
		elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
		CL = Meter2Color(GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter())
		elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		CL = Meter2Color(GAMESTATE:GetCurrentSteps(PLAYER_2):GetMeter())
		end
MESSAGEMAN:Broadcast("SFB")
end;
};



LoadFont("Common Normal")..{
InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y*0.4;settext,"";rainbow);
SFBMessageCommand=function(self)
self:playcommand("Nep")
end;
NepCommand=function(self)
if GAMESTATE:GetSongBeat() >= FB then
if not Y[5] then
MESSAGEMAN:Broadcast("RIPR")
Y[5] = true
end
elseif GAMESTATE:GetSongBeat() >= FB-1 then
--self:settext("GOO")

if not Y[1] then
MESSAGEMAN:Broadcast("Gooo")
Y[1] = true
end


elseif GAMESTATE:GetSongBeat() >= FB-2 then
--self:settext("1")
if not Y[2] then
MESSAGEMAN:Broadcast("Nueng")
Y[2] = true
end
elseif GAMESTATE:GetSongBeat() >= FB-3 then
--self:settext("2")
if not Y[3] then
MESSAGEMAN:Broadcast("Song")
Y[3] = true
end
elseif GAMESTATE:GetSongBeat() >= FB-4 then
--self:settext("3")
if not Y[4] then
MESSAGEMAN:Broadcast("Sam")
Y[4] = true
end
end
if GAMESTATE:GetSongBeat() < FB+10 then
self:sleep(1/30):queuecommand("Nep")
end
end;
};


LoadFont("Common Large")..{
SFBMessageCommand=cmd(Center;animate,false;diffuse,CL;zoom,1;zoomx,0);
SamMessageCommand=cmd(settext,"3";decelerate,(GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB-3)-GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB-4))/1.5;zoomx,1;);
SongMessageCommand=cmd(settext,"2";zoomx,0;decelerate,(GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB-2)-GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB-3))/1.5;zoomx,1;);
NuengMessageCommand=cmd(settext,"1";zoomx,0;decelerate,(GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB-1)-GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB-2))/1.5;zoomx,1;);
GoooMessageCommand=cmd(decelerate,(GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB)-GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB-1))/1.5;zoomx,0);
};

Def.ActorFrame{
SFBMessageCommand=cmd(Center;diffuse,CL;);
LoadFont("Common Large")..{
OnCommand=cmd(x,-45;settext,'G';zoomy,0);
GoooMessageCommand=cmd(decelerate,(GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB)-GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB-1))/1.5;zoomy,1);
RIPRMessageCommand=cmd(decelerate,(GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB+1)-GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB))/1.5;zoomx,0);
};
LoadFont("Common Large")..{
OnCommand=cmd(x,45;settext,'O';zoomy,0);
GoooMessageCommand=cmd(decelerate,(GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB)-GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB-1))/1.5;zoomy,1);
RIPRMessageCommand=cmd(decelerate,(GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB+1)-GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB))/1.5;zoomx,0);
};
LoadFont("Common Large")..{
OnCommand=cmd(x,105;settext,'!';zoomy,0);
GoooMessageCommand=cmd(decelerate,(GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB)-GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB-1))/1.5;zoomy,1);
RIPRMessageCommand=cmd(decelerate,(GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB+1)-GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(FB))/1.5;zoomx,0);
};
};





};
return Tune;