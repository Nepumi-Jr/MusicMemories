return Def.ActorFrame{
    Def.ActorFrame{
        InitCommand=function(self) self:xy(-272/2,-96/2) end;
        Def.Quad{
            InitCommand=function(self) self:diffuse(color("#333333")):horizalign(left):vertalign(top) end;
            OnCommand=function(self) self:xy(5,5):zoomto(262,4) end;
        };
        Def.Quad{
            InitCommand=function(self) self:diffuse(color("#333333")):horizalign(left):vertalign(top) end;
            OnCommand=function(self) self:xy(5,87):zoomto(262,4) end;
        };
        Def.Quad{
            InitCommand=function(self) self:diffuse(color("#333333")):horizalign(left):vertalign(top) end;
            OnCommand=function(self) self:xy(5,5):zoomto(4,86) end;
        };
        Def.Quad{
            InitCommand=function(self) self:diffuse(color("#333333")):horizalign(left):vertalign(top) end;
            OnCommand=function(self) self:xy(263,5):zoomto(4,86) end;
        };
    };
};