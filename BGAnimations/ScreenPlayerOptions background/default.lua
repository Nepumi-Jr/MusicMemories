local num_players = GAMESTATE:GetHumanPlayers();
local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame {
	Def.Sprite {
		Condition=not GAMESTATE:IsCourseMode();
		InitCommand=function(self) self:Center(); end;
		OnCommand=function(self)
			if GAMESTATE:GetCurrentSong() then
				local song = GAMESTATE:GetCurrentSong();
				if song:HasBackground() then
					self:LoadBackground(song:GetBackgroundPath());
				end;
				self:scale_or_crop_background();
				(function(self) self:fadebottom(0.25); self:fadetop(0.25); self:croptop(48/480); self:cropbottom(48/480); end)(self);
			else
				self:visible(false);
			end
		end;
	};
	Def.Quad {
		InitCommand=function(self) self:Center(); self:scaletoclipped(SCREEN_WIDTH+1,SCREEN_HEIGHT); end;
		OnCommand=function(self)
			self:diffuse(color("#FFFFFF"));
			self:diffusealpha(0.2);
		end;
	};
};



return t
