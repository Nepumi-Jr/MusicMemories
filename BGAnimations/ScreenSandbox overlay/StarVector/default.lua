local t = Def.ActorFrame{

    Def.Quad{
        InitCommand=function(self) self:FullScreen(); self:diffuse({0,0,0,1}); end;
    };

    LoadActor("dance.lua")..{
        InitCommand=function(self) self:Center(); end;
        OnCommand=function(self) self:wag(); end;
    };


};

return t;