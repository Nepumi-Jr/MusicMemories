return {
    W1EarlyCommand = cmd(stopeffect;shadowlength,4;diffusealpha,1;zoom,1.3;linear,0.05;zoom,1;sleep,0.8;linear,0;diffusealpha,0;glowblink;effectperiod,0.05;effectcolor1,1,1,1,0;effectcolor2,1,1,1,0.8);
    W1LateCommand = cmd(stopeffect;shadowlength,4;diffusealpha,1;zoom,1.3;linear,0.05;zoom,1;sleep,0.8;linear,0;diffusealpha,0;glowblink;effectperiod,0.05;effectcolor1,1,1,1,0;effectcolor2,1,1,1,0.8);
    W2EarlyCommand = cmd(stopeffect;shadowlength,4;diffusealpha,1;zoom,1.3;linear,0.05;zoom,1;sleep,0.8;linear,0;diffusealpha,0);
    W2LateCommand = cmd(stopeffect;shadowlength,4;diffusealpha,1;zoom,1.3;linear,0.05;zoom,1;sleep,0.8;linear,0;diffusealpha,0);
    W3EarlyCommand = cmd(stopeffect;shadowlength,4;diffusealpha,1;zoom,1.2;linear,0.05;zoom,1;sleep,0.8;linear,0;diffusealpha,0);
    W3LateCommand = cmd(stopeffect;shadowlength,4;diffusealpha,1;zoom,1.2;linear,0.05;zoom,1;sleep,0.8;linear,0;diffusealpha,0);
    W4EarlyCommand = cmd(stopeffect;shadowlength,4;diffusealpha,1;zoom,1.1;linear,0.05;zoom,1;sleep,0.8;linear,0;diffusealpha,0);
    W4LateCommand = cmd(stopeffect;shadowlength,4;diffusealpha,1;zoom,1.1;linear,0.05;zoom,1;sleep,0.8;linear,0;diffusealpha,0);
    W5EarlyCommand = cmd(shadowlength,4;diffusealpha,1;zoom,1.0;vibrate;effectmagnitude,4,8,8;sleep,0.8;linear,0;diffusealpha,0);
    W5LateCommand = cmd(shadowlength,4;diffusealpha,1;zoom,1.0;vibrate;effectmagnitude,4,8,8;sleep,0.8;linear,0;diffusealpha,0);
    MissEarlyCommand = cmd(stopeffect;shadowlength,4;diffusealpha,1;zoom,1;addy,-20;linear,0.8;addy,20;sleep,0.8;linear,0;diffusealpha,0);
    MissLateCommand = cmd(stopeffect;shadowlength,4;diffusealpha,1;zoom,1;addy,-20;linear,0.8;addy,20;sleep,0.8;linear,0;diffusealpha,0);

    HoldLetGoCommand=cmd(shadowlength,4;diffusealpha,1;zoom,1;y,-10;linear,0.8;y,10;sleep,0.5;linear,0;diffusealpha,0);
    HoldJudgmentHeldCommand=cmd(shadowlength,4;diffusealpha,1;zoom,1.25;linear,0.3;zoomx,1;zoomy,1;sleep,0.5;linear,0;diffusealpha,0);
};