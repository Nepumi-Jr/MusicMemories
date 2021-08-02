local cl = ... or color("#FFC90F")
local t = Def.ActorFrame{
	LoadActor(THEME:GetPathG("_Mini","Arrow")).. {
        BeginCommand=cmd(bob;effectmagnitude,0,5,0;diffuse,cl)
    };
};

return t;