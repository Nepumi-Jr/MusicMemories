local t = Def.ActorFrame{

	LoadActor(THEME:GetPathG("Global","Background"));
	Def.ActorFrame{
		OnCommand=function(self) self:effectclock("beat"); self:diffuseramp(); self:effectcolor1(color("1,1,1,0.9")); self:effectcolor2(color("1,1,1,0.7")); self:effecttiming(.5,.5,0,0); end;
		Def.Sprite {
			InitCommand=function(self) self:diffusealpha(1); self:pulse(); self:effectclock('beat'); self:effectmagnitude(1.025,1,1); self:effecttiming(1,0,1,0); end;
			CurrentSongChangedMessageCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:finishtweening(); self:sleep(0.32); self:queuecommand("ModifySongBackground"); end;
			ModifySongBackgroundCommand=function(self)
				local cur_song = GAMESTATE:GetCurrentSong()
				if cur_song then
					if cur_song:GetBackgroundPath() then
						self:visible(true);
						self:LoadBackground(cur_song:GetBackgroundPath());
						self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
					else
						self:visible(false);
						self:Load(nil)
					end;
					self:diffusealpha(scale(LoadModule("ColorTone.Nighty.lua")(),0,1,1,0.75))
				else
					self:visible(false);
					self:Load(nil)
				end
			end;	
		};
	};

	Def.Sprite {
		InitCommand=function(self) self:x(0); self:y(0); self:diffusealpha(0.8); end;
		CurrentSongChangedMessageCommand=function(self) self:finishtweening(); self:sleep(0.32); self:queuecommand("ModifySongBackground"); end;
		ModifySongBackgroundCommand=function(self)
			if GAMESTATE:GetCurrentSong() then
				if GAMESTATE:GetCurrentSong():GetPreviewVidPath() then
					
					self:visible(true);
					self:Load(GAMESTATE:GetCurrentSong():GetPreviewVidPath());
					self:stretchto(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
					self:diffusealpha(0)
					self:sleep(0.5)
					self:accelerate(1):diffusealpha(scale(LoadModule("ColorTone.Nighty.lua")(),0,1,0.55,0.8))
				else
					self:Load(nil)
					self:visible(false);
				end;
			else
				self:Load(nil)
				self:visible(false);
			end;
		end;	
	};



	
};







return t;
