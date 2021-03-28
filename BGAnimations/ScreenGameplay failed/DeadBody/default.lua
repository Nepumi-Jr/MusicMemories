local Sppped = 1/60
local t = Def.ActorFrame{
    LoadActor("Dead.mp3")..{
        StartTransitioningCommand=cmd(play);
    };
    LoadActor("DeadBody")..{
        InitCommand=cmd(FullScreen;y,SCREEN_CENTER_Y-50;pause;visible,false;setstate,0);
        OnCommand=cmd(visible,true;pause;setstate,0;sleep,Sppped;queuecommand,"F1");
        F1Command=cmd(setstate,1;sleep,Sppped;queuecommand,"F2");
        F2Command=cmd(setstate,2;sleep,Sppped;queuecommand,"F3");
        F3Command=cmd(setstate,3;sleep,Sppped;queuecommand,"F4");
        F4Command=cmd(setstate,4;sleep,Sppped;queuecommand,"F5");
        F5Command=cmd(setstate,5;sleep,Sppped;queuecommand,"F6");
        F6Command=cmd(setstate,6;);
    };
};

return t;