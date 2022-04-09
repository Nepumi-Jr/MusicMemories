return LoadFont("Common Normal") .. {
	Text=ScreenString("Exit");
	InitCommand=function(self) self:x(SCREEN_CENTER_X); self:zoom(0.75); self:shadowlength(0); self:diffuse(color("#880000")); self:NoStroke(); end;
	OnCommand=function(self) self:diffusealpha(0); self:decelerate(0.5); self:diffusealpha(1); end;
	OffCommand=function(self) self:stoptweening(); self:accelerate(0.3); self:diffusealpha(0); self:queuecommand("Hide"); end;
	HideCommand=function(self) self:visible(false); end;

	GainFocusCommand=function(self) self:diffuseshift(); self:effectcolor1(color("#FF2222")); self:effectcolor2(color("#880000")); end;
	LoseFocusCommand=function(self) self:stopeffect(); end;
};
