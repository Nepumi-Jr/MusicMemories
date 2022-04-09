local t = Def.ActorFrame {};

t[#t+1] = Def.Quad {
	InitCommand=function(self) self:vertalign(bottom); self:zoomto(SCREEN_WIDTH,34); self:diffuse(color("#161616")); end;
};

t[#t+1] = LoadActor(THEME:GetPathG("ScreenWithMenuElements","header/Header")) .. {
	InitCommand=function(self) self:y(-48); self:vertalign(bottom); self:zoomtowidth(SCREEN_WIDTH); end;
	OnCommand=function(self) self:zoomy(-1); self:diffuse(color("#ffd400")); end;
};

return t;
