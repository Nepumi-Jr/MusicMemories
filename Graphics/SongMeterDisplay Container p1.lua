local size=THEME:GetMetric("SongMeterDisplay","StreamWidth")-14;
local song = nil;
local maxbeat=1;
local nowbeat=0;
local firstsec=0;
local maxsec=1;
local nowsec=0;
local t;
t=Def.ActorFrame{
	LoadActor("Creeper.lua")..{
		Name="_SEC_";
		InitCommand=function(self) self:animate(false); self:setstate(0); self:diffusealpha(0); self:zoom(2); self:blend("BlendMode_Add"); self:x(-size/2); end;
		OnCommand=function(self)
			(function(self) self:diffusealpha(0); self:sleep(1); self:bounceend(0.5); self:zoom(1); self:diffusealpha(1); end)(self);
		end;
	};
	LoadActor("Steve.lua")..{
		Name="_BEAT_";
		InitCommand=function(self) self:diffusealpha(0); self:zoom(2); self:blend("BlendMode_Add"); end;
		OnCommand=function(self)
			(function(self) self:diffusealpha(0); self:sleep(1); self:bounceend(0.5); self:zoom(1); self:diffusealpha(1); end)(self);
		end;
	};
	--[[
	LoadFont("Common Normal")..{
		Name="_DEBUG_";
		InitCommand=function(self) self:diffuse(Color("White")); self:socketcolor(Color("Blank")); end;
		OnCommand=function(self)
			(function(self) self:diffusealpha(0); self:sleep(1); self:bounceend(0.5); self:zoom(1); self:diffusealpha(1); self:settext("DEBUG"); end)(self);
		end;
	};
	--]]
};
local function update(self)
	if (not song) or (song ~= GAMESTATE:GetCurrentSong()) then
		song = GAMESTATE:GetCurrentSong();
		if not song then
			return;
		end;
		firstsec=song:GetFirstSecond();
		maxsec=math.max(1,song:GetLastSecond()-firstsec);
		maxbeat=math.max(1,Sec2PlayerBeat(PLAYER_1,song:GetLastSecond()));
	end;
	if not song then
		return;
	end;
	local beat = self:GetChild("_BEAT_");
	local sec = self:GetChild("_SEC_");
	local musicsec=_MUSICSECOND()
	nowsec=math.min(math.max(0,musicsec-firstsec),maxsec);
	nowbeat=math.min(math.max(0,GetPlayerSongBeat2(PLAYER_1,musicsec)),maxbeat);
	beat:x(-size/2+size*nowbeat/maxbeat);
	sec:x(-size/2+size*nowsec/maxsec);
--	local dbg = self:GetChild("_DEBUG_");
--	dbg:settextf("%f",nowbeat);
end;
t.InitCommand=function(self) self:SetUpdateFunction(update); end;
return t;