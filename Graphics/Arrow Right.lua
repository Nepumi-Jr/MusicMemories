local cl = ... or color("#FFC90F")
local t = Def.ActorFrame{
	LoadActor(THEME:GetPathG("_Mini","Arrow")).. {
        BeginCommand=function(self) self:bob(); self:effectmagnitude(5,0,0); self:diffuse(cl); self:rotationz(270); end
    };
};

return t;