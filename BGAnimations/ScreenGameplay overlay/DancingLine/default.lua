local t = Def.ActorFrame{};
local RanCl = {"Red","Blue","Green","Yellow","Orange","Purple","Greener","Magenta","Pink"};
local PZ = false;
t[#t+1] = Def.Quad {
InitCommand=function(self) self:x(0); self:y(SCREEN_BOTTOM-4); self:zoomy(8); self:horizalign(left); end;
OnCommand=function(self) self:playcommand("SBTL"); end;
SBTLCommand=function(self)
SONGg = GAMESTATE:GetCurrentSong();
self:zoomx(math.max(SCREEN_RIGHT*((GAMESTATE:GetCurMusicSeconds()/SONGg:GetLastSecond()))),0)
if math.mod(GAMESTATE:GetSongBeat(),4) < 0.5 and not PZ then
self:diffuse(Color[RanCl[math.random(#RanCl)]])
PZ = true;
elseif math.mod(GAMESTATE:GetSongBeat(),4) >= 0.5 then
PZ = false;
end


self:sleep(1/60):queuecommand("SBTL")
end;
};
t[#t+1] = Def.Quad {
InitCommand=function(self) self:x(0); self:y(SCREEN_BOTTOM-4); self:zoomy(8); self:horizalign(left); end;
OnCommand=function(self) self:playcommand("SBTL"); end;
SBTLCommand=function(self)
self:zoomx(math.max(SCREEN_RIGHT*((GAMESTATE:GetCurMusicSeconds()/SONGg:GetLastSecond()))),0)
self:diffusealpha(-math.mod(GAMESTATE:GetSongBeat(),1)+1)

self:sleep(1/60):queuecommand("SBTL")
end;
};
return t;