local t = Def.ActorFrame {
	OnCommand=function(self)
		local player = GAMESTATE:GetMasterPlayerNumber()
		GAMESTATE:UpdateDiscordProfile(GAMESTATE:GetPlayerDisplayName(player))
		GAMESTATE:UpdateDiscordScreenInfo((THEME:GetString('DiscordRich',"Select_Song") or "Selecting Song" )..
        string.format(" (stage %d)",GAMESTATE:GetCurrentStageIndex()+1) ,"",1)
	end;
	
};

return t;
