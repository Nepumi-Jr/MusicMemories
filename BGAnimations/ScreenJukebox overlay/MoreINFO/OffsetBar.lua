local WID = 250;
local B = 50;
local BAD = PREFSMAN:GetPreference("TimingWindowSecondsW5");

local II = 0;

local Ni = Def.ActorFrame{
	Def.ActorFrame{
		Def.Quad{
			InitCommand=cmd(zoomx,WID;zoomy,7;diffuse,GameColor.Judgment["JudgmentLine_W5"]);
		};
		Def.Quad{
			InitCommand=cmd(zoomx,WID*
			PREFSMAN:GetPreference("TimingWindowSecondsW4")/
			PREFSMAN:GetPreference("TimingWindowSecondsW5");zoomy,7;diffuse,
			GameColor.Judgment["JudgmentLine_W4"]);
		};
		Def.Quad{
			InitCommand=cmd(zoomx,WID*
			PREFSMAN:GetPreference("TimingWindowSecondsW3")/
			PREFSMAN:GetPreference("TimingWindowSecondsW5");zoomy,7;diffuse,
			GameColor.Judgment["JudgmentLine_W3"]);
		};
		Def.Quad{
			InitCommand=cmd(zoomx,WID*
			PREFSMAN:GetPreference("TimingWindowSecondsW2")/
			PREFSMAN:GetPreference("TimingWindowSecondsW5");zoomy,7;diffuse,
			GameColor.Judgment["JudgmentLine_W2"]);
		};
		Def.Quad{
			InitCommand=cmd(zoomx,WID*
			PREFSMAN:GetPreference("TimingWindowSecondsW1")/
			PREFSMAN:GetPreference("TimingWindowSecondsW5");zoomy,7;diffuse,
			GameColor.Judgment["JudgmentLine_W1"]);
			JudgmentMessageCommand=function()
				II = math.mod(II+1,B);
			end
		};
	};
};



for i = 1,B do
	Ni[#Ni+1]=Def.Quad{
		InitCommand=cmd(zoomy,20;zoomx,1.5;diffusealpha,0;fadetop,0.5;fadebottom,0.5);
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