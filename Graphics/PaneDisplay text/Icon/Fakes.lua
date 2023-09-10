return Def.ActorFrame{
    Def.ActorFrame{
        OnCommand=function(self) self:pulse():effectmagnitude(1,1.1,0):effecttiming(0,0,1/2,7/2):effectclock('beat') end;
        Def.ActorFrame{
            OnCommand=function(self) self:wag():effectclock("beat"):effectmagnitude(0,0,7):effectoffset(0.25) end;
            LoadActor(THEME:GetPathG("OutfoxNote/_fake", ""));
        };
    };
};