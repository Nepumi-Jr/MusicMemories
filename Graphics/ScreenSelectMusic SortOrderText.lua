return Def.ActorFrame{
    Def.Quad{
        Name="BG";
        InitCommand=function(self)
            self:horizalign(left):zoomto(50,40):diffuse(color("#333333")):faderight(0.2)
        end;
    };
    --sort icon
    LoadActor(THEME:GetPathG("_icon","Sort"))..{
        Name="Icon";
        InitCommand=function(self)
            self:horizalign(left):zoomto(20,20):xy(5,-1)
        end;
    };
    LoadFont("Common Normal") .. {
        Text="test";
        Name="DisplayText";
        InitCommand=function(self)
            self:horizalign(left):xy(30,3)
        end;
    };
};