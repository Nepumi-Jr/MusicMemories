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
local jud1 = GetPicJudPath(Op1);
local frame1 = true;
local nameP1 = PROFILEMAN:GetProfile(PLAYER_1):GetDisplayName();
local StepText1 = "";
local Step1;
local StepSt1;


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
		OnCommand=cmd(x,-297;y,210;zoomx,680/794;zoomy,263/256);
			StandardDecorationFromTable( "GraphDisplay" .. ToEnumShortString(PLAYER_1), GraphDisplay(PLAYER_1) );
            --StandardDecorationFromTable( "ComboGraph" .. ToEnumShortString(PLAYER_1));
			--BG
			Def.ActorFrame{
			Def.ActorFrame{
			InitCommand=cmd(diffusealpha,0.7);
			Condition=SS1[7] ~= 0;
			OnCommand=cmd(x,SCREEN_CENTER_X*0.806;y,SCREEN_CENTER_Y*0.616;zoomy,170);
			Def.Quad{
			OnCommand=function(self)
			self:fadetop(0)
			self:horizalign(left)
			self:sleep(1+0.3*5):decelerate(0.2)
			self:fadetop(1.2)
			self:x((SS1[1]+SS1[2]+SS1[3]+SS1[4]+SS1[5])/SS1[7]*496):zoomx((SS1[6]/SS1[7])*496)
			self:diffuse(color("#555555"))
			end;
			};
			Def.Quad{
			OnCommand=function(self)
			self:fadetop(0)
			self:horizalign(left)
			self:sleep(1+0.3*4):decelerate(0.2)
			self:fadetop(1.2)
			self:x((SS1[1]+SS1[2]+SS1[3]+SS1[4])/SS1[7]*496):zoomx((SS1[5]/SS1[7])*496)
			self:diffuse(GameColor.Judgment["JudgmentLine_W5"])
			end;
			};
			Def.Quad{
			OnCommand=function(self)
			self:fadetop(0)
			self:horizalign(left)
			self:sleep(1+0.3*3):decelerate(0.2)
			self:fadetop(1.2)
			self:x((SS1[1]+SS1[2]+SS1[3])/SS1[7]*496):zoomx((SS1[4]/SS1[7])*496)
			self:diffuse(GameColor.Judgment["JudgmentLine_W4"])
			end;
			};
			Def.Quad{
			OnCommand=function(self)
			self:fadetop(0)
			self:horizalign(left)
			self:sleep(1+0.3*2):decelerate(0.2)
			self:fadetop(1.2)
			self:x((SS1[1]+SS1[2])/SS1[7]*496):zoomx((SS1[3]/SS1[7])*496)
			self:diffuse(GameColor.Judgment["JudgmentLine_W3"])
			end;
			};
			Def.Quad{
			OnCommand=function(self)
			self:fadetop(0)
			self:horizalign(left)
			self:sleep(1+0.3*1):decelerate(0.2)
			self:fadetop(1.2)
			self:x((SS1[1])/SS1[7]*496):zoomx((SS1[2]/SS1[7])*496)
			self:diffuse(GameColor.Judgment["JudgmentLine_W2"])
			end;
			};
			Def.Quad{
			OnCommand=function(self)
			self:fadetop(0)
			self:horizalign(left)
			self:sleep(1):decelerate(0.2)
			self:fadetop(1.2)
			self:zoomx((SS1[1]/SS1[7])*496)
			self:diffuse(GameColor.Judgment["JudgmentLine_W1"])
			end;
			};
		};
	};
			Def.ActorFrame{
			Condition=SS1[7] == 0;
			OnCommand=cmd(x,SCREEN_CENTER_X*0.806;y,SCREEN_CENTER_Y*0.616);
			Def.Quad{
			OnCommand=function(self)
			self:fadetop(0)
			self:horizalign(left)
			self:sleep(1):decelerate(0.2)
			self:fadetop(1.2)
			self:zoomx(496)
			self:zoomy(170)
			self:diffuse(PlayerColor(PLAYER_1))
			self:diffusealpha(0.9)
			end;
			};
		};
	};

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

Def.Quad{
    InitCommand=cmd(y,SCREEN_CENTER_Y*0.3;horizalign,left;zoomx,170;zoomy,25;faderight,1;diffuse,GameColor.Difficulty[StepSt1:GetDifficulty()]);
};

LoadFont("Common Normal")..{
InitCommand=cmd(x,10;y,SCREEN_CENTER_Y*0.3;horizalign,left;zoom,1;shadowlength,2);
OnCommand=cmd(settext,StepText1;);
};
	

--[[LoadFont("Common normal")..{
	InitCommand=cmd(x,200;y,110+22*0;zoom,0.8;shadowlength,2;settext,"Hold:");
};
LoadFont("Common normal")..{
	InitCommand=cmd(x,200;y,110+22*1;zoom,0.8;shadowlength,2;settext,"Mine:");
};
LoadFont("Common normal")..{
	InitCommand=cmd(x,245;y,110+22*1;zoom,0.8;shadowlength,2;
	settextf,"%04d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_AvoidMine'));
	OnCommand=cmd();
};
LoadFont("Common normal")..{
	InitCommand=cmd(x,280;y,112+22*1;zoom,0.4;shadowlength,2;
	settextf,"/%04d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_HitMine')+STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_AvoidMine'));
};
LoadFont("Common normal")..{
	InitCommand=cmd(x,200;y,110+22*2;zoom,0.8;shadowlength,2;settext,"Burn:");
};
LoadFont("Common normal")..{
	InitCommand=cmd(x,260;y,110+22*2;zoom,0.8;shadowlength,2;settextf,"%.1f cal.",STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetCaloriesBurned());
	OnCommand=cmd();
};
LoadFont("Common normal")..{
	InitCommand=cmd(x,200;y,110+22*3;zoom,0.8;shadowlength,2;settext,"MC:");
};]]

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
        InitCommand=function(self)
            self:settext("Sample Text"):zoom(0.6):shadowlength(1)
            self:x(230):y(SCREEN_CENTER_Y-130)
        end;
        OnCommand=function(self)
            local PRInd = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPersonalHighScoreIndex()
            self:visible(PRInd ~= -1);
            local text = string.format(THEME:GetString("ScreenEvaluation", "PersonalRecord"), PRInd+1)
            self:settext(text):diffusealpha(0):sleep(2):decelerate(0.3):diffusealpha(1)
        end;
    };
    LoadFont("Common Normal")..{
        InitCommand=function(self)
            self:settext("Sample Text"):zoom(0.6):shadowlength(1)
            self:x(230):y(SCREEN_CENTER_Y-145)
        end;
        OnCommand=function(self)
            local MRInd = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetMachineHighScoreIndex()
            self:visible(MRInd ~= -1);
            local text = string.format(THEME:GetString("ScreenEvaluation", "MachineRecord"), MRInd+1)
            self:settext(text):diffusealpha(0):sleep(2):decelerate(0.3):diffusealpha(1)
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
local jud2 = GetPicJudPath(Op2);
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
		OnCommand=cmd(x,138;y,21;zoomx,677/794;zoomy,255/256);
StandardDecorationFromTable( "GraphDisplay" .. ToEnumShortString(PLAYER_2), GraphDisplay(PLAYER_2) );
--BG
Def.ActorFrame{

Def.ActorFrame{
InitCommand=cmd(diffusealpha,0.7);
Condition=SS2[7] ~= 0;
OnCommand=cmd(x,SCREEN_CENTER_X*0.806;y,SCREEN_CENTER_Y*0.616+197.5;zoomy,170);
Def.Quad{
OnCommand=function(self)
self:fadetop(0)
self:horizalign(left)
self:sleep(1+0.3*5):decelerate(0.2)
self:fadetop(1.2)
self:x(((SS2[1]+SS2[2]+SS2[3]+SS2[4]+SS2[5])/SS2[7])*496):zoomx((SS2[6]/SS2[7])*496)
self:diffuse(color("#555555"))
end;
};
Def.Quad{
OnCommand=function(self)
self:fadetop(0)
self:horizalign(left)
self:sleep(1+0.3*4):decelerate(0.2)
self:fadetop(1.2)
self:x(((SS2[1]+SS2[2]+SS2[3]+SS2[4])/SS2[7])*496):zoomx((SS2[5]/SS2[7])*496)
self:diffuse(GameColor.Judgment["JudgmentLine_W5"])
end;
};
Def.Quad{
OnCommand=function(self)
self:fadetop(0)
self:horizalign(left)
self:sleep(1+0.3*3):decelerate(0.2)
self:fadetop(1.2)
self:x(((SS2[1]+SS2[2]+SS2[3])/SS2[7])*496):zoomx((SS2[4]/SS2[7])*496)
self:diffuse(GameColor.Judgment["JudgmentLine_W4"])
end;
};
Def.Quad{
OnCommand=function(self)
self:fadetop(0)
self:horizalign(left)
self:sleep(1+0.3*2):decelerate(0.2)
self:fadetop(1.2)
self:x(((SS2[1]+SS2[2])/SS2[7])*496):zoomx((SS2[3]/SS2[7])*496)
self:diffuse(GameColor.Judgment["JudgmentLine_W3"])
end;
};
Def.Quad{
OnCommand=function(self)
self:fadetop(0)
self:horizalign(left)
self:sleep(1+0.3*1):decelerate(0.2)
self:fadetop(1.2)
self:x(((SS2[1])/SS2[7])*496):zoomx((SS2[2]/SS2[7])*496)
self:diffuse(GameColor.Judgment["JudgmentLine_W2"])
end;
};
Def.Quad{
OnCommand=function(self)
self:fadetop(0)
self:horizalign(left)
self:sleep(1):decelerate(0.2)
self:fadetop(1.2)
self:zoomx((SS2[1]/SS2[7])*496)
self:diffuse(GameColor.Judgment["JudgmentLine_W1"])
end;
};
};
Def.ActorFrame{
Condition=SS2[7] == 0;
OnCommand=cmd(x,SCREEN_CENTER_X*0.806;y,SCREEN_CENTER_Y*0.616+197.5);
Def.Quad{
OnCommand=function(self)
self:fadetop(0)
self:horizalign(left)
self:sleep(1):decelerate(0.2)
self:fadetop(1.2)
self:zoomx(496)
self:zoomy(170)
self:diffuse(PlayerColor(PLAYER_2))
self:diffusealpha(0.9)
end;
};
};
};
};
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

	
Def.Quad{
    InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y*0.3;horizalign,right;zoomx,170;zoomy,25;fadeleft,1;diffuse,GameColor.Difficulty[StepSt2:GetDifficulty()]);
};

LoadFont("Common Normal")..{
InitCommand=cmd(x,SCREEN_RIGHT-10;y,SCREEN_CENTER_Y*0.3;horizalign,right;zoom,1;shadowlength,2);
OnCommand=cmd(settext,StepText2;);
};

	

--[[LoadFont("Common normal")..{
	InitCommand=cmd(x,CX*2-200;y,110+22*0;zoom,0.8;shadowlength,2;settext,"Hold:");
};
LoadFont("Common normal")..{
	InitCommand=cmd(x,CX*2-200;y,110+22*1;zoom,0.8;shadowlength,2;settext,"Mine:");
};
LoadFont("Common normal")..{
	InitCommand=cmd(x,CX*2-275;y,110+22*1;zoom,0.8;shadowlength,2;
	settextf,"%04d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores('TapNoteScore_AvoidMine'));
	OnCommand=cmd();
};
LoadFont("Common normal")..{
	InitCommand=cmd(x,CX*2-240;y,112+22*1;zoom,0.4;shadowlength,2;
	settextf,"/%04d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores('TapNoteScore_HitMine')+STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores('TapNoteScore_AvoidMine'));
};
LoadFont("Common normal")..{
	InitCommand=cmd(x,CX*2-200;y,110+22*2;zoom,0.8;shadowlength,2;settext,"Burn:");
};
LoadFont("Common normal")..{
	InitCommand=cmd(x,CX*2-260;y,110+22*2;zoom,0.8;shadowlength,2;settextf,"%.1f cal.",STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetCaloriesBurned());
	OnCommand=cmd();
};
LoadFont("Common normal")..{
	InitCommand=cmd(x,CX*2-200;y,110+22*3;zoom,0.8;shadowlength,2;settext,"MC:");
};]]

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

	

};



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