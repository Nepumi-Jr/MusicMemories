local pos = {0,30,250,40,0,1.3}
return Def.ActorFrame{
    --BG
    Def.ActorFrame{
        FOV = (0);
        OnCommand=function(self)
            self:Center():rotationx(pos[4]):rotationy(pos[5]):zoom(pos[6]):wag():effectmagnitude(0,4,0):effectperiod(30)
        end;
        LoadActor(THEME:GetPathG("","3DTable"))..{
            OnCommand=function(self)
                self:xy(pos[1],pos[2]):z(pos[3])
            end;
        };
    };
	
};