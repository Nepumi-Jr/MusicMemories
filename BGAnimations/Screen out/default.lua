local fSleepTime = THEME:GetMetric( Var "LoadingScreen","ScreenOutDelay") or 0.2;

return Def.ActorFrame {
	Def.Quad{
		InitCommand=function(self) self:diffuse({0.5,0.5,0.5,0.5}); self:FullScreen(); self:cropleft(1); end;
		OnCommand=function(self) self:decelerate(fSleepTime/2); self:cropleft(0); end;
	};
	Def.Quad{
		InitCommand=function(self) self:diffuse({0.5,0.5,0.5,1}); self:FullScreen(); self:cropleft(1); end;
		OnCommand=function(self) self:sleep(fSleepTime/2); self:decelerate(fSleepTime/2); self:cropleft(0); end;
	};
};