local t = Def.ActorFrame {};
if not GAMESTATE: IsCourseMode() then
return t;
end;
if GAMESTATE: IsCourseMode() then


local HOLD = 1;

t[#t + 1] = Def.Quad {
	InitCommand = function(self) self:FullScreen(); self:diffuse({
		0,
		0,
		0,
		0
	}); end;
	StartCommand = function(self) self:decelerate(0.5); self:diffusealpha(1); end;
	FinishCommand = function(self) self:decelerate(0.5); self:diffusealpha(0); end;
}

t[#t + 1] = Def.Quad {
	InitCommand = function(self) self:CenterX(); self:y(SCREEN_CENTER_Y * 1.6); self:zoomx(SCREEN_RIGHT); self:zoomy(200); self:diffuse({
		0,
		0,
		0,
		0.3
	}); end;
	FinishCommand = function(self) self:decelerate(0.5); self:zoomy(200); self:sleep(math.max(0.001, HOLD - 1)); self:decelerate(0.5); self:zoomy(0); end;
};

t[#t + 1] = LoadFont("Common Large").. {
	Text = "? Memories";
	InitCommand = function(self) self:CenterX(); self:y(SCREEN_CENTER_Y * 1.3); self:diffuse(Color.Orange); self:zoom(0.75); self:diffusealpha(0); end;
	BeforeLoadingNextCourseSongMessageCommand = function(self)
		self:settextf("%s Memories",FormatNumberAndSuffix(GAMESTATE:GetCourseSongIndex() + 2));
	end;
	FinishCommand = function(self) self:decelerate(0.5); self:diffusealpha(1); self:sleep(math.max(0.001, HOLD - 1)); self:decelerate(0.5); self:diffusealpha(0); end;
};

t[#t + 1] = LoadFont("Common Normal").. {
	InitCommand = function(self) self:CenterX(); self:y(SCREEN_CENTER_Y + 150); self:zoom(1); self:cropright(1); self:diffusealpha(0); end;
	BeforeLoadingNextCourseSongMessageCommand = function(self)
	local ppeng = SCREENMAN: GetTopScreen(): GetNextCourseSong();

	Title = ppeng: GetDisplayMainTitle();

	Sub = ppeng: GetDisplaySubTitle();

	Time = ppeng: MusicLengthSeconds();

	HOLD = ppeng: GetFirstSecond();

	See = color("#FF8800")
	local SE;
	SE = "";
	if Title == ""
	then
	SE = SE..
	"No Title\n"
	else
		SE = SE..Title..
	"\n"
	end
	if Sub ~= ""
	then
	SE = SE..Sub..
	"\n"
	end
	SE = SE..SecondsToMSSMsMs(Time)

	self: settext(SE);


	if Time < 3 * 60 then
	self: stopeffect(): diffuse(Color("White"))
	elseif Time < 5 * 60 then
	self: stopeffect(): diffuse(Color("White")): diffusebottomedge(Color("Red"))
	else
		self: stopeffect(): rainbow()
	end
	self: linear(0.5): cropright(0)
	end;
	FinishCommand = function(self) self:decelerate(0.5); self:diffusealpha(1); self:sleep(math.max(0.001, HOLD - 1)); self:decelerate(0.5); self:diffusealpha(0); end;
};


end
return t;