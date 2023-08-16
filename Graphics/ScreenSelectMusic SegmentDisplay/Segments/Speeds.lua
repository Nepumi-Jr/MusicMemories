local segmentColor = Color.Green;
return Def.ActorFrame{
    Def.Quad{
        InitCommand=function(self) self:zoomto(80,1):y(-26-10):vertalign(bottom):fadeleft(0.2):faderight(0.2):diffuse(segmentColor) end;
    };
    Def.Quad{
        InitCommand=function(self) self:zoomto(80,1):y(-26+10):vertalign(top):fadeleft(0.2):faderight(0.2):diffuse(segmentColor) end;
    };
    Def.Quad{
        InitCommand=function(self) self:zoomto(80,20):y(-26):fadeleft(0.2):faderight(0.2):diffuse(color("#333333")) end;
    };
    LoadFont("Common Large")..{
        Text="Speed";
        InitCommand=function(self) self:zoom(0.8*0.2):y(-30) end;
    };
    --load Arrow
    LoadActor(THEME:GetPathG("OutfoxNote/_arrow", ""))..{
        OnCommand=function(self) self:zoom(0.4):y(0):bob():effectmagnitude(0,10,0) :finishtweening():playcommand("Animate") end;
    };
    LoadActor(THEME:GetPathG("OutfoxNote/_arrow", ""))..{
        OnCommand=function(self) self:zoom(0.4):y(20):bob():effectmagnitude(0,20,0):finishtweening():playcommand("Animate") end;
    };
    Def.Quad{
        InitCommand=function(self) self:zoomto(20,10):x(58):y(12):diffuse(segmentColor):fadeleft(0.3):horizalign(right) end;
    };
};