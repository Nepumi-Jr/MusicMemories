local t = Def.ActorFrame{


--LoadActor("X-mas");
--LoadActor("ED");
LoadActor("Ready")..{
	InitCommand=cmd(draworder,500;diffusealpha,0);
	OnCommand=cmd(sleep,1;linear,0.5;diffusealpha,1);	
	};
LoadActor("321Go")..{
	InitCommand=cmd(draworder,500;diffusealpha,0);
	OnCommand=cmd(sleep,1;linear,0.5;diffusealpha,1);	
	};
LoadActor("Go")..{
	InitCommand=cmd(draworder,500;diffusealpha,0);
	OnCommand=cmd(sleep,1;linear,0.5;diffusealpha,1);	
	};
LoadActor("Pause")..{InitCommand=cmd(draworder,500);
	StartTransitioningCommand=cmd(linear,0.5;diffusealpha,0);
};


LoadActor("Stageaward");

};

return t;