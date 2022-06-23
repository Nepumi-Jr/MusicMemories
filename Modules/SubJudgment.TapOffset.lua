return function(player)
    return Def.ActorFrame{
        LoadFont("Common Normal")..{
            OnCommand=function(self) self:strokecolor({1,1,1,1}); self:horizalign(left); end;
            JudgmentMessageCommand=function(self,param)

				if param.Player ~= player then return end;
				if param.HoldNoteScore then return end;
                local TNSList = {"TapNoteScore_W5","TapNoteScore_W4","TapNoteScore_W3","TapNoteScore_W2","TapNoteScore_W1","TapNoteScore_ProW1","TapNoteScore_ProW2","TapNoteScore_ProW3","TapNoteScore_ProW4","TapNoteScore_ProW5"}
                
				if FindInTable(param.TapNoteScore, TNSList) ~= nil then
                    self:stoptweening():settextf(" ms")
                    self:visible(true)
                    self:diffuse((param.Early) and color("#00B4FF") or color("#FF0096")):diffusealpha(1):zoom(1.05):decelerate(0.125):zoom(1):sleep(0.8):decelerate(0.1):diffusealpha(0)
                end
			end;
        };
        LoadFont("Common Normal")..{
            OnCommand=function(self) self:strokecolor({1,1,1,1}); self:horizalign(right); end;
            JudgmentMessageCommand=function(self,param)

				if param.Player ~= player then return end;
				if param.HoldNoteScore then return end;

				local TNSList = {"TapNoteScore_W5","TapNoteScore_W4","TapNoteScore_W3","TapNoteScore_W2","TapNoteScore_W1","TapNoteScore_ProW1","TapNoteScore_ProW2","TapNoteScore_ProW3","TapNoteScore_ProW4","TapNoteScore_ProW5"}
                
				if FindInTable(param.TapNoteScore, TNSList) ~= nil then
                    self:stoptweening():settextf("%d", param.TapNoteOffset * 1000 or 1000)
                    self:visible(true)
                    self:diffuse((param.Early) and color("#00B4FF") or color("#FF0096")):diffusealpha(1):zoom(1.05):decelerate(0.125):zoom(1):sleep(0.8):decelerate(0.1):diffusealpha(0)
                end
			end;
        };
    };
end