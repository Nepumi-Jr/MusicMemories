return function(player)
    return Def.ActorFrame{
        Def.Sprite{                
            OnCommand=function(self)
                self:pause();
                self:visible(false);

                local JudF = TP[ToEnumShortString(player)].ActiveModifiers.JudgmentGraphic
                JudF = LoadModule("Options.JudgmentsFileShortName.lua")(JudF)

                local path = "/"..THEMEDIR().."Resource/JudF/EL/";
                
                local files = FILEMAN:GetDirListing(path)
                local RealFile = THEME:GetPathG("Def","EL");
                
                for k,filename in ipairs(files) do
                    if string.match(filename, " 1x2.png") and string.match(filename,JudF) then
                        RealFile = path..filename;
                        break
                    end
                end
                self:Load(RealFile);
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
            InitCommand=cmd(zoom,0.5);
        };
    };
end