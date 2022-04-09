local curScreen = Var "LoadingScreen";
local curStage = GAMESTATE:GetCurrentStage();
local curStageIndex = GAMESTATE:GetCurrentStageIndex();
local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame {
    Def.Quad{
        InitCommand=function(self) self:diffuse(NumStageColor(curStageIndex+1)); self:horizalign(right); self:vertalign(top); self:x(SCREEN_RIGHT); self:y(50); self:zoomy(2); self:zoomx(120); self:fadeleft(0.3); end;
    };
    Def.Quad{
        InitCommand=function(self) self:diffuse(color("#333333")); self:horizalign(right); self:vertalign(top); self:x(SCREEN_RIGHT); self:y(52); self:zoomy(30); self:zoomx(120); self:fadeleft(0.3); end;
    };
    Def.Quad{
        InitCommand=function(self) self:diffuse(NumStageColor(curStageIndex+1)); self:horizalign(right); self:vertalign(top); self:x(SCREEN_RIGHT); self:y(82); self:zoomy(2); self:zoomx(120); self:fadeleft(0.3); end;
    };
	LoadFont("Common Normal") .. {
		InitCommand=function(self) self:x(SCREEN_RIGHT-12); self:y(67); self:horizalign(right); self:skewx(-0.2); self:zoom(0.7); self:shadowlength(1); end;
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
