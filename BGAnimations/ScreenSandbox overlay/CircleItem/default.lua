return Def.ActorFrame{
    Def.Quad{
        InitCommand = function(self) self:zoom(64):x(-200) end;
        OnCommand = function(self) self:rainbow():sleep(2000) end;
    };
    LoadActor("./circleItem", Color.Red);
    Def.ActorFrame{
		InitCommand=function(self) self:z(5):effectclock("beat")
            self:bounce():effectmagnitude(0,0,-5):effectperiod(1):effecttiming(0.75,0.25,0,0)
        end;
		Def.Model {
			Meshes="_Dead.txt";
			Materials="_Dead.txt";
			Bones="_Dead.txt";
			InitCommand= function(self) self:x(-1):y(5):zoom(2):effectclock("beat"):thump() end;
		};
	};
}