local t = Def.ActorFrame{};
local AlDelay = 0.4;
local ISMISSION1 = false;
local ISMISSION2 = false;

--SM("\n\n\n\n\n\n\n\n\n"..tostring(ISMISSION2));



if not GAMESTATE:IsCourseMode() then
	local path=GAMESTATE:GetCurrentSong():GetSongDir();
	if path then
		if FILEMAN:DoesFileExist(path.."MissionTag.lua") and false then
			--LoadActor(path.."MissionTag");

			if GAMESTATE:IsPlayerEnabled(PLAYER_1) and PnMissionState(PLAYER_1,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)) ~= "NotMission" then
				ISMISSION1 = true;
			end
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) and PnMissionState(PLAYER_2,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)) ~= "NotMission" then
				ISMISSION2 = true;
			end
		end
	end
end

local function GraphDisplay( pn )
	local t = Def.ActorFrame {
		Def.GraphDisplay {
			InitCommand=function(self) self:Load("GraphDisplay"); end;
			OnCommand=function(self) self:x(-7.5); self:y(-25); self:zoomx(1.55); end;
			BeginCommand=function(self)
				local ss = SCREENMAN:GetTopScreen():GetStageStats();
				self:Set( ss, ss:GetPlayerStageStats(pn) );
				self:player( pn );
			end
		};
	};
	return t;
end





local CorS;
if GAMESTATE:IsCourseMode() then
CorS = GAMESTATE:GetCurrentCourse();
else
CorS = GAMESTATE:GetCurrentSong();
end

local CX = SCREEN_CENTER_X;
local CY = SCREEN_CENTER_Y

t[#t+1] = Def.ActorFrame{
	--BORDER Stuff
	Def.Quad{InitCommand=function(self) self:vertalign(bottom); self:CenterX(); self:y(CY*1.87); self:zoomy(180); self:zoomx(7); end;};
	Def.Quad{InitCommand=function(self) self:CenterX(); self:y(CY*1.87-180); self:zoomx(CX*2); self:zoomy(7); end;};
	Def.Quad{InitCommand=function(self) self:vertalign(bottom); self:x(CX-250/2); self:y(CY*1.87-180); self:zoomy(217.5); self:zoomx(7); end;};
	Def.Quad{InitCommand=function(self) self:vertalign(bottom); self:x(CX+250/2); self:y(CY*1.87-180); self:zoomy(217.5); self:zoomx(7); end;};
	
    Def.Quad{
        InitCommand=function(self) self:diffuse(GameColor.PlayerColors.PLAYER_2 or {0,0,1,1}); self:horizalign(left); self:vertalign(top); self:y(1); self:zoomy(2); self:zoomx(SCREEN_RIGHT); end;
    };
    Def.Quad{
        InitCommand=function(self) self:diffuse(color("#333333")); self:horizalign(left); self:vertalign(top); self:zoomy(50); self:y(3); self:zoomx(SCREEN_RIGHT); end;
    };
    Def.Quad{
        InitCommand=function(self) self:diffuse(GameColor.PlayerColors.PLAYER_2 or {0,0,1,1}); self:horizalign(left); self:vertalign(top); self:y(53); self:zoomy(2); self:zoomx(SCREEN_RIGHT); end;
    };
    
    --Def.Quad{InitCommand=function(self) self:horizalign(right); self:x(CX-250/2); self:y(CY*1.87-180-100); self:zoomx(100+3.5); self:zoomy(7); end;};
	--Def.Quad{InitCommand=function(self) self:horizalign(left); self:x(CX+250/2); self:y(CY*1.87-180-100); self:zoomx(100+3.5); self:zoomy(7); end;};
	--Def.Quad{InitCommand=function(self) self:vertalign(bottom); self:x(CX-250/2-100); self:y(CY*1.87-180-100); self:zoomy(120-2); self:zoomx(7); end;};
	--Def.Quad{InitCommand=function(self) self:vertalign(bottom); self:x(CX+250/2+100); self:y(CY*1.87-180-100); self:zoomy(120-2); self:zoomx(7); end;};
};


t[#t+1] = Def.ActorFrame{
	InitCommand=function(self) self:zoom(0.9); self:x(SCREEN_CENTER_X); self:y(110); end;
--Song Banner
Def.Quad{
InitCommand=function(self) self:x(-250/2-3.5); self:zoom(7); self:zoomy(103); end;
};
Def.Quad{
InitCommand=function(self) self:x(250/2+3.5); self:zoom(7); self:zoomy(103); self:shadowlength(3); end;
};
Def.Quad{
InitCommand=function(self) self:y(90/2+3.5); self:zoom(7); self:zoomx(263); self:shadowlength(3); end;
};
Def.Quad{
InitCommand=function(self) self:y(-90/2-3.5); self:zoom(7); self:zoomx(263); end;
};
Def.Sprite{
OnCommand=function(self)
	
if GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():HasBanner() then
self:Load(GAMESTATE:GetCurrentCourse():GetBannerPath())
elseif GAMESTATE:GetCurrentSong():HasBanner() then
self:Load(GAMESTATE:GetCurrentSong():GetBannerPath())
else
self:Load(getThemeDir().."/Graphics/Common fallback banner.png")
end
self:zoomtoheight(90):zoomtowidth(250)
end;
};



};
if GAMESTATE:IsCourseMode() then
t[#t+1] = LoadActor("InfoCourse.lua")
else
t[#t+1] = LoadActor("InfoSong.lua")
end

t[#t+1] = Def.ActorFrame{
	Def.ActorFrame{
        LoadFont("Common Large")..{
            InitCommand=function(self) self:x(SCREEN_RIGHT-10); self:y(12); self:horizalign(right); self:zoom(0.35); end;
            OnCommand=function(self)
                local TName,Length = LoadModule("Options.SmartTapNoteScore.lua")()
                TName = LoadModule("Utils.SortTiming.lua")(TName)
                self:settext(LoadModule("Options.ReturnCurrentTiming.lua")().Name):skewx(-0.2)
                self:diffusebottomedge(
                    JudgmentLineToColor(TName[1])
                )
            end;
		};
		LoadFont("Common Normal")..{
            InitCommand=function(self) self:x(SCREEN_RIGHT-10); self:y(45); self:horizalign(right); self:zoom(0.6); end;
            OnCommand=function(self)
                self:settextf("Life LV : %d      Timing LV : %d",GetLifeDifficulty(), GetTimingDifficulty())
            end;
		};
    };
};

local tapScoreName,Length = LoadModule("Options.SmartTapNoteScore.lua")()
tapScoreName = LoadModule("Utils.SortTiming.lua")(tapScoreName)
tapScoreName[#tapScoreName + 1] = "Miss"



local Players = GAMESTATE:GetHumanPlayers();

for iterPn in ivalues(Players) do

    local thisPn = iterPn;
    local Op1 = TP[ToEnumShortString(thisPn)].ActiveModifiers.JudgmentGraphic;
    local jud1 = LoadModule("Options.JudgmentGetPath.lua")(Op1);
    local frame1 = true;
    local StepText1 = "";
    local StepSt1;
    local curPNStateStat = STATSMAN:GetCurStageStats():GetPlayerStageStats(thisPn)

    if GAMESTATE:IsCourseMode() then
        StepSt1 = GAMESTATE:GetCurrentTrail(thisPn);
    else
        StepSt1 = GAMESTATE:GetCurrentSteps(thisPn);
    end

    StepText1 = LoadModule("TextDisplay.Difficulty.lua")(StepSt1)

    t[#t+1] = Def.ActorFrame{
        Condition = GAMESTATE:IsPlayerEnabled(thisPn);
        Def.ActorFrame{
            OnCommand=function(self) self:x(thisPn == PLAYER_1 and 0 or SCREEN_CENTER_X+3); self:y(SCREEN_BOTTOM-31); end;
            --? from outfox
            Def.GraphDisplay{
                InitCommand=function(self) self:vertalign(bottom):horizalign(left):y(-15) end;
                OnCommand=function(self)
                    self:Load("GraphDisplay"..ToEnumShortString(thisPn))
                    local playerStageStats = STATSMAN:GetCurStageStats():GetPlayerStageStats(thisPn)
                    local stageStats = STATSMAN:GetCurStageStats()
                    self:Set(stageStats, playerStageStats)
                    local Line = self:GetChild("Line")
                    
                    Line:visible(false)
                end;
            };
            Def.ComboGraph{
                InitCommand=function(self) self:vertalign(bottom):horizalign(left) end;
                OnCommand=function(self)
                    self:Load("ComboGraph"..ToEnumShortString(thisPn))
                    local playerStageStats = STATSMAN:GetCurStageStats():GetPlayerStageStats(thisPn)
                    local stageStats = STATSMAN:GetCurStageStats()
                    self:Set(stageStats, playerStageStats)
                end;
            };
        };
        Def.ActorMultiVertex{
            InitCommand=function(self)
                
                self:horizalign(left)
                self:x(thisPn == PLAYER_1 and -0.5 or 554.5):y(SCREEN_CENTER_Y+20.5);
                self:SetDrawState{Mode="DrawMode_Quads"}
            end;
            OnCommand=function(self)
                local Vers = {}
                local width = 298
                local height = 5
                local lastX = 0
                local isDoom = true
                for i,v in pairs(tapScoreName) do
                    local val = curPNStateStat:GetTapNoteScores("TapNoteScore_"..v)
                    if v == LoadModule("Options.BestJudge.lua")() then--For Pump
                        val = val + curPNStateStat:GetTapNoteScores("TapNoteScore_CheckpointHit")
                    elseif v == "Miss" then--For Pump
                        val = val + curPNStateStat:GetTapNoteScores("TapNoteScore_CheckpointMiss")
                    end

                    if val > 0 then
                        isDoom = false
                        break
                    end
                end
                
                if not isDoom then
                    for i,v in pairs(tapScoreName) do
                        local val = curPNStateStat:GetPercentageOfTaps("TapNoteScore_"..v)
                        if v == LoadModule("Options.BestJudge.lua")() then--For Pump
                            val = val + curPNStateStat:GetPercentageOfTaps("TapNoteScore_CheckpointHit")
                        elseif v == "Miss" then--For Pump
                            val = val + curPNStateStat:GetPercentageOfTaps("TapNoteScore_CheckpointMiss")
                        end
                        local nextX = lastX + val * width
                        local thisColor = JudgmentLineToColor(v)
                        table.insert(Vers,{{nextX,height,0},thisColor})
                        table.insert(Vers,{{nextX,-height,0},thisColor})
                        table.insert(Vers,{{lastX,-height,0},thisColor})
                        table.insert(Vers,{{lastX,height,0},thisColor})
                        lastX = nextX;
                    end
                end
                self:SetNumVertices(#Vers):SetVertices( Vers )
            end;
        };	
        
        Def.Quad{
            InitCommand=function(self) self:x(thisPn == PLAYER_1 and 0 or SCREEN_RIGHT); self:y(SCREEN_CENTER_Y*0.3); self:horizalign(thisPn == PLAYER_1 and left or right); self:zoomx(170); self:zoomy(25); self:faderight(thisPn == PLAYER_1 and 1 or 0); self:fadeleft(thisPn == PLAYER_2 and 1 or 0); self:diffuse(GameColor.Difficulty[StepSt1:GetDifficulty()]); end;
        };
        LoadFont("Common Normal")..{
            InitCommand=function(self) self:x(thisPn == PLAYER_1 and 10 or SCREEN_RIGHT - 10); self:y(SCREEN_CENTER_Y*0.3); self:horizalign(thisPn == PLAYER_1 and left or right); self:zoom(1); self:shadowlength(2); end;
            OnCommand=function(self) self:settext(StepText1); end;
        };
        Def.Sprite{
            Condition=LoadModule("Eva.CustomStageAward.lua")(thisPn) ~= "Nope";
            InitCommand=function(self) self:x(thisPn == PLAYER_1 and 205 or 595); self:y(SCREEN_CENTER_Y-30); self:zoom(0.4); self:shadowlength(2); end;
            OnCommand=function(self) self:Load(THEME:GetPathG("StageAward", ToEnumShortString(LoadModule("Eva.CustomStageAward.lua")(thisPn)))); self:diffusealpha(0); self:zoom(3); self:rotationz(-60); self:sleep(2); self:decelerate(0.5); self:zoom(0.2); self:rotationz(0); self:diffusealpha(1); end;
        };
        Def.Sprite{
            Condition=(curPNStateStat:GetPeakComboAward() ~= nil);
            InitCommand=function(self) self:x(thisPn == PLAYER_1 and 250 or 640); self:y(SCREEN_CENTER_Y-30); self:zoom(0.4); self:shadowlength(2); end;
            OnCommand=function(self) 
                local peak = ToEnumShortString(curPNStateStat:GetPeakComboAward())
                if peak == "10000" then peak = "10k" end
                self:Load(THEME:GetPathG("PeakCombo", peak)); 
                self:diffusealpha(0); self:zoom(3); self:rotationz(-60); self:sleep(2); self:decelerate(0.5); self:zoom(0.3); self:rotationz(0); self:diffusealpha(1); 
            end;
        };
        LoadFont("Common Normal")..{
            InitCommand=function(self) self:x(thisPn == PLAYER_1 and 100 or (SCREEN_CENTER_X + 330)); self:y(243); self:zoom(1);  end;
            OnCommand=function(self) 
                local percent = STATSMAN:GetCurStageStats():GetPlayerStageStats(thisPn):GetPercentDancePoints()
                self:settext(FormatPercentScore(percent))
                self:shadowlength(0.5):addx(thisPn == PLAYER_1 and -70 or 70):diffusealpha(0):sleep(1.3):decelerate(0.25):addx(thisPn == PLAYER_1 and 70 or -70):diffusealpha(1)
            end;
        };
        LoadFont("Common Normal")..{
            InitCommand=function(self)
                self:settext("Sample Text"):zoom(0.6):shadowlength(1)
                self:x(thisPn == PLAYER_1 and 230 or SCREEN_RIGHT - 230):y(SCREEN_CENTER_Y-145)
            end;
            OnCommand=function(self)
                local PRInd = curPNStateStat:GetPersonalHighScoreIndex()
                self:visible(PRInd ~= -1);
                local text = string.format(THEME:GetString("ScreenEvaluation", "PersonalRecord"), PRInd+1)
                self:settext(text):diffusealpha(0):sleep(2):decelerate(0.3):diffusealpha(1)
            end;
        };
        LoadFont("Common Normal")..{
            InitCommand=function(self)
                self:settext("Sample Text"):zoom(0.6):shadowlength(1)
                self:x(thisPn == PLAYER_1 and 230 or SCREEN_RIGHT - 230):y(SCREEN_CENTER_Y-160)
            end;
            OnCommand=function(self)
                local MRInd = curPNStateStat:GetMachineHighScoreIndex()
                self:visible(MRInd ~= -1);
                local text = string.format(THEME:GetString("ScreenEvaluation", "MachineRecord"), MRInd+1)
                self:settext(text):diffusealpha(0):sleep(2):decelerate(0.3):diffusealpha(1)
            end;
        };
    };
    for i,v in pairs(tapScoreName) do
        t[#t+1] = Def.ActorFrame{
            InitCommand=function(self) self:x(thisPn == PLAYER_1 and 200 or 800); self:y(85 + 22*i*math.min(6/#tapScoreName,1)); end;
            Def.Sprite{
                InitCommand=function(self) self:x(thisPn == PLAYER_1 and -140 or 0); self:zoom(0.35*math.min(6/#tapScoreName,1)); self:shadowlength(3); end; 
                OnCommand=function(self) self:pause();self:Load( jud1 );
                    local miniFileName = string.match(jud1, ".*/(.*)")
                    frame1 = string.find(miniFileName, "%[double%]")

                    if self:GetNumStates() == #tapScoreName * 2 or string.find(miniFileName, "2x%d") ~= nil then
                        frame1 = true
                    end
                        if v == "Miss" then
                            self:setstate(self:GetNumStates() - 1) 
                        elseif frame1 then
                            self:setstate((i-1)*2) 
                        else
                            self:setstate((i-1)) 
                        end 
                    end; 
            };
            Def.ActorFrame{
                OnCommand=function(self) self:addx(-70 * (thisPn == PLAYER_1 and 1 or -1)); self:diffusealpha(0); self:sleep(0.7+i*0.06*math.min(6/#tapScoreName,1)); self:decelerate(0.25); self:addx(70 * (thisPn == PLAYER_1 and 1 or -1)); self:diffusealpha(1); end;
                LoadFont("Combo Number")..{
                    Text  = "6969";
                    InitCommand=function(self) self:x(-63); self:y(3); self:zoom(0.3*math.min(6/#tapScoreName,1)); self:shadowlength(1); end;
                    OnCommand=function(self)
                        local nowNum = curPNStateStat:GetTapNoteScores("TapNoteScore_"..v)
                        if IsGame("pump") then
                            if v == LoadModule("Options.BestJudge.lua")() then--For Pump
                                nowNum = nowNum + curPNStateStat:GetTapNoteScores("TapNoteScore_CheckpointHit")
                            elseif v == "Miss" then--For Pump
                                nowNum = nowNum + curPNStateStat:GetTapNoteScores("TapNoteScore_CheckpointMiss")
                            end
                        end
                        local thisCl  = JudgmentLineToColor(v)
                        self:diffuse(thisCl)
                        self:settextf("%04d",nowNum);
                        self:AddAttribute(0,{Length = math.max(3-math.floor(math.log10(round(math.max(nowNum,1)))),0); Diffuse = ColorDarkTone(thisCl)})
                    end; 
                };
            };
        };
    end

end;



function KodPercent(p)
if p < 10 then
return string.format("0%.2f",p).."%";
elseif p >= 10 and p < 100 then
return string.format("%.2f",p).."%";
elseif p == 100 then
return "100%!!";
end
end

local ScP1 = 0;
local ScP2 = 0;

--! another dead code 
if TP.Battle.IsBattle then 
if TP.Battle.Mode == "Ac" then
t[#t+1] = Def.ActorFrame{
LoadFont("_differentiator 60px")..{
	InitCommand=function(self) self:x(SCREEN_CENTER_X*0.5); self:y(SCREEN_CENTER_Y*1.45); self:settext(KodPercent(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()*100)); self:zoom(0); self:rainbowscroll(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints() > STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()); end;
	OnCommand=function(self) self:sleep(TFO(TP.Battle.Hidden,3,1.5)); self:decelerate(0.5); self:zoom(0.75); end
};
LoadFont("_differentiator 60px")..{
	InitCommand=function(self) self:x(SCREEN_CENTER_X*1.5); self:y(SCREEN_CENTER_Y*1.45); self:settext(KodPercent(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()*100)); self:zoom(0); self:rainbowscroll(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints() < STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()); end;
	OnCommand=function(self) self:sleep(TFO(TP.Battle.Hidden,3,1.5)); self:decelerate(0.5); self:zoom(0.75); end
};
};
elseif TP.Battle.IsBattle and TP.Battle.Mode == "Dr" then
t[#t+1] = Def.ActorFrame{
LoadFont("_differentiator 60px")..{
	InitCommand=function(self) self:x(SCREEN_CENTER_X*0.5); self:y(SCREEN_CENTER_Y*1.45); self:settext(TFO(TP.Battle.Info[#TP.Battle.Info][4]==1 and TP.Battle.Info[#TP.Battle.Info][5][2] > 1,"Survive!",TFO(TP.Battle.Info[#TP.Battle.Info][5][1] > 1,SecondsToMMSSMsMs(TP.Battle.Info[#TP.Battle.Info][5][2]),TFO(TP.Battle.IsfailorIsDraw,"Draw!",KodPercent(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()*100))))); self:zoom(0); self:rainbowscroll((TP.Battle.Info[#TP.Battle.Info][4]==1)); end;
	OnCommand=function(self) self:sleep(TFO(TP.Battle.Hidden,3,1.5)); self:decelerate(0.5); self:zoom(0.95); end;
};
--SM("\n\n\n\n\nISLA : "..tostring( TP.Battle.Info[#TP.Battle.Info][5][2]));
LoadFont("_differentiator 60px")..{
	InitCommand=function(self) self:x(SCREEN_CENTER_X*1.5); self:y(SCREEN_CENTER_Y*1.45); self:settext(TFO(TP.Battle.Info[#TP.Battle.Info][4]==2 and TP.Battle.Info[#TP.Battle.Info][5][1] > 1,"Survive!",TFO(TP.Battle.Info[#TP.Battle.Info][5][2] > 1,SecondsToMMSSMsMs(TP.Battle.Info[#TP.Battle.Info][5][2]),TFO(TP.Battle.IsfailorIsDraw,"Draw!",KodPercent(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()*100))))); self:zoom(0); self:rainbowscroll((TP.Battle.Info[#TP.Battle.Info][4]==2)); end;
	OnCommand=function(self) self:sleep(TFO(TP.Battle.Hidden,3,1.5)); self:decelerate(0.5); self:zoom(0.95); end;
};
};
end
t[#t+1] = Def.ActorFrame{
LoadFont("_differentiator 60px")..{
	InitCommand=function(self)
	for i = 1,#TP.Battle.Info do
	if TP.Battle.Info[i][4] == 1 then
	ScP1 = ScP1 + 1
	elseif TP.Battle.Info[i][4] == 2 then
	ScP2 = ScP2 + 1
	end
	end
	self:settext(ScP1):x(250)
	:y(CY-50):zoom(0)
	:rainbowscroll(TP.Battle.Info[#TP.Battle.Info][4]==1)
	end;
	OnCommand=function(self) self:sleep(TFO(TP.Battle.Hidden,3,1.5)); self:decelerate(0.5); self:zoom(0.8); end;
};
LoadFont("_differentiator 60px")..{
	InitCommand=function(self)
	self:settext(ScP2):x(CX+(CX-250))
	:y(CY-50):zoom(0)
	:rainbowscroll(TP.Battle.Info[#TP.Battle.Info][4]==2)
	end;
	OnCommand=function(self) self:sleep(TFO(TP.Battle.Hidden,3,1.5)); self:decelerate(0.5); self:zoom(0.8); end;
};
};
end

return t;