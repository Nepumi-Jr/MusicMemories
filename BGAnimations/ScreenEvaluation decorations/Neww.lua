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
	InitCommand=cmd(zoom,0.9;x,SCREEN_CENTER_X;y,110);
--Song Banner
Def.Quad{
InitCommand=cmd(x,-250/2-3.5;zoom,7;zoomy,103;);
};
Def.Quad{
InitCommand=cmd(x,250/2+3.5;zoom,7;zoomy,103;shadowlength,3;);
};
Def.Quad{
InitCommand=cmd(y,90/2+3.5;zoom,7;zoomx,263;shadowlength,3;);
};
Def.Quad{
InitCommand=cmd(y,-90/2-3.5;zoom,7;zoomx,263;);
};
Def.Sprite{
OnCommand=function(self)
	
if GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():HasBanner() then
self:Load(GAMESTATE:GetCurrentCourse():GetBannerPath())
elseif GAMESTATE:GetCurrentSong():HasBanner() then
self:Load(GAMESTATE:GetCurrentSong():GetBannerPath())
else
self:Load(THEMEDIR().."/Graphics/Common fallback banner.png")
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
            InitCommand=cmd(x,SCREEN_RIGHT-10;y,12;horizalign,right;zoom,0.35);
            OnCommand=function(self)
                local TName,Length = LoadModule("Options.SmartTapNoteScore.lua")()
                TName = LoadModule("Utils.SortTiming.lua")(TName)
                self:settext(LoadModule("Options.ReturnCurrentTiming.lua")().Name):skewx(-0.2)
                self:diffusebottomedge(
                    LoadModule("Color.Judgment.lua")(TName[1])
                )
            end;
		};
		LoadFont("Common Normal")..{
            InitCommand=cmd(x,SCREEN_RIGHT-10;y,45;horizalign,right;zoom,0.6);
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
            OnCommand=cmd(x,thisPn == PLAYER_1 and -297 or 138;y,210;zoomx,677/794;zoomy,255/256);
                StandardDecorationFromTable( "GraphDisplay" .. ToEnumShortString(thisPn), GraphDisplay(thisPn) );
                --StandardDecorationFromTable( "ComboGraph" .. ToEnumShortString(thisPn));
                Def.ActorMultiVertex{
                    InitCommand=function(self)
                        self:xy(SCREEN_CENTER_X*0.806,SCREEN_CENTER_Y*0.616)
                        self:SetDrawState{Mode="DrawMode_Quads"}
                    end;
                    OnCommand=function(self)
                        local Vers = {}
                        local mxX = 496
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
                        
                        if isDoom then
                            if thisPn == PLAYER_1 then
                                table.insert(Vers,{{mxX,85,0},PlayerColor(PLAYER_2)})
                                table.insert(Vers,{{mxX,-85,0},{1,1,1,0}})
                                table.insert(Vers,{{0,-85,0},{1,1,1,0}})
                                table.insert(Vers,{{0,85,0},PlayerColor(PLAYER_1)})
                            else
                                table.insert(Vers,{{mxX,85,0},PlayerColor(PLAYER_1)})
                                table.insert(Vers,{{mxX,-85,0},{1,1,1,0}})
                                table.insert(Vers,{{0,-85,0},{1,1,1,0}})
                                table.insert(Vers,{{0,85,0},PlayerColor(PLAYER_2)})
                            end
                        else
                            for i,v in pairs(tapScoreName) do
                                local val = curPNStateStat:GetPercentageOfTaps("TapNoteScore_"..v)
                                if v == LoadModule("Options.BestJudge.lua")() then--For Pump
                                    val = val + curPNStateStat:GetPercentageOfTaps("TapNoteScore_CheckpointHit")
                                elseif v == "Miss" then--For Pump
                                    val = val + curPNStateStat:GetPercentageOfTaps("TapNoteScore_CheckpointMiss")
                                end
                                local nextX = lastX + val * mxX
                                local thisColor = LoadModule("Color.Judgment.lua")(v)
                                table.insert(Vers,{{nextX,85,0},thisColor})
                                table.insert(Vers,{{nextX,-85,0},{1,1,1,0}})
                                table.insert(Vers,{{lastX,-85,0},{1,1,1,0}})
                                table.insert(Vers,{{lastX,85,0},thisColor})
                                lastX = nextX;
                            end
                        end
                        self:SetNumVertices(#Vers):SetVertices( Vers )
                    end;
                };	
        };
        Def.Quad{
            InitCommand=cmd(x,thisPn == PLAYER_1 and 0 or SCREEN_RIGHT;y,SCREEN_CENTER_Y*0.3;horizalign,thisPn == PLAYER_1 and left or right;zoomx,170;zoomy,25;faderight,thisPn == PLAYER_1 and 1 or 0;fadeleft,thisPn == PLAYER_2 and 1 or 0;diffuse,GameColor.Difficulty[StepSt1:GetDifficulty()]);
        };
        LoadFont("Common Normal")..{
            InitCommand=cmd(x,thisPn == PLAYER_1 and 10 or SCREEN_RIGHT - 10;y,SCREEN_CENTER_Y*0.3;horizalign,thisPn == PLAYER_1 and left or right;zoom,1;shadowlength,2);
            OnCommand=cmd(settext,StepText1;);
        };
        Def.Sprite{
            Condition=LoadModule("Eva.CustomStageAward.lua")(thisPn) ~= "Nope";
            InitCommand=cmd(x,thisPn == PLAYER_1 and 205 or 595;y,SCREEN_CENTER_Y-23;zoom,0.4;shadowlength,2);
            OnCommand=cmd(Load,THEME:GetPathG("StageAward", ToEnumShortString(LoadModule("Eva.CustomStageAward.lua")(thisPn)));diffusealpha,0;zoom,3;rotationz,-60;sleep,2;decelerate,0.5;zoom,0.2;rotationz,0;diffusealpha,1);
        };
        Def.Sprite{
            Condition=(curPNStateStat:GetPeakComboAward() ~= nil);
            InitCommand=cmd(x,thisPn == PLAYER_1 and 250 or 640;y,SCREEN_CENTER_Y-23;zoom,0.4;shadowlength,2);
            OnCommand=cmd(Load,THEME:GetPathG("PeakCombo", ToEnumShortString(curPNStateStat:GetPeakComboAward()));diffusealpha,0;zoom,3;rotationz,-60;sleep,2;decelerate,0.5;zoom,0.3;rotationz,0;diffusealpha,1);
        };
        LoadFont("Common Normal")..{
            InitCommand=function(self)
                self:settext("Sample Text"):zoom(0.6):shadowlength(1)
                self:x(thisPn == PLAYER_1 and 230 or SCREEN_RIGHT - 230):y(SCREEN_CENTER_Y-130)
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
                self:x(thisPn == PLAYER_1 and 230 or SCREEN_RIGHT - 230):y(SCREEN_CENTER_Y-145)
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
            InitCommand=cmd(x,thisPn == PLAYER_1 and 200 or 800;y,85 + 22*i*math.min(6/#tapScoreName,1););
            Def.Sprite{
                InitCommand=cmd(x,thisPn == PLAYER_1 and -140 or 0;zoom,0.35*math.min(6/#tapScoreName,1);shadowlength,3); 
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
                OnCommand=cmd(addx,-70 * (thisPn == PLAYER_1 and 1 or -1);diffusealpha,0;sleep,0.7+i*0.06*math.min(6/#tapScoreName,1);decelerate,0.25;addx,70 * (thisPn == PLAYER_1 and 1 or -1);diffusealpha,1);
                LoadFont("Combo Number")..{
                    Text  = "6969";
                    InitCommand=cmd(x,-63;y,3;zoom,0.3*math.min(6/#tapScoreName,1);shadowlength,1);
                    OnCommand=function(self)
                        local nowNum = curPNStateStat:GetTapNoteScores("TapNoteScore_"..v)
                        if v == LoadModule("Options.BestJudge.lua")() then--For Pump
                            nowNum = nowNum + curPNStateStat:GetTapNoteScores("TapNoteScore_CheckpointHit")
                        elseif v == "Miss" then--For Pump
                            nowNum = nowNum + curPNStateStat:GetTapNoteScores("TapNoteScore_CheckpointMiss")
                        end
                        local thisCl  = LoadModule("Color.Judgment.lua")(v)
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

if TP.Battle.IsBattle then 
if TP.Battle.Mode == "Ac" then
t[#t+1] = Def.ActorFrame{
LoadFont("_differentiator 60px")..{
	InitCommand=cmd(x,SCREEN_CENTER_X*0.5;y,SCREEN_CENTER_Y*1.45;settext,KodPercent(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()*100);zoom,0;rainbowscroll,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints() > STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints());
	OnCommand=cmd(sleep,TFO(TP.Battle.Hidden,3,1.5);decelerate,0.5;zoom,0.75)
};
LoadFont("_differentiator 60px")..{
	InitCommand=cmd(x,SCREEN_CENTER_X*1.5;y,SCREEN_CENTER_Y*1.45;settext,KodPercent(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()*100);zoom,0;rainbowscroll,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints() < STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints());
	OnCommand=cmd(sleep,TFO(TP.Battle.Hidden,3,1.5);decelerate,0.5;zoom,0.75)
};
};
elseif TP.Battle.IsBattle and TP.Battle.Mode == "Dr" then
t[#t+1] = Def.ActorFrame{
LoadFont("_differentiator 60px")..{
	InitCommand=cmd(x,SCREEN_CENTER_X*0.5;y,SCREEN_CENTER_Y*1.45;settext,TFO(TP.Battle.Info[#TP.Battle.Info][4]==1 and TP.Battle.Info[#TP.Battle.Info][5][2] > 1,"Survive!",TFO(TP.Battle.Info[#TP.Battle.Info][5][1] > 1,SecondsToMMSSMsMs(TP.Battle.Info[#TP.Battle.Info][5][2]),TFO(TP.Battle.IsfailorIsDraw,"Draw!",KodPercent(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()*100))));zoom,0;rainbowscroll,(TP.Battle.Info[#TP.Battle.Info][4]==1));
	OnCommand=cmd(sleep,TFO(TP.Battle.Hidden,3,1.5);decelerate,0.5;zoom,0.95);
};
--SM("\n\n\n\n\nISLA : "..tostring( TP.Battle.Info[#TP.Battle.Info][5][2]));
LoadFont("_differentiator 60px")..{
	InitCommand=cmd(x,SCREEN_CENTER_X*1.5;y,SCREEN_CENTER_Y*1.45;settext,TFO(TP.Battle.Info[#TP.Battle.Info][4]==2 and TP.Battle.Info[#TP.Battle.Info][5][1] > 1,"Survive!",TFO(TP.Battle.Info[#TP.Battle.Info][5][2] > 1,SecondsToMMSSMsMs(TP.Battle.Info[#TP.Battle.Info][5][2]),TFO(TP.Battle.IsfailorIsDraw,"Draw!",KodPercent(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()*100))));zoom,0;rainbowscroll,(TP.Battle.Info[#TP.Battle.Info][4]==2));
	OnCommand=cmd(sleep,TFO(TP.Battle.Hidden,3,1.5);decelerate,0.5;zoom,0.95);
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
	OnCommand=cmd(sleep,TFO(TP.Battle.Hidden,3,1.5);decelerate,0.5;zoom,0.8);
};
LoadFont("_differentiator 60px")..{
	InitCommand=function(self)
	self:settext(ScP2):x(CX+(CX-250))
	:y(CY-50):zoom(0)
	:rainbowscroll(TP.Battle.Info[#TP.Battle.Info][4]==2)
	end;
	OnCommand=cmd(sleep,TFO(TP.Battle.Hidden,3,1.5);decelerate,0.5;zoom,0.8);
};
};
end

return t;