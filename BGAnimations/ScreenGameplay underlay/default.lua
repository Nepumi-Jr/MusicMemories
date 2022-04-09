local t = Def.ActorFrame{
	LoadActor("P1State");
	LoadActor("P2State");
	LoadActor("ScreenFilter");
	--LoadActor("NewBg");
	--LoadActor("Border");
Def.ActorFrame{
		OnCommand=function(self) self:playcommand('James'); end;
		JamesCommand=function(self)
if GAMESTATE:GetCurMusicSeconds() >= 0 then
	a = GAMESTATE:GetCurMusicSeconds() - 0
	self:diffusealpha(1-(math.min(a,1)))
	else
	self:diffusealpha(1)
end
		
		self:sleep(0.02)
		self:queuecommand('James')
		end;
Def.Sprite {
	InitCommand=function(self) self:Center(); self:draworder(1001); self:diffusealpha(1); self:blend('BlendMode_Add'); end;
	BeginCommand=function(self) self:LoadFromCurrentSongBackground(); end;
		OnCommand=function(self)
			self:SetSize(SCREEN_WIDTH,SCREEN_HEIGHT)
		end;
	CurrentSongChangedMessageCommand=function(self) self:LoadFromCurrentSongBackground(); end;
};
};
	--LoadActor("ED");
};
--330965 before
--88050096
--331996
return t;