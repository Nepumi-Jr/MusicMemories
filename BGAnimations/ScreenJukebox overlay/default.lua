

local gOverlayPath = "../ScreenGameplay overlay/"


local t = Def.ActorFrame{};



t[#t+1] = LoadActor("SoundReady");
t[#t+1] = LoadActor("Time.lua")..{
	GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,-100;);
};
t[#t+1] = LoadActor("BPM")..{
	GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,-50;);
};
if ((GAMESTATE:GetPlayerState(PLAYER_1):GetCurrentPlayerOptions():DrainSetting() == "DrainType_SuddenDeath" and GAMESTATE:IsPlayerEnabled(PLAYER_1)) or 
(GAMESTATE:GetPlayerState(PLAYER_2):GetCurrentPlayerOptions():DrainSetting() == "DrainType_SuddenDeath" and GAMESTATE:IsPlayerEnabled(PLAYER_2))) and not ((GAMESTATE:IsCourseMode()) and not GAMESTATE:GetCurrentCourse():IsNonstop()) then
t[#t+1] = LoadActor("Wario's Time")..{
	OnCommand=cmd(y,-10);
	GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;zoom,0;);
};
end

if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	if not (GAMESTATE:GetPlayMode() == 'PlayMode_Rave' or GAMESTATE:GetPlayMode() == 'PlayMode_Battle') then
		t[#t+1] = LoadActor("P1Health");
	end
t[#t+1] = LoadActor("P1State");
t[#t+1] = LoadActor("P1TapIndicator")..{
	GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;diffusealpha,0;);
};
end
if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	if not (GAMESTATE:GetPlayMode() == 'PlayMode_Rave' or GAMESTATE:GetPlayMode() == 'PlayMode_Battle') then
		t[#t+1] = LoadActor("P2Health");
	end
t[#t+1] = LoadActor(gOverlayPath.."P2State");
t[#t+1] = LoadActor(gOverlayPath.."P2TapIndicator")..{
	GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;diffusealpha,0;);
};
end



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
else
t[#t+1] = LoadActor(gOverlayPath.."DancingLine")..{
    GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,10;);
};


