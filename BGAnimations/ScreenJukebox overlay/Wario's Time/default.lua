local WT={0,1,2,3,true,0};
local WC={0,0,0,0,true,0};
local Wera = 0;
function CWT2Cl(C)
if C == 0 then
return color("#FFFFFFFF")
elseif C == 1 then
return color("#FFCC00FF")
elseif C == 2 then
return color("#FF0000FF")
else
return color("#000000FF")
end
end;
local t = Def.ActorFrame{};
t[#t+1] = Def.ActorFrame{
Def.ActorFrame{
InitCommand=cmd(Center;zoom,0.3;y,120);
OnCommand=cmd(playcommand,"NepuA");
NepuACommand=function(self)
if (GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2)) or (GAMESTATE:IsPlayerEnabled(PLAYER_1) and not Center1Player()) or (GAMESTATE:IsPlayerEnabled(PLAYER_2) and not Center1Player()) then
self:CenterX();
elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) and Center1Player() then
self:x(SCREEN_CENTER_X-260);
elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) and Center1Player() then
self:x(SCREEN_CENTER_X+260);
end
		if GAMESTATE:GetCurrentSong():GetFirstSecond() >= GAMESTATE:GetCurMusicSeconds() then
		Wera = GAMESTATE:GetCurrentSong():GetLastSecond() - GAMESTATE:GetCurrentSong():GetFirstSecond()
		else
		Wera = math.max(math.ceil(GAMESTATE:GetCurrentSong():GetLastSecond()) - GAMESTATE:GetCurMusicSeconds(),0)
		end
		
		if math.floor(Wera/60) > 10 then
		WT[1] = math.floor(math.floor(Wera/60)/10)
		WT[2] = math.floor(Wera/60)-math.floor(math.floor(Wera/60)/10)*10
		else
		WT[1] = 0
		WT[2] = math.floor(Wera/60)
		end
		WT[3] = math.floor((Wera - (WT[2]+WT[1]*10)*60)/10)
		WT[4] = math.floor(Wera - ((WT[2]+WT[1]*10)*60 + WT[3]*10))
		WT[5] = Wera - (WT[4]+WT[3]*10+WT[2]*60+WT[1]*600) > 0.5
		if Wera <= 31 and Wera > 11 then
		WT[6] = 1
		elseif Wera <= 11 then
		WT[6] = 2
		else
		WT[6] = 0
		end
self:sleep(1/30)
self:queuecommand("NepuA")
end;
LoadActor("WarioTime")..{
InitCommand=cmd(animate,false;SetTextureFiltering,false;x,-50*4);
OnCommand=cmd(playcommand,"NepuB");
NepuBCommand=function(self)
self:visible(not (WT[1] == 0))
self:setstate(WT[1])
self:diffuse(CWT2Cl(WT[6]))
self:sleep(1/30)
self:queuecommand("NepuB")
end;
};
LoadActor("WarioTime")..{
InitCommand=cmd(animate,false;SetTextureFiltering,false;x,-25*4);
OnCommand=cmd(playcommand,"NepuB");
NepuBCommand=function(self)
self:setstate(WT[2])
self:diffuse(CWT2Cl(WT[6]))
self:sleep(1/30)
self:queuecommand("NepuB")
end;
};
LoadActor("WarioTime")..{
InitCommand=cmd(animate,false;SetTextureFiltering,false;x,25*4);
OnCommand=cmd(playcommand,"NepuB");
NepuBCommand=function(self)
self:setstate(WT[3])
self:diffuse(CWT2Cl(WT[6]))
self:sleep(1/30)
self:queuecommand("NepuB")
end;
};
LoadActor("WarioTime")..{
InitCommand=cmd(animate,false;SetTextureFiltering,false;x,50*4);
OnCommand=cmd(playcommand,"NepuB");
NepuBCommand=function(self)
self:setstate(WT[4])
self:diffuse(CWT2Cl(WT[6]))
self:sleep(1/30)
self:queuecommand("NepuB")
end;
};
LoadActor("Ticktock")..{
InitCommand=cmd(animate,false;SetTextureFiltering,false;setstate,1);
OnCommand=cmd(playcommand,"NepuB");
NepuBCommand=function(self)
self:visible(WT[5])
self:diffuse(CWT2Cl(WT[6]))
self:sleep(1/30)
self:queuecommand("NepuB")
end;
};
};
};
return t;