local t = Def.ActorFrame{};
local S = 1
local Con = false;
local SeB = function( event )
	if not event then return end

	if event.type == "InputEventType_FirstPress" then
	if event.button == "Left" or event.button == "DownLeft" then
	if S == 1 then
	S = 2
	else
	S = 1
	end
	end
	MESSAGEMAN:Broadcast("Re")
	if event.button == "Right" or event.button == "DownRight" then
	if S == 1 then
	S = 2
	else
	S = 1
	end
	MESSAGEMAN:Broadcast("Re")
	end
	if event.button == "Start" or event.button == "Center" then
	if S == 1 then
	TP.Battle.IsBattle = false;
	if THEME:GetMetric("Common","AutoSetStyle") == false then
	SCREENMAN:GetTopScreen():SetNextScreenName("ScreenSelectStyle"):StartTransitioningScreen("SM_GoToNextScreen")
	else
	SCREENMAN:GetTopScreen():SetNextScreenName("ScreenProfileLoad"):StartTransitioningScreen("SM_GoToNextScreen")
	end
	else
	SCREENMAN:GetTopScreen():SetNextScreenName("ScreenSelectBattle"):StartTransitioningScreen("SM_GoToNextScreen")
	end
	MESSAGEMAN:Broadcast("Con")
	Con = true;
	end
	if event.button == "Back" then
	SCREENMAN:GetTopScreen():SetNextScreenName("ScreenTitleMenu"):StartTransitioningScreen("SM_GoToNextScreen")
	end
	end
	
	
end
t[#t+1] = Def.ActorFrame{
OnCommand=function(self) self:playcommand("Lo"); end;
LoCommand=function(self) SCREENMAN:GetTopScreen():AddInputCallback(SeB) self:sleep(0.02):queuecommand("Lo") end;
Def.ActorFrame{
OnCommand=function(self) self:x(SCREEN_CENTER_X*0.5); self:y(SCREEN_CENTER_Y); self:zoom(0); self:decelerate(0.5); self:zoom(1); end;
ReMessageCommand=function(self)
if not Con then
if S == 1 then
self:stoptweening():decelerate(0.3):zoom(1)
else
self:stoptweening():decelerate(0.3):zoom(0.75)
end
end
end;
ConMessageCommand=function(self)
self:stoptweening():decelerate(0.5):zoom(0)
if S == 1 then  end;
end;
LoadModule("Menu.Button.lua")(0,0,color("#77FF77"),color("#33AA33"),color("#33AA33"),color("#33AA33"),color("#33AA33"),"Normal","Just Normal");
};
Def.ActorFrame{
OnCommand=function(self) self:x(SCREEN_CENTER_X*1.5); self:y(SCREEN_CENTER_Y); self:zoom(0); self:decelerate(0.5); self:zoom(0.75); end;
ReMessageCommand=function(self)
if not Con then
if S == 2 then
self:stoptweening():decelerate(0.3):zoom(1)
else
self:stoptweening():decelerate(0.3):zoom(0.75)
end
end
end;
ConMessageCommand=function(self)
self:stoptweening():decelerate(0.5):zoom(0)
if S == 2 then  end;
end;
LoadModule("Menu.Button.lua")(0,0,color("#FF9900"),color("#AA6600"),color("#AA6600"),color("#AA6600"),color("#AA6600"),"Battle!","More Fun!");
};
};
return t;