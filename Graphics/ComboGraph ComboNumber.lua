return LoadFont("Common Bold") .. {
	InitCommand=function(self) self:zoom(12/54); self:y(-1); self:shadowlength(1); self:strokecolor(Color.Outline); end;
};
