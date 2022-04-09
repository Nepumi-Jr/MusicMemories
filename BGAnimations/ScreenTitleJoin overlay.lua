local t = Def.ActorFrame{};

-- todo: add event mode indicators and such
if GAMESTATE:IsEventMode() then
	t[#t+1] = LoadFont("Common Large")..{
		Text=Screen.String("EventMode");
		InitCommand=function(self) self:CenterX(); self:y(SCREEN_BOTTOM-72); self:zoom(0.675); self:diffuse(Color.Yellow); self:strokecolor(ColorDarkTone(Color.Yellow)); self:shadowlength(1); end;
		OnCommand=function(self) self:glowshift(); self:textglowmode('TextGlowMode_Inner'); self:effectperiod(2); end;
	};
end;

return t;