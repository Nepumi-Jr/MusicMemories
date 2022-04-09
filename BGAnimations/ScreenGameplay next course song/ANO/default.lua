local t = Def.ActorFrame{};
t[#t+1] = Def.ActorFrame{
	FOV = (0);
	StartCommand=function(self) self:Center(); self:queuecommand("INTA"); end;
	INTACommand=function(self)
		self:decelerate(0.5)
		self:rotationx(75):rotationy(35):zoom(2.2)
		self:linear(3)
		self:rotationx(80):rotationy(45):zoom(2.7)
	end;
	Def.ActorFrame{
		StartCommand=function(self) self:queuecommand("INTB"); end;
	INTBCommand=function(self)
		self:x(80):y(0)
		self:linear(3)
		self:x(100):y(0)
	end;
	LoadActor("3DStuff")..{
		StartCommand=function(self) self:queuecommand("INTC"); end;
		INTCCommand=function(self)
		self:z(20)
		self:linear(3)
		self:z(10)
	end;
	};
	};
	};

t[#t+1] = Def.Quad{
StartCommand=function(self) self:zoom(99999); self:diffuse(color("#000000FF")); self:linear(1); self:diffusealpha(0); end;
};
return t;