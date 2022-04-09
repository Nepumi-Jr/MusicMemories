
if STATSMAN:GetCurStageStats():AllFailed() or (not OP()) or #GAMESTATE:GetHumanPlayers() > 1 then return Def.ActorFrame{}; end
local Isla = Def.ActorFrame{
		OnCommand=function(self) self:draworder(50020); end;
		
	LoadActor("HappyIsla-Render")..{
		
		OnCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_CENTER_X/2*(GAMESTATE:GetHumanPlayers()[1] == PLAYER_1 and 1 or -1)); self:y(SCREEN_CENTER_Y*1.47-55); self:zoom(0.15); end;
		OffCommand=function(self) self:linear(0.2); self:diffusealpha(0); end;
	};
};

return Isla;