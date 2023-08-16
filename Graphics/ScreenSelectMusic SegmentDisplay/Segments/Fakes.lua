local segmentColor = Color.Pink;
return Def.ActorFrame{
    Def.Quad{
        InitCommand=function(self) self:zoomto(60,1):y(-26-10):vertalign(bottom):fadeleft(0.2):faderight(0.2):diffuse(segmentColor) end;
    };
    Def.Quad{
        InitCommand=function(self) self:zoomto(60,1):y(-26+10):vertalign(top):fadeleft(0.2):faderight(0.2):diffuse(segmentColor) end;
    };
    Def.Quad{
        InitCommand=function(self) self:zoomto(60,20):y(-26):fadeleft(0.2):faderight(0.2):diffuse(color("#333333")) end;
    };
    LoadFont("Common Large")..{
        Text="Fake";
        InitCommand=function(self) self:zoom(0.8*0.2):y(-30) end;
    };
    --load Arrow
    LoadActor(THEME:GetPathG("OutfoxNote/_arrow", ""))..{
        OnCommand=function(self) self:zoom(0.4):y(0):rainbow() end;
    };
    Def.Quad{
        InitCommand=function(self) self:zoomto(20,10):x(58):y(-12):diffuse(segmentColor):fadeleft(0.3):horizalign(right) end;
    };
};