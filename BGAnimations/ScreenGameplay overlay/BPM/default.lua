--ratemod = string.match(GAMESTATE:GetSongOptionsString(), "%d.%d");
--if ratemod then
--	ratemod = tonumber(ratemod);
--else
--	ratemod = 1.0
--end TODO: Fix After rate and pitch stable


local fz = 0.7;

local palentUpdateFunc = function(self)
	local c = self:GetChildren();
	local Bpm = GAMESTATE:GetSongPosition():GetCurBPS() * 60 *
			SCREENMAN:GetTopScreen():GetHasteRate();
	--if ratemod == 1 then
		if Bpm > 600 then
			c.NormalBPM:rainbowscroll(true)
		else
			c.NormalBPM:rainbowscroll(false)
		end
		c.NormalBPM:settext(round(Bpm))
		c.NormalBPM:diffuse(BPMColor(Bpm))
		c.NormalBPM:strokecolor(ColorTone(BPMColor(Bpm)))

		c.bpmText:diffuse(BPMColor(Bpm))
		c.bpmText:strokecolor(ColorTone(BPMColor(Bpm)))
	--else
	--	c.RateBPMSub:settextf("%d x %.1f =",round(Bpm),ratemod)
	--	c.RateBPMSub:diffuse(BPMColor(Bpm))
	--
	--	if Bpm*  ratemod > 600 then
	--		c.RateBPMMain:rainbowscroll(true)
	--	else
	--		c.RateBPMMain:rainbowscroll(false)
	--	end
	--	if Bpm * ratemod >= 1000 then
	--		c.RateBPMMain:settextf("%.d",Bpm * ratemod)
	--	else
	--		c.RateBPMMain:settextf("%.1f",Bpm * ratemod)
	--	end
	--
	--	c.RateBPMMain:diffuse(BPMColor(Bpm * ratemod))
	--
	--	if LoadModule("Gameplay.IsFrameSolo.lua")() then
	--		if GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 then
	--			c.RateBPMMain:x(-120 + c.RateBPMSub:GetWidth() * 0.8 + 10)
	--		end
	--	end
	--end
end;


local t = Def.ActorFrame{
	OnCommand=function(self) 
		self:x(SCREEN_CENTER_X); self:y(53); self:zoom(0.9);

		if LoadModule("Gameplay.IsFrameSolo.lua")() then
			local c = self:GetChildren();
			if GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 then
				self:x(SCREEN_RIGHT*0.75)
				c.bpmText:x(-115):zoom(0.5):y(5)
				c.NormalBPM:x(-100):zoom(1.3):horizalign(left)
				--if ratemod ~= 1 then
				--	c.RateBPMSub:x(-120):zoom(0.8):horizalign(left)
				--	c.RateBPMMain:zoom(1.2):horizalign(left)
				--end
			else
				self:x(SCREEN_RIGHT*0.25)
				c.bpmText:x(115):zoom(0.5):y(5)
				c.NormalBPM:x(100):zoom(1.3):horizalign(right)
			end
			--if ratemod ~= 1 then
			--	c.bpmText:settext("")
			--end
			self:y(25)
		end

		self:SetUpdateFunction(palentUpdateFunc);
	end;
	LoadFont("Common Normal")..{
		Name = "bpmText";
		Text = "BPM";
		InitCommand=function(self) self:diffuse(color("#FFFFFF")); self:zoom(0); end;
	};
	LoadFont("Common Normal")..{
		Name = "NormalBPM";
		InitCommand=function(self) self:diffuse(color("#FFFFFF")); self:zoom(0.7); end;
	};

	--LoadFont("Common Normal")..{
	--	Name = "RateBPMSub";
	--	Condition=(ratemod ~= 1);
	--	InitCommand=function(self) self:x(-27.5); self:diffuse(color("#FFFFFF")); self:zoom(0.6); self:playcommand('loop'); end;
	--};
	--LoadFont("Common Normal")..{
	--	Name = "RateBPMMain";
	--	Condition=(ratemod ~= 1);
	--	InitCommand=function(self) self:x(20); self:diffuse(color("#FFFFFF")); self:zoom(0.7); self:playcommand('loop'); end;
	--};
};
return t;