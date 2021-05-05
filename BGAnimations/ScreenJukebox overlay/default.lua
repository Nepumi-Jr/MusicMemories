

local gOverlayPath = "../ScreenGameplay overlay/"


local t = Def.ActorFrame{};



t[#t+1] = LoadActor(gOverlayPath.."SoundReady");
t[#t+1] = LoadActor(gOverlayPath.."Time.lua")..{
	GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,-100;);
};
t[#t+1] = LoadActor(gOverlayPath.."BPM")..{
	GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,-50;);
};


t[#t+1] = LoadActor(gOverlayPath.."MulPStuff");



t[#t+1]=LoadActor(gOverlayPath.."TitleAll");

--if tostring(SCREENMAN:GetTopScreen():GetScreenType()) ~== "ScreenType_SystemMenu" then
--end
t[#t+1] = LoadActor(gOverlayPath.."IQ");

t[#t+1] = LoadActor(gOverlayPath.."BetterG");

t[#t+1] = LoadActor(gOverlayPath.."Boom");

t[#t+1] = LoadActor(gOverlayPath.."Niko");

t[#t+1] = LoadActor(gOverlayPath.."Border");


t[#t+1] = LoadActor(gOverlayPath.."ButtomLifeLine/NewDefault.lua")..{
    GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,10;);
};

return t;


