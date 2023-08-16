local segmentColor = Color.Orange;
return Def.ActorFrame{
    Def.Quad{
        InitCommand=function(self) self:zoomto(70,1):y(-26-10):vertalign(bottom):fadeleft(0.2):faderight(0.2):diffuse(segmentColor) end;
    };
    Def.Quad{
        InitCommand=function(self) self:zoomto(70,1):y(-26+10):vertalign(top):fadeleft(0.2):faderight(0.2):diffuse(segmentColor) end;
    };
    Def.Quad{
        InitCommand=function(self) self:zoomto(70,20):y(-26):fadeleft(0.2):faderight(0.2):diffuse(color("#333333")) end;
    };
    LoadFont("Common Large")..{
        Text="Delay";
        InitCommand=function(self) self:zoom(0.8*0.2):y(-30) end;
    };
    --load Arrow
    LoadActor(THEME:GetPathG("OutfoxNote/_arrow", ""))..{
        OnCommand=function(self) self:zoom(0.4):y(-10):finishtweening():playcommand("Animate") end;
        SetIconsCommand=function(self,param) self:finishtweening():playcommand("Animate") end;
        ShowCommand=function(self,param) self:finishtweening():playcommand("Animate") end;
        HideCommand=function(self,param) self:finishtweening():playcommand("Animate") end;
        AnimateCommand=function(self) self:finishtweening():y(30):linear(0.3):y(10):sleep(0.5):linear(0.3):y(-10):queuecommand("Animate") end;
    };
    Def.Quad{
        InitCommand=function(self) self:zoomto(20,10):x(58):y(-24):diffuse(segmentColor):fadeleft(0.3):horizalign(right) end;
    };
};