local Histy = 0;
local Nope = 14.524-8.704;
local t = Def.ActorFrame{
--troll = string.len(you suck);
	LoadActor("Bow") .. {
		OnCommand=function(self) self:sleep(19.750); self:playcommand('loop'); end;
		loopCommand=function(self)
		if Nope <= 0 then
		i_suck = SCREENMAN:GetTopScreen():GetNextCourseSong():MusicLengthSeconds()
		end
		Nope = -99999999999
		self:sleep(0.063)
		self:queuecommand('loop')
		end;
	};
};
return t;