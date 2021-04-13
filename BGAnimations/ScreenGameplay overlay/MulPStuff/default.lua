local Players = GAMESTATE:GetHumanPlayers();
local t = Def.ActorFrame{};

-- Danger
for pn in ivalues(Players) do
    if not (GAMESTATE:GetPlayMode() == 'PlayMode_Rave' or GAMESTATE:GetPlayMode() == 'PlayMode_Battle') then
		t[#t+1] = LoadActor("Health", pn);
	end
    t[#t+1] = LoadActor("Stat", pn);
    t[#t+1] = LoadActor("TapIndicator", pn).. {
        GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;diffusealpha,0;);
    };
end

return t;