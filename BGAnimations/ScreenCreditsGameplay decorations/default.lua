local t = Def.ActorFrame{

LoadActor("Ready")..{
	InitCommand=function(self) self:draworder(500); self:diffusealpha(0); end;
	OnCommand=function(self) self:sleep(1); self:linear(0.5); self:diffusealpha(1); end;	
	};
LoadActor("321Go")..{
	InitCommand=function(self) self:draworder(500); self:diffusealpha(0); end;
	OnCommand=function(self) self:sleep(1); self:linear(0.5); self:diffusealpha(1); end;	
	};

};

return t;