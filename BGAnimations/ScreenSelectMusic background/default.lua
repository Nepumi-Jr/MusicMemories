local t = Def.ActorFrame{

	LoadActor(THEME:GetPathG("Global","Background"));
	Def.ActorFrame{
		InitCommand=function(self) self:diffusealpha(1); self:bob(); self:effectclock('beat'); self:effectmagnitude(1,3,0):zoom(1.1); self:effectperiod(32); end;
		Def.Sprite {
			CurrentSongChangedMessageCommand=function(self) self:finishtweening():sleep(0.3) self:queuecommand("ModifySongBackground"); end;
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
				else
					self:visible(false);
					self:Load(nil)
				end
			end;	
		};
		Def.Sprite {
			CurrentSongChangedMessageCommand=function(self) self:finishtweening():croptop(1) self:queuecommand("ModifySongBackground"); end;
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
					self:croptop(1):fadetop(0.2):decelerate(0.3):croptop(0):fadetop(0)
				else
					self:visible(false);
					self:Load(nil)
				end
			end;	
		};
	};
};







return t;
