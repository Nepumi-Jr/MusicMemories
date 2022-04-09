local ShowFlashyCombo = ThemePrefs.Get("FlashyCombo")
return Def.ActorFrame {
	LoadActor("explosion") .. {
		InitCommand=function(self) self:diffusealpha(0); self:blend('BlendMode_Add'); self:hide_if(not ShowFlashyCombo); end;
		MilestoneCommand=function(self) self:rotationz(0); self:zoom(2); self:diffusealpha(0.5); self:linear(0.5); self:rotationz(90); self:zoom(1.75); self:diffusealpha(0); end;
	};
	LoadActor("explosion") .. {
		InitCommand=function(self) self:diffusealpha(0); self:blend('BlendMode_Add'); self:hide_if(not ShowFlashyCombo); end;
		MilestoneCommand=function(self) self:rotationz(0); self:zoom(2); self:diffusealpha(0.5); self:linear(0.5); self:rotationz(-90); self:zoom(2.5); self:diffusealpha(0); end;
	};
	LoadActor("arrowsplode") .. {
		InitCommand=function(self) self:diffusealpha(0); self:blend('BlendMode_Add'); self:hide_if(not ShowFlashyCombo); end;
		MilestoneCommand=function(self) self:rotationz(10); self:zoom(.25); self:diffusealpha(1); self:decelerate(0.6); self:rotationz(0); self:zoom(1.3); self:diffusealpha(0); end;
	};
	LoadActor("minisplode") .. {
		InitCommand=function(self) self:diffusealpha(0); self:blend('BlendMode_Add'); self:hide_if(not ShowFlashyCombo); end;
		MilestoneCommand=function(self) self:rotationz(10); self:zoom(.25); self:diffusealpha(1); self:linear(0.4); self:rotationz(0); self:zoom(1.8); self:diffusealpha(0); end;
	};
};