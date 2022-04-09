local toll = 0;
local FB = 0;
local RFB =  0;
local Funny = true;
function B2S(b)
return GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(b)
end;
local ratemod = string.match(GAMESTATE:GetSongOptionsString(), "%d.%d");
if ratemod then
	ratemod = tonumber(ratemod);
else
	ratemod = 1.0
end
local SP3 =1
local SP2 =1
local SP1 =1
local SPGo = 1
local Frame = 0;
local t = Def.ActorFrame{
Def.ActorFrame{
OnCommand=function(self) self:playcommand("Ne"); end;
NeCommand=function(self)
if math.mod(math.abs(GAMESTATE:GetSongBeat()),1)< 0.5 and not Funny then
Funny = true
self:diffuse(color((math.random(1,10)/10)..","..(math.random(1,10)/10)..","..(math.random(1,10)/10)..","..1))
elseif math.mod(GAMESTATE:GetSongBeat(),1)>= 0.5 then
Funny = false
end
self:sleep(1/30)
self:queuecommand("Ne")
end;


Def.ActorFrame{
	InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); end;
LoadActor("count 1x5.png")..{
		InitCommand=function(self) self:diffusealpha(0); end;
		OnCommand=function(self)
FB = GAMESTATE:GetCurrentSong():GetFirstBeat();
if math.mod(FB,4) <= 2 then
RFB = math.floor(FB/4)*4
else
RFB = math.ceil(FB/4)*4
end
SP3 =math.abs(B2S(RFB-4) - B2S(RFB-3.25))/ratemod;
SP2 =math.abs(B2S(RFB-3) - B2S(RFB-2.25))/ratemod;
SP1 =math.abs(B2S(RFB-2) - B2S(RFB-1.25))/ratemod;
SPGo = math.abs(B2S(RFB-1) - B2S(RFB-0.25))/ratemod;
		self:animate(0);
		self:playcommand("TTO")
		end;
		TTOCommand=function(self)
		if GAMESTATE:GetSongBeat() >= RFB-8 and GAMESTATE:GetSongBeat() <= RFB-4 and toll == 0 then
		toll = 1
		elseif GAMESTATE:GetSongBeat() >= RFB-4 and GAMESTATE:GetSongBeat() <= RFB-3 and toll == 1 then
		self:diffusealpha(1)
		self:rotationz(-10)
		self:zoom(2)
		self:linear(SP3)
		self:rotationz(0)
		self:zoom(1)
		Frame = 0
		toll = 2
		elseif GAMESTATE:GetSongBeat() >= RFB-3 and GAMESTATE:GetSongBeat() <= RFB-2 and toll == 2 then
		self:rotationz(15)
		self:zoom(2)
		self:linear(SP2)
		self:rotationz(0)
		self:zoom(1)
		Frame = 1
		toll = 3
		elseif GAMESTATE:GetSongBeat() >= RFB-2 and GAMESTATE:GetSongBeat() <= RFB-1 and toll == 3 then
		self:rotationz(-20)
		self:zoom(2)
		self:linear(SP1)
		self:rotationz(0)
		self:zoom(1)
		Frame = 2
		toll = 4
		elseif GAMESTATE:GetSongBeat() >= RFB-1 and GAMESTATE:GetSongBeat() <= RFB and toll == 4 then
		self:rotationz(25)
		self:zoom(2)
		self:linear(SPGo)
		self:rotationz(0)
		self:zoom(1)
		Frame = 3
		toll = 5
		elseif GAMESTATE:GetSongBeat() >= RFB and toll == 5 then
		self:linear(SPGo)
		self:diffusealpha(0)
		elseif GAMESTATE:GetSongBeat() >= RFB+4 then
		self:linear(SPGo)
		self:diffusealpha(0)
		end
		self:sleep(1/30)
		self:setstate(Frame)
		if GAMESTATE:GetSongBeat() < RFB+10 then
		self:queuecommand("TTO")
		end
		end;
};
};


};
};
return t;