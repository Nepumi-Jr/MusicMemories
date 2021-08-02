local t = Def.ActorFrame{};
local Row = 1;
local InputOfArrow = function( event )
	if not event then return end

	if event.type == "InputEventType_FirstPress" then
		if (event.button == "Left" or event.button == "Down" or event.button == "Up" or event.button == "Right" or event.button == "DownLeft" or event.button == "DownRight") and Row == 1 then
			Row = 2;
			MESSAGEMAN:Broadcast('Chan')
		elseif (event.button == "Left" or event.button == "Down" or event.button == "Up" or event.button == "Right" or event.button == "DownLeft" or event.button == "DownRight") and Row == 2 then
			Row = 1;
			MESSAGEMAN:Broadcast('Chan')
		elseif event.button == "Start" or event.button == "Center" then
			MESSAGEMAN:Broadcast('TorPai')--TorPai in Thai is mean Next
			if Row == 1 then
				SCREENMAN:GetTopScreen():SetNextScreenName("ScreenSelectMiniGames"):StartTransitioningScreen("SM_GoToNextScreen")
			elseif Row == 2 then
				SCREENMAN:GetTopScreen():SetNextScreenName("ScreenSelectTools"):StartTransitioningScreen("SM_GoToNextScreen")
			end
		elseif event.button == "Back" or event.button == "UpLeft" or event.button == "UpRight" then
			MESSAGEMAN:Broadcast('Nope')
			SCREENMAN:GetTopScreen():SetNextScreenName(Branch.TitleMenu()):StartTransitioningScreen("SM_GoToNextScreen")
			--SCREENMAN:GetTopScreen():RemoveInputCallback(InputOfArrow)
	end
	end
end;
t[#t+1] = Def.ActorFrame{
	name = "I hope Neptune have good dream";
	OnCommand=function(self)
	SCREENMAN:GetTopScreen():AddInputCallback(InputOfArrow)
	end;
		LoadActor( THEME:GetPathS("Common","start") )..{
			TorPaiMessageCommand=cmd(play);
		};
		LoadActor( THEME:GetPathS("Common","cancel") )..{
			NopeMessageCommand=cmd(play);
		};
		LoadActor( THEME:GetPathS("Common","value") )..{
			ChanMessageCommand=cmd(play);
		};
};
t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y-100;zoom,.4;queuecommand,"Chan");
	ChanMessageCommand=function(self)
	self:finishtweening()
		self:bounceend(0.5)
		if Row == 1 then
		self:bob()
        self:effectmagnitude(0,10,0)
		self:zoom(0.6)
		else
		self:stopeffect()
		self:zoom(0.4)
		end
	end;
	TorPaiMessageCommand=function(self)
	self:finishtweening()
		self:decelerate(0.5)
		self:stopeffect()
		self:zoom(0)
		end;
	LoadModule("Menu.Button.lua")(0,0,color("#FFAA77"),color("#FF8833"),color("#FFAA55"),color("#FFFFFF"),color("#999999"),"More","Games!")
};
t[#t+1] = Def.ActorFrame{
	OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y+100;zoom,.4);
	ChanMessageCommand=function(self)
	self:finishtweening()
		self:bounceend(0.5)
		if Row == 2 then
		self:bob()
        self:effectmagnitude(0,10,0)
		self:zoom(0.6)
		else
		self:stopeffect()
		self:zoom(0.4)
		end
	end;
	TorPaiMessageCommand=function(self)
	self:finishtweening()
		self:decelerate(0.5)
		self:stopeffect()
		self:zoom(0)
		end;
	LoadModule("Menu.Button.lua")(0,0,color("#AAAAFF"),color("#6666FF"),color("#66AAFF"),color("#000000"),color("#333333"),"Tool","So many!")
};
return t;