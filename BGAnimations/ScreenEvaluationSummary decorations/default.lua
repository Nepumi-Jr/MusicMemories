local t = Def.ActorFrame{};

t[#t+1] = Def.Quad{
    OnCommand=function(self) self:FullScreen(); self:diffuse({0,0,0,0.4}); self:fadetop(0.2); self:fadebottom(0.12); end;
};
t[#t+1] = LoadActor("Neww");
t[#t+1] = LoadActor("Intro.lua");
--t[#t+1] = StandardDecorationFromFileOptional("BannerList","BannerList");


t[#t+1] = Def.ActorFrame {
    Def.Quad{
        InitCommand=function(self) self:diffuse(color("#555555")); self:x(SCREEN_CENTER_X); self:y(SCREEN_BOTTOM); self:zoomx(SCREEN_RIGHT); self:zoomy(60); end;	
    };
    Def.Quad{
        InitCommand=function(self) self:diffuse(GameColor.PlayerColors.PLAYER_1 or {1,0,0,1}); self:x(SCREEN_CENTER_X); self:y(SCREEN_BOTTOM-60/2); self:zoomx(SCREEN_RIGHT); self:zoomy(2.5); end;	
    };
};
t[#t+1] = StandardDecorationFromFileOptional("Header","Header");
t[#t+1] = StandardDecorationFromFileOptional( "Help", "Help" );



return t;