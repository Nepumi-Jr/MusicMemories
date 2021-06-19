local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame {
    Def.Quad{
        InitCommand=cmd(diffuse,color("#555555");x,SCREEN_CENTER_X;y,SCREEN_BOTTOM;zoomx,SCREEN_RIGHT;zoomy,60);	
    };
    Def.Quad{
        InitCommand=cmd(diffuse,GameColor.PlayerColors.PLAYER_1 or {1,0,0,1};x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-60/2;zoomx,SCREEN_RIGHT;zoomy,2.5);	
    };
};
t[#t+1] = StandardDecorationFromFileOptional("Header","Header");
t[#t+1] = StandardDecorationFromFileOptional( "Help", "Help" );
return t