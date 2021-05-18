local t = Def.ActorFrame{

    Def.Quad{
        InitCommand=cmd(FullScreen;diffuse,{0,0,0,1});
    };

    LoadActor("dance.lua")..{
        InitCommand=cmd(Center);
        OnCommand=cmd(wag);
    };


};

return t;