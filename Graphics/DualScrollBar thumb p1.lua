return Def.ActorFrame{
    LoadActor(THEME:GetPathG("DualScrollBar thumb","all")).. {
        InitCommand=cmd(diffuse,PlayerColor(PLAYER_1);x,-5);
    };
    LoadActor(THEME:GetPathG("Arrow","Up")).. {
        InitCommand=cmd(y,-30;zoom,0.3);
    };
    LoadActor(THEME:GetPathG("Arrow","Down")).. {
        InitCommand=cmd(y,30;zoom,0.3);
    };
};