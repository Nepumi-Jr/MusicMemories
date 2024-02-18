return Def.ActorFrame{
    LoadActor("_arrow.png").. {
        InitCommand=function(self) self:zoom(0.15):y(15) end;
        OnCommand=function(self) self:bob(); self:effectmagnitude(0,2,0); self:effecttiming(0.2,0.6,0.2,0):effectclock("beat");  end
    };
};
