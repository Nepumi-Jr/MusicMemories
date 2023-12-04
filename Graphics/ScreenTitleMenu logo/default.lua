TP.Battle.IsBattle = false;
local t = Def.ActorFrame{
	InitCommand=function(self) self:fov(70); end;
	-- LoadActor("_arrow")..{
	-- 	OnCommand=function(self) self:x(200); end;
	-- };
	LoadActor(THEME:GetPathG("","OutfoxLogo"))..{
		InitCommand=function(self) 
			self:zoom(0.5)
			self:bob():effectmagnitude(0,3,0):effectperiod(7) 
		end;
	};
	LoadActor("MusicMemoriesText.png")..{
		InitCommand=function(self) 
			self:x(205):y(40):rotationz(-5):zoom(0.15); 
			self:bob():effectmagnitude(0,5,0):effectperiod(7):effectoffset(0.4)
		end;
	};
	
};

return t;

