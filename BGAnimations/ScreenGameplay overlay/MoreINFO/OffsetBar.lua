local WID = 250;
local B = 50;
local BAD = PREFSMAN:GetPreference("TimingWindowSecondsW5");

local II = 0;

local Ni = Def.ActorFrame{
	Def.ActorFrame{
		Def.Quad{
			InitCommand=function(self) self:zoomx(WID); self:zoomy(7); self:diffuse(GameColor.Judgment["JudgmentLine_W5"]); end;
		};
		Def.Quad{
			InitCommand=function(self) self:zoomx(WID*
			PREFSMAN:GetPreference("TimingWindowSecondsW4")/
			PREFSMAN:GetPreference("TimingWindowSecondsW5")); self:zoomy(7); self:diffuse(GameColor.Judgment["JudgmentLine_W4"]); end;
		};
		Def.Quad{
			InitCommand=function(self) self:zoomx(WID*
			PREFSMAN:GetPreference("TimingWindowSecondsW3")/
			PREFSMAN:GetPreference("TimingWindowSecondsW5")); self:zoomy(7); self:diffuse(GameColor.Judgment["JudgmentLine_W3"]); end;
		};
		Def.Quad{
			InitCommand=function(self) self:zoomx(WID*
			PREFSMAN:GetPreference("TimingWindowSecondsW2")/
			PREFSMAN:GetPreference("TimingWindowSecondsW5")); self:zoomy(7); self:diffuse(GameColor.Judgment["JudgmentLine_W2"]); end;
		};
		Def.Quad{
			InitCommand=function(self) self:zoomx(WID*
			PREFSMAN:GetPreference("TimingWindowSecondsW1")/
			PREFSMAN:GetPreference("TimingWindowSecondsW5")); self:zoomy(7); self:diffuse(GameColor.Judgment["JudgmentLine_W1"]); end;
			JudgmentMessageCommand=function()
				II = math.mod(II+1,B);
			end
		};
	};
};



for i = 1,B do
	Ni[#Ni+1]=Def.Quad{
		InitCommand=function(self) self:zoomy(20); self:zoomx(1.5); self:diffusealpha(0); self:fadetop(0.5); self:fadebottom(0.5); end;
		JudgmentMessageCommand=function(self,param)
			if II == i-1 and param.TapNoteOffset ~= nil  then
				self:finishtweening()
				self:x(param.TapNoteOffset/BAD*WID/2);
				self:diffusealpha(1):zoomx(2):decelerate(5):diffusealpha(0):zoomx(0);
			end
		end;
	};
end

return Ni;