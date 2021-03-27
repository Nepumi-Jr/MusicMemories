local t = Def.ActorFrame{};
	t[#t+1] = Def.Quad{
		GETOUTOFGAMESMMessageCommand=function(self)
			if SCREENMAN:GetTopScreen():GetChild('PlayerP1') then
				SCREENMAN:GetTopScreen():GetChild('LifeP1'):sleep(0.7):accelerate(.5):addy(-60);
			end
			if SCREENMAN:GetTopScreen():GetChild('PlayerP2') then
				SCREENMAN:GetTopScreen():GetChild('LifeP2'):sleep(0.7):accelerate(.5):addy(-60);
			end
			GAMESTATE:GetPlayerState(PLAYER_1):GetPlayerOptions('ModsLevel_Song'):Stealth(1,1,true):Dark(1,1,true):Drunk(1,1,true):Tipsy(1,1,true):Blind(1,1,true)
			GAMESTATE:GetPlayerState(PLAYER_2):GetPlayerOptions('ModsLevel_Song'):Stealth(1,1,true):Dark(1,1,true):Drunk(1,1,true):Tipsy(1,1,true):Blind(1,1,true)
		end;
	};

return t;