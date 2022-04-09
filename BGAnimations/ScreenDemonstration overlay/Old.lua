local t = Def.ActorFrame{--Mc is awesome!--Under lay life
	LoadActor("Easter Egg.lua")..{
		OnCommand=function(self) self:y(SCREEN_BOTTOM-40); end;
	};
	LoadActor("Stage!.lua")..{
		OnCommand=function(self) end;
	};
	LoadActor("Hardddddd.lua")..{
		OnCommand=function(self) end;
	};
};
return t;