--If a Command has "NOTESKIN:GetMetricA" in it, that means it gets the command from the metrics.ini, else use function(self) end; to define command.
--If you dont know how "NOTESKIN:GetMetricA" works here is an explanation.
--NOTESKIN:GetMetricA("The [Group] in the metrics.ini", "The actual Command to fallback on in the metrics.ini");

local t = Def.ActorFrame {
	Def.Sprite {
		Texture="St and Cp";
		Frame0000=3;
		Delay0000=1;
		Frame0001=5;
		Delay0001=1;
		Frame0002=4;
		Delay0002=1;
		Frame0003=5;
		Delay0003=1;
		InitCommand=function(self) self:effectclock("beat"); end;
	};
};
return t;

--[[
Effecttiming Info

Effecttiming is one of the most anoying commands I have ever used
Because there was no one able to tell me how it works
But I found out how

The basic command is effecttiming,0,0,0,0
It is beat based so effecttiming,0.25,0.25,0.25,0.25 is equal as 1 beat (when you have effectclock,"beat" in use)
The first 0 is the amount of time to transfer from effectcolor1 to effectcolor2
The second 0 is the ammount of time effectcolor1 stays
The third 0 is the amount of time to transfer from effectcolor2 to effectcolor1
The last 0 is the ammount of tume effectcolor2 stays
Every 0 can change value to as high as possible

An example of effectcolor1 and effectcolor2 going from 1 color to the other with no transfer is effecttiming,0,0.50,0,0.50
An example of effectcolor1 and effectcolor2 going from effectcolor1 to the other with a transfer is effecttiming,0.25,0.50,0,0.25
]]
