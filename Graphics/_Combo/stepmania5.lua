local c;
local cf;
local canAnimate = false;
local Troll = TP[ToEnumShortString(player)].ActiveModifiers.ComboColor or "PlayerColor(player)";
local player = Var "Player";
local ShowComboAt = THEME:GetMetric("Combo", "ShowComboAt");
local Pulse = THEME:GetMetric("Combo", "PulseCommand");
local PulseLabel = THEME:GetMetric("Combo", "PulseLabelCommand");

local NumberMinZoom = THEME:GetMetric("Combo", "NumberMinZoom");
local NumberMaxZoom = THEME:GetMetric("Combo", "NumberMaxZoom");
local NumberMaxZoomAt = THEME:GetMetric("Combo", "NumberMaxZoomAt");

local LabelMinZoom = THEME:GetMetric("Combo", "LabelMinZoom");
local LabelMaxZoom = THEME:GetMetric("Combo", "LabelMaxZoom");

local ShowFlashyCombo = ThemePrefs.Get("FlashyCombo")

local t = Def.ActorFrame {
	InitCommand=function(self) self:vertalign(bottom); end;
	-- flashy combo elements:
 	LoadActor(THEME:GetPathG("Combo","100Milestone")) .. {
		Name="OneHundredMilestone";
		InitCommand=function(self) self:visible(ShowFlashyCombo); end;
		FiftyMilestoneCommand=function(self) self:playcommand("Milestone"); end;
	};
	LoadActor(THEME:GetPathG("Combo","1000Milestone")) .. {
		Name="OneThousandMilestone";
		InitCommand=function(self) self:visible(ShowFlashyCombo); end;
		ToastyAchievedMessageCommand=function(self) self:playcommand("Milestone"); end;
	};
	-- normal combo elements:
	Def.ActorFrame {
		Name="ComboFrame";
		LoadFont( "_roboto Bold 54px.ini") .. {
			Name="Number";
			OnCommand = function(self) self:y(240-216-1.5); self:shadowlength(1); self:horizalign(right); self:vertalign(bottom); end;
		};
		LoadFont( "_roboto Bold 54px.ini") .. {
			Name="Misses";
			OnCommand = function(self) self:y(240-216-1.5); self:shadowlength(1); self:horizalign(right); self:vertalign(bottom); end;
		};
		LoadActor("5_combo")..{
			Name="ComboLabel";
			InitCommand=function(self) self:Center(); end;
			OnCommand = THEME:GetMetric("Combo", "ComboLabelOnCommand");
		};
		LoadActor("5_misses")..{
			Name="MissLabel";
			OnCommand = THEME:GetMetric("Combo", "MissLabelOnCommand");
		};
	};
	InitCommand = function(self)
		c = self:GetChildren();
		cf = c.ComboFrame:GetChildren();
		cf.Number:visible(false);
		cf.Misses:visible(false);
		cf.ComboLabel:visible(false)
		cf.MissLabel:visible(false)
	end;
	
	-- Milestones:
	-- 25,50,100,250,600 Multiples;
--[[ 		if (iCombo % 100) == 0 then
			c.OneHundredMilestone:playcommand("Milestone");
		elseif (iCombo % 250) == 0 then
			-- It should really be 1000 but thats slightly unattainable, since
			-- combo doesnt save over now.
			c.OneThousandMilestone:playcommand("Milestone");
		else
			return
		end; --]]
 	TwentyFiveMilestoneCommand=function(self,parent)
		if ShowFlashyCombo then
			(function(self) self:finishtweening(); self:addy(-4); self:bounceend(0.125); self:addy(4); end)(self);
		end;
	end;
	--]]
	--[[
	ToastyAchievedMessageCommand=function(self,params)
		if params.PlayerNumber == player then
			(function(self) self:thump(2); self:effectclock('beat'); end)(c.ComboFrame);
		end;
	end;
	ToastyDroppedMessageCommand=function(self,params)
		if params.PlayerNumber == player then
			(function(self) self:stopeffect(); end)(c.ComboFrame);
		end;
	end; --]]
	ComboCommand=function(self, param)
		local iCombo = param.Misses or param.Combo;
		if not iCombo or iCombo < ShowComboAt then
			cf.Number:visible(false);
			cf.Misses:visible(false);
			cf.ComboLabel:visible(false)
			cf.MissLabel:visible(false)
			return;
		end

		cf.ComboLabel:visible(false)
		cf.MissLabel:visible(false)

		param.Zoom = scale( iCombo, 0, NumberMaxZoomAt, NumberMinZoom, NumberMaxZoom );
		param.Zoom = clamp( param.Zoom, NumberMinZoom, NumberMaxZoom );

		param.LabelZoom = scale( iCombo, 0, NumberMaxZoomAt, LabelMinZoom, LabelMaxZoom );
		param.LabelZoom = clamp( param.LabelZoom, LabelMinZoom, LabelMaxZoom );
		if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
		if param.Combo then
			cf.ComboLabel:visible(false)
			cf.MissLabel:visible(true)
		else
			cf.ComboLabel:visible(true)
			cf.MissLabel:visible(false)
		end
		else
		if param.Combo then
			cf.ComboLabel:visible(true)
			cf.MissLabel:visible(false)
		else
			cf.ComboLabel:visible(false)
			cf.MissLabel:visible(true)
		end
		end
		cf.Number:settext( string.format("%i", iCombo) );
		cf.Misses:settext( string.format("%i", iCombo) );
        cf.Number:textglowmode("TextGlowMode_Stroke");
		-- For April FOOL day!
		if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
		if param.FullComboW1 then
			cf.Misses:diffuse(color("#ff0000"));
			cf.Misses:stopeffect();
			cf.Number:stopeffect();
			cf.Misses:visible(true);
			cf.Number:visible(false);
		elseif param.FullComboW2 then
			cf.Misses:diffuse(color("#ff0000"));
			cf.Misses:stopeffect();
			cf.Number:stopeffect();
			cf.Misses:visible(true);
			cf.Number:visible(false);
		elseif param.FullComboW3 then
			cf.Misses:diffuse(color("#ff0000"));
			cf.Misses:stopeffect();
			cf.Number:stopeffect();
			cf.Misses:visible(true);
			cf.Number:visible(false);
		elseif param.Combo then
			cf.Misses:diffuse(color("#ff0000"));
			cf.Misses:stopeffect();
			cf.Number:stopeffect();
			cf.Misses:visible(true);
			cf.Number:visible(false);
		else
			cf.Misses:visible(false);
			cf.Number:visible(true);
			cf.Number:diffuse(Troll);
			cf.Number:strokecolor(Color("Stealth"));
			cf.Number:stopeffect();
		end
		else
		if param.FullComboW1 then
			cf.Number:diffuse( GameColor.Judgment["JudgmentLine_W1"] );
			cf.Number:strokecolor( GameColor.Judgment["JudgmentLine_W1"] );
            cf.Number:textglowmode("TextGlowMode_Stroke");
			cf.Number:glowshift();
		elseif param.FullComboW2 then
			cf.Number:diffuse( GameColor.Judgment["JudgmentLine_W2"] );
			cf.Number:strokecolor( GameColor.Judgment["JudgmentLine_W2"] );
            cf.Number:textglowmode("TextGlowMode_Stroke");
			cf.Number:glowshift();
		elseif param.FullComboW3 then
			cf.Number:diffuse( GameColor.Judgment["JudgmentLine_W3"] );
			cf.Number:strokecolor( GameColor.Judgment["JudgmentLine_W3"] );
            cf.Number:textglowmode("TextGlowMode_Stroke");
			cf.Number:glowshift();
		elseif param.Combo then
			-- Player 1's color is Red, which conflicts with the miss combo.
			-- instead, just diffuse to white for now. -aj
			--c.Number:diffuse(PlayerColor(player));
			cf.Number:diffuse(Troll);
			cf.Number:strokecolor(Color("Stealth"));
			cf.Number:stopeffect();
		else
			cf.Number:diffuse(color("#ff0000"));
			cf.Number:stopeffect();
		end
		end
		-- Pulse
		Pulse5( cf.Number, param );
		Pulse5( cf.Misses, param );
		if comboType == "ITG" then
		else
		if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
		if param.Combo then
			PulseLabelMisses( cf.MissLabel, param );
		else
			PulseLabel( cf.ComboLabel, param );
		end
		else
		if param.Combo then
			PulseLabel( cf.ComboLabel, param );
		else
			PulseLabelMisses( cf.MissLabel, param );
		end
		end
		end
		-- Milestone Logic
	end;
--[[ 	ScoreChangedMessageCommand=function(self,param)
		local iToastyCombo = param.ToastyCombo;
		if iToastyCombo and (iToastyCombo > 0) then
-- 			(function(self) self:thump(); self:effectmagnitude(1,1.2,1); self:effectclock('beat'); end)(c.Number)
-- 			(function(self) self:thump(); self:effectmagnitude(1,1.2,1); self:effectclock('beat'); end)(c.Number)
		else
-- 			c.Number:stopeffect();
		end;
	end; --]]
};

return t;
