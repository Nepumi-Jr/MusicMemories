local t = Def.ActorFrame{
    StartTransitioningCommand=function(self)
        
        local Nooo = false;
        
        if GAMESTATE:GetCurrentCourse() then
            if GAMESTATE:GetCurrentCourse():IsEndless() then
                Ns = 40
            else
                Ns = GAMESTATE:GetCurrentCourse():GetEstimatedNumStages();
            end
            MeAt = GAMESTATE:GetCourseSongIndex()+1
            if MeAt == Ns and Ns > 3 then
                Nooo = true;
            end
        elseif GAMESTATE:GetSongBeat() >= GAMESTATE:GetCurrentSong():GetLastBeat() * 0.9 then
            Nooo = true;
        end

        if Nooo then
            self:playcommand("NeNooo")
        else
            self:playcommand("NeFail")
        end
    end;
};



t[#t+1] = Def.ActorFrame{
    LoadActor("So Sad Fade") .. {
        NeNoooMessageCommand=function(self) self:play(); end;
    };
    Def.Quad{
        InitCommand=function(self) self:diffuse({1-0.2,1-0.3,1-0.15,0}); self:zoom(9999); end;
        NeNoooMessageCommand=function(self) self:diffusealpha(1); self:sleep(0.5); self:linear(0.5); self:diffusealpha(0); end
    };
    Def.Quad{
        InitCommand=function(self) self:diffusealpha(0); self:zoom(9999); end;
        NeNoooMessageCommand=function(self) self:linear(0.5); self:diffuse({0.2,0.3,0.15}); self:sleep(0.001); self:diffusealpha(0); end
    };
    Def.Quad{
        InitCommand=function(self) self:Center(); self:zoomx(99999); self:diffuse(color("#445534")); self:zoomy(0); self:blend('BlendMode_InvertDest'); end;
        NeNoooMessageCommand=function(self) self:sleep(0.5); self:zoomy(SCREEN_CENTER_Y*2); end;
    };
    Def.Quad {
            NeNoooMessageCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:diffusealpha(0); self:diffuse(color("#FF8888")); self:zoomy(0); self:zoomtowidth(SCREEN_WIDTH); self:sleep(0.704); self:diffusealpha(0.65); self:bounceend(1); self:zoomy(80):sleep(2.3):decelerate(0.7):cropleft(1):fadeleft(0.5) end;
    };
    Def.Quad{
        InitCommand=function(self) self:FullScreen(); self:diffuse(color("#441122")):cropbottom(1):fadebottom(0.5) end;
        NeNoooMessageCommand=function(self) self:sleep(5):decelerate(1):cropbottom(0):fadebottom(0) end;
    };
    LoadActor("N.png")..{
        InitCommand=function(self) self:diffusealpha(0); end;
        NeNoooMessageCommand=function(self) self:x(SCREEN_CENTER_X-30*1); self:y(SCREEN_CENTER_Y-100); self:diffusealpha(0); self:diffuse(color("#88BB8800")); self:bounceend(0.25); self:y(SCREEN_CENTER_Y); self:diffusealpha(1):sleep(3):accelerate(1):addy(100):rotationz(5):diffusealpha(0) end
    };
    LoadActor("O.png")..{
        InitCommand=function(self) self:diffusealpha(0); end;
        NeNoooMessageCommand=function(self) self:x(SCREEN_CENTER_X+30*1); self:y(SCREEN_CENTER_Y-100); self:diffusealpha(0); self:diffuse(color("#88BB8800")); self:sleep(0.5*1); self:bounceend(0.25); self:y(SCREEN_CENTER_Y); self:diffusealpha(1):sleep(3):accelerate(1):addy(100):rotationz(5):diffusealpha(0) end
    };
    LoadActor("O.png")..{
        InitCommand=function(self) self:diffusealpha(0); end;
        NeNoooMessageCommand=function(self) self:x(SCREEN_CENTER_X+30*3); self:y(SCREEN_CENTER_Y-100); self:diffusealpha(0); self:diffuse(color("#88BB8800")); self:sleep(0.5*1.5); self:bounceend(0.25); self:y(SCREEN_CENTER_Y); self:diffusealpha(1):sleep(3):accelerate(1):addy(100):rotationz(5):diffusealpha(0) end
    };
    LoadActor("O.png")..{
        InitCommand=function(self) self:diffusealpha(0); end;
        NeNoooMessageCommand=function(self) self:x(SCREEN_CENTER_X+30*5); self:y(SCREEN_CENTER_Y-100); self:diffusealpha(0); self:diffuse(color("#88BB8800")); self:sleep(0.5*1.75); self:bounceend(0.25); self:y(SCREEN_CENTER_Y); self:diffusealpha(1):sleep(3):accelerate(1):addy(100):rotationz(5):diffusealpha(0) end
    };
    LoadActor("O.png")..{
        InitCommand=function(self) self:diffusealpha(0); end;
        NeNoooMessageCommand=function(self) self:x(SCREEN_CENTER_X+30*7); self:y(SCREEN_CENTER_Y-100); self:diffusealpha(0); self:diffuse(color("#88BB8800")); self:sleep(0.5*2); self:bounceend(0.25); self:y(SCREEN_CENTER_Y); self:diffusealpha(1):sleep(3):accelerate(1):addy(100):rotationz(5):diffusealpha(0) end
    };
    LoadActor("O.png")..{
        InitCommand=function(self) self:diffusealpha(0); end;
        NeNoooMessageCommand=function(self) self:x(SCREEN_CENTER_X+30*9); self:y(SCREEN_CENTER_Y-100); self:diffusealpha(0); self:diffuse(color("#88BB8800")); self:sleep(0.5*2.1); self:bounceend(0.25); self:y(SCREEN_CENTER_Y); self:diffusealpha(1):sleep(3):accelerate(1):addy(100):rotationz(5):diffusealpha(0) end
    };
    LoadActor("O.png")..{
        InitCommand=function(self) self:diffusealpha(0); end;
        NeNoooMessageCommand=function(self) self:x(SCREEN_CENTER_X+30*11); self:y(SCREEN_CENTER_Y-100); self:diffusealpha(0); self:diffuse(color("#88BB8800")); self:sleep(0.5*2.2); self:bounceend(0.25); self:y(SCREEN_CENTER_Y); self:diffusealpha(1):sleep(3):accelerate(1):addy(100):rotationz(5):diffusealpha(0) end
    };
    LoadActor("O.png")..{
        InitCommand=function(self) self:diffusealpha(0); end;
        NeNoooMessageCommand=function(self) self:x(SCREEN_CENTER_X+30*13); self:y(SCREEN_CENTER_Y-100); self:diffusealpha(0); self:diffuse(color("#88BB8800")); self:sleep(0.5*2.27); self:bounceend(0.25); self:y(SCREEN_CENTER_Y); self:diffusealpha(1):sleep(3):accelerate(1):addy(100):rotationz(5):diffusealpha(0) end
    };
    LoadActor("O.png")..{
        InitCommand=function(self) self:diffusealpha(0); end;
        NeNoooMessageCommand=function(self) self:x(SCREEN_CENTER_X+30*15); self:y(SCREEN_CENTER_Y-100); self:diffusealpha(0); self:diffuse(color("#88BB8800")); self:sleep(0.5*2.35); self:bounceend(0.25); self:y(SCREEN_CENTER_Y); self:diffusealpha(1):sleep(3):accelerate(1):addy(100):rotationz(5):diffusealpha(0) end
    };
    LoadActor("O.png")..{
        InitCommand=function(self) self:diffusealpha(0); end;
        NeNoooMessageCommand=function(self) self:x(SCREEN_CENTER_X+30*17); self:y(SCREEN_CENTER_Y-100); self:diffusealpha(0); self:diffuse(color("#88BB8800")); self:sleep(0.5*2.4); self:bounceend(0.25); self:y(SCREEN_CENTER_Y); self:diffusealpha(1):sleep(3):accelerate(1):addy(100):rotationz(5):diffusealpha(0) end
    };







    Def.Quad{
        InitCommand=function(self) self:FullScreen(); self:diffuse(color("#00000000")); end;
        NeFailMessageCommand=function(self) self:linear(0.2); self:diffusealpha(1); self:linear(0.5); self:diffusealpha(0); self:linear(2); self:diffuse({0.4,0.1,0.1,0.6}); end;
    };
    Def.Quad{
        InitCommand=function(self) self:FullScreen(); self:diffuse(color("#FFAAAA00")); self:blend("BlendMode_Modulate"); end;
        NeFailMessageCommand=function(self) self:diffusealpha(0.4); end;
    };
    Def.Quad{
        InitCommand=function(self) self:FullScreen(); self:diffuse(color("#441122")):croptop(1):fadetop(0.5) end;
        NeFailMessageCommand=function(self) self:sleep(4):decelerate(0.3):croptop(0):fadetop(0) end;
    };
    Def.ActorFrame{
        InitCommand=function(self) self:Center():zoom(0.4):diffuse(color("#FFAA99")):blend("BlendMode_Add"):diffusealpha(0) end;
        NeFailMessageCommand=function(self) self:decelerate(2):diffusealpha(1):zoom(0.7):sleep(2):accelerate(0.6):diffusealpha(0):addy(100):rotationz(10) end;
        LoadActor("F.png") .. {
            InitCommand=function(self) self:x(-200):addx(math.random(-60,60)):y(math.random(-60,60)):rotationx(math.random(-15,15)):rotationy(math.random(-15,15)):rotationz(math.random(-15,15)) end;
            NeFailMessageCommand=function(self) self:decelerate(3.8):x(-200):y(0):rotationx(0):rotationy(0):rotationz(0) end;
        };
        LoadActor("A.png") .. {
            InitCommand=function(self) self:x(-30):addx(math.random(-60,60)):y(math.random(-60,60)):rotationx(math.random(-15,15)):rotationy(math.random(-15,15)):rotationz(math.random(-15,15)) end;
            NeFailMessageCommand=function(self) self:decelerate(3.8):x(-30):y(0):rotationx(0):rotationy(0):rotationz(0) end;
        };
        LoadActor("I.png") .. {
            InitCommand=function(self) self:x(130):addx(math.random(-60,60)):y(math.random(-60,60)):rotationx(math.random(-15,15)):rotationy(math.random(-15,15)):rotationz(math.random(-15,15)) end;
            NeFailMessageCommand=function(self) self:decelerate(3.8):x(130):y(0):rotationx(0):rotationy(0):rotationz(0) end;
        };
        LoadActor("L.png") .. {
            InitCommand=function(self) self:x(250):addx(math.random(-60,60)):y(math.random(-60,60)):rotationx(math.random(-15,15)):rotationy(math.random(-15,15)):rotationz(math.random(-15,15)) end;
            NeFailMessageCommand=function(self) self:decelerate(3.8):x(250):y(0):rotationx(0):rotationy(0):rotationz(0) end;
        };
    };
    -- Def.Sprite{
    --     InitCommand=function(self) self:blend("BlendMode_Add"); self:CenterX(); self:y(SCREEN_CENTER_Y); self:animate(false); self:zoom(0.9); self:diffuse({1,0.7,0.7,0}); end;
    --     OnCommand=function(self) self:Load(THEME:GetCurrentThemeDirectory().."Graphics/_GraphFont/BigCount/FAIL.png"); end;
    --     NeFailMessageCommand=function(self) self:sleep(1); self:linear(4); self:diffusealpha(1); self:y(SCREEN_CENTER_Y); end;
    -- };
    LoadActor("Failll") .. {
            NeFailMessageCommand=function(self) self:play(); end;
    };
};


return t;