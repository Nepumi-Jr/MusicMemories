local t = Def.ActorFrame{

    Def.Quad{
        InitCommand=function(self) self:FullScreen(); self:diffuse(color("#70421400")); self:blend('BlendMode_WeightedMultiply'); end;
        OnCommand=function(self) self:diffusealpha(1); end;
    };

    Def.Sprite{
        InitCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y-100); self:animate(false); self:zoom(1.3); self:diffuse(color("#70421400")); self:Load(THEME:GetCurrentThemeDirectory().."Graphics/_GraphFont/BigCount/FAIL.png"); end;
        OnCommand=function(self) self:decelerate(0.2); self:diffusealpha(1); self:y(SCREEN_CENTER_Y-50); self:zoom(0.85); end;
    };
    LoadActor("YES.png")..{
        InitCommand=function(self) self:x(SCREEN_RIGHT+100); self:y(SCREEN_BOTTOM*0.85); self:zoom(0.3); end;
        OnCommand=function(self) self:linear(0.2); self:x(150); end;
    };

    LoadActor("ROUND.mp3")..{
        StartTransitioningCommand=function(self) self:play(); end;
    };
};





return t;