

local gOverlayPath = "../ScreenGameplay overlay/"


local t = Def.ActorFrame{};



t[#t+1] = LoadActor(gOverlayPath.."SoundReady");
t[#t+1] = LoadActor(gOverlayPath.."Time.lua")..{
	GETOUTOFGAMESMMessageCommand=function(self) self:sleep(.75); self:accelerate(0.5); self:y(-100); end;
};
t[#t+1] = LoadActor(gOverlayPath.."BPM")..{
	GETOUTOFGAMESMMessageCommand=function(self) self:sleep(.75); self:accelerate(0.5); self:y(-50); end;
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
    GETOUTOFGAMESMMessageCommand=function(self) self:sleep(.75); self:accelerate(0.5); self:y(10); end;
};

return t;


