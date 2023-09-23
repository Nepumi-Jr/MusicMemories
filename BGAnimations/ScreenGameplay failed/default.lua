local MEME = ThemePrefs.Get("MEMEMode");
local FailType = math.random(1,20)

local t = Def.ActorFrame{};

t[#t+1] = Def.Quad{
StartTransitioningCommand=function()
	MESSAGEMAN:Broadcast("AFTERFAIL");
end;
};
FailType = math.random(1,16)

if FailType < 7 or not MEME then
	t[#t+1]=LoadActor("Normal");
elseif FailType == 7 then
	t[#t+1]=LoadActor("What");
elseif FailType == 8 then
	t[#t+1]=LoadActor("IWNKTG");
elseif FailType >= 9 and FailType <= 13 then
	t[#t+1]=LoadActor("Pump");
elseif FailType >= 14 and FailType <= 16 then
	t[#t+1]=LoadActor("DefaultLoooong");--So OG
end


return t;