return Def.BitmapText{
	Font="Common Normal",
	InitCommand= function(self) self:x(SCREEN_CENTER_X); self:zoom(.75, 0); self:diffuse(color("#808080")); end,
	OnCommand= function(self)
		self:diffusealpha(0)
		self:decelerate(0.5)
		self:diffusealpha(1)
		-- fancy effect:  Look at the name (which is set by the screen) to set text
		self:settext(
			THEME:GetString("ScreenMapControllers", "Action" .. self:GetName()))
	end,
	OffCommand=function(self) self:stoptweening(); self:accelerate(0.3); self:diffusealpha(0); self:queuecommand("Hide"); end,
	HideCommand=function(self) self:visible(false); end,
	GainFocusCommand=function(self) self:diffuseshift(); self:effectcolor2(color("#808080")); self:effectcolor1(color("#FFFFFF")); end,
	LoseFocusCommand=function(self) self:stopeffect(); end,
}
