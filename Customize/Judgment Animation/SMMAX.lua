return {
    W1EarlyCommand = function(self) self:stopeffect(); self:shadowlength(4); self:diffusealpha(1); self:zoom(1.3); self:linear(0.05); self:zoom(1); self:sleep(0.8); self:linear(0); self:diffusealpha(0); self:glowblink(); self:effectperiod(0.05); self:effectcolor1(1,1,1,0); self:effectcolor2(1,1,1,0.8); end;
    W1LateCommand = function(self) self:stopeffect(); self:shadowlength(4); self:diffusealpha(1); self:zoom(1.3); self:linear(0.05); self:zoom(1); self:sleep(0.8); self:linear(0); self:diffusealpha(0); self:glowblink(); self:effectperiod(0.05); self:effectcolor1(1,1,1,0); self:effectcolor2(1,1,1,0.8); end;
    W2EarlyCommand = function(self) self:stopeffect(); self:shadowlength(4); self:diffusealpha(1); self:zoom(1.3); self:linear(0.05); self:zoom(1); self:sleep(0.8); self:linear(0); self:diffusealpha(0); end;
    W2LateCommand = function(self) self:stopeffect(); self:shadowlength(4); self:diffusealpha(1); self:zoom(1.3); self:linear(0.05); self:zoom(1); self:sleep(0.8); self:linear(0); self:diffusealpha(0); end;
    W3EarlyCommand = function(self) self:stopeffect(); self:shadowlength(4); self:diffusealpha(1); self:zoom(1.2); self:linear(0.05); self:zoom(1); self:sleep(0.8); self:linear(0); self:diffusealpha(0); end;
    W3LateCommand = function(self) self:stopeffect(); self:shadowlength(4); self:diffusealpha(1); self:zoom(1.2); self:linear(0.05); self:zoom(1); self:sleep(0.8); self:linear(0); self:diffusealpha(0); end;
    W4EarlyCommand = function(self) self:stopeffect(); self:shadowlength(4); self:diffusealpha(1); self:zoom(1.1); self:linear(0.05); self:zoom(1); self:sleep(0.8); self:linear(0); self:diffusealpha(0); end;
    W4LateCommand = function(self) self:stopeffect(); self:shadowlength(4); self:diffusealpha(1); self:zoom(1.1); self:linear(0.05); self:zoom(1); self:sleep(0.8); self:linear(0); self:diffusealpha(0); end;
    W5EarlyCommand = function(self) self:shadowlength(4); self:diffusealpha(1); self:zoom(1.0); self:vibrate(); self:effectmagnitude(4,8,8); self:sleep(0.8); self:linear(0); self:diffusealpha(0); end;
    W5LateCommand = function(self) self:shadowlength(4); self:diffusealpha(1); self:zoom(1.0); self:vibrate(); self:effectmagnitude(4,8,8); self:sleep(0.8); self:linear(0); self:diffusealpha(0); end;
    MissEarlyCommand = function(self) self:stopeffect(); self:shadowlength(4); self:diffusealpha(1); self:zoom(1); self:addy(-20); self:linear(0.8); self:addy(20); self:sleep(0.8); self:linear(0); self:diffusealpha(0); end;
    MissLateCommand = function(self) self:stopeffect(); self:shadowlength(4); self:diffusealpha(1); self:zoom(1); self:addy(-20); self:linear(0.8); self:addy(20); self:sleep(0.8); self:linear(0); self:diffusealpha(0); end;

    HoldLetGoCommand=function(self) self:shadowlength(4); self:diffusealpha(1); self:zoom(1); self:y(-10); self:linear(0.8); self:y(10); self:sleep(0.5); self:linear(0); self:diffusealpha(0); end;
    HoldJudgmentHeldCommand=function(self) self:shadowlength(4); self:diffusealpha(1); self:zoom(1.25); self:linear(0.3); self:zoomx(1); self:zoomy(1); self:sleep(0.5); self:linear(0); self:diffusealpha(0); end;
};