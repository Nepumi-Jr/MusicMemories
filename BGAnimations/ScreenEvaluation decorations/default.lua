local t = LoadFallbackB();

t[#t+1] = Def.Quad{
    OnCommand=function(self) self:FullScreen(); self:diffuse({0,0,0,0.4}); self:fadetop(0.2); self:fadebottom(0.12); end;
};
t[#t+1] = Def.Quad{
    InitCommand=function(self) self:visible(false); end;
    OnCommand=function()
        MESSAGEMAN:Broadcast("SystemRePoss",{state = "AfterGame"})
    end;
};
t[#t+1] = LoadActor("Neww");
t[#t+1] = LoadActor("DLC");

return t;