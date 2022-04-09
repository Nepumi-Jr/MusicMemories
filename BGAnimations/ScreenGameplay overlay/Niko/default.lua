local ENDED = false;

local updateCmd = function(self)
	if not ENDED then
		local SONGg = GAMESTATE:GetCurrentSong();
		local per =GAMESTATE:GetCurMusicSeconds()/SONGg:GetLastSecond();
		self:x(per*SCREEN_RIGHT);
	end
end;

local t=Def.ActorFrame{

	Def.ActorFrame{
		InitCommand=function(self) self:SetUpdateFunction(
			updateCmd
			);
		end;

	Def.Sprite{
		Texture="Chiaki Nanami 1x3.png";
		Frame0000 = 1;
		Delay0000 = 0.5;
		Frame0001 = 0;
		Delay0001 = 0.5;
		InitCommand=function(self) self:play(); self:y(SCREEN_BOTTOM-32); self:effectclock("Beat"); self:SetTextureFiltering(false); self:zoom(1); end;

		OffCommand=function(self)
			ENDED = true;
			self:SetStateProperties(
				{{Frame= 2, Delay= 5}}
			)
		end;

	};
	};

};

return t;
