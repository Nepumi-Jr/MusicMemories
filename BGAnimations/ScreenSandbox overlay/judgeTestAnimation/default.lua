
local animateValue = 60
local speedTick = 0.4

local function getJudgeAnimateCmd(timing)
    if timing == "W1" then
        return cmd(rotationz,0;shadowlength,0;y,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,0.2 * animateValue / 60 + 1;addy,-10 * animateValue / 60;
                    decelerate,0.05*2.5 * animateValue / 60;
                    addy,10 * animateValue / 60;zoomy,1;zoom,1;
                    sleep,0.8;
                    decelerate,0.1;diffusealpha,0.05;)
    elseif timing == "W2" then
        return cmd(rotationz,0;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1.15;addy,-7;
                    decelerate,0.05*2.5;
                    addy,7;zoomy,1;zoom,1;
                    sleep,0.5;
                    decelerate,0.1;diffusealpha,0.05;)
    elseif timing == "W3" then
        return cmd(rotationz,5;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1.1;addy,-6;
                    decelerate,0.05*2.5;
                    addy,6;zoomy,1;zoom,1;
                    sleep,0.5;
                    decelerate,0.1;diffusealpha,0.05;)
    elseif timing == "W4" then
        return cmd(rotationz,7;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1;addy,-5;
                    decelerate,0.05*2.5;
                    addy,5;zoomy,1;zoom,1;
                    sleep,0.5;
                    decelerate,0.1;diffusealpha,0.05;)
    elseif timing == "W5" then
        return cmd(rotationz,15;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1;addy,-5;
                    decelerate,0.05*2.5;
                    addy,5;zoomy,1;zoom,1;
                    sleep,0.5;
                    decelerate,0.1;diffusealpha,0.05;)
    else
        return cmd(rotationz,25;y,0;shadowlength,0;diffusealpha,1;zoom,1;y,-20;
                    linear,0.8;
                    y,20;
                    sleep,0.5;
                    linear,0.1;diffusealpha,0;)
    end
end

local InputOfArrow = function( event )
	if not event then return end

    if event.type ~= "InputEventType_Release" then
		if event.button == "Left" then
			animateValue = math.max(0,animateValue - 10)
            MESSAGEMAN:Broadcast("speedReload")
        elseif event.button == "Right" then
            animateValue = animateValue + 10
            MESSAGEMAN:Broadcast("speedReload")
		end

        if event.button == "Up" then
            speedTick = speedTick + 0.01
            MESSAGEMAN:Broadcast("speedReload")
        elseif event.button == "Down" then
            speedTick = math.max(0.001,speedTick - 0.01)
            MESSAGEMAN:Broadcast("speedReload")
        end
    end
end;


local t = Def.ActorFrame{
    OnCommand=function(self)
        SCREENMAN:GetTopScreen():AddInputCallback(InputOfArrow)
    end;
    Def.Quad{
        OnCommand=function(self)
            self:visible(false);
            self:playcommand("Tick")
        end;
        speedReloadMessageCommand=function(self)
            self:playcommand("Tick")
        end;
        TickCommand=function(self)
            MESSAGEMAN:Broadcast("TickTest")
            self:sleep(speedTick):queuecommand("Tick")
        end;
    };
    LoadFont("Combo Number") .. {
        InitCommand=function(self)
            self:xy(SCREEN_CENTER_X,70):zoom(0.5):settext(animateValue):rainbow()
        end;
        speedReloadMessageCommand=function(self)
            self:settext(animateValue)
        end;
    };

    LoadFont("Common Normal") .. {
        InitCommand=function(self)
            self:xy(SCREEN_CENTER_X+150,80):zoom(1):settextf("%.4f s",speedTick):rainbow()
        end;
        speedReloadMessageCommand=function(self)
            self:settextf("%.4f s",speedTick)
        end;
    };
    Def.ActorFrame{
        InitCommand=function(self)
            self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y)
        end;
        Def.Sprite{
            Texture="MemoryOTOG2 [double]";
            InitCommand=function(self)
                self:pause();
            end;
            TickTestMessageCommand=function(self)
                local timing = {
                    {"W1", 0}, 
                    {"W2", 2}, 
                    {"W3", 4}, 
                    {"W4", 6}, 
                    {"W5", 8}, 
                    {"Miss", 10}
                };
                
                local timingIndex = math.random(1,#timing)
                timingIndex = 1
                self:stoptweening()
                self:setstate(timing[timingIndex][2])
                local thisAnimateCmd = getJudgeAnimateCmd(timing[timingIndex][1])
                thisAnimateCmd(self);
            end;
        };
    };
    
};

return t;