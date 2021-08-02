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
	OnCommand=cmd(draworder,5000);
};

local function getSubJudge()
    local thisSubJudge = TP[ToEnumShortString(player)].ActiveModifiers.SubJudge
    if thisSubJudge ~= "None" then
        --printf("%s",thisSubJudge)
        return LoadModule("SubJudgment."..thisSubJudge..".lua")(player)..{
            InitCommand=cmd(x,40;y,40);
        };
    else
        return Def.ActorFrame{};
    end
end

t[#t+1] = Def.ActorFrame {
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
		ResetCommand=cmd(finishtweening;stopeffect;visible,false);
	};
	

	LoadActor(Woosh,true)..{
		Name="FAIL";
		OnCommand=cmd();
	};
    getSubJudge();


	LoadFont("_roboto Bold 54px") .. {
		Name="ProtimingDisplay";
		Text="";
		InitCommand=cmd(visible,false);
		OnCommand=THEME:GetMetric("Protiming","ProtimingOnCommand");
		ResetCommand=cmd(finishtweening;stopeffect;visible,false);
	};
	LoadFont("_open sans semibold 24px") .. {
		Name="ProtimingAverage";
		Text="";
		InitCommand=cmd(visible,false);
		OnCommand=THEME:GetMetric("Protiming","AverageOnCommand");
		ResetCommand=cmd(finishtweening;stopeffect;visible,false);
	};
	LoadFont("_open sans semibold 24px") .. {
		Name="TextDisplay";
		Text=THEME:GetString("Protiming","MS");
		InitCommand=cmd(visible,false);
		OnCommand=THEME:GetMetric("Protiming","TextOnCommand");
		ResetCommand=cmd(finishtweening;stopeffect;visible,false);
	};
	Def.Quad {
		Name="ProtimingGraphBG";
		InitCommand=cmd(visible,false;y,32;zoomto,ProtimingWidth,16);
		ResetCommand=cmd(finishtweening;diffusealpha,0.8;visible,false);
		OnCommand=cmd(diffuse,Color("Black");diffusetopedge,color("0.1,0.1,0.1,1");diffusealpha,0.8;shadowlength,2;);
	};
	Def.Quad {
		Name="ProtimingGraphWindowW3";
		InitCommand=cmd(visible,false;y,32;zoomto,ProtimingWidth-4,16-4);
		ResetCommand=cmd(finishtweening;diffusealpha,1;visible,false);
		OnCommand=cmd(diffuse,GameColor.Judgment["JudgmentLine_W3"];);
	};
	Def.Quad {
		Name="ProtimingGraphWindowW2";
		InitCommand=cmd(visible,false;y,32;zoomto,scale(PREFSMAN:GetPreference("TimingWindowSecondsW2"),0,PREFSMAN:GetPreference("TimingWindowSecondsW3"),0,ProtimingWidth-4),16-4);
		ResetCommand=cmd(finishtweening;diffusealpha,1;visible,false);
		OnCommand=cmd(diffuse,GameColor.Judgment["JudgmentLine_W2"];);
	};
	Def.Quad {
		Name="ProtimingGraphWindowW1";
		InitCommand=cmd(visible,false;y,32;zoomto,scale(PREFSMAN:GetPreference("TimingWindowSecondsW1"),0,PREFSMAN:GetPreference("TimingWindowSecondsW3"),0,ProtimingWidth-4),16-4);
		ResetCommand=cmd(finishtweening;diffusealpha,1;visible,false);
		OnCommand=cmd(diffuse,GameColor.Judgment["JudgmentLine_W1"];);
	};
	Def.Quad {
		Name="ProtimingGraphUnderlay";
		InitCommand=cmd(visible,false;y,32;zoomto,ProtimingWidth-4,16-4);
		ResetCommand=cmd(finishtweening;diffusealpha,0.25;visible,false);
		OnCommand=cmd(diffuse,Color("Black");diffusealpha,0.25);
	};
	Def.Quad {
		Name="ProtimingGraphFill";
		InitCommand=cmd(visible,false;y,32;zoomto,0,16-4;horizalign,left;);
		ResetCommand=cmd(finishtweening;diffusealpha,1;visible,false);
		OnCommand=cmd(diffuse,Color("Red"););
	};
	Def.Quad {
		Name="ProtimingGraphAverage";
		InitCommand=cmd(visible,false;y,32;zoomto,2,7;);
		ResetCommand=cmd(finishtweening;diffusealpha,0.85;visible,false);
		OnCommand=cmd(diffuse,Color("Orange");diffusealpha,0.85);
	};
	Def.Quad {
		Name="ProtimingGraphCenter";
		InitCommand=cmd(visible,false;y,32;zoomto,2,16-4;);
		ResetCommand=cmd(finishtweening;diffusealpha,1;visible,false);
		OnCommand=cmd(diffuse,Color("White");diffusealpha,1);
	};

	InitCommand = function(self)
		c = self:GetChildren();
		SS = 0 ;

        local miniFileName = JudPath;

        miniFileName = string.match(miniFileName, ".*/(.*)")
        isDouble = string.find(miniFileName, "%[double%]")

        if c.Judgment:GetNumStates() == #TName * 2 or string.find(miniFileName, "2x%d") ~= nil then
            isDouble = true
        end

	end;

	JudgmentMessageCommand=function(self, param)
        -- Fix Player Combo animating when player successfully avoids a mine.
        
		local tempTNS = param.TapNoteScore;
        local iFrame = -1;

		if tempTNS== "TapNoteScore_CheckpointHit" then
			tempTNS = "TapNoteScore_"..bestJudge;
		elseif tempTNS== "TapNoteScore_CheckpointMiss" then
			tempTNS = "TapNoteScore_Miss";
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
			c.Judgment:Load(THEMEDIR().."/BGAnimations/ScreenGameplay overlay/IQ/IQJud 1x7.png");
			PTAM=true;
		elseif PTAM then
			PTAM=false;
			if string.match(tostring(SCREENMAN:GetTopScreen()),"ScreenEdit") then
				c.Judgment:Load(LoadModule("Options.JudgmentGetPath.lua")("Edit 2x6.png"));
			else
				c.Judgment:Load(JudPath);
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
            iFrame = c.Judgment:GetNumStates() - 1
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

		if Op ~= "None" or Op ~= "SM5ProTiming" then c.Judgment:setstate( iFrame ); end

		if param.Cor ~= nil then
			if not param.Cor then
				c.Judgment:setstate( 7-1 );
			end
		end

		if ((tempTNS == 'TapNoteScore_Miss'  or tempTNS == 'TapNoteScore_W5' or tempTNS == 'TapNoteScore_W4')
		or param.HoldNoteScore == "HoldNoteScore_LetGo")
		and SS == 0 then
		SS = 9999;
		c.FAIL:play()
		MESSAGEMAN:Broadcast("SOFAIL", {pn=param.Player,fr=iFrame,cor=param.Cor})
		c.Judgment:visible(false);
		else
		c.Judgment:visible(true);
		end
		
		if Op ~= "SM5ProTiming" then
			if tempTNS ~= 'TapNoteScore_Miss' then
				if param.Early then
					UseJudgeCmd[ToEnumShortString(tempTNS).."EarlyCommand"](c.Judgment);
				else
					UseJudgeCmd[ToEnumShortString(tempTNS).."LateCommand"](c.Judgment);
				end
				muan = false;
			else
				if muan then
					UseJudgeCmd[ToEnumShortString(tempTNS).."EarlyCommand"](c.Judgment);
					muan = false
				else
					UseJudgeCmd[ToEnumShortString(tempTNS).."LateCommand"](c.Judgment);
					muan = true
				end
			end

			c.Judgment:visible( true );
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
			c.Judgment:visible( false );
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
			(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphBG);
			(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphUnderlay);
			(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphWindowW3);
			(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphWindowW2);
			(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphWindowW1);
			(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphFill);
			(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphAverage);
			(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphCenter);
		end
		
	end;

};
t[#t+1]=Def.ActorFrame {
		Name="PORSOSAD";
		SOFAILMessageCommand=function(self,param)
			if param.pn ~= player then return end;
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
			if param.cor ~= nil then
				self:Load(THEMEDIR().."/BGAnimations/ScreenGameplay overlay/IQ/IQJud 1x7.png");
			else
				self:Load(JudPath);
			end
			if Op ~= "None" then self:setstate( param.fr ) end
			self:visible(true):linear(0.5):addx(math.random(-150,150)):diffusealpha(0):rotationz(math.random( -15, 15 )):zoom(2)
		end;
		ResetCommand=cmd(finishtweening;stopeffect;visible,false);
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
