return Def.ActorFrame {
	LoadActor(THEME:GetPathB("_frame","3x3"),"rounded black",380,120);
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
		Text="If you misstep repeatedly, your dance\ngauge will decrease until the game\nis DEAD";
		InitCommand=function(self) self:y(18); self:wrapwidthpixels(480); self:vertspacing(-12); self:shadowlength(1); end;
		BeginCommand=function(self)
			self:AddAttribute(75, {Length=7, Diffuse=Color.Red});
		end;
		OnCommand=function(self) self:zoom(0.75); end;
	};
	LoadFont("Common Normal") .. {
		Text="TIP:if you first miss\nyou will here 'WOOOPP'";
		InitCommand=function(self) self:y(48); self:wrapwidthpixels(480); self:vertspacing(-12); self:shadowlength(1); end;
		BeginCommand=function(self)
			self:AddAttribute(75, {Length=7, Diffuse=Color.Red});
		end;
		OnCommand=function(self) self:zoom(0.5); end;
	};
};
