return Def.ActorFrame {
-- 	InitCommand=function(self) self:x(SCREEN_RIGHT); self:y(SCREEN_BOTTOM); self:draworder(101); end;
	StartTransitioningCommand=function(self)
		MESSAGEMAN:Broadcast("Toasty",{ Time = math.random(1,3) });
	end
};