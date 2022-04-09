local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
  InitCommand=function(self) self:Center(); end;
	Def.Quad {
		InitCommand=function(self) self:diffuse({0,0,0,1}); self:scaletoclipped(SCREEN_WIDTH,SCREEN_HEIGHT); end;
		OnCommand=function(self) self:linear(0.5); self:diffuse({1,1,1,1}); self:sleep(13.15); end;
	};
};
t[#t+1] = Def.ActorFrame {
  InitCommand=function(self) self:Center(); end;
	Def.ActorFrame {
		LoadActor("_arrow") .. {
			InitCommand=function(self) self:diffusealpha(0); self:y(-50); end;
			OnCommand=function(self) self:x(-200); self:sleep(0.75); self:decelerate(0.5); self:diffusealpha(1); self:addx(150); self:linear(2); self:addx(150); self:accelerate(0.5); self:diffusealpha(0); self:addx(150); end;
		};
		LoadFont("Common normal") .. {
			Text = ProductID();
			InitCommand=function(self) self:diffuse({0,0,0,0}); self:y(75); self:zoom(2.5); end;
			OnCommand=function(self) self:x(200); self:sleep(0.75); self:decelerate(0.5); self:diffusealpha(1); self:addx(-150); self:linear(2); self:addx(-150); self:accelerate(0.5); self:diffusealpha(0); self:addx(-150); end;
		};
		LoadActor("ssc") .. {
			InitCommand=function(self) self:diffusealpha(0); self:x(0); self:y(-85); end;
			OnCommand=function(self) self:x(-200); self:sleep(0.75+3.2); self:decelerate(0.5); self:diffusealpha(1); self:addx(150); self:linear(2); self:addx(150); self:accelerate(0.5); self:diffusealpha(0); self:addx(150); end;
		};
		LoadFont("Common normal") .. {
			Text = "Nepumi";
			InitCommand=function(self) self:diffuse({0,0,0,0}); self:y(0); self:zoom(2.5); end;
			OnCommand=function(self) self:x(200); self:sleep(0.75+3.2); self:decelerate(0.5); self:diffusealpha(1); self:addx(-150); self:linear(2); self:addx(-150); self:accelerate(0.5); self:diffusealpha(0); self:addx(-150); end;
		};
		LoadFont("Common normal") .. {
			Text = "TEAMRIZU";
			InitCommand=function(self) self:diffuse({0,0,0,0}); self:x(0); self:y(85); self:zoom(2.5); end;
			OnCommand=function(self) self:x(-200); self:sleep(0.75+3.2); self:decelerate(0.5); self:diffusealpha(1); self:addx(150); self:linear(2); self:addx(150); self:accelerate(0.5); self:diffusealpha(0); self:addx(150); end;
		};
		LoadFont("Common Normal") .. {
			Text=THEME:GetThemeDisplayName();
			InitCommand=function(self) self:diffuse({0,0,0,0}); self:y(100); self:zoom(1.5); end;
			OnCommand=function(self) self:y(100); self:sleep(0.75+3.2*2); self:decelerate(0.5); self:diffusealpha(1); self:addy(-100); self:linear(5); self:addy(-50); self:accelerate(0.5); self:diffusealpha(0); self:addy(-100); end;
		};
	};

};

return t
