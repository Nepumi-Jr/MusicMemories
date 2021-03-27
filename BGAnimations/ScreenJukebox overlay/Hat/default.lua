local PPeng;
if GAMESTATE:IsCourseMode() then
PPeng = GAMESTATE:GetCurrentCourse():GetCourseEntry(0):GetSong();
else
PPeng = GAMESTATE:GetCurrentSong();
end


local FB = round(round(PPeng:GetFirstBeat())/4)*4


local Y = {false,false,false,false,false}


function B2S(b)
return GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(b)
end;


local Char = -0.25
local OFF = PREFSMAN:GetPreference('GlobalOffsetSeconds');

local Tune = Def.ActorFrame{

Def.Quad{
OnCommand=cmd(sleep,0.1;queuecommand,"GM");--Use For Delay
--IDK Why SM use > 0 beat and then turn back to real beat :(
GMCommand=function(self)
MESSAGEMAN:Broadcast("SFB")
end;
};




LoadFont("Common Normal")..{
InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y*0.4;settext,"";rainbow);
SFBMessageCommand=function(self)
self:playcommand("Nep")
end;
NepCommand=function(self)
if GAMESTATE:GetSongBeat() >= FB+Char then
elseif GAMESTATE:GetSongBeat() >= FB-1+Char then
--self:settext("GOO")

if not Y[1] then
MESSAGEMAN:Broadcast("lent")
Y[1] = true
end


elseif GAMESTATE:GetSongBeat() >= FB-2+Char then
--self:settext("1")
if not Y[2] then
MESSAGEMAN:Broadcast("lent")
Y[2] = true
end
elseif GAMESTATE:GetSongBeat() >= FB-3+Char then
--self:settext("2")
if not Y[3] then
MESSAGEMAN:Broadcast("lent")
Y[3] = true
end
elseif GAMESTATE:GetSongBeat() >= FB-4+Char then
--self:settext("3")
if not Y[4] then
MESSAGEMAN:Broadcast("lent")
Y[4] = true
end
end
if GAMESTATE:GetSongBeat() < FB+10 then
self:sleep(1/30):queuecommand("Nep")
end
end;
};


LoadActor("Hat.mp3")..{
--lentMessageCommand=cmd(play);
};







};
return Tune;