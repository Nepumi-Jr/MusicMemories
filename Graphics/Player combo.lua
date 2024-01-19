local c;
local cf;
local player = Var "Player";

local ShowComboAt = THEME:GetMetric("Combo", "ShowComboAt");

local Pulse = function(self, isReverse)
	self:finishtweening();
	self:diffusealpha(1);
	self:skewy(0.125):addy(5 * (isReverse and -1 or 1)):rotationz(-5);
	self:decelerate(0.05*2.5);
	self:addy(5 * (isReverse and 1 or -1)):skewy(0):rotationz(0);
end;
local NumberMinZoom = THEME:GetMetric("Combo", "NumberMinZoom");
local NumberMaxZoom = THEME:GetMetric("Combo", "NumberMaxZoom");
local NumberMaxZoomAt = THEME:GetMetric("Combo", "NumberMaxZoomAt");
local LabelMinZoom = THEME:GetMetric("Combo", "LabelMinZoom");
local LabelMaxZoom = THEME:GetMetric("Combo", "LabelMaxZoom");
local ShowFlashyCombo = ThemePrefs.Get("FlashyCombo")
local MaxCom = 0;
local madness = 0;
local FN = "Combo Numbers";
local FM = "Combo Misses";
local CL = "Memories_combo";
local ML = "Memories_misses";
local NumInArr = {nil,nil,nil,nil};

local QUE = {};
local XBar = 3;
local NPSi = 1;

local ZSC = 3;

local PS = STATSMAN:GetCurStageStats():GetPlayerStageStats(player);
local numberOnCommand = THEME:GetMetric("Combo", "Numbertor12315OnCommand");
local missNumberOnCommand = THEME:GetMetric("Combo", "Numbermisstor12315OnCommand");

local comboLabelOnCommand = function(self, isReverse)
	self:xy(-40,25 - 30 * (isReverse and 1 or 0));
	self:shadowlength(1);
	self:zoom(0.65);
	self:align(0,1);
end;

local comboLabelPulse = function(self, isReverse, isMiss)
	local rf = (isReverse and -1 or 1); -- reverse factor
	self:finishtweening();
	self:rotationz(-2 * rf):skewx(-0.125 * rf):addx(7):addy(2 * rf);

	if isMiss then
		self:glow(BoostColor(Color("Red"),1.2));
	end

	self:decelerate(0.05*2.5):glow(1,1,1,0)
	self:rotationz(0):addx(-7):skewx(0):addy(-2 * rf);

end;

--Use to find Y Position for Bouncing :D
numberOnCommand = THEME:GetMetric("Combo", "Numbertor12315OnCommand");
missNumberOnCommand = THEME:GetMetric("Combo", "Numbermisstor12315OnCommand");

local Fac = 3;
if not GAMESTATE:ShowW1() then
Fac = 2;
end

local Stat;
Stat ={
{0,0,0,0,0,0,0,0,0},
{0,0,0,0,0,0,0,0,0}
};

local thisSleepBeat;

local function timeFromBeat(beat)
	return GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(beat)
end

local function GSB()
	local BI = 1;
	local nowBeat = GAMESTATE:GetSongBeat();
	
	--? searching to find best beat stamp
	while (timeFromBeat(round(nowBeat) + BI) - timeFromBeat(nowBeat)) < 0.2 do
		BI = BI * 2
	end
	local targetBeat = round(nowBeat) + BI
	return timeFromBeat(targetBeat + 0.4) - timeFromBeat(nowBeat)
end;

local comboOffset = LoadModule("PlayerOption.GetOffset.lua")(player, "Combo")


local t = Def.ActorFrame {};
	t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) self:vertalign(bottom); end;
	-- flashy combo elements:
 	--[[LoadActor(THEME:GetPathG("Combo","100Milestone")) .. {
		Name="OneHundredMilestone";
		InitCommand=function(self) self:visible(ShowFlashyCombo); end;
		FiftyMilestoneCommand=function(self) self:playcommand("Milestone"); end;
	};]]
	-- normal combo elements:
	Def.ActorFrame {
		Name="ComboFrame";
		OnCommand=function(self)
			self:xy(comboOffset.x, comboOffset.y)
			self:zoom(comboOffset.zoom)
			self:diffusealpha(comboOffset.alpha)
		end;
		LoadFont(FN) .. {
			Name="Number";
			OnCommand = numberOnCommand;
            WaitCommand=function(self)
				thisSleepBeat = GSB()
				self:sleep(thisSleepBeat)
				self:queuecommand("GoO")
			end;
			GoOCommand=function(self) 
				self:effectclock("beat"):bounce():effectmagnitude(0,5,0):effecttiming(0.05,0.05,0.25,0.65):effectoffset(0.1); 
			end;
		};
		LoadFont(FM) .. {
			Name="Misses";
			OnCommand = missNumberOnCommand;
			WaitCommand=function(self)
				self:sleep(thisSleepBeat)
				self:queuecommand("GoO")
			end;
			GoOCommand=function(self) self:effectclock("beat"):bounce():effectmagnitude(0,5,0):effecttiming(0.05,0.05,0.25,0.65):effectoffset(0.1);  end;
		};
        LoadFont("Isla/_chakra petch semibold overlay 72px") .. {
			Name="NumberOverlay";
			OnCommand = numberOnCommand;
            WaitCommand=function(self)
				self:sleep(thisSleepBeat)
				self:queuecommand("GoO")
			end;
			GoOCommand=function(self)self:effectclock("beat"):bounce():effectmagnitude(0,5,0):effecttiming(0.05,0.05,0.25,0.65):effectoffset(0.1);  end;
		};
		LoadActor(CL)..{
			Name="ComboLabel";
			InitCommand=function(self) self:draworder(105); end;
		};
		LoadActor(ML)..{
			Name="MissLabel";
			InitCommand=function(self) self:draworder(105); end;
		};
	};
	InitCommand = function(self)
		c = self:GetChildren();
		cf = c.ComboFrame:GetChildren();
		cf.Number:visible(false);
        cf.NumberOverlay:visible(false);
		cf.Misses:visible(false);
		cf.ComboLabel:visible(false)
		cf.MissLabel:visible(false)
	end;
 	TwentyFiveMilestoneCommand=function(self,parent)
		if ShowFlashyCombo then
			(function(self) self:finishtweening(); self:diffuse(BoostColor(Color("White"),1.75)); self:linear(0.25); self:diffuse(color("#FFFFFF")); end)(self);
		end;
	end;
	ComboCommand=function(self, param)
		local iCombo = param.Misses or param.Combo;
		if not iCombo or iCombo < ShowComboAt then
			cf.Number:visible(false);
			cf.Misses:visible(false);
            cf.NumberOverlay:visible(false);
			cf.ComboLabel:visible( false)
			cf.MissLabel:visible( false)
			return;
		end

		local isReverse = LoadModule("Gameplay.IsNowReverse.lua")(player);

		if LoadModule("Easter.today.lua")()=="FOOL" then
			local tod = param.Misses;
			param.Misses=param.Combo;
			param.Combo=tod;
		end

		comboLabelOnCommand( cf.ComboLabel, isReverse );
		comboLabelOnCommand( cf.MissLabel, isReverse );

		param.Zoom = scale( iCombo, 0, NumberMaxZoomAt, NumberMinZoom, NumberMaxZoom );
		param.Zoom = clamp( param.Zoom, NumberMinZoom, NumberMaxZoom );

		param.LabelZoom = scale( iCombo, 0, NumberMaxZoomAt, LabelMinZoom, LabelMaxZoom );
		param.LabelZoom = clamp( param.LabelZoom, LabelMinZoom, LabelMaxZoom );
		if param.Combo then
			cf.ComboLabel:visible( true)
			cf.MissLabel:visible( false)
		else
			cf.ComboLabel:visible( false)
			cf.MissLabel:visible( true)
		end

		if iCombo > MaxCom and param.Combo then
		MaxCom = iCombo
		end
		cf.Number:settext( string.format("%i", iCombo) );
        cf.NumberOverlay:settext( string.format("%i", iCombo) );
		cf.Misses:settext( string.format("%i", iCombo) );


		local SA = LoadModule("Eva.CustomStageAward.lua")(player);

		if string.find( SA,"W1") then
            cf.NumberOverlay:diffuse(JudgmentLineToColor("W1"));
		elseif string.find( SA,"W2") then
            cf.NumberOverlay:diffuse(JudgmentLineToColor("W2"));
		elseif string.find( SA,"W3") then
			cf.NumberOverlay:diffuse(JudgmentLineToColor("W3"));
		elseif string.find( SA,"Choke") then
            cf.NumberOverlay:diffuse(JudgmentLineToColor("W4"));
		elseif string.find( SA,"NoMiss") then
			cf.NumberOverlay:diffuse(JudgmentLineToColor("W5"));
		else
			cf.NumberOverlay:diffuse({0,0,0,1});
		end

        

		if param.Combo then
			cf.Number:diffuse({1,1,1,1});
			cf.Misses:visible(false);
			cf.Number:visible(true);
		else
			cf.Misses:diffuse(color("#ff0000"));
			cf.Misses:visible(true);
			cf.Number:visible(false);
		end

        cf.NumberOverlay:visible(true);
		
		-- Pulse
		Pulse( cf.NumberOverlay, isReverse );
		Pulse( cf.Number, isReverse );
		Pulse( cf.Misses, isReverse );

		local curPulseLabel = param.Combo and cf.ComboLabel or cf.MissLabel;
		local isCurMiss = not param.Combo;
		
		if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
			curPulseLabel = param.Combo and cf.MissLabel or cf.ComboLabel
			isCurMiss = param.Combo;
		end

		comboLabelPulse( curPulseLabel, isReverse, isCurMiss );
		
		
		cf.Number:y(17.5);
        cf.NumberOverlay:y(17.5);
		cf.Misses:y(17.5);

		cf.Number:stopeffect()
		cf.Number:queuecommand("Wait")
        cf.NumberOverlay:stopeffect()
		cf.NumberOverlay:queuecommand("Wait")
		cf.Misses:stopeffect()
		cf.Misses:queuecommand("Wait")
		
		-- Milestone Logic
	end;
	};



	
	t[#t+1] = Def.ActorFrame{
		OnCommand=function(self) self:visible(false); end;
		--JUst DeBUg
		LoadFont(FN)..{
			Text = "000";
			InitCommand=numberOnCommand;
			OnCommand =function(self) end;
		};
		LoadFont(FN)..{
			Text = "000";
			InitCommand=numberOnCommand;
			ComboCommand=function(self)
				self:diffuse(Color.Red);
				local lZSC = 3;
				self:zoom(lZSC);
				self:x((self:GetWidth()+35)*lZSC/3-58):y(22.5+self:GetHeight()*lZSC/4-7)
			end;
		};

	}

t[#t+1] = Def.ActorFrame{	
	OnCommand=function(self) 
		self:xy(comboOffset.x, comboOffset.y)
		self:zoom(comboOffset.zoom)
		self:diffusealpha(comboOffset.alpha)
	end;

	LoadFont(FN)..{
	InitCommand=function(self) self:diffusealpha(0); end;
	OnCommand =numberOnCommand;
		FiftyMilestoneCommand=function(self)
			if ShowFlashyCombo and LoadModule("Easter.today.lua")()~="FOOL" then
				--self:visible(true)
				--SM("\n\n\n\n\n"..string.format("X is %.2f Y is %.2f",self:GetWidth(),self:GetHeight()));
				self:finishtweening():diffusealpha(1)
				self:settext(string.format("%i",tonumber(self:GetText()+50)));
				--SM("\n\n\n\nBOOM AT "..self:GetText())
				self:decelerate(0.5):x((self:GetZoom()*self:GetWidth()+35)*ZSC/3-58):y(22.5+self:GetZoom()*self:GetHeight()*ZSC/4-7):zoom(self:GetZoom()*ZSC):diffusealpha(0)
				:sleep(0.001):x(0):y(22.5)
				--self:visible(false)
			end
		end;
	ComboCommand=function(self, param)
		local iCombo = param.Misses or param.Combo or 0;
		local iFCombo = math.floor(iCombo/50)*50;
		--self:visible(false)
		param.Zoom = scale( iCombo, 0, NumberMaxZoomAt, NumberMinZoom, NumberMaxZoom );
		param.Zoom = clamp( param.Zoom, NumberMinZoom, NumberMaxZoom );

		if iFCombo>=0 then self:settext( string.format("%i", iFCombo) ); end
		self:zoom(param.Zoom)

		ZSC = scale(iFCombo,50,1000,1.5,4);

		if param.FullComboW1 and LoadModule("Easter.today.lua")()~="FOOL" then
			self:rainbow();
			self:strokecolor( Alpha(JudgmentLineToColor("W1"),0) );
            self:textglowmode("TextGlowMode_Stroke");
		elseif param.FullComboW2 and LoadModule("Easter.today.lua")()~="FOOL" then
			self:diffuse( Alpha(JudgmentLineToColor("W2"),0) );
			self:diffusebottomedge(Alpha({1,1,1,1},0));
			self:strokecolor( Alpha(JudgmentLineToColor("W2"),0) );
            self:textglowmode("TextGlowMode_Stroke");
			self:glowshift();
		elseif param.FullComboW3 and LoadModule("Easter.today.lua")()~="FOOL" then
			self:diffuse( Alpha(JudgmentLineToColor("W3"),0) );
			self:diffusebottomedge(Alpha({1,1,1,1},0));
			self:strokecolor( Alpha(JudgmentLineToColor("W3"),0) );
            self:textglowmode("TextGlowMode_Stroke");
			self:glowshift();
		elseif param.Combo then
			-- instead, just diffuse to white for now. -aj
			self:diffuse(Alpha({1,1,1,1},0));
			self:strokecolor(Alpha(Color("Stealth"),0));
			self:stopeffect();
		end
		
		-- Milestone Logic
	end;
	};
};

	
return t;
