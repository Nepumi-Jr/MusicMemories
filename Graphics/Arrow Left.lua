local cl = ... or color("#FFC90F")
local t = Def.ActorFrame{
	LoadActor(THEME:GetPathG("_Mini","Arrow")).. {
        BeginCommand=cmd(bob;effectmagnitude,-5,0,0;diffuse,cl;rotationz,90)
    };
};

return t;