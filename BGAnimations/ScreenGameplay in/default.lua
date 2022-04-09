
local t = Def.ActorFrame{
	OnCommand=function(self) self:draworder(50000); end;
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
	OnCommand=function(self) self:sleep(math.random(0,70)/70*0.7); self:draworder(600); self:accelerate(2); self:fadetop(2); self:linear(0.5); self:diffusealpha(0); end
}
end

TP.Eva:initialize()


return t