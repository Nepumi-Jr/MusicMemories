return function(player)
    return Def.ActorFrame{
        Def.Sprite{                
            OnCommand=function(self)
                self:pause();
                self:visible(false);
                local JudF = TP[ToEnumShortString(pn)].ActiveModifiers.JudgmentGraphic
                local JudgeFastSlow = LoadModule("Judgement.GetFastSlowPath.lua")(JudF)
                self:Load(JudgeFastSlow);
            end;
            JudgmentMessageCommand=function(self,param)

				if param.Player ~= player then return end;
				if param.HoldNoteScore then return end;

				if param.TapNoteScore=="TapNoteScore_W5" or
				param.TapNoteScore=="TapNoteScore_W4" or
				param.TapNoteScore=="TapNoteScore_W3" or
				param.TapNoteScore=="TapNoteScore_W2" then
					self:finishtweening():visible(true)
					self:setstate((param.Early) and 0 or 1):diffusealpha(1):zoom(0.55):decelerate(0.125):zoom(0.5):sleep(0.8):decelerate(0.1):diffusealpha(0)
                elseif param.TapNoteScore=="TapNoteScore_W1" or
                param.TapNoteScore=="TapNoteScore_ProW1" or
                param.TapNoteScore=="TapNoteScore_ProW2" or
                param.TapNoteScore=="TapNoteScore_ProW3" or
                param.TapNoteScore=="TapNoteScore_ProW4" or
                param.TapNoteScore=="TapNoteScore_ProW5" then
					self:finishtweening():visible(false)
				end
			end;
            InitCommand=function(self) self:zoom(0.5); end;
        };
    };
end