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
    LoadActor("So Sad") .. {
        NeNoooMessageCommand=cmd(play);
    };
    Def.Quad{
        InitCommand=cmd(diffuse,{1-0.2,1-0.3,1-0.15,0};zoom,9999);
        NeNoooMessageCommand=cmd(diffusealpha,1;sleep,0.5;linear,0.5;diffusealpha,0;)
    };
    Def.Quad{
        InitCommand=cmd(diffusealpha,0;zoom,9999);
        NeNoooMessageCommand=cmd(linear,0.5;diffuse,{0.2,0.3,0.15};sleep,0.001;diffusealpha,0;)
    };
    Def.Quad{
        InitCommand=cmd(Center;zoomx,99999;diffuse,color("#445534");zoomy,0;blend,'BlendMode_InvertDest');
        NeNoooMessageCommand=cmd(sleep,0.5;zoomy,SCREEN_CENTER_Y*2);
    };
    Def.Quad {
            NeNoooMessageCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffusealpha,0;diffuse,color("#FF8888");zoomy,0;zoomtowidth,SCREEN_WIDTH;sleep,0.704;diffusealpha,0.65;bounceend,1;zoomy,80;);
    };
    LoadActor("N.png")..{
        InitCommand=cmd(diffusealpha,0);
        NeNoooMessageCommand=cmd(x,SCREEN_CENTER_X-30*1;y,SCREEN_CENTER_Y-100;diffusealpha,0;diffuse,color("#88BB8800");bounceend,0.25;y,SCREEN_CENTER_Y;diffusealpha,1)
    };
    LoadActor("O.png")..{
        InitCommand=cmd(diffusealpha,0);
        NeNoooMessageCommand=cmd(x,SCREEN_CENTER_X+30*1;y,SCREEN_CENTER_Y-100;diffusealpha,0;diffuse,color("#88BB8800");sleep,0.5*1;bounceend,0.25;y,SCREEN_CENTER_Y;diffusealpha,1)
    };
    LoadActor("O.png")..{
        InitCommand=cmd(diffusealpha,0);
        NeNoooMessageCommand=cmd(x,SCREEN_CENTER_X+30*3;y,SCREEN_CENTER_Y-100;diffusealpha,0;diffuse,color("#88BB8800");sleep,0.5*1.5;bounceend,0.25;y,SCREEN_CENTER_Y;diffusealpha,1)
    };
    LoadActor("O.png")..{
        InitCommand=cmd(diffusealpha,0);
        NeNoooMessageCommand=cmd(x,SCREEN_CENTER_X+30*5;y,SCREEN_CENTER_Y-100;diffusealpha,0;diffuse,color("#88BB8800");sleep,0.5*1.75;bounceend,0.25;y,SCREEN_CENTER_Y;diffusealpha,1)
    };
    LoadActor("O.png")..{
        InitCommand=cmd(diffusealpha,0);
        NeNoooMessageCommand=cmd(x,SCREEN_CENTER_X+30*7;y,SCREEN_CENTER_Y-100;diffusealpha,0;diffuse,color("#88BB8800");sleep,0.5*2;bounceend,0.25;y,SCREEN_CENTER_Y;diffusealpha,1)
    };
    LoadActor("O.png")..{
        InitCommand=cmd(diffusealpha,0);
        NeNoooMessageCommand=cmd(x,SCREEN_CENTER_X+30*9;y,SCREEN_CENTER_Y-100;diffusealpha,0;diffuse,color("#88BB8800");sleep,0.5*2.1;bounceend,0.25;y,SCREEN_CENTER_Y;diffusealpha,1)
    };
    LoadActor("O.png")..{
        InitCommand=cmd(diffusealpha,0);
        NeNoooMessageCommand=cmd(x,SCREEN_CENTER_X+30*11;y,SCREEN_CENTER_Y-100;diffusealpha,0;diffuse,color("#88BB8800");sleep,0.5*2.2;bounceend,0.25;y,SCREEN_CENTER_Y;diffusealpha,1)
    };
    LoadActor("O.png")..{
        InitCommand=cmd(diffusealpha,0);
        NeNoooMessageCommand=cmd(x,SCREEN_CENTER_X+30*13;y,SCREEN_CENTER_Y-100;diffusealpha,0;diffuse,color("#88BB8800");sleep,0.5*2.27;bounceend,0.25;y,SCREEN_CENTER_Y;diffusealpha,1)
    };
    LoadActor("O.png")..{
        InitCommand=cmd(diffusealpha,0);
        NeNoooMessageCommand=cmd(x,SCREEN_CENTER_X+30*15;y,SCREEN_CENTER_Y-100;diffusealpha,0;diffuse,color("#88BB8800");sleep,0.5*2.35;bounceend,0.25;y,SCREEN_CENTER_Y;diffusealpha,1)
    };
    LoadActor("O.png")..{
        InitCommand=cmd(diffusealpha,0);
        NeNoooMessageCommand=cmd(x,SCREEN_CENTER_X+30*17;y,SCREEN_CENTER_Y-100;diffusealpha,0;diffuse,color("#88BB8800");sleep,0.5*2.4;bounceend,0.25;y,SCREEN_CENTER_Y;diffusealpha,1)
    };







    Def.Quad{
        InitCommand=cmd(FullScreen;diffuse,color("#00000000"));
        NeFailMessageCommand=cmd(linear,0.2;diffusealpha,1;linear,0.5;diffusealpha,0;linear,2;diffuse,{0.4,0.1,0.1,0.6});
    };
    Def.Quad{
        InitCommand=cmd(FullScreen;diffuse,color("#FF888800");blend,"BlendMode_Modulate");
        NeFailMessageCommand=cmd(diffusealpha,1);
    };
    
    
    Def.Sprite{
        InitCommand=cmd(blend,"BlendMode_Add";CenterX;y,SCREEN_CENTER_Y-100;animate,false;zoom,0.9;diffuse,{1,0,0,0});
        OnCommand=cmd(Load,THEME:GetCurrentThemeDirectory().."Graphics/GraphFont/BigCount/FAIL.png");
        NeFailMessageCommand=cmd(sleep,2.5;decelerate,0.5;diffusealpha,1;y,SCREEN_CENTER_Y-50);
    };
    LoadActor("Failll") .. {
            NeFailMessageCommand=cmd(play);
    };
};


return t;