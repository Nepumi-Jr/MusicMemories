
if STATSMAN:GetCurStageStats():AllFailed() or (not OP()) or #GAMESTATE:GetHumanPlayers() > 1 then return Def.ActorFrame{}; end
local Isla = Def.ActorFrame{
		OnCommand=cmd(draworder,50020);
		
	LoadActor("HappyIsla-Render")..{
		
		OnCommand=cmd(x,SCREEN_CENTER_X+SCREEN_CENTER_X/2*(GAMESTATE:GetHumanPlayers()[1] == PLAYER_1 and 1 or -1);y,SCREEN_CENTER_Y*1.47-55;zoom,0.15);
		OffCommand=cmd(linear,0.2;diffusealpha,0);
	};
};

return Isla;