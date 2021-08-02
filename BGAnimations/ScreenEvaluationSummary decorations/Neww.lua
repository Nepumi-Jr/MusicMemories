local t = Def.ActorFrame{};
local AlDelay = 0.4;
local ISMISSION1 = false;
local ISMISSION2 = false;




local function GraphDisplay( pn )
	local t = Def.ActorFrame {
		Def.GraphDisplay {
			InitCommand=cmd(Load,"GraphDisplay";);
			OnCommand=cmd(x,-7.5;y,-25;zoomx,1.55);
			BeginCommand=function(self)
				local ss = SCREENMAN:GetTopScreen():GetStageStats();
				self:Set( ss, ss:GetPlayerStageStats(pn) );
				self:player( pn );
			end
		};
	};
	return t;
end

local pageNow = {
    P1 = 0,
    P2 = 0,
}
local pageCrt = STATSMAN:GetStagesPlayed() + 1

local inputHandler = function( event )

	if not event then return end

	if event.type == "InputEventType_FirstPress" then
		
		local DIR = "?"
		local PNn = 0

		if (event.button == "Left" or event.button == "DownLeft" or event.button == "MenuLeft") then
			DIR = "L"
		elseif (event.button == "Right" or event.button == "DownRight" or event.button == "MenuRight") then
			DIR = "R"
		end

		if event.PlayerNumber == PLAYER_1 then
			PNn = 1
		elseif event.PlayerNumber == PLAYER_2 then
			PNn = 2
		end

		if DIR ~= "?" and PNn ~= 0 and GAMESTATE:IsPlayerEnabled(event.PlayerNumber) then
			local thisPn = "P"..tostring(PNn)
            if DIR == 'L' then
                --printf("%d - 1 + %d mod %s id fucking %d", pageNow[thisPn], pageCrt, pageCrt, math.mod(pageNow[thisPn] - 1 + pageCrt, pageCrt))
                pageNow[thisPn] = math.mod(pageNow[thisPn] - 1 + pageCrt, pageCrt)
            elseif DIR == 'R' then
                --printf("%d + 1 + %d mod %s id fucking %d", pageNow[thisPn], pageCrt, pageCrt, math.mod(pageNow[thisPn] + 1 + pageCrt, pageCrt))
                pageNow[thisPn] = math.mod(pageNow[thisPn] + 1 , pageCrt)
            end

            MESSAGEMAN:Broadcast("reSelect",{DIR=DIR,PN=PNn})
		end

		-- if (event.button == "Start" or
		-- 	event.button == "Center") and GAMESTATE:IsPlayerEnabled(event.PlayerNumber) then 
		-- 	MESSAGEMAN:Broadcast("RIPmannnn")
		-- end
		
	end

end



local CorS;
if GAMESTATE:IsCourseMode() then
CorS = GAMESTATE:GetCurrentCourse();
else
CorS = GAMESTATE:GetCurrentSong();
end

local CX = SCREEN_CENTER_X;
local CY = SCREEN_CENTER_Y;

t[#t+1] = Def.ActorFrame{
	--BORDER Stuff
	Def.Quad{InitCommand=cmd(vertalign,bottom;CenterX;y,CY*1.87;zoomy,180;zoomx,7;);};
	Def.Quad{InitCommand=cmd(CenterX;y,CY*1.87-180;zoomx,CX*2;zoomy,7;);};
	Def.Quad{InitCommand=cmd(vertalign,bottom;x,CX-250/2;y,CY*1.87-180;zoomy,217.5;zoomx,7;);};
	Def.Quad{InitCommand=cmd(vertalign,bottom;x,CX+250/2;y,CY*1.87-180;zoomy,217.5;zoomx,7;);};
	
    Def.Quad{
        InitCommand=cmd(diffuse,GameColor.PlayerColors.PLAYER_2 or {0,0,1,1};horizalign,left;vertalign,top;y,1;zoomy,2;zoomx,SCREEN_RIGHT);
    };
    Def.Quad{
        InitCommand=cmd(diffuse,color("#333333");horizalign,left;vertalign,top;zoomy,50;y,3;zoomx,SCREEN_RIGHT);
    };
    Def.Quad{
        InitCommand=cmd(diffuse,GameColor.PlayerColors.PLAYER_2 or {0,0,1,1};horizalign,left;vertalign,top;y,53;zoomy,2;zoomx,SCREEN_RIGHT);
    };
    
    --Def.Quad{InitCommand=cmd(horizalign,right;x,CX-250/2;y,CY*1.87-180-100;zoomx,100+3.5;zoomy,7;);};
	--Def.Quad{InitCommand=cmd(horizalign,left;x,CX+250/2;y,CY*1.87-180-100;zoomx,100+3.5;zoomy,7;);};
	--Def.Quad{InitCommand=cmd(vertalign,bottom;x,CX-250/2-100;y,CY*1.87-180-100;zoomy,120-2;zoomx,7;);};
	--Def.Quad{InitCommand=cmd(vertalign,bottom;x,CX+250/2+100;y,CY*1.87-180-100;zoomy,120-2;zoomx,7;);};
};


t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(y,140);
    LoadFont("Common Normal").. {
        OnCommand=cmd(x,SCREEN_CENTER_X-110;horizalign,left;settext,"Total ");
    };
    LoadFont("Combo Number").. {
        OnCommand=cmd(x,SCREEN_CENTER_X;y,20;settext,STATSMAN:GetStagesPlayed();zoom,0.8;);
    };
    LoadFont("Common Normal").. {
        OnCommand=cmd(x,SCREEN_CENTER_X+110;y,30;horizalign,right;settext,"Stage(s)");
    };

    LoadFont("Common Normal").. {
        OnCommand=cmd(x,SCREEN_CENTER_X;y,115;settextf,"date : %d-%d-%d",Year(),MonthOfYear()+1,DayOfMonth());
    };



};

--[[t[#t+1] = Def.ActorFrame{
	Def.ActorFrame{
		LoadFont("Common Normal")..{
				InitCommand=cmd(x,SCREEN_CENTER_X-123;y,75;horizalign,right;zoom,1.1);
				OnCommand=function(self)
				self:settext("Life Diff.")
				end;
		};
		LoadFont("Common Normal")..{
				InitCommand=cmd(x,SCREEN_CENTER_X-123;y,100;horizalign,right;zoom,1);
				OnCommand=function(self)
				self:settextf("LV.%d",GetLifeDifficulty())
				end;
		};
		};

		Def.ActorFrame{
		LoadFont("Common Normal")..{
				InitCommand=cmd(x,SCREEN_CENTER_X-123;y,130;horizalign,right;zoom,1.1);
				OnCommand=function(self)
				self:settext("Time Diff.")
				end;
		};
		LoadFont("Common Normal")..{
				InitCommand=cmd(x,SCREEN_CENTER_X-123;y,155;horizalign,right);
				OnCommand=function(self)
				self:settextf("LV.%d",GetTimingDifficulty())
				end;
		};
	};
};]]

local stageStatus = {
    P1 = {
        W1 = 0,
        W2 = 0,
        W3 = 0,
        W4 = 0,
        W5 = 0,
        Miss = 0,
        score = 0,
        percent = 0,
    },
    P2 = {
        W1 = 0,
        W2 = 0,
        W3 = 0,
        W4 = 0,
        W5 = 0,
        Miss = 0,
        score = 0,
        percent = 0,
    }
};

local stageAnimate = {
    P1 = {
        W1 = 0,
        W2 = 0,
        W3 = 0,
        W4 = 0,
        W5 = 0,
        Miss = 0,
        score = 0,
        percent = 0,
    },
    P2 = {
        W1 = 0,
        W2 = 0,
        W3 = 0,
        W4 = 0,
        W5 = 0,
        Miss = 0,
        score = 0,
        percent = 0,
    }
};


t[#t+1] = Def.Quad{
    InitCommand=cmd(visible,false);
    OnCommand=function(self)
        local pageCrt = STATSMAN:GetStagesPlayed() + 1
        for ii,allPn in pairs({"P1","P2"}) do
            local constPn = allPn == "P1" and PLAYER_1 or PLAYER_2
            if GAMESTATE:IsPlayerEnabled(constPn) then 
                for i,v in pairs({"W1","W2","W3","W4","W5","Miss"}) do
                    stageStatus[allPn][v] = 0
                    for j = 1,(pageCrt-1) do
                        stageStatus[allPn][v] = 
                        stageStatus[allPn][v] + STATSMAN:GetPlayedStageStats(j):GetPlayerStageStats(constPn):GetTapNoteScores("TapNoteScore_"..v);
                    end
                end
                MESSAGEMAN:Broadcast("reSelect",{DIR="?",PN=(allPn == "P1" and 1 or 2)})
            end

            stageStatus[allPn]["score"] = 0
            stageStatus[allPn]["percent"] = 0
            for j = 1,(pageCrt-1) do
                stageStatus[allPn]["score"] = 
                stageStatus[allPn]["score"] + STATSMAN:GetPlayedStageStats(j):GetPlayerStageStats(constPn):GetScore();
                stageStatus[allPn]["percent"] = 
                stageStatus[allPn]["percent"] + STATSMAN:GetPlayedStageStats(j):GetPlayerStageStats(constPn):GetPercentDancePoints();
            end
            stageStatus[allPn]["percent"] = stageStatus[allPn]["percent"] / (pageCrt - 1)

        end
        SCREENMAN:GetTopScreen():AddInputCallback(inputHandler);
    end;
    reSelectMessageCommand=function(self, params)
        local thisPn = "P"..tostring(params["PN"])
        local constPn = thisPn == "P1" and PLAYER_1 or PLAYER_2
        local pageCrt = STATSMAN:GetStagesPlayed() + 1
        
        if params["DIR"] == "L" or params["DIR"] == "R" then
            if pageNow[thisPn] == 0 then
                for i,v in pairs({"W1","W2","W3","W4","W5","Miss"}) do
                    stageStatus[thisPn][v] = 0
                    for j = 1,(pageCrt-1) do
                        stageStatus[thisPn][v] = 
                        stageStatus[thisPn][v] + STATSMAN:GetPlayedStageStats(j):GetPlayerStageStats(constPn):GetTapNoteScores("TapNoteScore_"..v);
                    end
                end
                stageStatus[thisPn]["score"] = 0
                stageStatus[thisPn]["percent"] = 0
                for j = 1,(pageCrt-1) do
                    stageStatus[thisPn]["score"] = 
                    stageStatus[thisPn]["score"] + STATSMAN:GetPlayedStageStats(j):GetPlayerStageStats(constPn):GetScore();
                    stageStatus[thisPn]["percent"] = 
                    stageStatus[thisPn]["percent"] + STATSMAN:GetPlayedStageStats(j):GetPlayerStageStats(constPn):GetPercentDancePoints();
                end
                stageStatus[thisPn]["percent"] = stageStatus[thisPn]["percent"] / (pageCrt - 1)
                
            else
                for i,v in pairs({"W1","W2","W3","W4","W5","Miss"}) do
                    stageStatus[thisPn][v] = STATSMAN:GetPlayedStageStats(pageCrt-pageNow[thisPn]):GetPlayerStageStats(constPn):GetTapNoteScores("TapNoteScore_"..v)
                end
                stageStatus[thisPn]["score"] = STATSMAN:GetPlayedStageStats(pageCrt-pageNow[thisPn]):GetPlayerStageStats(constPn):GetScore();
                stageStatus[thisPn]["percent"] = STATSMAN:GetPlayedStageStats(pageCrt-pageNow[thisPn]):GetPlayerStageStats(constPn):GetPercentDancePoints();
            end
        end
        --printf("%d", STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(thisPn == "P1" and PLAYER_1 or PLAYER_2):GetTapNoteScores("TapNoteScore_W1"))
        --printf("%d - %d",pageNow[thisPn],STATSMAN:GetPlayedStageStats(pageNow[thisPn]):GetPlayerStageStats(constPn):GetTapNoteScores("TapNoteScore_W1"))

    end;
};

local function createStageStatus(pplayer)
    local x = Def.ActorFrame{};
    for i,v in pairs({"W1","W2","W3","W4","W5","Miss"}) do
        x[#x+1] = Def.ActorFrame{
            OnCommand = cmd(diffusealpha,0;x,pplayer == "P1" and -70 or 70;sleep,1-(6-i)*0.05;decelerate,0.25;x,0;diffusealpha,1);
            LoadFont("Common Normal")..{
                InitCommand=cmd(y,i*22);
                OnCommand=function(self)
                    self:settext("0000")
                    self:shadowlength(1)
                    self:diffuse(GameColor.Judgment["JudgmentLine_"..v]);
                    self:playcommand("reloadNum")
                end;
                reloadNumCommand=function(self)
                    local nowNum = stageAnimate[pplayer][v]
                    if math.abs(stageStatus[pplayer][v] - nowNum) >= 0.5 then
                        local newNum = nowNum + (stageStatus[pplayer][v] - nowNum) * 0.2
                        
                        self:settextf("%04d",round(newNum));
                        stageAnimate[pplayer][v] = newNum
                    end
                    self:AddAttribute(0,{Length = math.max(3-math.floor(math.log10(round(math.max(nowNum,1)))),0); Diffuse = ColorDarkTone(GameColor.Judgment["JudgmentLine_"..v])})
                    self:sleep(1/30):queuecommand("reloadNum")
                end;
            };
        };
    end
    return x;
end;


--[[
████████████████████████████
███████     █████  █████████
███████  █  ████   █████████
███████     █████  █████████
███████  ████████  █████████
███████  ████████  █████████
███████  ██████      ███████
████████████████████████████
]]

local SS1;
SS1 = {
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W1'),
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W2'),
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W3'),
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W4'),
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W5'),
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_Miss'),
0
};


local Op1 = TP[ToEnumShortString(PLAYER_1)].ActiveModifiers.JudgmentGraphic;
local jud1 = LoadModule("Options.JudgmentGetPath.lua")(Op1);
local frame1 = true;
local nameP1 = PROFILEMAN:GetProfile(PLAYER_1):GetDisplayName();
local StepText1 = "";
local Step1;
local StepSt1;

local function stepText(step)
    return THEME:GetString("CustomDifficulty",ToEnumShortString(step:GetDifficulty())).." : "..step:GetMeter()
end

if GAMESTATE:IsCourseMode() then
    StepSt1 = GAMESTATE:GetCurrentTrail(PLAYER_1);
else
	StepSt1 = GAMESTATE:GetCurrentSteps(PLAYER_1);
end

StepText1 = THEME:GetString("CustomDifficulty",ToEnumShortString(StepSt1:GetDifficulty())).." : "..StepSt1:GetMeter()


SS1[7] = SS1[1]+SS1[2]+SS1[3]+SS1[4]+SS1[5]+SS1[6];
t[#t+1] = Def.ActorFrame{
Condition = GAMESTATE:IsPlayerEnabled(PLAYER_1);


Def.ActorFrame{
	InitCommand=cmd(x,-440;y,-5);
    Def.Sprite{
		InitCommand=cmd(x,500;y,110;zoom,0.35;shadowlength,3); OnCommand=function(self) self:pause();self:Load( jud1 );
		if self:GetNumStates() == 12 then frame1 = true else frame1 = false end
		if frame1 then
			self:setstate(0*1) else
			self:setstate(0) end end; 
	};
    Def.Sprite{
		InitCommand=cmd(x,500;y,110+22*1;zoom,0.35;shadowlength,3); OnCommand=function(self) self:pause();self:Load( jud1 );
		if self:GetNumStates() == 12 then frame1 = true else frame1 = false end
		if frame1 then
			self:setstate(1*2) else
			self:setstate(1) end end; 
	};
    Def.Sprite{
		InitCommand=cmd(x,500;y,110+22*2;zoom,0.35;shadowlength,3); OnCommand=function(self) self:pause();self:Load( jud1 );
		if self:GetNumStates() == 12 then frame1 = true else frame1 = false end
		if frame1 then
			self:setstate(2*2) else
			self:setstate(2) end end; 
	};
    Def.Sprite{
		InitCommand=cmd(x,500;y,110+22*3;zoom,0.35;shadowlength,3); OnCommand=function(self) self:pause();self:Load( jud1 );
		if self:GetNumStates() == 12 then frame1 = true else frame1 = false end
		if frame1 then
			self:setstate(3*2) else
			self:setstate(3) end end; 
	};
    Def.Sprite{
		InitCommand=cmd(x,500;y,110+22*4;zoom,0.35;shadowlength,3); OnCommand=function(self) self:pause();self:Load( jud1 );
		if self:GetNumStates() == 12 then frame1 = true else frame1 = false end
		if frame1 then
			self:setstate(4*2) else
			self:setstate(4) end end; 
	};
    Def.Sprite{
		InitCommand=cmd(x,500;y,110+22*5;zoom,0.35;shadowlength,3); OnCommand=function(self) self:pause();self:Load( jud1 );
		if self:GetNumStates() == 12 then frame1 = true else frame1 = false end
		if frame1 then
			self:setstate(5*2) else
			self:setstate(5) end end; 
	};
};

    Def.ActorFrame {
        OnCommand=cmd(x,131;y,88);
        createStageStatus("P1")
    };
	
    Def.Sprite{
        OnCommand=function(self)
            self:Load(THEME:GetPathG("GradeDisplayEval","TierWut"));
            self:xy(230, 160)--SCREEN_CENTER_X + 200
            self:zoom(1.3)
        end;
        reSelectMessageCommand=function(self,param)
            if param.PN==1 then
                self:stoptweening():decelerate(0.15):y(170):diffusealpha(0):queuecommand("changingGrade")
            end
        end;
        changingGradeCommand=function(self)
            local thisPn = "P1"
            if pageNow[thisPn] == 0 then
                self:Load(THEME:GetPathG("GradeDisplayEval","TierWut"));
            else
                local thisGrade = STATSMAN:GetPlayedStageStats(pageCrt-pageNow[thisPn]):GetPlayerStageStats(PLAYER_1):GetGrade()
                self:Load(THEME:GetPathG("GradeDisplayEval",ToEnumShortString(thisGrade)));
            end
            self:decelerate(0.15):y(160):diffusealpha(1) 
        end;
    };

LoadActor("ICON/"..(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetStageAward() or "lose")..".png")..{
    Condition=(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetStageAward() ~= nil);
    InitCommand=cmd(x,205;y,SCREEN_CENTER_Y-23;zoom,0.5;shadowlength,2);
    OnCommand=cmd(diffusealpha,0;zoom,3;rotationz,-60;sleep,2;decelerate,0.5;zoom,0.5;rotationz,0;diffusealpha,1);
};
LoadActor("ICON/"..(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPeakComboAward() or "lose")..".png")..{
    Condition=(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPeakComboAward() ~= nil);
    InitCommand=cmd(x,250;y,SCREEN_CENTER_Y-23;zoom,0.5;shadowlength,2);
    OnCommand=cmd(diffusealpha,0;zoom,3;rotationz,-60;sleep,2;decelerate,0.5;zoom,0.5;rotationz,0;diffusealpha,1);
};

    LoadFont("Common Normal")..{
		InitCommand=cmd(xy,230, 110+22*6+5);
		-- x = SCREEN_CENTER_X + 200
        OnCommand=function(self)
			self:playcommand("reloadScore");
		end;
		reloadScoreCommand=function(self)
            local thisPn = "P1"
            local newScore = stageStatus[thisPn]["score"]
            local nowScoring = stageAnimate[thisPn]["score"]
            nowScoring = nowScoring + ((newScore - nowScoring) * 0.5);
            if math.abs((newScore - nowScoring) * 0.5) >= 0.01 then
                local digits = math.floor(math.log10(nowScoring))
                local thatString = string.format( "%09d",round(nowScoring))
                for i = string.len(thatString) + 1 - 3, 2,-3 do
                    thatString = string.sub(thatString,1,i-1)..','..string.sub(thatString,i,string.len(thatString))
                end

                self:diffuse({1,1,1,1}):diffusetopedge(ColorLightTone({1,1,1,1}));
                self:settext(thatString)
                
                if digits <= 9 then
                    self:AddAttribute(0,{Length = 10-digits - math.floor(digits/3); Diffuse = ColorDarkTone({1,1,1,1});})
                end
            elseif newScore == 0 then
                self:AddAttribute(0,{Length = 10; Diffuse = ColorDarkTone({1,1,1,1});})
                self:diffuse({1,1,1,1}):diffusetopedge(ColorLightTone({1,1,1,1}));
                self:settext("000,000,000")
            end
            stageAnimate[thisPn]["score"] = nowScoring
            self:sleep(1/30):queuecommand("reloadScore")
		end;
		GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,-100;);
	};

    LoadFont("Common Normal")..{
        InitCommand=cmd(xy,100, 110+22*6+5);
        --x = 110+22*6+5
        OnCommand=function(self)
            self:settext("00.00%")
            self:shadowlength(1)
            self:diffuse(PlayerColor(PLAYER_1))
            self:strokecolor(ColorDarkTone(PlayerColor(PLAYER_1)))
            self:playcommand("reloadNum")
        end;
        reloadNumCommand=function(self)
            local thisPn = "P1"
            local nowNum = stageAnimate[thisPn]["percent"]
            if math.abs(stageStatus[thisPn]["percent"] - nowNum) >= 0.005 then
                local newNum = nowNum + (stageStatus[thisPn]["percent"] - nowNum) * 0.2
                
                self:settextf("%.2f%%",newNum*100);
                stageAnimate[thisPn]["percent"] = newNum
            end
            self:sleep(1/30):queuecommand("reloadNum")
        end;
    };

};



--[[
████████████████████████████
███████     ████     ███████
███████  █  ████████ ███████
███████     ████     ███████
███████  ███████ ███████████
███████  ███████ ███████████
███████  ███████     ███████
████████████████████████████
]]

if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
local SS2;
SS2 = {
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores('TapNoteScore_W1'),
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores('TapNoteScore_W2'),
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores('TapNoteScore_W3'),
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores('TapNoteScore_W4'),
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores('TapNoteScore_W5'),
STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores('TapNoteScore_Miss'),
0
};

local Op2 = TP[ToEnumShortString(PLAYER_2)].ActiveModifiers.JudgmentGraphic;
local jud2 = LoadModule("Options.JudgmentGetPath.lua")(Op2);
local frame2 = true;
local GradeforP2 = "MemoriesHD 4x2.png"--in 589
local nameP2 = PROFILEMAN:GetProfile(PLAYER_2):GetDisplayName();
if MonthOfYear() == 10-1 and DayOfMonth() == 31 then
	GradeforP2 = "Horror 4x2.png"
end

local StepText2 = "";
local Step2;
local StepSt2;

if GAMESTATE:IsCourseMode() then
    StepSt2 = GAMESTATE:GetCurrentTrail(PLAYER_2);
else
	StepSt2 = GAMESTATE:GetCurrentSteps(PLAYER_2);
end

StepText2 = THEME:GetString("CustomDifficulty",ToEnumShortString(StepSt2:GetDifficulty())).." : "..StepSt2:GetMeter()


SS2[7] = SS2[1]+SS2[2]+SS2[3]+SS2[4]+SS2[5]+SS2[6];

t[#t+1] = Def.ActorFrame{
Def.ActorFrame{
	OnCommand=cmd(x,220+70;y,-5-197.5);
Def.Sprite{
		InitCommand=cmd(x,500;y,110+197.5;zoom,0.35;shadowlength,3); OnCommand=function(self) self:pause();self:Load(jud2);
		if self:GetNumStates() == 12 then frame2 = true else frame2 = false end
		if frame2 then
			self:setstate(0*1) else
			self:setstate(0) end end; 
	};
Def.Sprite{
		InitCommand=cmd(x,500;y,110+22*1+197.5;zoom,0.35;shadowlength,3); OnCommand=function(self) self:pause();self:Load(jud2);
		if self:GetNumStates() == 12 then frame2 = true else frame2 = false end
		if frame2 then
			self:setstate(1*2) else
			self:setstate(1) end end; 
	};
Def.Sprite{
		InitCommand=cmd(x,500;y,110+22*2+197.5;zoom,0.35;shadowlength,3); OnCommand=function(self) self:pause();self:Load(jud2);
		if self:GetNumStates() == 12 then frame2 = true else frame2 = false end
		if frame2 then
			self:setstate(2*2) else
			self:setstate(2) end end; 
	};
Def.Sprite{
		InitCommand=cmd(x,500;y,110+22*3+197.5;zoom,0.35;shadowlength,3); OnCommand=function(self) self:pause();self:Load(jud2);
		if self:GetNumStates() == 12 then frame2 = true else frame2 = false end
		if frame2 then
			self:setstate(3*2) else
			self:setstate(3) end end; 
	};
Def.Sprite{
		InitCommand=cmd(x,500;y,110+22*4+197.5;zoom,0.35;shadowlength,3); OnCommand=function(self) self:pause();self:Load(jud2);
		if self:GetNumStates() == 12 then frame2 = true else frame2 = false end
		if frame2 then
			self:setstate(4*2) else
			self:setstate(4) end end; 
	};
Def.Sprite{
		InitCommand=cmd(x,500;y,110+22*5+197.5;zoom,0.35;shadowlength,3); OnCommand=function(self) self:pause();self:Load(jud2);
		if self:GetNumStates() == 12 then frame2 = true else frame2 = false end
		if frame2 then
			self:setstate(5*2) else
			self:setstate(5) end end; 
	};
};	

    Def.ActorFrame {
        OnCommand=cmd(x,SCREEN_RIGHT-135;y,88);
        createStageStatus("P2")
    };

        Def.Sprite{
        OnCommand=function(self)
            self:Load(THEME:GetPathG("GradeDisplayEval","TierWut"));
            self:xy(SCREEN_CENTER_X + 200, 160)
            self:zoom(1.3)
        end;
        reSelectMessageCommand=function(self,param)
            if param.PN==2 then
                self:stoptweening():decelerate(0.15):y(170):diffusealpha(0):queuecommand("changingGrade")
            end
        end;
        changingGradeCommand=function(self)
            local thisPn = "P2"
            if pageNow[thisPn] == 0 then
                self:Load(THEME:GetPathG("GradeDisplayEval","TierWut"));
            else
                local thisGrade = STATSMAN:GetPlayedStageStats(pageCrt-pageNow[thisPn]):GetPlayerStageStats(PLAYER_2):GetGrade()
                self:Load(THEME:GetPathG("GradeDisplayEval",ToEnumShortString(thisGrade)));
            end
            self:decelerate(0.15):y(160):diffusealpha(1) 
        end;
    };


LoadActor("ICON/"..(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetStageAward() or "lose")..".png")..{
    Condition=(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetStageAward() ~= nil);
    InitCommand=cmd(x,SCREEN_CENTER_X + 175;y,SCREEN_CENTER_Y-23;zoom,0.5;shadowlength,2);
    OnCommand=cmd(diffusealpha,0;zoom,3;rotationz,-60;sleep,2;decelerate,0.5;zoom,0.5;rotationz,0;diffusealpha,1);
};
LoadActor("ICON/"..(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPeakComboAward() or "lose")..".png")..{
    Condition=(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPeakComboAward() ~= nil);
    InitCommand=cmd(x,SCREEN_CENTER_X + 175 + 45;y,SCREEN_CENTER_Y-23;zoom,0.5;shadowlength,2);
    OnCommand=cmd(diffusealpha,0;zoom,3;rotationz,-60;sleep,2;decelerate,0.5;zoom,0.5;rotationz,0;diffusealpha,1);
};

    LoadFont("Common Normal")..{
		InitCommand=cmd(xy,SCREEN_CENTER_X + 200, 110+22*6+5);
        OnCommand=function(self)
			self:playcommand("reloadScore");
		end;
		reloadScoreCommand=function(self)
            local thisPn = "P2"
            local newScore = stageStatus[thisPn]["score"]
            local nowScoring = stageAnimate[thisPn]["score"]
            nowScoring = nowScoring + ((newScore - nowScoring) * 0.5);
            if math.abs((newScore - nowScoring) * 0.5) >= 0.01 then
                local digits = math.floor(math.log10(nowScoring))
                local thatString = string.format( "%09d",round(nowScoring))
                for i = string.len(thatString) + 1 - 3, 2,-3 do
                    thatString = string.sub(thatString,1,i-1)..','..string.sub(thatString,i,string.len(thatString))
                end

                self:diffuse({1,1,1,1}):diffusetopedge(ColorLightTone({1,1,1,1}));
                self:settext(thatString)
                
                if digits <= 9 then
                    self:AddAttribute(0,{Length = 10-digits - math.floor(digits/3); Diffuse = ColorDarkTone({1,1,1,1});})
                end
            elseif newScore == 0 then
                self:AddAttribute(0,{Length = 10; Diffuse = ColorDarkTone({1,1,1,1});})
                self:diffuse({1,1,1,1}):diffusetopedge(ColorLightTone({1,1,1,1}));
                self:settext("000,000,000")
            end
            stageAnimate[thisPn]["score"] = nowScoring
            self:sleep(1/30):queuecommand("reloadScore")
		end;
		GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,-100;);
	};

    LoadFont("Common Normal")..{
        InitCommand=cmd(xy,SCREEN_CENTER_X + 350, 110+22*6+5);
        OnCommand=function(self)
            self:settext("00.00%")
            self:shadowlength(1)
            self:diffuse(PlayerColor(PLAYER_2))
            self:strokecolor(ColorDarkTone(PlayerColor(PLAYER_2)))
            self:playcommand("reloadNum")
        end;
        reloadNumCommand=function(self)
            local thisPn = "P2"
            local nowNum = stageAnimate[thisPn]["percent"]
            if math.abs(stageStatus[thisPn]["percent"] - nowNum) >= 0.005 then
                local newNum = nowNum + (stageStatus[thisPn]["percent"] - nowNum) * 0.2
                
                self:settextf("%.2f%%",newNum*100);
                stageAnimate[thisPn]["percent"] = newNum
            end
            self:sleep(1/30):queuecommand("reloadNum")
        end;
    };


};

end;

	
--[[
█████ All ██████
]]
    

for i,v in pairs({PLAYER_1,PLAYER_2}) do
    local x = Def.ActorFrame {};
    for xi = pageCrt-1,1,-1 do
        x[#x+1]=Def.ActorFrame{
            Condition = GAMESTATE:IsPlayerEnabled(v);
            OnCommand=cmd(y,-35+(pageCrt - xi - 1)*30);
            Def.ActorFrame{
                LoadFont("Common Normal")..{
                    OnCommand=cmd(zoom,0.95;x,-200+15;settextf,"S%d ",pageCrt - xi;);
                };
                LoadFont("Combo Number")..{
                    InitCommand=cmd(zoom,0.27;x,-60;horizalign,right;settextf,"%d",STATSMAN:GetPlayedStageStats(xi):GetPlayerStageStats(v):GetScore());
                    OnCommand=cmd(playcommand,"onLoop");
                    onLoopCommand=cmd(sleep,5;decelerate,0.5;cropleft,1;sleep,5;decelerate,0.5;cropleft,0;sleep,0.02;queuecommand,"onLoop");
                };
                LoadFont("Combo Number")..{
                    InitCommand=cmd(zoom,0.27;x,-150;horizalign,left;settextf,"%.02f%%",STATSMAN:GetPlayedStageStats(xi):GetPlayerStageStats(v):GetPercentDancePoints()*100;cropright,1);
                    OnCommand=cmd(playcommand,"onLoop");
                    onLoopCommand=cmd(sleep,5;decelerate,0.5;cropright,0;sleep,5;decelerate,0.5;cropright,1;sleep,0.02;queuecommand,"onLoop");
                };
                
                LoadFont("Common Normal")..{
                    OnCommand=cmd(zoom,0.75;x,13;settextf,"MC:%d",math.min(STATSMAN:GetPlayedStageStats(xi):GetPlayerStageStats(v):MaxCombo(),99999));
                };
            };
            Def.Sprite{
                OnCommand=cmd(x,-36;y,-2;Load,THEME:GetPathG("GradeDisplayEval",ToEnumShortString(STATSMAN:GetPlayedStageStats(xi):GetPlayerStageStats(v):GetGrade()));zoom,0.3);
            };
            LoadActor("ICON/"..(STATSMAN:GetPlayedStageStats(xi):GetPlayerStageStats(v):GetStageAward() or "Lose")..".png")..{
                OnCommand=cmd(zoom,0.3;x,70);
            };
            LoadActor("ICON/"..(STATSMAN:GetPlayedStageStats(xi):GetPlayerStageStats(v):GetPeakComboAward() or "Lose")..".png")..{
                OnCommand=cmd(zoom,0.3;x,95);
            };
            Def.Quad{
                InitCommand=cmd(x,110;horizalign,left;zoomx,100;zoomy,25;faderight,0.3;fadeleft,0.3;diffuse,GameColor.Difficulty[STATSMAN:GetPlayedStageStats(xi):GetPlayerStageStats(v):GetPlayedSteps()[1]:GetDifficulty()]);
            };
            LoadFont("Common Normal")..{
                InitCommand=cmd(x,160;zoom,0.6;shadowlength,1);
                OnCommand=cmd(settext,stepText(STATSMAN:GetPlayedStageStats(xi):GetPlayerStageStats(v):GetPlayedSteps()[1]););
            };
        };
    end
    t[#t+1]=Def.ActorFrame{
        InitCommand=cmd(diffusealpha,0);
        OnCommand = cmd(x, SCREEN_CENTER_X*0.806-133 + (i==2 and SCREEN_CENTER_X+5 or 0);y,SCREEN_CENTER_Y*0.616+212);
        reSelectMessageCommand=function(self,param)	
            if param.PN == i then
                if pageNow["P"..tostring(i)] == 0 then
                    self:stoptweening():decelerate(0.2):diffusealpha(1) 
                else
                    self:stoptweening():decelerate(0.2):diffusealpha(0) 
                end
            end 
        end;
        Def.Quad{
            OnCommand=cmd(diffuse,{0.2,0.2,0.2,0.1};diffusealpha,0.9;zoomx,494*680/794;zoomy,170*263/256);
        };
        -- Def.Quad{
        --     OnCommand=cmd(diffuse,ColorMidTone(PlayerColor(v));diffusealpha,0.9;zoomx,494*680/794;zoomy,170*263/256);
        -- };
        LoadFont("Common Large") .. {
            Text = Screen.String("HeaderText");
            OnCommand=cmd(horizalign,left;x,-200;y,-70;zoom,0.25;shadowlength,1);
        };
        x;
    };

    for iPage = 1,pageCrt -1 do
        t[#t+1]=Def.ActorFrame{
            Condition = GAMESTATE:IsPlayerEnabled(v);
            InitCommand=cmd(diffusealpha,0);
            OnCommand = cmd(x, SCREEN_CENTER_X*0.806-133 + (i==2 and SCREEN_CENTER_X+5 or 0);y,SCREEN_CENTER_Y*0.616+212);
            reSelectMessageCommand=function(self,param)	
                if param.PN==i then
                    if pageNow["P"..tostring(i)] == iPage then
                        self:stoptweening():decelerate(0.2):diffusealpha(1) 
                    else
                        self:stoptweening():decelerate(0.2):diffusealpha(0) 
                    end
                end 
            end;
            Def.Quad{
                OnCommand=cmd(diffuse,ColorDarkTone(PlayerColor(v));diffusealpha,0.9;zoomx,494*680/794;zoomy,170*263/256);
            };
            LoadFont("Common Large") .. {
                Text = "Stage "..tostring(iPage);
                OnCommand=cmd(horizalign,left;x,-200;y,-70;zoom,0.25;shadowlength,1);
            };
            Def.Quad{
                InitCommand=cmd(x,212;y,-60;horizalign,right;zoomx,100;zoomy,25;fadeleft,0.7;diffuse,GameColor.Difficulty[STATSMAN:GetPlayedStageStats(iPage):GetPlayerStageStats(v):GetPlayedSteps()[1]:GetDifficulty()]);
            };
            LoadFont("Common Normal")..{
                InitCommand=cmd(x,200;y,-60;horizalign,right;zoom,0.6;shadowlength,1);
                OnCommand=cmd(settext,stepText(STATSMAN:GetPlayedStageStats(iPage):GetPlayerStageStats(v):GetPlayedSteps()[1]););
            };
            Def.Sprite{
            OnCommand=function(self)
                self:xy(-100,-10)
                local thisSong = STATSMAN:GetPlayedStageStats(pageCrt - iPage):GetPlayedSongs()[1]
                if thisSong:HasBanner() then
                    self:Load(thisSong:GetBannerPath())
                else
                    self:Load(THEMEDIR().."/Graphics/Common fallback banner.png")
                end
                self:zoomtoheight(60):zoomtowidth(150)
                end;
            };
            Def.Quad{
                OnCommand=cmd(xy,-100,-40;zoomy,4;zoomx,154);
            };
            Def.Quad{
                OnCommand=cmd(xy,-100,20;zoomy,4;zoomx,154);
            };
            Def.Quad{
                OnCommand=cmd(xy,-175,-10;zoomy,60;zoomx,4);
            };
            Def.Quad{
                OnCommand=cmd(xy,-25,-10;zoomy,60;zoomx,4);
            };
            LoadFont("Common Normal")..{
				InitCommand=cmd(x,-15;y,-20;horizalign,left;maxwidth,220);
				OnCommand=function(self) 
				local thisSong = STATSMAN:GetPlayedStageStats(pageCrt - iPage):GetPlayedSongs()[1];	
					local text = thisSong:GetDisplayMainTitle()
					self:settext(text)
				end;
			};
            LoadFont("Common Normal")..{
				InitCommand=cmd(x,-15;y,-5;horizalign,left;vertalign,top;maxwidth,220;zoom,0.7);
				OnCommand=function(self) 
                    local thisSong = STATSMAN:GetPlayedStageStats(pageCrt - iPage):GetPlayedSongs()[1];	
                    local text = ""
                    if thisSong:GetDisplaySubTitle() and thisSong:GetDisplaySubTitle() ~= "" then
                        text = thisSong:GetDisplaySubTitle().."\n"
                    end
                    if thisSong:GetDisplayArtist() then
                        text = text .. thisSong:GetDisplayArtist()
                    end
                    self:settext(text)
				end;
			};

            LoadFont("Combo Number")..{
				InitCommand=cmd(x,190;y,50;horizalign,right;skewx,-0.1;vertalign,top;maxwidth,250;zoom,0.7);
				OnCommand=function(self) 
                    local thisSong = STATSMAN:GetPlayedStageStats(pageCrt - iPage):GetPlayedSongs()[1];	
                    local lenTime = thisSong:GetLastSecond()
                    self:settext(SecondsToMMSSMsMs(lenTime))
                    if thisSong:IsMarathon() then
                        self:diffuse({1,1,1,1}):diffusebottomedge(Color("Magenta"))
                    elseif thisSong:IsLong() then
                        self:diffuse({1,1,1,1}):diffusebottomedge(Color("Red"))
                    else
                        self:diffuse({1,1,1,1})
                    end
                end;
			};
            LoadFont("Common Normal")..{
                Text = "BPM";
                InitCommand=cmd(horizalign,left;x,-175;y,40);
            };
            LoadFont("Combo Number")..{
				InitCommand=cmd(horizalign,left;x,-175;y,60;skewx,-0.1;vertalign,top;maxwidth,250;zoom,0.5);
				OnCommand=function(self) 
                    local thisSong = STATSMAN:GetPlayedStageStats(pageCrt - iPage):GetPlayedSongs()[1];	
                    local bpm = thisSong:GetDisplayBpms()
                    if bpm[1] == bpm[2] then
                        self:settextf("%d",bpm[1])
                    else
                        self:settextf("%d-%d",bpm[1], bpm[2])
                    end
                    
				end;
			};
        };
    end
    
end

return t;