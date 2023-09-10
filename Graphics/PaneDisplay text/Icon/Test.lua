return Def.ActorFrame{
    LoadActor(THEME:GetPathG("OutfoxNote/_arrow", ""));
    LoadFont("Combo Number")..{
        Text="3";
        OnCommand=function(self) self:zoom(0.4):x(-7):y(10):diffuse(Color.Black) end;
    };
    LoadFont("Combo Number")..{
        Text="+";
        OnCommand=function(self) self:zoom(0.4):x(9):y(10):diffuse(Color.Black) end;
    };
};