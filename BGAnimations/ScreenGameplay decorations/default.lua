local t = Def.ActorFrame{


--LoadActor("X-mas");
--LoadActor("ED");
LoadActor("Ready")..{
	InitCommand=function(self) self:draworder(500); self:diffusealpha(0); end;
	OnCommand=function(self) self:sleep(1); self:linear(0.5); self:diffusealpha(1); end;	
	};
LoadActor("321Go")..{
	InitCommand=function(self) self:draworder(500); self:diffusealpha(0); end;
	OnCommand=function(self) self:sleep(1); self:linear(0.5); self:diffusealpha(1); end;	
	};
LoadActor("Go")..{
	InitCommand=function(self) self:draworder(500); self:diffusealpha(0); end;
	OnCommand=function(self) self:sleep(1); self:linear(0.5); self:diffusealpha(1); end;	
	};
LoadActor("Pause")..{InitCommand=function(self) self:draworder(500); end;
	StartTransitioningCommand=function(self) self:linear(0.5); self:diffusealpha(0); end;
};


LoadActor("Stageaward");

};

return t;