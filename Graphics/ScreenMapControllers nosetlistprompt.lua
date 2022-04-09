return Def.ActorFrame{
	InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); end,
	Def.Quad{
		InitCommand=function(self) self:zoomto(SCREEN_WIDTH,SCREEN_HEIGHT); self:diffuse(Color.Black); self:diffusealpha(0); end,
		TweenOnCommand=function(self) self:stoptweening(); self:diffusealpha(1); self:linear(0.5); self:diffusealpha(0.8); end,
		TweenOffCommand=function(self) self:stoptweening(); self:linear(0.5); self:diffusealpha(0); end,
	},
	Def.ActorFrame{
		Def.BitmapText{
			Font="Common Normal",
			Text=ScreenString("NoSetListPrompt"),
			InitCommand=function(self) self:y(10); self:wrapwidthpixels(SCREEN_WIDTH-48); self:diffusealpha(0); end,
			TweenOnCommand=function(self) self:stoptweening(); self:diffusealpha(0); self:sleep(0.5125); self:linear(0.125); self:diffusealpha(1); end,
			TweenOffCommand=function(self) self:stoptweening(); self:linear(0.5); self:diffusealpha(0); end,
		},
	},
}
