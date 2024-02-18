local c;
local player = Var "Player";
local SS = 0;
local PTAM = false;
local JudPath = "";

local Woosh = THEME:GetPathS("LifeMeterBattery","lose");



local JudgeName = TP[ToEnumShortString(player)].ActiveModifiers.JudgmentGraphic or "!!default!!";
--JudgeName = "MemoryP2 [Pro] [double] (doubleres) 2x11.png"
JudPath = LoadModule("Options.JudgmentGetPath.lua")(JudgeName);

local function ShowProtiming()
	  if GAMESTATE:IsDemonstration() then
	    return false
	  else
	    return GetUserPrefB("UserPrefProtiming" .. ToEnumShortString(player));
	  end
end;
local ProtimingWidth = 240;

local LTAP;
local LER;

local function MakeAverage( t )
	local sum = 0;
	for i=1,#t do
		sum = sum + t[i];
	end
	return sum / #t
end
local muan = false;
local tTotalJudgments = {};
local guaek = 1;



local UseJudgeCmd = LoadModule("Options.JudgmentAnimation.lua")(JudgeName)



local ProtimingCmds = {
	TapNoteScore_W1 = THEME:GetMetric( "Protiming", "ProtimingW1Command" );
	TapNoteScore_W2 = THEME:GetMetric( "Protiming", "ProtimingW2Command" );
	TapNoteScore_W3 = THEME:GetMetric( "Protiming", "ProtimingW3Command" );
	TapNoteScore_W4 = THEME:GetMetric( "Protiming", "ProtimingW4Command" );
	TapNoteScore_W5 = THEME:GetMetric( "Protiming", "ProtimingW5Command" );
	TapNoteScore_Miss = THEME:GetMetric( "Protiming", "ProtimingMissCommand" );
};




local AverageCmds = {
	Pulse = THEME:GetMetric( "Protiming", "AveragePulseCommand" );
};
local TextCmds = {
	Pulse = THEME:GetMetric( "Protiming", "TextPulseCommand" );
};

local TName,Length = LoadModule("Options.SmartTapNoteScore.lua")()
TName = LoadModule("Utils.SortTiming.lua")(TName)
TName[#TName + 1] = "Miss"
local isDouble;
local bestJudge = LoadModule("Options.BestJudge.lua")()--For Pump

local t = Def.ActorFrame {
	OnCommand=function(self) self:draworder(5000); end;
};


local PomuLocation = {
	[9] = {
		[0] = 1,
		[1] = 1,
		[2] = 1,
		[3] = 4,
		[4] = 4,
		[5] = 4,
		[6] = 7,
		[7] = 7,
		[8] = 7
	},
	[7] = {
		[0] = 0,
		[1] = 0,
		[2] = 3,
		[3] = 3,
		[4] = 3,
		[5] = 6,
		[6] = 6
	},
	[5] = {
		[0] = 2,
		[1] = 2,
		[2] = 2,
		[3] = 2,
		[4] = 2
	},
	[3] = {
		[0] = 1,
		[1] = 1,
		[2] = 1
	},
	[4] = {
		[0] = 0,
		[1] = 1,
		[2] = 2,
		[3] = 3
	}
}


local judgeOffset = LoadModule("PlayerOption.GetOffset.lua")(player, "Judge")

local judgeActor;


t[#t+1] = Def.ActorFrame {
	Name = "BigJudge";
	OnCommand = function(self)
		if IsGame("po-mu") then
			self:zoom(0.7)
		elseif IsGame("gddm") then
			self:zoom(0.55)
			if tonumber(ToEnumShortString(self:GetParent():GetName())) % 2 == 1 then
				self:y(-20)
			else
				self:y(-40)
			end
		end
	end;
	Def.ActorFrame {
		Name="JudgeOffset";
		OnCommand = function(self)
			self:xy(judgeOffset.x,judgeOffset.y)
			self:zoom(judgeOffset.zoom)
			self:diffusealpha(judgeOffset.alpha)
		end;
		Def.Sprite{                    
			Name="Judgment";
			OnCommand=function(self)
			self:pause();
			self:visible(false);
				if string.match(tostring(SCREENMAN:GetTopScreen()),"ScreenEdit") then
					self:Load(LoadModule("Options.JudgmentGetPath.lua")("Edit 2x6.png"));
				else
					self:Load(JudPath);
				end
			end;
			InitCommand=THEME:GetMetric("Judgment","JudgmentOnCommand");
			ResetCommand=function(self) self:finishtweening(); self:stopeffect(); self:visible(false); end;
		};
	};
	

	LoadActor(Woosh,true)..{
		Name="FAIL";
		OnCommand=function(self) end;
	};



	LoadFont("_roboto Bold 54px") .. {
		Name="ProtimingDisplay";
		Text="";
		InitCommand=function(self) self:visible(false); end;
		OnCommand=THEME:GetMetric("Protiming","ProtimingOnCommand");
		ResetCommand=function(self) self:finishtweening(); self:stopeffect(); self:visible(false); end;
	};
	LoadFont("_open sans semibold 24px") .. {
		Name="ProtimingAverage";
		Text="";
		InitCommand=function(self) self:visible(false); end;
		OnCommand=THEME:GetMetric("Protiming","AverageOnCommand");
		ResetCommand=function(self) self:finishtweening(); self:stopeffect(); self:visible(false); end;
	};
	LoadFont("_open sans semibold 24px") .. {
		Name="TextDisplay";
		Text=THEME:GetString("Protiming","MS");
		InitCommand=function(self) self:visible(false); end;
		OnCommand=THEME:GetMetric("Protiming","TextOnCommand");
		ResetCommand=function(self) self:finishtweening(); self:stopeffect(); self:visible(false); end;
	};
	Def.Quad {
		Name="ProtimingGraphBG";
		InitCommand=function(self) self:visible(false); self:y(32); self:zoomto(ProtimingWidth,16); end;
		ResetCommand=function(self) self:finishtweening(); self:diffusealpha(0.8); self:visible(false); end;
		OnCommand=function(self) self:diffuse(Color("Black")); self:diffusetopedge(color("0.1,0.1,0.1,1")); self:diffusealpha(0.8); self:shadowlength(2); end;
	};
	Def.Quad {
		Name="ProtimingGraphWindowW3";
		InitCommand=function(self) self:visible(false); self:y(32); self:zoomto(ProtimingWidth-4,16-4); end;
		ResetCommand=function(self) self:finishtweening(); self:diffusealpha(1); self:visible(false); end;
		OnCommand=function(self) self:diffuse(JudgmentLineToColor("W3")); end;
	};
	Def.Quad {
		Name="ProtimingGraphWindowW2";
		InitCommand=function(self) self:visible(false); self:y(32); self:zoomto(scale(PREFSMAN:GetPreference("TimingWindowSecondsW2"),0,PREFSMAN:GetPreference("TimingWindowSecondsW3"),0,ProtimingWidth-4),16-4); end;
		ResetCommand=function(self) self:finishtweening(); self:diffusealpha(1); self:visible(false); end;
		OnCommand=function(self) self:diffuse(JudgmentLineToColor("W2")); end;
	};
	Def.Quad {
		Name="ProtimingGraphWindowW1";
		InitCommand=function(self) self:visible(false); self:y(32); self:zoomto(scale(PREFSMAN:GetPreference("TimingWindowSecondsW1"),0,PREFSMAN:GetPreference("TimingWindowSecondsW3"),0,ProtimingWidth-4),16-4); end;
		ResetCommand=function(self) self:finishtweening(); self:diffusealpha(1); self:visible(false); end;
		OnCommand=function(self) self:diffuse(JudgmentLineToColor("W1")); end;
	};
	Def.Quad {
		Name="ProtimingGraphUnderlay";
		InitCommand=function(self) self:visible(false); self:y(32); self:zoomto(ProtimingWidth-4,16-4); end;
		ResetCommand=function(self) self:finishtweening(); self:diffusealpha(0.25); self:visible(false); end;
		OnCommand=function(self) self:diffuse(Color("Black")); self:diffusealpha(0.25); end;
	};
	Def.Quad {
		Name="ProtimingGraphFill";
		InitCommand=function(self) self:visible(false); self:y(32); self:zoomto(0,16-4); self:horizalign(left); end;
		ResetCommand=function(self) self:finishtweening(); self:diffusealpha(1); self:visible(false); end;
		OnCommand=function(self) self:diffuse(Color("Red")); end;
	};
	Def.Quad {
		Name="ProtimingGraphAverage";
		InitCommand=function(self) self:visible(false); self:y(32); self:zoomto(2,7); end;
		ResetCommand=function(self) self:finishtweening(); self:diffusealpha(0.85); self:visible(false); end;
		OnCommand=function(self) self:diffuse(Color("Orange")); self:diffusealpha(0.85); end;
	};
	Def.Quad {
		Name="ProtimingGraphCenter";
		InitCommand=function(self) self:visible(false); self:y(32); self:zoomto(2,16-4); end;
		ResetCommand=function(self) self:finishtweening(); self:diffusealpha(1); self:visible(false); end;
		OnCommand=function(self) self:diffuse(Color("White")); self:diffusealpha(1); end;
	};

	InitCommand = function(self)
		c = self:GetChildren();
		judgeActor = self:GetChild("JudgeOffset"):GetChild("Judgment");
		SS = 0 ;

        local miniFileName = JudPath;

        miniFileName = string.match(miniFileName, ".*/(.*)")
        isDouble = string.find(miniFileName, "%[double%]")

        if judgeActor:GetNumStates() == #TName * 2 or string.find(miniFileName, "2x%d") ~= nil then
            isDouble = true
        end
		

	end;

	JudgmentMessageCommand=function(self, param)
        --! Fix Player  for popn mode
        --*   -- Code modify from _fallback

        local useThisJudge = true;
		
        if self:GetParent():GetName() ~= "Judgment" then
            if IsGame("po-mu") then
                if PomuLocation[GAMESTATE:GetCurrentStyle():ColumnsPerPlayer()][param.FirstTrack] ~= tonumber(ToEnumShortString(self:GetParent():GetName())) then 
                    useThisJudge = false
                end
            else
                --printf("%s",self:GetParent():GetName())
                if param.FirstTrack ~= tonumber(ToEnumShortString(self:GetParent():GetName())) then 
                    useThisJudge = false 
                end
            end
        end

        

		local tempTNS = param.TapNoteScore;
        local iFrame = -1;

		--this applies only pump mode
		if IsGame("pump") then
			if tempTNS== "TapNoteScore_CheckpointHit" then
				tempTNS = "TapNoteScore_"..bestJudge;
			elseif tempTNS== "TapNoteScore_CheckpointMiss" then
				tempTNS = "TapNoteScore_Miss";
			end
		end
		
		
		if LoadModule("Easter.today.lua")()=="FOOL" then
        --if false then
        	if tempTNS=="TapNoteScore_Miss" then
        		tempTNS="TapNoteScore_W1";
        	elseif tempTNS=="TapNoteScore_W5" then
        		tempTNS="TapNoteScore_W2";
        	elseif tempTNS=="TapNoteScore_W4" then
        		tempTNS="TapNoteScore_W3";
        	elseif tempTNS=="TapNoteScore_W3" then
        		tempTNS="TapNoteScore_W4";
        	elseif tempTNS=="TapNoteScore_W2" then
        		tempTNS="TapNoteScore_W5";
        	elseif tempTNS=="TapNoteScore_W1" then
        		tempTNS="TapNoteScore_Miss";
        	end

        	if param.Early then
        		param.Early=false
        	else
        		param.Early=true
        	end
        end


        local msgParam = param;
        MESSAGEMAN:Broadcast("TestJudgment",msgParam);
        --
		if param.Player ~= player then return end;
		if param.HoldNoteScore then return end;

		if param.Cor ~= nil then
			judgeActor:Load(getThemeDir().."/BGAnimations/ScreenGameplay overlay/IQ/IQJud 1x7.png");
			PTAM=true;
		elseif PTAM then
			PTAM=false;
			if string.match(tostring(SCREENMAN:GetTopScreen()),"ScreenEdit") then
				judgeActor:Load(LoadModule("Options.JudgmentGetPath.lua")("Edit 2x6.png"));
			else
				judgeActor:Load(JudPath);
			end
		end

        for i = 1,#TName do
			if tempTNS == "TapNoteScore_"..TName[i] then 
                iFrame = i-1 
            end
		end

		if iFrame == -1 then return end
		if isDouble then
            iFrame = (iFrame)*2 + (param.Early and 0 or 1)
        end

        if tempTNS == "TapNoteScore_Miss" then
            iFrame = judgeActor:GetNumStates() - 1
        end

        if ((tempTNS == 'TapNoteScore_Miss'  or tempTNS == 'TapNoteScore_W5' or tempTNS == 'TapNoteScore_W4')
		or param.HoldNoteScore == "HoldNoteScore_LetGo")
		and SS == 0 then
            SS = 9999;
            if not useThisJudge then return; end
            c.FAIL:play()
            MESSAGEMAN:Broadcast("SOFAIL", {pn=param.Player,fr=iFrame,cor=param.Cor})
            judgeActor:visible(false);
        else
            if not useThisJudge then return; end
            judgeActor:visible(true);
		end

		local fTapNoteOffset = param.TapNoteOffset;
		if param.HoldNoteScore then
			fTapNoteOffset = 1;
		else
			fTapNoteOffset = param.TapNoteOffset;
		end

		if tempTNS == 'TapNoteScore_Miss' then
			fTapNoteOffset = 1;
			bUseNegative = true;
		else
-- 			fTapNoteOffset = fTapNoteOffset;
			bUseNegative = false;
		end;

		if fTapNoteOffset ~= 1 then
			-- we're safe, you can push the values
			tTotalJudgments[#tTotalJudgments+1] = math.abs(fTapNoteOffset);
--~ 			tTotalJudgments[#tTotalJudgments+1] = bUseNegative and fTapNoteOffset or math.abs( fTapNoteOffset );
		end

		self:playcommand("Reset");

		if Op ~= "None" or Op ~= "SM5ProTiming" then judgeActor:setstate( iFrame ); end

		if param.Cor ~= nil then
			if not param.Cor then
				judgeActor:setstate( 7-1 );
			end
		end


		
		if Op ~= "SM5ProTiming" then
			if tempTNS ~= 'TapNoteScore_Miss' then
				if param.Early then
					UseJudgeCmd[ToEnumShortString(tempTNS).."EarlyCommand"](judgeActor);
				else
					UseJudgeCmd[ToEnumShortString(tempTNS).."LateCommand"](judgeActor);
				end
				muan = false;
			else
				if muan then
					UseJudgeCmd[ToEnumShortString(tempTNS).."EarlyCommand"](judgeActor);
					muan = false
				else
					UseJudgeCmd[ToEnumShortString(tempTNS).."LateCommand"](judgeActor);
					muan = true
				end
			end

			judgeActor:visible( true );
			c.ProtimingDisplay:visible( false );
			c.ProtimingAverage:visible( false );
			c.TextDisplay:visible( false );
			c.ProtimingGraphBG:visible( false );
			c.ProtimingGraphUnderlay:visible( false );
			c.ProtimingGraphWindowW3:visible( false );
			c.ProtimingGraphWindowW2:visible( false );
			c.ProtimingGraphWindowW1:visible( false );
			c.ProtimingGraphFill:visible( false );
			c.ProtimingGraphAverage:visible( false );
			c.ProtimingGraphCenter:visible( false );
		else
			judgeActor:visible( false );
			c.ProtimingDisplay:visible( true );
			c.ProtimingDisplay:settextf("%i",fTapNoteOffset * 1000);
			ProtimingCmds[param.TapNoteScore](c.ProtimingDisplay);
			
			c.ProtimingAverage:visible( true );
			c.ProtimingAverage:settextf("%.2f%%",clamp(100 - MakeAverage( tTotalJudgments ) * 1000 ,0,100));
			AverageCmds['Pulse'](c.ProtimingAverage);
			
			c.TextDisplay:visible( true );
			TextCmds['Pulse'](c.TextDisplay);
			
			c.ProtimingGraphBG:visible( true );
			c.ProtimingGraphUnderlay:visible( true );
			c.ProtimingGraphWindowW3:visible( true );
			c.ProtimingGraphWindowW2:visible( true );
			c.ProtimingGraphWindowW1:visible( true );
			c.ProtimingGraphFill:visible( true );
			c.ProtimingGraphFill:finishtweening();
			c.ProtimingGraphFill:decelerate(1/60);
	-- 		c.ProtimingGraphFill:zoomtowidth( clamp(fTapNoteOffset * 188,-188/2,188/2) );
			c.ProtimingGraphFill:zoomtowidth( clamp(
					scale(
					fTapNoteOffset,
					0,PREFSMAN:GetPreference("TimingWindowSecondsW3"),
					0,(ProtimingWidth-4)/2),
				-(ProtimingWidth-4)/2,(ProtimingWidth-4)/2)
			);
			c.ProtimingGraphAverage:visible( true );
			c.ProtimingGraphAverage:zoomtowidth( clamp(
					scale(
					MakeAverage( tTotalJudgments ),
					0,PREFSMAN:GetPreference("TimingWindowSecondsW3"),
					0,ProtimingWidth-4),
				0,ProtimingWidth-4)
			);
	-- 		c.ProtimingGraphAverage:zoomtowidth( clamp(MakeAverage( tTotalJudgments ) * 1880,0,188) );
			c.ProtimingGraphCenter:visible( true );
			(function(self) self:sleep(2); self:linear(0.5); self:diffusealpha(0); end)(c.ProtimingGraphBG);
			(function(self) self:sleep(2); self:linear(0.5); self:diffusealpha(0); end)(c.ProtimingGraphUnderlay);
			(function(self) self:sleep(2); self:linear(0.5); self:diffusealpha(0); end)(c.ProtimingGraphWindowW3);
			(function(self) self:sleep(2); self:linear(0.5); self:diffusealpha(0); end)(c.ProtimingGraphWindowW2);
			(function(self) self:sleep(2); self:linear(0.5); self:diffusealpha(0); end)(c.ProtimingGraphWindowW1);
			(function(self) self:sleep(2); self:linear(0.5); self:diffusealpha(0); end)(c.ProtimingGraphFill);
			(function(self) self:sleep(2); self:linear(0.5); self:diffusealpha(0); end)(c.ProtimingGraphAverage);
			(function(self) self:sleep(2); self:linear(0.5); self:diffusealpha(0); end)(c.ProtimingGraphCenter);
		end
		
	end;

};
t[#t+1]=Def.ActorFrame {
		Name="PORSOSAD";
		SOFAILMessageCommand=function(self,param)
			if param.pn ~= player then return end;
            if self:GetParent():GetName() ~= "Judgment" and tonumber(ToEnumShortString(self:GetParent():GetName())) ~= 1 then return; end;
			self:decelerate(0.125):addy(-100):accelerate(0.5-0.125):addy(300)
		end;
	Def.Sprite{                    
		Name="SOSAD";
		InitCommand=function(self)
		self:pause();
		self:visible(false);
			if string.match(tostring(SCREENMAN:GetTopScreen()),"ScreenEdit") then
				self:Load(LoadModule("Options.JudgmentGetPath.lua")("Edit 2x6.png"));
			else
				self:Load(JudPath);
			end
		end;
		OnCommand=THEME:GetMetric("Judgment","JudgmentOnCommand");
		SOFAILMessageCommand=function(self,param)
			if param.pn ~= player then return end;
            if self:GetParent():GetParent():GetName() ~= "Judgment" and tonumber(ToEnumShortString(self:GetParent():GetParent():GetName())) ~= 1 then return; end;
			if param.cor ~= nil then
				self:Load(getThemeDir().."/BGAnimations/ScreenGameplay overlay/IQ/IQJud 1x7.png");
			else
				self:Load(JudPath);
			end
			if Op ~= "None" then self:setstate( param.fr ) end
			self:visible(true):linear(0.5):addx(math.random(-150,150)):diffusealpha(0):rotationz(math.random( -15, 15 )):zoom(2)
		end;
		ResetCommand=function(self) self:finishtweening(); self:stopeffect(); self:visible(false); end;
	};
	};

t[#t+1] = LoadActor( THEME:GetPathS("LifeMeterBattery","gain") ,true)..{
	Name = "WTF";
	JudgmentMessageCommand=function(self, param)
		if param.Cor ~= nil and param.Cor == true then
			self:playforplayer(player)
		end
	end;
};
t[#t+1] = LoadActor( THEME:GetPathS("LifeMeterBattery","lose") ,true)..{
	Name = "WTF2";
	JudgmentMessageCommand=function(self, param)
		if param.Cor ~= nil and param.Cor == false then
			self:playforplayer(player)
		end
	end;
};


return t;
