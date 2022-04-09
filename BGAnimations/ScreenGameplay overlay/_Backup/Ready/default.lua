local toii = 0;
local FB = 0;
local Funny = true;
local LentRea = true;
local PPeng;
if GAMESTATE:IsCourseMode() then
PPeng = GAMESTATE:GetCurrentCourse():GetCourseEntry(0):GetSong();
else
PPeng = GAMESTATE:GetCurrentSong();
end
if PPeng:GetFirstBeat() < 4 then
LentRea = false;
end
local t = Def.ActorFrame{};
if PPeng:GetFirstBeat() > 8 then
t[#t+1] = Def.ActorFrame{
OnCommand=function(self) self:playcommand("Ne"); end;
NeCommand=function(self)
if math.abs(math.mod(GAMESTATE:GetSongBeat(),1))< 0.5 and not Funny then
Funny = true
self:diffuse(color((math.random(1,10)/10)..","..(math.random(1,10)/10)..","..(math.random(1,10)/10)..","..1))
elseif math.mod(GAMESTATE:GetSongBeat(),1)>= 0.5 then
Funny = false
end
self:sleep(1/30)
self:queuecommand("Ne")
end;
LoadActor("Ready.png")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:diffusealpha(0); end;
		OnCommand=function(self) self:playcommand('Rea'); end;
		ReaCommand=function(self)
		if LentRea then
		FB = PPeng:GetFirstBeat();
		if GAMESTATE:GetSongBeat() >= FB-8 and GAMESTATE:GetSongBeat() <= FB-5 and toii == 0 then
		self:linear(0.25)
		self:diffusealpha(1)
		toii = 1
		elseif GAMESTATE:GetSongBeat() >= FB-5 and GAMESTATE:GetSongBeat() <= FB-4 and toii == 1 then
		self:linear(0.25)
		self:diffusealpha(0)
		toii = 2
		elseif GAMESTATE:GetSongBeat() >= FB+4 then
		self:linear(0.25)
		self:diffusealpha(0)
		end
		
		if GAMESTATE:GetSongBeat() < FB+4 then
		self:sleep(0.02)
		self:queuecommand('Rea')
		end
		end
		end;
};
};
elseif PPeng:GetFirstBeat() < 8 and PPeng:GetFirstBeat() > 4 then
t[#t+1] = Def.ActorFrame{
OnCommand=function(self) self:playcommand("Ne"); end;
NeCommand=function(self)
if math.abs(math.mod(GAMESTATE:GetSongBeat(),1))< 0.5 and not Funny then
Funny = true
self:diffuse(color((math.random(1,10)/10)..","..(math.random(1,10)/10)..","..(math.random(1,10)/10)..","..1))
elseif math.mod(GAMESTATE:GetSongBeat(),1)>= 0.5 then
Funny = false
end
self:sleep(1/30)
self:queuecommand("Ne")
end;
LoadActor("Ready.png")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y-80); self:diffusealpha(0); end;
		OnCommand=function(self) self:playcommand('Rea'); end;
		ReaCommand=function(self)
		if LentRea then
		FB = PPeng:GetFirstBeat();
		if GAMESTATE:GetSongBeat() >= 0 and GAMESTATE:GetSongBeat() <= 4 and toii == 0 then
		self:linear(0.25)
		self:diffusealpha(1)
		toii = 1
		elseif GAMESTATE:GetSongBeat() >= 4 and GAMESTATE:GetSongBeat() <= 4 and toii == 1 then
		self:linear(0.25)
		self:diffusealpha(0)
		toii = 2
		elseif GAMESTATE:GetSongBeat() >= 8 then
		self:linear(0.25)
		self:diffusealpha(0)
		end
		
		if GAMESTATE:GetSongBeat() < 8 then
		self:sleep(0.02)
		self:queuecommand('Rea')
		end
		end
		end;
};
};
end
return t;