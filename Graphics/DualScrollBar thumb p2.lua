return Def.ActorFrame{
    LoadActor(THEME:GetPathG("DualScrollBar thumb","all")).. {
        InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_2)); self:x(5); end;
    };
    LoadActor(THEME:GetPathG("Arrow","Up")).. {
        InitCommand=function(self) self:y(-30); self:zoom(0.3); end;
    };
    LoadActor(THEME:GetPathG("Arrow","Down")).. {
        InitCommand=function(self) self:y(30); self:zoom(0.3); end;
    };
};