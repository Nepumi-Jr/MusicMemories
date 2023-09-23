local Factor= 0.6
local t = Def.ActorFrame{

    StartTransitioningCommand=function(self)
        SCREENMAN:GetTopScreen():zoom(Factor):x((1-Factor)*SCREEN_CENTER_X):y((1-Factor)*SCREEN_CENTER_Y-50)
    end;

    Def.Quad{
        OnCommand=function(self) self:CenterX(); self:zoomx(SCREEN_RIGHT); self:y(SCREEN_BOTTOM-100); self:zoomy(200); self:diffuse({0,0,0,1}); self:fadetop(1); end;
    };
    LoadActor("WHAT.png")..{
        OnCommand=function(self) self:Center(); self:y(SCREEN_CENTER_Y+185); self:zoom(1); end;
    };
    LoadActor("Whatttt.mp3")..{
        StartTransitioningCommand=function(self) self:play(); end;
    };
    LoadActor("UJustFail.png")..{
        OnCommand=function(self) self:Center(); self:y(SCREEN_CENTER_Y+400); self:zoom(Factor):diffusealpha(0) end;
        StartTransitioningCommand=function(self) self:sleep(4.4):diffusealpha(1) end;
    };
    Def.Quad{
        InitCommand=function(self) self:FullScreen(); self:y(SCREEN_CENTER_Y+90):zoomto(SCREEN_WIDTH/Factor, SCREEN_HEIGHT/Factor) self:diffuse(color("#441122")):croptop(1):fadetop(0.5) end;
        StartTransitioningCommand=function(self) self:sleep(8.8):decelerate(0.5):croptop(0):fadetop(0) end;
    };

    

};

return t;