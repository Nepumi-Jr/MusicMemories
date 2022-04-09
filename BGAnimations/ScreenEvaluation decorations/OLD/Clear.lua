local pic = "normal.png";
local symbol = {'C','L','E','A','R','E','D'};
local CCl = {color("#FF0000"),
color("#FF8800"),
color("#FFFF00"),
color("#00FF00"),
color("#00FF88"),
color("#0000FF"),
color("#FF00FF")};
local Rannn = {1,1,1,1,1,1,1};
LoadActor("../_save/Battle.lua")
local FULLLL = false;
if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):FullCombo() then
FULLLL = true;
end
elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):FullCombo() then
FULLLL = true;
end
end
if Isbattle then
pic = "rave.png";
symbol = {'R','E','S','U','I','T','S'};
elseif MonthOfYear() == 4-1 and DayOfMonth() == 1 then
pic = "FOOLED.png";
symbol = {'F','A','I','L','E','D','point'};
elseif FULLLL then
symbol = {'A','W','E','S','O','M','E'};
elseif GAMESTATE:GetPlayMode() == "PlayMode_Rave" or GAMESTATE:GetPlayMode() == "PlayMode_Battle" then
pic = "rave.png";
symbol = {'R','E','S','U','I','T','S'};
elseif GAMESTATE:GetPlayMode() == "PlayMode_Nonstop" or GAMESTATE:GetPlayMode() == "PlayMode_Oni" or GAMESTATE:GetPlayMode() == "PlayMode_Endless" then
pic = "oni.png";
symbol = {'F','I','N','I','S','H','point'};
end
local t = Def.ActorFrame{};
	t[#t+1] = LoadActor("Let/"..pic)..{
		InitCommand=function(self) self:Center(); self:FullScreen(); end;
		OnCommand=function(self) self:diffusealpha(0.35); self:sleep(0.25); self:linear(0.5); self:diffusealpha(0); end;
	};
local Sped = 60;
local Leaveit = 40;
for i = 1,7 do
	t[#t+1]=LoadActor("Let/"..symbol[i]..".png")..{
		InitCommand=function(self)
		self:x(SCREEN_CENTER_X + Sped*(i-4))
		:CenterY()
		:diffuse(CCl[i])
		end;
		OnCommand=function(self)
		self:sleep(0.2):decelerate(0.5)
		Rannn[i] = math.random(1,4)
		if Rannn[i] == 1 then
		self:x(math.random(0,SCREEN_RIGHT))
		self:y((-1)*Leaveit)
		elseif Rannn[i] == 2 then
		self:x((-1)*Leaveit)
		self:y(math.random(0,SCREEN_BOTTOM))
		elseif Rannn[i] == 3 then
		self:x(math.random(0,SCREEN_RIGHT))
		self:y(SCREEN_BOTTOM+Leaveit)
		elseif Rannn[i] == 4 then
		self:x(SCREEN_RIGHT+Leaveit)
		self:y(math.random(0,SCREEN_BOTTOM))
		end
		end;
	};
end




return t;