return Def.ActorFrame {
	LoadActor(THEME:GetPathB("_frame","3x3"),"rounded black",380,80);
	Def.Quad {
		Name="Underline";
		InitCommand=function(self) self:y(-12); end;
		OnCommand=function(self) self:diffuse(color("#ffd400")); self:shadowlength(1); self:zoomtowidth(192); self:fadeleft(0.25); self:faderight(0.25); end;
	};
	LoadFont("Common Bold") .. {
		Text=ScreenString("Information");
		InitCommand=function(self) self:y(-26); end;
		OnCommand=function(self) self:skewx(-0.125); self:diffuse(color("#ffd400")); self:shadowlength(2); self:shadowcolor(BoostColor(color("#ffd40077"),0.25)); end
	};
	LoadFont("Common Normal") .. {
		Text="When the arrows rise to this point,\nstep on the matching panels.\nand hold them";
		InitCommand=function(self) self:y(18); self:wrapwidthpixels(480); self:vertspacing(-12); self:shadowlength(1); end;
		OnCommand=function(self) self:zoom(0.75); end;
	};
};
