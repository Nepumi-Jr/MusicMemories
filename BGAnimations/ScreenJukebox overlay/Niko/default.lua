local ENDED = false;
local x=Def.ActorFrame{

	Def.ActorFrame{
		InitCommand=cmd(SetUpdateFunction,function(self)
			if not ENDED then
				local SONGg = GAMESTATE:GetCurrentSong();
				local per =GAMESTATE:GetCurMusicSeconds()/SONGg:GetLastSecond();
				self:x(per*SCREEN_RIGHT);
			end
		end;
		);

	Def.Sprite{
		Texture="Chiaki Nanami 1x3.png";
		Frame0000 = 1;
		Delay0000 = 0.5;
		Frame0001 = 0;
		Delay0001 = 0.5;
		InitCommand=cmd(play;y,SCREEN_BOTTOM-32;effectclock,"Beat";
			SetTextureFiltering,false;zoom,1;
			);

		OffCommand=function(self)
			ENDED = true;
			self:SetStateProperties(
				{{Frame= 2, Delay= 5}}
			)
		end;

	};
	};

};

return x;
