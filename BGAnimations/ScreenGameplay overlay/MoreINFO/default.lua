local N = Def.ActorFrame{
	
	LoadActor("Jud")..{
		OnCommand=function(self)
            if GAMESTATE:IsPlayerEnabled(PLAYER_1) and Center1Player() then
                self:x(SCREEN_CENTER_X-220);
            elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) and Center1Player() then
                self:x(SCREEN_CENTER_X+220);
            else
                self:CenterX()
            end
            
            self:y(SCREEN_CENTER_Y+50)

        end;
	};
	LoadActor("OffsetBar")..{
		OnCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y*2-30); end;
	};
	
	
};


return N;

