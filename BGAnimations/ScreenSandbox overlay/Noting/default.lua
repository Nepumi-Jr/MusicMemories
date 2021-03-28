return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,{0,0,0,1});
	};
	LoadFont("Common Normal")..{
		Text="*nothing here*";
		InitCommand=cmd(Center;zoom,0.4);
	};
	LoadActor("Cricket")..{
		OnCommand=cmd(play);
	};
};