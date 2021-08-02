local t = Def.ActorFrame {};
t[#t + 1] = StandardDecorationFromFileOptional("BackgroundFrame","BackgroundFrame");
t[#t + 1] = LoadActor(THEME:GetPathG("Arrow", "Right")) ..{
    OnCommand = cmd(xy, SCREEN_CENTER_X + 370, SCREEN_CENTER_Y + 120;zoom,0.7);
    OffCommand= cmd(accelerate,0.3;addx,100);
};
t[#t + 1] = LoadActor(THEME:GetPathG("Arrow", "Left")) ..{
    OnCommand = cmd(xy, SCREEN_CENTER_X - 370, SCREEN_CENTER_Y + 120;zoom,0.7);
    OffCommand= cmd(accelerate,0.3;addx,-100);
};
return t
