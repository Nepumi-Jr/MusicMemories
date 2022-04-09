local Nep = 0;
local t = Def.ActorFrame{
    --[[Def.ActorFrame{
        InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); end;
        OnCommand=function(self)
            if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
                self:spin()
                self:effectmagnitude(200,344,104.203)
            end
        end;
        Def.ActorFrame{
            CurrentSongChangedMessageCommand=function(self)
                self:sleep(0.075);
                self:diffuse(ColorRandom());
            end;
            OnCommand=function(self) self:queuecommand("CurrentSongChangedMessage"); end;
            LoadActor(THEME:GetPathG("","_Robot_Note")) .. {
                InitCommand=function(self) self:x(-20); self:z(100); self:zoom(0.75); self:rotationz(-90); end;
                StartSelectingStepsMessageCommand=function(self)
                    self:decelerate(0.5);
                    if GAMESTATE:IsCourseMode() then
                        self:x(SCREEN_CENTER_X-90);
                        self:y(SCREEN_CENTER_Y);
                    else
                        self:x(SCREEN_CENTER_X+160+10);
                        self:y(SCREEN_CENTER_Y*0.5);
                        self:rotationz(-90+360);
                    end
                end;
                SongUnchosenMessageCommand=function(self) self:decelerate(0.5); self:x(-130); self:zoom(0.75); self:rotationz(-90); end;
                OnCommand=function(self)
                    self:bounce();
                    self:effectmagnitude(-15,0,0);
                    self:effectclock('beat');
                    self:effectperiod(1);
                end;
                PreviousSongMessageCommand=function(self)
                    self:rotationx(0);
                    self:decelerate(0.2);
                    self:rotationx(-180);
                end;
                NextSongMessageCommand=function(self)
                    self:rotationx(0);
                    self:decelerate(0.2);
                    self:rotationx(180);
                end;
            };
        };
    };]]
    LoadActor(THEME:GetPathG("Arrow","Left"))..{
        InitCommand=function(self) self:x(SCREEN_CENTER_X+20); self:y(SCREEN_CENTER_Y-2); self:zoom(0.5); end;
    };
    LoadActor(THEME:GetPathG("Arrow","right"))..{
        InitCommand=function(self) self:x(SCREEN_CENTER_X+380); self:y(SCREEN_CENTER_Y-2); self:zoom(0.5); end;
    };
};

--Custom Text helper here...
t[#t+1] = Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:diffuse(color("#555555")); self:x(SCREEN_CENTER_X); self:y(SCREEN_BOTTOM); self:zoomx(SCREEN_RIGHT); self:zoomy(60); end;	
	};
	Def.Quad{
		InitCommand=function(self) self:diffuse(GameColor.PlayerColors.PLAYER_1 or {1,0,0,1}); self:x(SCREEN_CENTER_X); self:y(SCREEN_BOTTOM-60/2); self:zoomx(SCREEN_RIGHT); self:zoomy(2.5); end;	
	};
	StandardDecorationFromFileOptional( "SeSongHelp", "NewHelp" );

};



return t;


