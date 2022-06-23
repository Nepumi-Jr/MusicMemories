local c;
local cf;
local player = Var "Player";
local ShowComboAt = THEME:GetMetric("Combo", "ShowComboAt");
local Pulse = THEME:GetMetric("Combo", "PulseCommand");
local Pulse2 = THEME:GetMetric("Combo", "Pulse2Command");
local NumberMinZoom = THEME:GetMetric("Combo", "NumberMinZoom");
local NumberMaxZoom = THEME:GetMetric("Combo", "NumberMaxZoom");
local NumberMaxZoomAt = THEME:GetMetric("Combo", "NumberMaxZoomAt");
local LabelMinZoom = THEME:GetMetric("Combo", "LabelMinZoom");
local LabelMaxZoom = THEME:GetMetric("Combo", "LabelMaxZoom");
local ShowFlashyCombo = ThemePrefs.Get("FlashyCombo")
local MaxCom = 0;
local madness = 0;
local Grace = 0;--pumpkin :D
local FN = "Combo Numbers";
local FM = "Combo Misses";
local CL = "_Combo/Memories_combo";
local ML = "_Combo/Memories_misses";
local NumInArr = {nil,nil,nil,nil};

local QUE = {};
local XBar = 3;
local NPSi = 1;

local ZSC = 3;

local PS = STATSMAN:GetCurStageStats():GetPlayerStageStats(player);
local CMDofCB = {}

--Use to find Y Position for Bouncing :D
CMDofCB[1] = THEME:GetMetric("Combo", "Numbertor12315OnCommand");
CMDofCB[2] = THEME:GetMetric("Combo", "Numbermisstor12315OnCommand");
CMDofCB[3] = THEME:GetMetric("Combo", "ComboLabelOnCommand");
CMDofCB[4] = THEME:GetMetric("Combo", "MissLabelOnCommand");

local Fac = 3;
if not GAMESTATE:ShowW1() then
Fac = 2;
end

local Stat;
Stat ={
{0,0,0,0,0,0,0,0,0},
{0,0,0,0,0,0,0,0,0}
};

local function GSB()
local BI = 1;
local TD = GAMESTATE:GetCurrentSong():GetTimingData();

while (TD:GetElapsedTimeFromBeat(GAMESTATE:GetSongBeat()+BI) - TD:GetElapsedTimeFromBeat(GAMESTATE:GetSongBeat())) < 0.125 do
BI = BI *  2
end
return TD:GetElapsedTimeFromBeat(math.round(GAMESTATE:GetSongBeat())+BI)+0.05
- TD:GetElapsedTimeFromBeat(math.round(GAMESTATE:GetSongBeat())) 
- (TD:GetElapsedTimeFromBeat(math.round(GAMESTATE:GetSongBeat())+BI) - TD:GetElapsedTimeFromBeat(math.round(GAMESTATE:GetSongBeat())+(BI-0.4)))
--return math.abs(TD:GetElapsedTimeFromBeat(round(GAMESTATE:GetSongBeat()-0.1)+(BI-1)+0.9) - TD:GetElapsedTimeFromBeat(round(GAMESTATE:GetSongBeat())));
end;



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
		LoadFont(FN) .. {
			Name="Number";
			OnCommand = CMDofCB[1];
            WaitCommand=function(self)
            self:sleep(GSB())
            self:y(240-216-1.5);
            self:queuecommand("GoO")
            end;
		GoOCommand=function(self) self:effectclock("beat"); self:bounce(); self:effectmagnitude(0,-5,0); self:effecttiming(0.25,0.65,0.05,0.05); end;
		};
		LoadFont(FM) .. {
			Name="Misses";
			OnCommand = CMDofCB[2];
		WaitCommand=function(self)
		self:sleep(GSB())--If 2 Players use Split Jud type(Eg:Sm5 and ITG)
		self:y(240-216-1.5);
		self:queuecommand("GoO")
		end;
		GoOCommand=function(self) self:effectclock("beat"); self:bounce(); self:effectmagnitude(0,-5,0); self:effecttiming(0.25,0.65,0.05,0.05); end;
		};
        LoadFont("Isla/_chakra petch semibold overlay 72px") .. {
			Name="NumberOverlay";
			OnCommand = CMDofCB[1];
            WaitCommand=function(self)
            self:sleep(GSB())
            self:y(240-216-1.5);
            self:queuecommand("GoO")
            end;
		GoOCommand=function(self) self:effectclock("beat"); self:bounce(); self:effectmagnitude(0,-5,0); self:effecttiming(0.25,0.65,0.05,0.05); end;
		};
		LoadActor(CL)..{
			Name="ComboLabel";
			InitCommand=function(self) self:draworder(105); end;
			OnCommand = CMDofCB[3];
		};
		LoadActor(ML)..{
			Name="MissLabel";
			InitCommand=function(self) self:draworder(105); end;
			OnCommand = CMDofCB[4];
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

		if LoadModule("Easter.today.lua")()=="FOOL" then
			local tod = param.Misses;
			param.Misses=param.Combo;
			param.Combo=tod;
		end
		
		cf.ComboLabel:visible( false)
		cf.MissLabel:visible( false)

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
        Pulse( cf.NumberOverlay, param );
		Pulse( cf.Number, param );
		Pulse( cf.Misses, param );
		
		if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
		if param.Combo then
			cf.MissLabel:finishtweening():rotationz(-2):skewx(-0.125):addx(7):addy(2):glow(BoostColor(Color("Red"),1.2)):decelerate(0.05*2.5):glow(1,1,1,0):rotationz(0):addx(-7):skewx(0):addy(-2)
		else
			cf.ComboLabel:finishtweening():rotationz(-2):skewx(-0.125):addx(7):addy(2):decelerate(0.05*2.5):glow(1,1,1,0):rotationz(0):addx(-7):skewx(0):addy(-2)
		end
		else
		if param.Combo then
			cf.ComboLabel:finishtweening():rotationz(-2):skewx(-0.125):addx(7):addy(2):decelerate(0.05*2.5):glow(1,1,1,0):rotationz(0):addx(-7):skewx(0):addy(-2)
		else
			cf.MissLabel:finishtweening():rotationz(-2):skewx(-0.125):addx(7):addy(2):glow(BoostColor(Color("Red"),1.2)):decelerate(0.05*2.5):glow(1,1,1,0):rotationz(0):addx(-7):skewx(0):addy(-2)
		end
		end
		
		
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
			InitCommand=CMDofCB[1];
			OnCommand =function(self) end;
		};
		LoadFont(FN)..{
			Text = "000";
			InitCommand=CMDofCB[1];
			ComboCommand=function(self)
				self:diffuse(Color.Red);
				local lZSC = 3;
				self:zoom(lZSC);
				self:x((self:GetWidth()+35)*lZSC/3-58):y(22.5+self:GetHeight()*lZSC/4-7)
			end;
		};

	}

	t[#t+1] = Def.ActorFrame{	
		OnCommand=function(self) self:diffusealpha(1); end;

	LoadFont(FN)..{
	InitCommand=function(self) self:diffusealpha(0); end;
	OnCommand =CMDofCB[1];
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
