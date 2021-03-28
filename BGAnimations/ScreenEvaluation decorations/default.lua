local t = LoadFallbackB();

t[#t+1] = Def.Quad{
    OnCommand=cmd(FullScreen;diffuse,{0,0,0,0.4};fadetop,0.2;fadebottom,0.12);
};
t[#t+1] = Def.Quad{
    InitCommand=cmd(visible,false);
    OnCommand=function()
        MESSAGEMAN:Broadcast("SystemRePoss",{state = "AfterGame"})
    end;
};
t[#t+1] = LoadActor("Neww");
t[#t+1] = LoadActor("DLC");
--t[#t+1] = LoadActor("EPICIsla");
t[#t+1] = LoadActor("Heart");
t[#t+1] = LoadActor("Intro.lua");

return t;