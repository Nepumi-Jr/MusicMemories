local hat = 0;
local FB = 0;
local RFB =  0;
local Funny = true;
function B2S(b)
return GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(b)
end;
local Offset = -0.25;
local t = Def.ActorFrame{

LoadActor("Hat.mp3")..{
		InitCommand=function(self) self:diffusealpha(0); end;
		OnCommand=function(self) self:playcommand('Hat'); end;
		HatCommand=function(self)
		--self:setstate(RD)
FB = GAMESTATE:GetCurrentSong():GetFirstBeat();
if math.mod(FB,4) <= 2 then
RFB = math.floor(FB/4)*4
else
RFB = math.ceil(FB/4)*4
end
		if GAMESTATE:GetSongBeat() >= RFB-8+Offset and GAMESTATE:GetSongBeat() <= RFB-4+Offset and hat == 0 then
		hat = 1
		elseif GAMESTATE:GetSongBeat() >= RFB-4+Offset and GAMESTATE:GetSongBeat() <= RFB-3+Offset and hat == 1 then
		self:play()
		hat = 2
		elseif GAMESTATE:GetSongBeat() >= RFB-3+Offset and GAMESTATE:GetSongBeat() <= RFB-2+Offset and hat == 2 then
		self:play()
		hat = 3
		elseif GAMESTATE:GetSongBeat() >= RFB-2+Offset and GAMESTATE:GetSongBeat() <= RFB-1+Offset and hat == 3 then
		self:play()
		hat = 4
		elseif GAMESTATE:GetSongBeat() >= RFB-1+Offset and GAMESTATE:GetSongBeat() <= RFB+Offset and hat == 4 then
		self:play()
		hat = 5
		end
		self:sleep(0.02)
		self:queuecommand('Hat')
		end;
};


};
return t;