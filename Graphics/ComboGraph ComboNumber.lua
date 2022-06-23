return LoadFont("Common Normal")..{
	InitCommand=function(self)
		self:zoom(0.5):diffuse(Color.Black)
	end;
};