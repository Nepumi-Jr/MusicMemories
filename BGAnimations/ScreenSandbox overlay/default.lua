local t = Def.ActorFrame{};
local InputOfArrow = function( event )
	if not event then return end

	if event.type == "InputEventType_Repeat" then
		if event.button == "Start" or event.button == "Center" then
			MESSAGEMAN:Broadcast('Confirm')
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
		end
	end
end;

t[#t+1] = Def.ActorFrame{
	name = "YEY";
	InitCommand=cmd();
	OnCommand=function(self)
		SCREENMAN:GetTopScreen():AddInputCallback(InputOfArrow)
		self:sleep(1):queuecommand("ISLA")
	end;
	
		LoadActor( THEME:GetPathS("Common","start") )..{
			ConfirmMessageCommand=cmd(play);
		};
		LoadActor( THEME:GetPathS("Common","cancel") )..{
			NopeMessageCommand=cmd(play);
		};
		LoadActor( THEME:GetPathS("Common","value") )..{
			ChanMessageCommand=cmd(play);
		};
};
t[#t+1]=Def.Quad{
	OnCommand=cmd(visible,false;sleep,9999999);
};
t[#t+1] = LoadFont("Isla/_sov_monomon 24px")..{
	OnCommand=cmd(Center;zoom,1;settext,"SampleText"
	;strokecolor, GameColor.Judgment["JudgmentLine_W1"];textglowmode,"TextGlowMode_Stroke";
	thump;effectclock,"bgm");
};

t[#t+1] = LoadActor("/BGAnimations/pop1");
return t;