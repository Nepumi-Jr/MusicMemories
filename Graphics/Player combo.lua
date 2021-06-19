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

local function Long2ShortinSub(T)
	if T == "None" then
		return "No"
	elseif T == "Max combo" then
		return "Mc"
	elseif T == "Accuracy" then
		return "Ac"
	elseif T == "Accuracy From 100" then
		return "AcM"
	elseif T == 'Grade' then
		return "G"
	elseif T == "Note Collected(%)" then
		return "Ncp"
	elseif T == "Note Collected(/)" then
		return "Ncs"
	elseif T == "Missing Notes" then
		return "MN"
	elseif T == "NotePerSecond" then
		return "NPS";
	elseif T == "KeyPerSecond" then
		return "KPS";
	elseif T == "MyBestPercent" then
		return "MBB";--From My Best Border
	elseif T == "Fast/Late" then
		return "FL"
	else
		return nil;
	end
end;
local PS = STATSMAN:GetCurStageStats():GetPlayerStageStats(player);
local SubType = Long2ShortinSub(TP[ToEnumShortString(player)].ActiveModifiers.SubCombo) or "No";
local ITGJM = {"Chromatic","Deco","Emoticon","FP","ITG2","Mario","Pinkie Judgments","Tactics"};
local TORJM = {"tor12315za","ThaiJudgment","Edit","Neptune","Minecraft","Century"};
local URITG = false
local URTOR = false
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

local function IslaSay(self)
	local ACTO = self:GetChildren();

	while #QUE > 0 and GAMESTATE:GetCurMusicSeconds()-QUE[1] > 1 do
		table.remove(QUE,1)
	end
	if #QUE >= XBar then
		ACTO.I_Text:diffuse({1,scale(#QUE,XBar,XBar*2,1,0),0,1});
	else
		ACTO.I_Text:diffuse({scale(#QUE,0,XBar,0,1),1,0,1});
	end

	ACTO.I_Text:settextf("%s : %d",SubType,#QUE);
end


local t = Def.ActorFrame {};
	t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(vertalign,bottom);
	-- flashy combo elements:
 	--[[LoadActor(THEME:GetPathG("Combo","100Milestone")) .. {
		Name="OneHundredMilestone";
		InitCommand=cmd(visible,ShowFlashyCombo);
		FiftyMilestoneCommand=cmd(playcommand,"Milestone");
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
		GoOCommand=cmd(effectclock,"beat";bounce;effectmagnitude,0,-5,0;effecttiming,0.25,0.65,0.05,0.05);
		};
		LoadFont(FM) .. {
			Name="Misses";
			OnCommand = CMDofCB[2];
		WaitCommand=function(self)
		self:sleep(GSB())--If 2 Players use Split Jud type(Eg:Sm5 and ITG)
		self:y(240-216-1.5);
		self:queuecommand("GoO")
		end;
		GoOCommand=cmd(effectclock,"beat";bounce;effectmagnitude,0,-5,0;effecttiming,0.25,0.65,0.05,0.05);
		};
        LoadFont("Isla/_chakra petch semibold overlay 72px") .. {
			Name="NumberOverlay";
			OnCommand = CMDofCB[1];
            WaitCommand=function(self)
            self:sleep(GSB())
            self:y(240-216-1.5);
            self:queuecommand("GoO")
            end;
		GoOCommand=cmd(effectclock,"beat";bounce;effectmagnitude,0,-5,0;effecttiming,0.25,0.65,0.05,0.05);
		};
		LoadActor(CL)..{
			Name="ComboLabel";
			InitCommand=cmd(draworder,105);
			OnCommand = CMDofCB[3];
		};
		LoadFont("Common Large")..{
			Name="MaxCombo";
			InitCommand=cmd(draworder,105;);
			OnCommand = cmd(x,42;y,10;);
		};
		LoadActor(ML)..{
			Name="MissLabel";
			InitCommand=cmd(draworder,105);
			OnCommand = CMDofCB[4];
		};
	};
	InitCommand = function(self)
		c = self:GetChildren();
		cf = c.ComboFrame:GetChildren();
		cf.Number:visible(false);
        cf.NumberOverlay:visible(false);
		cf.MaxCombo:visible(SubType == "Mc")
		cf.Misses:visible(false);
		cf.ComboLabel:visible(false)
		cf.MissLabel:visible(false)
	end;
 	TwentyFiveMilestoneCommand=function(self,parent)
		if ShowFlashyCombo then
			(cmd(finishtweening;diffuse,BoostColor(Color("White"),1.75);linear,0.25;diffuse,color("#FFFFFF")))(self);
		end;
	end;
	ComboCommand=function(self, param)
		if SubType ~= "No" and SubType ~= "FL" then cf.MissLabel:y(0) cf.ComboLabel:y(0) end
		cf.MaxCombo:zoom(0.25);
		local iCombo = param.Misses or param.Combo;
		if not iCombo or iCombo < ShowComboAt then
			cf.Number:visible(false);
			cf.Misses:visible(false);
            cf.NumberOverlay:visible(false);
			cf.ComboLabel:visible( false)
			cf.MissLabel:visible( false)
			return;
		end

		if EASTER()=="FOOL" then
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
		cf.MaxCombo:settext( string.format("MC : %i", MaxCom) );
		cf.Number:settext( string.format("%i", iCombo) );
        cf.NumberOverlay:settext( string.format("%i", iCombo) );
		cf.Misses:settext( string.format("%i", iCombo) );


		local SA = CurStageAward(player);

		if string.find( SA,"W1") then
            cf.NumberOverlay:diffuse(GameColor.Judgment["JudgmentLine_W1"]);
		elseif string.find( SA,"W2") then
            cf.NumberOverlay:diffuse(GameColor.Judgment["JudgmentLine_W2"]);
		elseif string.find( SA,"W3") then
			cf.NumberOverlay:diffuse(GameColor.Judgment["JudgmentLine_W3"]);
		elseif string.find( SA,"Choke") then
            cf.NumberOverlay:diffuse(GameColor.Judgment["JudgmentLine_W4"]);
		elseif string.find( SA,"NoMiss") then
			cf.NumberOverlay:diffuse(GameColor.Judgment["JudgmentLine_W5"]);
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
		
		if iCombo > Grace and param.Combo then
			Grace = iCombo
			if param.Combo then
				-- instead, just diffuse to white for now. -aj
				cf.MaxCombo:diffuse({1,1,1,1});
				cf.MaxCombo:strokecolor(Color("Stealth"));
				cf.MaxCombo:stopeffect();
			else
				cf.MaxCombo:diffuse(color("#ff0000"));
				cf.MaxCombo:stopeffect();
			end
		end
		-- Pulse
        Pulse( cf.NumberOverlay, param );
		Pulse( cf.Number, param );
		Pulse( cf.Misses, param );
		
		if SubType == "Mc" then
		if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
		if iCombo > madness and not param.Combo then
		madness = iCombo
			cf.MaxCombo:finishtweening():diffusealpha(1):rotationz(-2):skewx(-0.125):addx(7):addy(2):decelerate(0.05*2.5):rotationz(0):addx(-7):skewx(0):addy(-2)
			:sleep(2):decelerate(0.1):diffusealpha(0):rotationz(10)
		end
		else
		if iCombo > madness and param.Combo then
		madness = iCombo
			cf.MaxCombo:finishtweening():diffusealpha(1):rotationz(-2):skewx(-0.125):addx(7):addy(2):decelerate(0.05*2.5):rotationz(0):addx(-7):skewx(0):addy(-2)
			:sleep(2):decelerate(0.1):diffusealpha(0):rotationz(10)
		end
		end
		end
		
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


if SubType ~= "No" then
	if SubType == "NPS" or SubType == "KPS" then
		t[#t+1] = Def.ActorFrame{
			OnCommand=cmd(x,10;y,10;zoom,0.3;diffusealpha,0);
			JudgmentMessageCommand=function(self,param)
				if param.Player ==  player then
					if SubType == "NPS" then
						if param.TapNoteScore ~= "TapNoteScore_Miss" and param.TapNoteScore ~= "TapNoteScore_AvoidMine" and param.HoldNoteScore ~= "HoldNoteScore_Held" then
							QUE[#QUE+1] = GAMESTATE:GetCurMusicSeconds();
						end
						XBar = (XBar * NPSi + #QUE)/(NPSi+1);
						NPSi = NPSi+1;
					end
					self:zoom(0.3)
					self:finishtweening():diffusealpha(1):rotationz(-2):skewx(-0.125):addx(7):addy(2):decelerate(0.05*2.5):rotationz(0):addx(-7):skewx(0):addy(-2)
					:sleep(2):decelerate(0.1):diffusealpha(0):rotationz(10)
				end
			end;
			Def.ActorFrame{
				OnCommand=cmd(SetUpdateFunction,IslaSay);
				LoadFont("Common Large")..{
					Name = "I_Text";
					OnCommand=cmd(horizalign,left);
				};
			};
		};
		t[#t+1] =Def.Quad{
			OnCommand=cmd(visible,false);
			StepP1MessageCommand=function()
				if player == PLAYER_1 and SubType == "KPS" then
					QUE[#QUE+1] = GAMESTATE:GetCurMusicSeconds();
				end
				XBar = (XBar * NPSi + #QUE)/(NPSi+1);
				NPSi = NPSi+1;
			end;
			StepP2MessageCommand=function()
				if player == PLAYER_2 and SubType == "KPS" then
					QUE[#QUE+1] = GAMESTATE:GetCurMusicSeconds();
				end
				XBar = (XBar * NPSi + #QUE)/(NPSi+1);
				NPSi = NPSi+1;
			end;
		};
	elseif SubType == "FL" then
		t[#t+1] = Def.Sprite{                    
			Name="LE";
			OnCommand=function(self)
			self:pause();
			self:visible(false);
	
			local JudF =  TP[ToEnumShortString(player)].ActiveModifiers.JudgmentGraphic:gsub(" %dx%d", ""):gsub(" %(doubleres%)", ""):gsub(".png", ""):gsub(" %[double%]",""):gsub(" %(res %d+x%d+%)","")
	
			local path = "/"..THEMEDIR().."Resource/JudF/EL/";
			
			local files = FILEMAN:GetDirListing(path)
			local RealFile = THEME:GetPathG("Def","EL");
			
			for k,filename in ipairs(files) do
				if string.match(filename, " 1x2.png") and string.match(filename,JudF) then
					RealFile = path..filename;
					break
				end
			end
			
	
				--Op
			self:Load(RealFile);
			end;
			InitCommand=cmd(x,35;y,-20);
			ResetCommand=cmd(finishtweening;stopeffect;visible,false);
			JudgmentMessageCommand=function(self,param)

				if param.Player ~= player then return end;
				if param.HoldNoteScore then return end;

				if param.TapNoteScore=="TapNoteScore_W5" or
				param.TapNoteScore=="TapNoteScore_W4" or
				param.TapNoteScore=="TapNoteScore_W3" or
				param.TapNoteScore=="TapNoteScore_W2" then

					self:finishtweening():visible(true)
					self:setstate((param.Early) and 0 or 1):diffusealpha(1):zoom(0.55):decelerate(0.125):zoom(0.5):sleep(0.8):decelerate(0.1):diffusealpha(0)

				else
					self:finishtweening():visible(false)
				end


			end;
		};
	end

local Stat={0,0,0,0,0,0,0,0,0};
	t[#t+1] =LoadFont( "Common Large") .. {
		OnCommand=cmd(x,10;y,5;zoom,0.2;horizalign,left;diffuse,{1,1,1,1};diffusealpha,0;);
		JudgmentMessageCommand=function(self, param)
		if param.Player ==  player then
		self:sleep(0.02)
		if param.TapNoteScore == "TapNoteScore_W1" then
		Stat[1] = Stat[1] +1
		elseif param.TapNoteScore == "TapNoteScore_W2" then
		Stat[2] = Stat[2] +1
		elseif param.TapNoteScore == "TapNoteScore_W3" then
		Stat[3] = Stat[3] +1
		elseif param.TapNoteScore == "TapNoteScore_W4" then
		Stat[4] = Stat[4] +1
		elseif param.TapNoteScore == "TapNoteScore_W5" then
		Stat[5] = Stat[5] +1
		elseif param.TapNoteScore == "TapNoteScore_Miss" then
		Stat[6] = Stat[6] +1
		elseif param.HoldNoteScore == "HoldNoteScore_Held" then
		Stat[7] = Stat[7] +1
		elseif param.HoldNoteScore == "HoldNoteScore_LetGo" then
		Stat[8] = Stat[8] +1
		elseif param.TapNoteScore == "TapNoteScore_HitMine" then
		Stat[9] = Stat[9] +1
		end
		
		local PS1 = STATSMAN:GetCurStageStats():GetPlayerStageStats(player);
		local Accc1 = math.min(PS1:GetActualDancePoints()/PS1:GetCurrentPossibleDancePoints(),1)+0.5;
		if not (GAMESTATE:GetPlayMode() == 'PlayMode_Rave' or GAMESTATE:GetPlayMode() == 'PlayMode_Battle') and (SCREENMAN:GetTopScreen():GetLifeMeter(player):IsFailing() or false) and math.mod(GAMESTATE:GetSongBeat(),2) < 1 then
		self:settext("Failed!!")
		self:finishtweening():diffuse(color("#FF0000")):diffusealpha(1):addy(10):zoomy(1.1/4):zoom(0.25*Accc1):linear(0.05):addy(-10):zoomy(1/4):zoom(0.25*Accc1):sleep(3):linear(0.5):diffusealpha(0):zoom(0.35*Accc1)
		else
		if SubType == "Ac" then
			if TP.Battle.IsBattle and ((TP.Battle.Hidden and TP.Battle.Mode == "Ac") or (TP.Battle.Mode == "Dr" and TP.Battle.Hidden and not TP.Battle.IsfailorIsDraw)) then
				self:settext("--.--%")
			else
				self:settext(FormatPercentScore(Accc1-0.5))
			end
		--SM(FormatPercentScore(Accc1-0.5));
		elseif SubType == "AcM" then
			if TP.Battle.IsBattle and ((TP.Battle.Hidden and TP.Battle.Mode == "Ac") or (TP.Battle.Mode == "Dr" and TP.Battle.Hidden and not TP.Battle.IsfailorIsDraw)) then
				self:settext("--.--%")
			else
				self:settext(FormatPercentScore(Accc1-0.5-1))
			end
		elseif SubType == "Ncp" then
			if TP.Battle.IsBattle and ((TP.Battle.Hidden and TP.Battle.Mode == "Ac") or (TP.Battle.Mode == "Dr" and TP.Battle.Hidden and not TP.Battle.IsfailorIsDraw)) then
				self:settext("--.--%")
			else
				self:settext(FormatPercentScore((Stat[5]+Stat[4]+Stat[3]+Stat[2]+Stat[1]+Stat[6]+Stat[7]+Stat[8])/(GAMESTATE:GetCurrentSteps(player):GetRadarValues(player):GetValue('RadarCategory_TapsAndHolds') )))
			end
		elseif SubType == "Ncs" then
			if TP.Battle.IsBattle and ((TP.Battle.Hidden and TP.Battle.Mode == "Ac") or (TP.Battle.Mode == "Dr" and TP.Battle.Hidden and not TP.Battle.IsfailorIsDraw)) then
				self:settext("??/??")
			else
				Tap=Stat[5]+Stat[4]+Stat[3]+Stat[2]+Stat[1]+Stat[7];
				All=GAMESTATE:GetCurrentSteps(player):GetRadarValues(player):GetValue('RadarCategory_TapsAndHolds')+GAMESTATE:GetCurrentSteps(player):GetRadarValues(player):GetValue('RadarCategory_Holds');
				self:settext(Tap.."/"..All)
			end
			
		elseif SubType == "MN" then
			if TP.Battle.IsBattle and ((TP.Battle.Hidden and TP.Battle.Mode == "Ac") or (TP.Battle.Mode == "Dr" and TP.Battle.Hidden and not TP.Battle.IsfailorIsDraw)) then
				self:settext("-??")
			else
				local Narin = Stat[6]+Stat[5]+Stat[4]+Stat[8];
				if Narin == 0 then
					self:diffuse(Color.Green)
					self:settext("FC!")
				else
					self:settextf("-%d",Narin)
					self:diffuse(Color.Red)
				end
			end
		elseif SubType == "MBB" then
			if TP.Battle.IsBattle and ((TP.Battle.Hidden and TP.Battle.Mode == "Ac") or (TP.Battle.Mode == "Dr" and TP.Battle.Hidden and not TP.Battle.IsfailorIsDraw)) then
				self:settext("???.??%");
			else
				local hs = -1;
				local hst = PROFILEMAN:GetProfile(player):GetHighScoreListIfExists(GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(player)):GetHighScores();
				if #hst~=0 then  hs= hst[1]:GetPercentDP(); end
					
				if hs == -1 then 
					self:settextf("%.2f%%",(Accc1-0.5)*100);
				else
					local magic = Accc1-0.5;
					local del = magic-hs;
					
					--SM("\n\n\n\n\n"..string.format( "%.2f vs %.2f is %.2f",magic,hs,magic-hs))
					if del <0 then
						self:settextf("%.2f%%",(magic-hs)*100);
						self:diffuse(Color.Red or {1,0,0,1});
					else
						self:settextf("+%.2f%%",(magic-hs)*100);
						self:diffuse(Color.Green or {0,1,0,1});
					end
				end

			end
		end
			if not (param.HoldNoteScore == "HoldNoteScore_Held" or
					param.HoldNoteScore == "HoldNoteScore_LetGo" or
					param.TapNoteScore == "TapNoteScore_HitMine") then
			
			if TP.Battle.IsBattle and ((TP.Battle.Hidden and TP.Battle.Mode == "Ac") or (TP.Battle.Mode == "Dr" and TP.Battle.Hidden and not TP.Battle.IsfailorIsDraw)) then
				self:zoom(0.3)
			else
				self:zoom(0.3*math.max(Accc1-0.5,0.3))
			end
			
			
			self:finishtweening():diffusealpha(1):rotationz(-2):skewx(-0.125):addx(7):addy(2):decelerate(0.05*2.5):rotationz(0):addx(-7):skewx(0):addy(-2)
			:sleep(2):decelerate(0.1):diffusealpha(0):rotationz(10)
			end
		end
		end
		end;
	};
end



	
	t[#t+1] = Def.ActorFrame{
		OnCommand=cmd(visible,false);
		--JUst DeBUg
		LoadFont(FN)..{
			Text = "000";
			InitCommand=CMDofCB[1];
			OnCommand =cmd();
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
		OnCommand=cmd(diffusealpha,1);

	LoadFont(FN)..{
	InitCommand=cmd(diffusealpha,0);
	OnCommand =CMDofCB[1];
		FiftyMilestoneCommand=function(self)
			if ShowFlashyCombo and EASTER()~="FOOL" then
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

		if param.FullComboW1 and EASTER()~="FOOL" then
			self:rainbow();
			self:strokecolor( Alpha(GameColor.Judgment["JudgmentLine_W1"],0) );
            self:textglowmode("TextGlowMode_Stroke");
		elseif param.FullComboW2 and EASTER()~="FOOL" then
			self:diffuse( Alpha(GameColor.Judgment["JudgmentLine_W2"],0) );
			self:diffusebottomedge(Alpha({1,1,1,1},0));
			self:strokecolor( Alpha(GameColor.Judgment["JudgmentLine_W2"],0) );
            self:textglowmode("TextGlowMode_Stroke");
			self:glowshift();
		elseif param.FullComboW3 and EASTER()~="FOOL" then
			self:diffuse( Alpha(GameColor.Judgment["JudgmentLine_W3"],0) );
			self:diffusebottomedge(Alpha({1,1,1,1},0));
			self:strokecolor( Alpha(GameColor.Judgment["JudgmentLine_W3"],0) );
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
