return Def.ActorFrame {
	LoadActor(THEME:GetPathG("_icon","Sort")) .. {
		InitCommand=function(self) self:x(-60); self:shadowlength(1); end;
	};
};
