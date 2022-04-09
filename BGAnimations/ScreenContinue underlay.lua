local timer_seconds = THEME:GetMetric(Var "LoadingScreen","TimerSeconds");
local t = Def.ActorFrame {};

-- Fade
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) self:Center(); end;	
	Def.Quad {
		InitCommand=function(self) self:scaletoclipped(SCREEN_WIDTH,SCREEN_HEIGHT); end;
		OnCommand=function(self) self:diffuse(Color.Black); self:diffusealpha(0); self:linear(0.5); self:diffusealpha(0.25); self:sleep(timer_seconds/2); self:linear(timer_seconds/2-0.5); self:diffusealpha(1); end;
	};
	-- Warning Fade
	Def.Quad {
		InitCommand=function(self) self:y(16); self:scaletoclipped(SCREEN_WIDTH,148); end;
		OnCommand=function(self) self:diffuse(Color.Black); self:diffusealpha(0.5); self:linear(timer_seconds); self:zoomtoheight(148*0.75); end;
	}
};
--
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) self:Center(); self:y(SCREEN_CENTER_Y-24); end;
	-- Underline
	Def.Quad {
		InitCommand=function(self) self:y(16); self:zoomto(256,1); end;
		OnCommand=function(self) self:diffuse(color("#ffd400")); self:shadowlength(1); self:shadowcolor(BoostColor(color("#ffd40077"),0.25)); self:linear(0.25); self:zoomtowidth(256); self:fadeleft(0.25); self:faderight(0.25); end;
	};
	LoadFont("Common Bold") .. {
		Text="Continue?";
		OnCommand=function(self) self:skewx(-0.125); self:diffuse(color("#ffd400")); self:shadowlength(2); self:shadowcolor(BoostColor(color("#ffd40077"),0.25)); end;
	};
};
--
return t
