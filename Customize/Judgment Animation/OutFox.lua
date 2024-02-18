local bigestOne = function(self) self:stoptweening(); self:zoom(0.65); self:diffusealpha(0.75); self:decelerate(0.15); self:zoom(0.60); self:diffusealpha(1); self:sleep(0.35); self:decelerate(0.3); self:diffusealpha(0); self:zoom(0.5); self:glowblink(); self:effectperiod(0.05); self:effectcolor1(color("1,1,1,0")); self:effectcolor2(color("1,1,1,0.15")); end;
local bigerOne = function(self) self:stoptweening(); self:zoom(0.65); self:diffusealpha(0.75); self:decelerate(0.15); self:zoom(0.60); self:diffusealpha(1); self:sleep(0.35); self:decelerate(0.3); self:diffusealpha(0); self:zoom(0.5); self:glowblink(); self:effectperiod(0.05); self:effectcolor1(color("1,1,1,0")); self:effectcolor2(color("1,1,1,0.10")); end;
local bigOne = function(self) self:stoptweening(); self:zoom(0.65); self:diffusealpha(0.75); self:decelerate(0.15); self:zoom(0.60); self:diffusealpha(1); self:sleep(0.35); self:decelerate(0.3); self:diffusealpha(0); self:zoom(0.5); self:glowblink(); self:effectperiod(0.05); self:effectcolor1(color("1,1,1,0")); self:effectcolor2(color("1,1,1,0.075")); end;
local normal = function(self) self:stoptweening(); self:zoom(0.65); self:diffusealpha(0.75); self:decelerate(0.15); self:zoom(0.60); self:diffusealpha(1); self:sleep(0.35); self:decelerate(0.3); self:diffusealpha(0); self:zoom(0.5); end;
return {
	ProW1EarlyCommand = bigestOne;
    ProW1LateCommand = bigestOne;
	ProW2EarlyCommand = bigerOne;
    ProW2LateCommand = bigerOne;
	ProW3EarlyCommand = bigerOne;
    ProW3LateCommand = bigerOne;
	ProW4EarlyCommand = bigerOne;
    ProW4LateCommand = bigerOne;
	ProW5EarlyCommand = bigerOne;
    ProW5LateCommand = bigerOne;
    W1EarlyCommand = bigOne;
    W1LateCommand = bigOne;
	W2EarlyCommand = normal;
    W2LateCommand = normal;
	W3EarlyCommand = normal;
    W3LateCommand = normal;
	W4EarlyCommand = normal;
    W4LateCommand = normal;
	W5EarlyCommand = normal;
    W5LateCommand = normal;
    MissEarlyCommand = function(self) self:stoptweening(); self:zoom(0.65); self:diffusealpha(0.75); self:decelerate(0.15); self:zoom(0.60); self:diffusealpha(1); self:sleep(0.35); self:decelerate(0.3); self:diffusealpha(0); end;
    MissLateCommand = function(self) self:stoptweening(); self:zoom(0.65); self:diffusealpha(0.75); self:decelerate(0.15); self:zoom(0.60); self:diffusealpha(1); self:sleep(0.35); self:decelerate(0.3); self:diffusealpha(0); end;
};