return function(player)
    return Def.ActorFrame{
        LoadFont("Common Normal")..{
            OnCommand=cmd(strokecolor,{1,1,1,1};horizalign,left);
            JudgmentMessageCommand=function(self,param)

				if param.Player ~= player then return end;
				if param.HoldNoteScore then return end;

				if param.TapNoteScore=="TapNoteScore_W5" or
				param.TapNoteScore=="TapNoteScore_W4" or
				param.TapNoteScore=="TapNoteScore_W3" or
				param.TapNoteScore=="TapNoteScore_W2" or
				param.TapNoteScore=="TapNoteScore_W1" or
                param.TapNoteScore=="TapNoteScore_ProW1" or
                param.TapNoteScore=="TapNoteScore_ProW2" or
                param.TapNoteScore=="TapNoteScore_ProW3" or
                param.TapNoteScore=="TapNoteScore_ProW4" or
                param.TapNoteScore=="TapNoteScore_ProW5" then
                    self:stoptweening():settextf(" ms")
                    self:visible(true)
                    self:diffuse((param.Early) and color("#00B4FF") or color("#FF0096")):diffusealpha(1):zoom(1.05):decelerate(0.125):zoom(1):sleep(0.8):decelerate(0.1):diffusealpha(0)
				else
                    self:visible(false):stoptweening()
                end
			end;
        };
        LoadFont("Common Normal")..{
            OnCommand=cmd(strokecolor,{1,1,1,1};horizalign,right);
            JudgmentMessageCommand=function(self,param)

				if param.Player ~= player then return end;
				if param.HoldNoteScore then return end;

				if param.TapNoteScore=="TapNoteScore_W5" or
				param.TapNoteScore=="TapNoteScore_W4" or
				param.TapNoteScore=="TapNoteScore_W3" or
				param.TapNoteScore=="TapNoteScore_W2" or
				param.TapNoteScore=="TapNoteScore_W1" or
                param.TapNoteScore=="TapNoteScore_ProW1" or
                param.TapNoteScore=="TapNoteScore_ProW2" or
                param.TapNoteScore=="TapNoteScore_ProW3" or
                param.TapNoteScore=="TapNoteScore_ProW4" or
                param.TapNoteScore=="TapNoteScore_ProW5" then
                    self:stoptweening():settextf("%d", param.TapNoteOffset * 1000 or 1000)
                    self:visible(true)
                    self:diffuse((param.Early) and color("#00B4FF") or color("#FF0096")):diffusealpha(1):zoom(1.05):decelerate(0.125):zoom(1):sleep(0.8):decelerate(0.1):diffusealpha(0)
				else
                    self:visible(false):stoptweening()
                end
			end;
        };
    };
end