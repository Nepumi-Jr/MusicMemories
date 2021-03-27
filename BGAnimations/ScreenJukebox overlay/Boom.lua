local CON = true;
return Def.ActorFrame{
	Def.Quad{
		OnCommand=cmd(FullScreen;diffusealpha,0);
		JudgmentMessageCommand=function(self,Isla)
			if Isla.TapNoteScore == "TapNoteScore_HitMine" and CON then
				self:finishtweening():diffusealpha(1):linear(0.3):diffusealpha(0);

			end
		end;

	};
	LoadActor( THEME:GetPathS("Player","mine") ,true)..{
	Name = "Isla";
	JudgmentMessageCommand=function(self, param)
		if param.make ~= nil and param.make then
			self:play();
		end
	end;
	};
};