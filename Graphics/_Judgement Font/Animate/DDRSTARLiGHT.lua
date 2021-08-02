return {
    W1EarlyCommand = cmd(glowblink;effectperiod,0.025;effectcolor1,color("1,1,1,0");effectcolor2,color("1,1,1,0.2");diffusealpha,1;zoom,0.7*1.5;linear,0.066;zoom,0.6*1.5;sleep,0.434;diffusealpha,0);
    W1LateCommand = cmd(glowblink;effectperiod,0.025;effectcolor1,color("1,1,1,0");effectcolor2,color("1,1,1,0.2");diffusealpha,1;zoom,0.7*1.5;linear,0.066;zoom,0.6*1.5;sleep,0.434;diffusealpha,0);
    W2EarlyCommand = cmd(stopeffect;diffusealpha,1;zoom,0.7*1.5;linear,0.066;zoom,0.6*1.5;sleep,0.434;diffusealpha,0);
    W2LateCommand = cmd(stopeffect;diffusealpha,1;zoom,0.7*1.5;linear,0.066;zoom,0.6*1.5;sleep,0.434;diffusealpha,0);
    W3EarlyCommand = cmd(stopeffect;diffusealpha,1;zoom,0.7*1.5;linear,0.066;zoom,0.6*1.5;sleep,0.434;diffusealpha,0);
    W3LateCommand = cmd(stopeffect;diffusealpha,1;zoom,0.7*1.5;linear,0.066;zoom,0.6*1.5;sleep,0.434;diffusealpha,0);
    W4EarlyCommand = cmd(stopeffect;zoom,0.6*1.5;diffusealpha,1;sleep,0.5;diffusealpha,0);
    W4LateCommand = cmd(stopeffect;zoom,0.6*1.5;diffusealpha,1;sleep,0.5;diffusealpha,0);
    W5EarlyCommand = cmd(stopeffect;zoom,0.6*1.5;diffusealpha,1;sleep,0.5;diffusealpha,0);
    W5LateCommand = cmd(stopeffect;zoom,0.6*1.5;diffusealpha,1;sleep,0.5;diffusealpha,0);
    MissEarlyCommand = cmd(stoptweening;stopeffect;zoom,0.6*1.5;linear,0.05;diffusealpha,1;linear,0.45;addy,26;linear,0;diffusealpha,0;addy,-26);
    MissLateCommand = cmd(stoptweening;stopeffect;zoom,0.6*1.5;linear,0.05;diffusealpha,1;linear,0.45;addy,26;linear,0;diffusealpha,0;addy,-26);

};