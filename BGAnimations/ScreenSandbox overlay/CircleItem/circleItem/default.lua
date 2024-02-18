local thisColor = ... or color("#FF0000")


local t = Def.ActorFrame{
    InitCommand = function(self) self:zoom(1/4 * 1.2) end;
    LoadActor("Color.png")..{
        InitCommand = function(self) self:diffuse(thisColor) end;
    };
    LoadActor("BodyFlash.png")..{
        OnCommand = function(self) 
            self:diffuseshift()
            self:effectcolor1({1,1,1,0.7})
            self:effectcolor2({1,1,1,0.2})
            self:effectclock("beat")
        end;
    };
    LoadActor("Overlay.png");

}
return t;
