local cl = ... or color("#FFC90F")
local t = Def.ActorFrame{
	LoadActor(THEME:GetPathG("_Mini","Arrow")).. {
        BeginCommand=function(self) self:bob(); self:effectmagnitude(0,5,0); self:diffuse(cl); end
    };
};

return t;