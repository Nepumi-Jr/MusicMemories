local t = Def.ActorFrame{

    Def.ActorFrame{
        InitCommand=function(self) self:Center(); end;
        LoadActor("50352933_p0-512.png")..{
            InitCommand=function(self) self:polygonmode("PolygonMode_Line"); end;
        };
    };

};

return t;