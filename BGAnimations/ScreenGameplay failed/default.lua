local MEME = ThemePrefs.Get("MEMEMode");
local t = Def.ActorFrame{};

t[#t+1] = Def.Quad{
StartTransitioningCommand=function()
	MESSAGEMAN:Broadcast("AFTERFAIL");
end;
};
local FailType = math.random(1,23);

if LoadModule("Easter.today.lua")() == "HALLOWEEN" then
	FailType = 13;
end

if FailType < 7 or not MEME then
	t[#t+1]=LoadActor("Normal");
elseif FailType == 7 then
	t[#t+1]=LoadActor("What");
elseif FailType == 8 then
	t[#t+1]=LoadActor("IWNKTG");
elseif FailType <= 12 then
	t[#t+1]=LoadActor("Pump");
elseif FailType == 13 then
	t[#t+1]=LoadActor("FNAF");
elseif  FailType <= 16 then
	t[#t+1]=LoadActor("DefaultLoooong");--So OG
elseif FailType <= 19 then
	t[#t+1]=LoadActor("ITG");
elseif FailType <= 21 then
	t[#t+1]=LoadActor("SmMax");
elseif FailType <= 23 then
	t[#t+1]=LoadActor("FNAF");
end


return t;