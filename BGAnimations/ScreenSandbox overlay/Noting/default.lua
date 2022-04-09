return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:FullScreen(); self:diffuse({0,0,0,1}); end;
	};
	LoadFont("Common Normal")..{
		Text="*nothing here*";
		InitCommand=function(self) self:Center(); self:zoom(0.4); end;
	};
	LoadActor("Cricket")..{
		OnCommand=function(self) self:play(); end;
	};
};