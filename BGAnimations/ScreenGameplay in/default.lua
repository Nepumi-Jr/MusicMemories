
local t = Def.ActorFrame{
	OnCommand=cmd(draworder,50000;);
}

local CX = SCREEN_CENTER_X;
local CY = SCREEN_CENTER_Y;
local SB = math.random(6,14);

for i = 1, SB+1 do
	t[#t+1] = Def.Quad {
		InitCommand=function(self)
		self:diffuse(color("#000000FF"))
		self:x(CX*2/SB*(i-1));
		self:zoomx(CX*2/SB);
		self:CenterY();
		self:zoomy(CY*2);
	
	end,
	OnCommand=cmd(sleep,math.random(0,70)/70*0.7;draworder,600;accelerate,2;fadetop,2;linear,0.5;diffusealpha,0)
}
end

TP.Eva:initialize()


return t