local cl = ... or color("#FFC90F")
local t = Def.ActorFrame{
	LoadActor(THEME:GetPathG("_Mini","Arrow")).. {
        BeginCommand=function(self) self:bob(); self:effectmagnitude(-5,0,0); self:effecttiming(0.2,0.6,0.2,0):effectclock("beat"); self:diffuse(cl); self:rotationz(90); end
    };
};

return t;