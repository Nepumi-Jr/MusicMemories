return Def.ActorFrame{
    Def.ActorFrame{
        OnCommand=function(self) self:pulse():effectmagnitude(1,1.1,0):effecttiming(0,0,1/2,7/2):effectclock('beat') end;
        Def.ActorFrame{
            OnCommand=function(self) self:wag():effectclock("beat"):effectmagnitude(0,0,7):effectoffset(0.1) end;
            LoadActor(THEME:GetPathG("OutfoxNote/_arrow", ""));
        };
        LoadFont("Combo Number")..{
            Text="2";
            OnCommand=function(self) self:zoom(0.5):y(10):diffuse(Color.White) end;
        };
    };
    
};