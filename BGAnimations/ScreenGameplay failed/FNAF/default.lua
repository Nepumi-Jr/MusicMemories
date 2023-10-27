local t = Def.ActorFrame{};

t[#t+1] = LoadActor("Power Runs Out") .. {
    StartTransitioningCommand=function(self) self:play(); end;
};

t[#t+1] = Def.Quad {
    StartTransitioningCommand = function(self)
        for k, v in pairs( SCREENMAN:GetTopScreen():GetChildren() ) do
            v:decelerate(9):diffusealpha(0);
        end
    end;
};

for i=1,2 do
    t[#t+1] = Def.Quad {
        StartTransitioningCommand = function(self)
            if SCREENMAN:GetTopScreen():GetChild('PlayerP'..i) then
                self:sleep(9):queuecommand("TipsyPlayer");
            end
        end;
        TipsyPlayerCommand = function(self)
            GAMESTATE:GetPlayerState(_G["PLAYER_"..i]):GetPlayerOptions('ModsLevel_Song'):Drunk(3 * (math.random(0,1) == 1 and 1 or -1),100,true):Tipsy(3 * (math.random(0,1) == 1 and 1 or -1),100,true)
            self:playcommand("Flicker");
        end;
        FlickerCommand = function(self)
            local slp1 = math.random(1,3)/22;
            local slp2 = math.random(1,3)/22;
            SCREENMAN:GetTopScreen():GetChild('PlayerP'..i)
                     :sleep(slp1):diffusealpha(1)
                     :sleep(slp2):diffusealpha(0)
            self:sleep(slp1 + slp2)
                :queuecommand("Flicker");
        end;
    };
end

t[#t+1] = Def.Quad{
    OnCommand = function(self)
        self:FullScreen():diffuse(color("#000000")):diffusealpha(0):decelerate(9):diffusealpha(1):sleep(0.1):diffusealpha(0);
    end
};

t[#t+1] = Def.Quad{
    InitCommand=function(self)
        local cl = color("#441122");
        if LoadModule("Easter.today.lua")() == "HALLOWEEN" then
            cl = color("#000000");
        end
        self:FullScreen(); self:diffuse(cl):cropbottom(1):fadebottom(0.5)
    end;
    StartTransitioningCommand=function(self) self:sleep(28.7):decelerate(0.3):cropbottom(0):fadebottom(0) end;
};


return t;