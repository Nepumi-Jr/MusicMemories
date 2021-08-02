local Nep = 0;
local t = Def.ActorFrame{
    --[[Def.ActorFrame{
        InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
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
            OnCommand=cmd(queuecommand,"CurrentSongChangedMessage");
            LoadActor(THEME:GetPathG("","_Robot_Note")) .. {
                InitCommand=cmd(x,-20;z,100;zoom,0.75;rotationz,-90);
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
                SongUnchosenMessageCommand=cmd(decelerate,0.5;x,-130;zoom,0.75;rotationz,-90);
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
        InitCommand=cmd(x,SCREEN_CENTER_X+20;y,SCREEN_CENTER_Y-2;zoom,0.5);
    };
    LoadActor(THEME:GetPathG("Arrow","right"))..{
        InitCommand=cmd(x,SCREEN_CENTER_X+380;y,SCREEN_CENTER_Y-2;zoom,0.5);
    };
};

--Custom Text helper here...
t[#t+1] = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(diffuse,color("#555555");x,SCREEN_CENTER_X;y,SCREEN_BOTTOM;zoomx,SCREEN_RIGHT;zoomy,60);	
	};
	Def.Quad{
		InitCommand=cmd(diffuse,GameColor.PlayerColors.PLAYER_1 or {1,0,0,1};x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-60/2;zoomx,SCREEN_RIGHT;zoomy,2.5);	
	};
	StandardDecorationFromFileOptional( "SeSongHelp", "NewHelp" );

};



return t;


