local t = Def.ActorFrame{

    Def.Quad{
        InitCommand=cmd(FullScreen;diffuse,color("#70421400");blend,'BlendMode_WeightedMultiply');
        OnCommand=cmd(diffusealpha,1);
    };

    Def.Sprite{
        InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-100;animate,false;zoom,1.3;diffuse,color("#70421400");Load,THEME:GetCurrentThemeDirectory().."Graphics/GraphFont/BigCount/FAIL.png");
        OnCommand=cmd(decelerate,0.2;diffusealpha,1;y,SCREEN_CENTER_Y-50;zoom,0.85);
    };
    LoadActor("YES.png")..{
        InitCommand=cmd(x,SCREEN_RIGHT+100;y,SCREEN_BOTTOM*0.85;zoom,0.3);
        OnCommand=cmd(linear,0.2;x,150);
    };

    LoadActor("ROUND.mp3")..{
        StartTransitioningCommand=cmd(play);
    };
};





return t;