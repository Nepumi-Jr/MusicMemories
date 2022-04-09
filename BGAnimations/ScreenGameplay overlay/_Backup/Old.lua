local t = Def.ActorFrame{};
	--Mc is awesome!--Under lay life
	t[#t+1] =
	LoadActor("Stage!.lua")..{
		OnCommand=function(self) end;
	};
if MonthOfYear() == 10-1 and DayOfMonth() == 31 then
	t[#t+1] = LoadActor("Easter Horror.lua")..{
		OnCommand=function(self) self:y(SCREEN_BOTTOM-40); end;
	};
else
	t[#t+1] = LoadActor("Easter Egg.lua")..{
		OnCommand=function(self) self:y(SCREEN_BOTTOM-40); end;
	};
end
return t;