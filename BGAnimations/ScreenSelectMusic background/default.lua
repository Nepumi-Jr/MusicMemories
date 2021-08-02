local t = Def.ActorFrame{

	LoadActor(THEME:GetPathG("Global","Background"));
	Def.ActorFrame{
		OnCommand=cmd(effectclock,"beat";diffuseramp;effectcolor1,color("1,1,1,0.9");effectcolor2,color("1,1,1,0.7");effecttiming,.5,.5,0,0);
		Def.Sprite {
			InitCommand=cmd(diffusealpha,1;pulse;effectclock,'beat';effectmagnitude,1.025,1,1;effecttiming,1,0,1,0);
			CurrentSongChangedMessageCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;finishtweening;sleep,0.32;queuecommand,"ModifySongBackground");
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
		InitCommand=cmd(x,0;y,0;diffusealpha,0.8);
		CurrentSongChangedMessageCommand=cmd(finishtweening;sleep,0.32;queuecommand,"ModifySongBackground");
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
