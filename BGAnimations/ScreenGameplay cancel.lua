local ScaleBack = {8,6};
local t = Def.ActorFrame{
	LoadActor(THEME:GetPathS("_Screen","cancel")) .. {
		StartTransitioningCommand=function(self) self:play(); end;
	};
};

for i = 0,ScaleBack[1] do
for j = 0,ScaleBack[2] do
t[#t+1] = Def.Quad{
	InitCommand=function(self)
	self:x((SCREEN_RIGHT/ScaleBack[1])*(i+0.5))
	self:y((SCREEN_BOTTOM/ScaleBack[2])*(j+0.5))
	self:zoomtowidth((SCREEN_RIGHT/ScaleBack[1])*0)
	self:zoomtoheight((SCREEN_BOTTOM/ScaleBack[2])*0)
	self:diffuse(color("#000000FF"))
	end;
	OnCommand=function(self)
	self:sleep((i+j)*0.12*(14/(ScaleBack[1]+ScaleBack[2])))
	self:bounceend(0.3*(14/(ScaleBack[1]+ScaleBack[2])))
	self:zoomtowidth(SCREEN_RIGHT/ScaleBack[1]):zoomtoheight(SCREEN_BOTTOM/ScaleBack[2])
	end;
};
end
end

return t;