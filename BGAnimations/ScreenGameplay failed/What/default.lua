local t = Def.ActorFrame{

    StartTransitioningCommand=function(self)
        local Factor= 0.6
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

    

};

return t;