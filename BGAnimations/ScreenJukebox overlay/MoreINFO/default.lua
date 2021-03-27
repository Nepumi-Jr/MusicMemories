local N = Def.ActorFrame{
	
	LoadActor("Jud")..{
		OnCommand=cmd(x,SCREEN_CENTER_X-220;y,SCREEN_CENTER_Y+50);
	};
	LoadActor("OffsetBar")..{
		OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y*2-30);
	};
	
	
};


return N;

