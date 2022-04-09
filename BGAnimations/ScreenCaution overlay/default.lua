local t = Def.ActorFrame {};


-- Fade
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) self:Center(); end;	
	Def.Quad {
		InitCommand=function(self) self:scaletoclipped(SCREEN_WIDTH,SCREEN_HEIGHT); end;
		OnCommand=function(self) self:diffuse(Color.Black); self:diffusealpha(0.8); end;
	};
};
-- Emblem
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); end;
	OnCommand=function(self) self:diffusealpha(0.5); end;
	LoadActor("_warning bg") .. {
	};
};

-- Text
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y-120); end;
	OnCommand=function(self) self:diffusealpha(0); self:linear(0.2); self:diffusealpha(1); end;
	LoadFont("Common Large") .. {
		Text=Screen.String("Caution");
		InitCommand=function(self) self:zoom(48/108); end;
		OnCommand=function(self) self:skewx(-0.1); self:diffuse(color("#E6BF7C")); self:diffusebottomedge(color("#FFB682")); self:strokecolor(color("#594420")); end;
	};
	LoadFont("Common Normal") .. {
		Text=Screen.String("CautionText");
		InitCommand=function(self) self:y(128); end;
		OnCommand=function(self) self:strokecolor(color("0,0,0,0.5")); self:shadowlength(1); self:wrapwidthpixels(SCREEN_WIDTH/0.5); end;
	};
};
--
return t
