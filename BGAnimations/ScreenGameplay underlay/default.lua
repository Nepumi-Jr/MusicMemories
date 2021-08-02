local t = Def.ActorFrame{
	LoadActor("P1State");
	LoadActor("P2State");
	LoadActor("ScreenFilter");
	--LoadActor("NewBg");
	--LoadActor("Border");
Def.ActorFrame{
		OnCommand=cmd(playcommand,'James');
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
	InitCommand=cmd(Center;draworder,1001;diffusealpha,1;blend,'BlendMode_Add');
	BeginCommand=cmd(LoadFromCurrentSongBackground);
		OnCommand=function(self)
			self:SetSize(SCREEN_WIDTH,SCREEN_HEIGHT)
		end;
	CurrentSongChangedMessageCommand=cmd(LoadFromCurrentSongBackground);
};
};
	--LoadActor("ED");
};
--330965 before
--88050096
--331996
return t;