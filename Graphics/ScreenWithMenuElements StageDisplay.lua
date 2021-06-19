local curScreen = Var "LoadingScreen";
local curStage = GAMESTATE:GetCurrentStage();
local curStageIndex = GAMESTATE:GetCurrentStageIndex();
local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame {
    Def.Quad{
        InitCommand=cmd(diffuse,NumStageColor(curStageIndex+1);horizalign,right;vertalign,top;x,SCREEN_RIGHT;y,50;zoomy,2;zoomx,120;fadeleft,0.3);
    };
    Def.Quad{
        InitCommand=cmd(diffuse,color("#333333");horizalign,right;vertalign,top;x,SCREEN_RIGHT;y,52;zoomy,30;zoomx,120;fadeleft,0.3);
    };
    Def.Quad{
        InitCommand=cmd(diffuse,NumStageColor(curStageIndex+1);horizalign,right;vertalign,top;x,SCREEN_RIGHT;y,82;zoomy,2;zoomx,120;fadeleft,0.3);
    };
	LoadFont("Common Normal") .. {
		InitCommand=cmd(x,SCREEN_RIGHT-12;y,67;horizalign,right;skewx,-0.2;zoom,0.7;shadowlength,1;);
		BeginCommand=function(self)
			local top = SCREENMAN:GetTopScreen()
			if top then
				if not string.find(top:GetName(),"ScreenEvaluation") then
					curStageIndex = curStageIndex + 1
				end
			end
			self:playcommand("Set")
		end;
		SetCommand=function(self)
			if GAMESTATE:GetCurrentCourse() then
				self:settext( curStageIndex+1 .. " / " .. GAMESTATE:GetCurrentCourse():GetEstimatedNumStages() );
			elseif GAMESTATE:IsEventMode() then
				self:settextf("Stage %s", curStageIndex);
			else
				if string.find(curScreen,"Evaluation") then
					local stageStats = STATSMAN:GetPlayedStageStats(1)
					curStage = stageStats:GetStage()
				end

				if THEME:GetMetric(curScreen,"StageDisplayUseShortString") then
					self:settextf("%s", ToEnumShortString(curStage));
				else
					self:settextf("%s Stage", ToEnumShortString(curStage));
				end;
			end;
			
		self:diffuse(NumStageColor(curStageIndex+1))
		end;
	};
};
return t
