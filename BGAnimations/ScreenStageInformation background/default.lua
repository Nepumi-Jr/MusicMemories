local t = Def.ActorFrame{};
local CAMPOS = {{{0,0,10,75,-10,1.1},{0,0,30,80,0,2.6}},
				{{0,0,20,20,0,1},{0,0,150,50,0,2.9}},
				{{-300,0,210,35,35,1.7},{0,0,190,45,0,2.7}},
				{{0,0,290,110,0,1},{-10,0,130,55,-5,2.7}},
				{{0,0,0,90,25,1},{0,0,0,90,0,2.7}},
				}
local CAMMOVER = math.random(1,#CAMPOS);
local wera = math.random(25,35)/10+2;
local DLCCon = false;
if GAMESTATE:IsCourseMode() then DLCCon = true end
t[#t+1] = Def.ActorFrame{
	FOV = (0);
	OnCommand=cmd(Center;queuecommand,"INTA");
	INTACommand=function(self)
		self:rotationx(CAMPOS[CAMMOVER][1][4]):rotationy(CAMPOS[CAMMOVER][1][5]):zoom(CAMPOS[CAMMOVER][1][6])
		self:decelerate(wera)
		self:rotationx(CAMPOS[CAMMOVER][2][4]):rotationy(CAMPOS[CAMMOVER][2][5]):zoom(CAMPOS[CAMMOVER][2][6])
		if DLCCon then
		self:sleep(0.01)
		self:decelerate(0.5)
		self:rotationx(75):rotationy(35):zoom(2.2)
		self:linear(3)
		self:rotationx(80):rotationy(45):zoom(2.7)
		end
	end;
	Def.ActorFrame{
		OnCommand=cmd(queuecommand,"INTB");
	INTBCommand=function(self)
		self:x(CAMPOS[CAMMOVER][1][1]):y(CAMPOS[CAMMOVER][1][2])
		self:decelerate(wera)
		self:x(CAMPOS[CAMMOVER][2][1]):y(CAMPOS[CAMMOVER][2][2])
		if DLCCon then
		self:sleep(0.01)
		self:decelerate(0.5)
		self:x(80):y(0)
		self:linear(3)
		self:x(100):y(0)
		end
	end;
	LoadActor("3DStuff")..{
		OnCommand=cmd(queuecommand,"INTC");
		INTCCommand=function(self)
		self:z(CAMPOS[CAMMOVER][1][3])
		self:decelerate(wera)
		self:z(CAMPOS[CAMMOVER][2][3])
		if DLCCon then
		self:sleep(0.01)
		self:decelerate(0.5)
		self:z(20)
		self:linear(3)
		self:z(10)
		end
	end;
	};
	};
	};

t[#t+1] = Def.Quad{
OnCommand=cmd(zoom,99999;diffuse,color("#000000FF");linear,1;diffusealpha,0);
};
return t;