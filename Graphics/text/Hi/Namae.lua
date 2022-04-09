local Histy = 0;
local Nope = 14.524-8.704;
local t = Def.ActorFrame{
--troll = string.len(you suck);
	LoadActor("Bow") .. {
		OnCommand=function(self) self:sleep(8.704); self:playcommand('loop'); end;
		loopCommand=function(self)
		if Nope >= 1 then
		if Histy >= 1 then
		Histy = Histy - 1
		self:play()
		end
		self:sleep(0.063)
		self:queuecommand('loop')
		Nope = Nope - 0.063
		end
		end;
	};
		LoadFont("_determination mono 24px")..{
			InitCommand=function(self) self:horizalign(left); self:x(SCREEN_CENTER_X-200+9999999999999999999999999); self:y(SCREEN_CENTER_Y+80); self:diffuse(color("#FFFFFF")); self:zoom(1.25); self:cropright(1); end;
			OnCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
			profile1 = PROFILEMAN:GetProfile(PLAYER_1);
			name1 = profile1:GetDisplayName();
			profile2 = PROFILEMAN:GetProfile(PLAYER_2);
			name2 = profile2:GetDisplayName();
			if name1=="" then
				Nep1 = 'Player 1';
			else
				Nep1 = name1;
			end
			if name2=="" then
				Nep2 = 'Player 2';
			else
				Nep2 = name2;
			end
			TOR1 = string.len(Nep1)
			TOR2 = string.len(Nep2)
			Histy = TOR1 + TOR2 + 6;
			elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
			profile = PROFILEMAN:GetProfile(PLAYER_1);
			name = profile:GetDisplayName();
			if name=="" then
				Nep = 'Player';
			else
				Nep = name;
			end
			Histy = (string.len(Nep))+1;
			elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
			profile = PROFILEMAN:GetProfile(PLAYER_2);
			name = profile:GetDisplayName();
			if name=="" then
				Nep = 'Player';
			else
				Nep = name;
			end
			Histy = (string.len(Nep))+1;
			end
			end;
		};
};
return t;