local speed = 5;
return Def.ActorFrame {
	Def.Quad{
		InitCommand=function(self) self:diffuse({0,0,0,0.5}); self:FullScreen(); self:cropright(1); end;
		OnCommand=function(self) self:decelerate(2.5/60*speed); self:cropright(0); end;
	};
	Def.Quad{
		InitCommand=function(self) self:diffuse({0,0,0,1}); self:FullScreen(); self:cropright(1); end;
		OnCommand=function(self) self:sleep(2.5/60*speed); self:decelerate(2.5/60*speed); self:cropright(0); end;
	};
};