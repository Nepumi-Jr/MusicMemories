return Def.ActorFrame {
 	LoadFont("Common Normal") .. {
		Name="TextTitle";
		InitCommand=function(self) self:y(-16.5); self:zoom(0.875); self:maxwidth(256/0.875); end;
		OnCommand=function(self) self:shadowlength(1); end;
-- 		TickCommand=function(self) self:finishtweening(); self:diffusealpha(0); self:addx(-10); self:zoomx(1.25); self:zoomy(0); self:decelerate(0.25); self:diffusealpha(1); self:addx(10); self:zoom(1); self:sleep(0); self:glow(Color("White")); self:decelerate(0.275); self:glow(Color("Invisible")); end;
	};
 	LoadFont("Common Normal") .. {
		Name="TextSubtitle";
		InitCommand=function(self) self:zoom(0.5); self:maxwidth(256/0.5); end;
		OnCommand=function(self) self:shadowlength(1); end;
-- 		TickCommand=function(self) self:finishtweening(); self:diffusealpha(0); self:addy(-10); self:addx(10); self:decelerate(0.25); self:diffusealpha(1); self:addy(10); self:addx(-10); end;
	};
	LoadFont("Common Normal") .. {
		Name="TextArtist";
		InitCommand=function(self) self:y(18); self:zoom(0.75); self:maxwidth(256/0.75); end;
		OnCommand=function(self) self:shadowlength(1); self:skewx(-0.2); end;
-- 		TickCommand=function(self) self:finishtweening(); self:diffusealpha(0); self:addy(10); self:addx(10); self:decelerate(0.25); self:diffusealpha(1); self:addy(-10); self:addx(-10); end;
	};
};