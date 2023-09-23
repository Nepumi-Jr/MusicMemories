
local function Blood(amo)
    local x = Def.ActorFrame{};

    for i = 1,amo do
        local Ang = math.random(0,180)
        local velo = math.random(100,300)*2
        local g = 400
        x[#x+1] = Def.ActorFrame{
            OnCommand=function(self) self:decelerate(velo*math.sin(Ang/180*math.pi)/g); self:addy(-velo*math.sin(Ang/180*math.pi)/2/g*velo*math.sin(Ang/180*math.pi)); self:accelerate(3-velo*math.sin(Ang/180*math.pi)/g); self:addy(0.5*g*math.pow(3-velo*math.sin(Ang/180*math.pi)/g,2)); self:diffusealpha(0); end;
            Def.Quad{
                InitCommand=function(self) self:x(math.random(-64*2.5,64*2.5)); self:y(math.random(-SCREEN_CENTER_Y,SCREEN_CENTER_Y)); self:zoom(math.random(3,15)/2); self:rotationx(math.random(0,360)); self:rotationy(math.random(0,360)); self:diffuse({1,0,0,1}); end;
                OnCommand=function(self) self:diffusealpha(1); self:linear(3); self:addx(velo*math.cos(Ang/180*math.pi)*3); self:rotationx(math.random(0,360)); self:rotationy(math.random(0,360)); end;
            };
        };
    end

    return x;
end

local t = Def.ActorFrame{

    Def.Quad{
        InitCommand=function(self) self:FullScreen(); self:diffuse({0,0,0,0}); end;
        OnCommand=function(self) self:decelerate(1); self:diffusealpha(0.7); end;
    };
    
    LoadActor("Sudden.png")..{
        InitCommand=function(self) self:Center():addy(30) self:diffusealpha(0); end;
        OnCommand=function(self) self:sleep(1); self:diffusealpha(1); self:sleep(7) end;
    };
    Def.Quad{
        InitCommand=function(self) self:FullScreen(); self:diffuse(color("#441122")):cropbottom(1):fadebottom(0.5) end;
        StartTransitioningCommand=function(self) self:sleep(8):decelerate(0.3):cropbottom(0):fadebottom(0) end;
    };
    LoadActor("SuddenDeath.mp3")..{
        StartTransitioningCommand=function(self) self:play(); end;
    };
    

    Def.ActorFrame{
        OnCommand=function(self) self:Center(); end;
        Blood(100);
    };

};



return t;