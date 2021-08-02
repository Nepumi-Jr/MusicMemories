
return Def.ActorFrame {
	Def.Quad {
		InitCommand=function(self)
			self:vertalign(bottom):zoomto(SCREEN_WIDTH,100):y(SCREEN_CENTER_Y-30)
            --self:fadetop(0.5)
            self:diffuse({0,0,0,0.8})
            self:fadetop(0.47)
		end;
	};
}