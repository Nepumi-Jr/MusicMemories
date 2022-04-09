return Def.ActorFrame {
	Def.ActorFrame {
		OnCommand=function(self) self:x(SCREEN_CENTER_X-20); end;

		-- Initial glow around receptors
		LoadActor("tapglow") .. {
			OnCommand=function(self) self:x(85); self:y(95); self:zoom(0.7); self:rotationz(90); self:diffuseshift(); self:effectcolor1(1,0.93333,0.266666,0.4); self:effectcolor2(1,1,1,1); self:effectperiod(0.25); self:effectmagnitude(0,1,0); self:diffusealpha(0); self:sleep(3); self:linear(0); self:diffusealpha(1); self:sleep(1); self:linear(0); self:diffusealpha(0); end;
		};
		LoadActor("tapglow") .. {
			OnCommand=function(self) self:x(275); self:y(95); self:zoom(0.7); self:rotationz(270); self:diffuseshift(); self:effectcolor1(1,0.93333,0.266666,0.4); self:effectcolor2(1,1,1,1); self:effectperiod(0.25); self:effectmagnitude(0,1,0); self:diffusealpha(0); self:sleep(3); self:linear(0); self:diffusealpha(1); self:sleep(1); self:linear(0); self:diffusealpha(0); end;
		};
		LoadActor("tapglow") .. {
			OnCommand=function(self) self:x(212); self:y(95); self:zoom(0.7); self:rotationz(180); self:diffuseshift(); self:effectcolor1(1,0.93333,0.266666,0.4); self:effectcolor2(1,1,1,1); self:effectperiod(0.25); self:effectmagnitude(0,1,0); self:diffusealpha(0); self:sleep(3); self:linear(0); self:diffusealpha(1); self:sleep(1); self:linear(0); self:diffusealpha(0); end;
		};
		LoadActor("tapglow") .. {
			OnCommand=function(self) self:x(148); self:y(95); self:zoom(0.7); self:diffuseshift(); self:effectcolor1(1,0.93333,0.266666,0.4); self:effectcolor2(1,1,1,1); self:effectperiod(0.25); self:effectmagnitude(0,1,0); self:diffusealpha(0); self:sleep(3); self:linear(0); self:diffusealpha(1); self:sleep(1); self:linear(0); self:diffusealpha(0); end;
		};

		LoadActor("tapglow") .. {
			OnCommand=function(self) self:x(148); self:y(95); self:zoom(0.7); self:diffuseshift(); self:effectcolor1(1,0.93333,0.266666,0.4); self:effectcolor2(1,1,1,1); self:effectperiod(0.25); self:effectmagnitude(0,1,0); self:diffusealpha(0); self:sleep(8); self:linear(0); self:diffusealpha(1); self:sleep(1); self:linear(0); self:diffusealpha(0); end;
		};
		-- 2nd step UP
		LoadActor("tapglow") .. {
			OnCommand=function(self) self:x(85); self:y(95); self:zoom(0.7); self:rotationz(90); self:diffuseshift(); self:effectcolor1(1,0.93333,0.266666,0.4); self:effectcolor2(1,1,1,1); self:effectperiod(0.25); self:effectmagnitude(0,1,0); self:diffusealpha(0); self:sleep(11); self:linear(0); self:diffusealpha(1); self:sleep(1); self:linear(0); self:diffusealpha(0); end;
		};

		-- 3rd step jump
		LoadActor("tapglow") .. {
			OnCommand=function(self) self:x(84); self:y(95); self:zoom(0.7); self:rotationz(90); self:diffuseshift(); self:effectcolor1(1,0.93333,0.266666,0.4); self:effectcolor2(1,1,1,1); self:effectperiod(0.25); self:effectmagnitude(0,1,0); self:diffusealpha(0); self:sleep(14); self:linear(0); self:diffusealpha(1); self:sleep(1); self:linear(0); self:diffusealpha(0); end;
		};
		LoadActor("tapglow") .. {
			OnCommand=function(self) self:x(275); self:y(95); self:zoom(0.7); self:rotationz(270); self:diffuseshift(); self:effectcolor1(1,0.93333,0.266666,0.4); self:effectcolor2(1,1,1,1); self:effectperiod(0.25); self:effectmagnitude(0,1,0); self:diffusealpha(0); self:sleep(14); self:linear(0); self:diffusealpha(1); self:sleep(1); self:linear(0); self:diffusealpha(0); end;
		};
		-- 4th step jump
		LoadActor("tapglow") .. {
			OnCommand=function(self) self:x(85); self:y(95); self:zoom(0.7); self:rotationz(90); self:diffuseshift(); self:effectcolor1(1,0.93333,0.266666,0.4); self:effectcolor2(1,1,1,1); self:effectperiod(0.25); self:effectmagnitude(0,1,0); self:diffusealpha(0); self:sleep(19); self:linear(0); self:diffusealpha(1); self:sleep(1); self:linear(0); self:diffusealpha(0); end;
		};
		LoadActor("tapglow") .. {
			OnCommand=function(self) self:x(275); self:y(95); self:zoom(0.7); self:rotationz(270); self:diffuseshift(); self:effectcolor1(1,0.93333,0.266666,0.4); self:effectcolor2(1,1,1,1); self:effectperiod(0.25); self:effectmagnitude(0,1,0); self:diffusealpha(0); self:sleep(21); self:linear(0); self:diffusealpha(1); self:sleep(1); self:linear(0); self:diffusealpha(0); end;
		};

		-- miss step
		LoadActor("healthhilight") .. {
			OnCommand=function(self) self:x(180); self:y(40); self:diffuseshift(); self:effectcolor1(1,0.93333,0.266666,0.4); self:effectcolor2(1,1,1,1); self:effectperiod(0.25); self:effectmagnitude(0,1,0); self:diffusealpha(1); end;
		};
		LoadFont("Common normal") .. {
		Text="Your life --->",
		InitCommand=function(self) self:x(-50); self:y(40); self:shadowlength(1); self:strokecolor(Color("Outline")); self:diffusealpha(0); end;
		OnCommand=function(self) self:skewx(-0.125); self:sleep(2); self:diffusealpha(1); self:sleep(0.5); self:diffusealpha(0); self:sleep(0.5); self:diffusealpha(1); self:sleep(0.5); self:diffusealpha(0); self:sleep(0.5); self:diffusealpha(1); self:sleep(0.5); self:diffusealpha(0); self:sleep(0.5); self:diffusealpha(1); self:sleep(0.5); self:diffusealpha(0); self:sleep(0.5); self:diffusealpha(1); self:sleep(0.5); self:diffusealpha(0); self:sleep(0.5); self:diffusealpha(1); self:sleep(0.5); self:diffusealpha(0); self:sleep(0.5); self:diffusealpha(1); self:sleep(0.5); self:diffusealpha(0); self:sleep(0.5); self:diffusealpha(1); self:sleep(0.5); self:diffusealpha(0); self:sleep(0.5); end;
	};
	};

	-- messages
	LoadFont("Common Bold") .. {
		Text="How To Play StepMania",
		InitCommand=function(self) self:zbuffer(1); self:z(20); self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:shadowlength(1); self:strokecolor(Color("Outline")); end;
		BeginCommand=function(self)
			self:AddAttribute(12, {Length=9, Diffuse=Color.Green});
		end;
		OnCommand=function(self) self:skewx(-0.125); self:diffuse(color("#ffd400")); self:shadowlength(2); self:shadowcolor(BoostColor(color("#ffd40077"),0.25)); self:diffusealpha(0); self:zoom(4); self:sleep(0.0); self:linear(0.3); self:diffusealpha(1); self:zoom(1); self:sleep(1.8); self:linear(0.3); self:zoom(0.75); self:x(170); self:y(60); end;
	};
	LoadActor("_howtoplay feet") .. {
			InitCommand=function(self) self:shadowlength(1); self:strokecolor(Color.Outline); end;
			OnCommand=function(self) self:z(20); self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:addx(-SCREEN_WIDTH); self:sleep(2.4); self:decelerate(0.3); self:addx(SCREEN_WIDTH); self:sleep(2); self:linear(0.3); self:zoomy(0); end;
	};
	Def.ActorFrame {
		InitCommand=function(self) self:x(SCREEN_CENTER_X+120); self:y(SCREEN_CENTER_Y+40); end;
		--[[
1=3
2=8
3=11
4=14
5=19
6=21
7=23

]]
		LoadActor("_howtoplay tap")..{
			InitCommand=function(self) self:diffusealpha(0); end;
			ShowCommand=function(self) self:linear(0); self:diffusealpha(1); self:sleep(2); self:linear(0); self:diffusealpha(0); end;
			OnCommand=function(self) self:sleep(8); self:queuecommand("Show"); end;
		};
		LoadActor("_howtoplay tap")..{
			InitCommand=function(self) self:diffusealpha(0); end;
			ShowCommand=function(self) self:linear(0); self:diffusealpha(1); self:sleep(2); self:linear(0); self:diffusealpha(0); end;
			OnCommand=function(self) self:sleep(11); self:queuecommand("Show"); end;
		};
		LoadActor("_howtoplay jump")..{
			InitCommand=function(self) self:diffusealpha(0); end;
			ShowCommand=function(self) self:linear(0); self:diffusealpha(1); self:sleep(2); self:linear(0); self:diffusealpha(0); end;
			OnCommand=function(self) self:sleep(14); self:queuecommand("Show"); end;
		};
		LoadActor("_howtoplay mine")..{
			InitCommand=function(self) self:diffusealpha(0); end;
			ShowCommand=function(self) self:linear(0); self:diffusealpha(1); self:sleep(2); self:linear(0); self:diffusealpha(0); end;
			OnCommand=function(self) self:sleep(17); self:queuecommand("Show"); end;
		};
		LoadActor("_howtoplay hold")..{
			InitCommand=function(self) self:diffusealpha(0); end;
			ShowCommand=function(self) self:linear(0); self:diffusealpha(1); self:sleep(2); self:linear(0); self:diffusealpha(0); end;
			OnCommand=function(self) self:sleep(19); self:queuecommand("Show"); end;
		};
		LoadActor("_howtoplay roll")..{
			InitCommand=function(self) self:diffusealpha(0); end;
			ShowCommand=function(self) self:linear(0); self:diffusealpha(1); self:sleep(2); self:linear(0); self:diffusealpha(0); end;
			OnCommand=function(self) self:sleep(21); self:queuecommand("Show"); end;
		};
		LoadActor("_howtoplay miss")..{
			InitCommand=function(self) self:diffusealpha(0); end;
			ShowCommand=function(self) self:linear(0); self:diffusealpha(1); self:sleep(2); self:linear(0); self:diffusealpha(0); end;
			OnCommand=function(self) self:sleep(23); self:queuecommand("Show"); end;
		};
	};
};
