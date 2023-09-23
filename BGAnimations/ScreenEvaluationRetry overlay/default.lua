local selected = 1
local InputOfArrow = function( event )
	if not event then return end

	if event.type == "InputEventType_FirstPress" then
		if event.button == "Start" or event.button == "Center" then
			MESSAGEMAN:Broadcast('Confirm')
			if selected == 1 then
				TP.Eva.readyState = 2
			end
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
		end

		if event.button == "Back" then
			MESSAGEMAN:Broadcast('Nope')
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
		end

		if event.button == "Down" or 
		event.button == "Up" or 
		event.button == "Left" or 
		event.button == "Right" or 
		event.button == "MenuLeft" or
		event.button == "MenuRight" or
		event.button == "MenuUp" or
		event.button == "MenuDown" or
		event.button == "DownLeft" or
		event.button == "DownRight"
		then
			selected = selected == 2 and 1 or 2
			MESSAGEMAN:Broadcast('Reload')
		end
	end
end;



local diffActor = Def.ActorFrame{};

--get diff for each player
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	local thisStep = GAMESTATE:GetCurrentSteps(pn)
	diffActor[#diffActor+1] = Def.ActorFrame{
		Def.Quad{
			InitCommand=function(self) self:x(pn == PLAYER_1 and 0 or SCREEN_RIGHT); self:y(SCREEN_CENTER_Y+100); self:horizalign(pn == PLAYER_1 and left or right); self:zoomx(170); self:zoomy(25); self:faderight(pn == PLAYER_1 and 1 or 0); self:fadeleft(pn == PLAYER_2 and 1 or 0); self:diffuse(GameColor.Difficulty[thisStep:GetDifficulty()]); end;
		};
		LoadFont("Common Normal")..{
			InitCommand=function(self) self:x(pn == PLAYER_1 and 10 or SCREEN_RIGHT - 10); self:y(SCREEN_CENTER_Y+100); self:horizalign(pn == PLAYER_1 and left or right); self:zoom(1); self:shadowlength(2); end;
			OnCommand=function(self) self:settext(LoadModule("TextDisplay.Difficulty.lua")(thisStep)); end;
		};
	};
	
end

return Def.ActorFrame{
	OnCommand=function(self)
		SCREENMAN:GetTopScreen():AddInputCallback(InputOfArrow)
		self:sleep(1):queuecommand("ISLA")
	end;
	LoadActor( THEME:GetPathS("Common","start") )..{
		ConfirmMessageCommand=function(self) self:play(); end;
	};
	LoadActor( THEME:GetPathS("Common","cancel") )..{
		NopeMessageCommand=function(self) self:play(); end;
	};
	LoadActor( THEME:GetPathS("Common","value") )..{
		ReloadMessageCommand=function(self) self:play(); end;
	};

	Def.Quad{
		OnCommand=function(self) self:FullScreen(6):diffuse(color("#00000099")) end;
	};

	LoadFont("Common Large")..{
		Text="Retry?";
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-200):zoom(0.7):diffuse(color("#FFFFFF"))
			self:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#FF9999")):effectperiod(3)
		end;
	};

	--song Banner
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-70):diffuse(color("#FFFFFF"))
			self:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#FF9999")):effectperiod(3)
		end;
		Def.Sprite{
			OnCommand=function(self)
			if GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():HasBanner() then
			self:Load(GAMESTATE:GetCurrentCourse():GetBannerPath()):scaletoclipped(256,80)
			elseif GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong():HasBanner() then
			self:Load(GAMESTATE:GetCurrentSong():GetBannerPath()):scaletoclipped(256,80)
			else
			self:Load(getThemeDir().."/Graphics/Common fallback banner.png"):scaletoclipped(256,80)
			end
			end;
		};
		LoadActor(THEME:GetPathG("ScreenSelectMusic","BannerFrame"))..{
			OnCommand=function(self) end;
		};
	};

	--song Infomation
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y):diffuse(color("#FFFFFF"))
		end;
		Def.Quad{
			OnCommand=function(self) self:zoomto(SCREEN_WIDTH,80):y(20):diffuse(color("#00000099")) end;
		};
		LoadFont("Common Normal")..{
			Text=GAMESTATE:GetCurrentSong():GetDisplayFullTitle();
			InitCommand=function(self) self:zoom(1):diffuse(color("#FFFFFF")) end;
		};
		LoadFont("Common Normal")..{
			Text=GAMESTATE:GetCurrentSong():GetDisplayArtist() or "unknown artist";
			InitCommand=function(self) self:y(20):zoom(0.7):diffuse(color("#FFFFFF")) end;
		};
		LoadFont("Common Normal")..{
			Text=SecondsToHHMMSS(GAMESTATE:GetCurrentSong():MusicLengthSeconds());
			InitCommand=function(self) self:y(40):zoom(0.7):diffuse(color("#FFFFFF")) end;
		};
	};

	diffActor;
	
	--menu (Retry or give it up)
	LoadFont("Common Normal")..{
		Text="-Retry-";
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+100):zoom(1.3):diffuse(color("#888888")) end;
		OnCommand=function(self) self:wag():effectmagnitude(0,0,2):effectperiod(5):effectoffset(math.random(0,20)/4) self:playcommand("Reload") end;
		ReloadMessageCommand=function(self) 
			self:finishtweening()
			self:decelerate(0.4)
			if selected == 1 then
				self:diffuse(color("#AAFFAA")):zoom(1.6)
			else
				self:diffuse(color("#888888")):zoom(0.8)
			end
		end;
	};

	LoadFont("Common Normal")..{
		Text="-Give it up-";
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+140):zoom(1.3):diffuse(color("#888888")) end;
		OnCommand=function(self) self:wag():effectmagnitude(0,0,2):effectperiod(5):effectoffset(math.random(0,20)/4) self:playcommand("Reload") end;
		ReloadMessageCommand=function(self) 
			self:finishtweening()
			self:decelerate(0.4)
			if selected == 2 then
				self:diffuse(color("#FFAAAA")):zoom(1.6)
			else
				self:diffuse(color("#888888")):zoom(0.8)
			end
		end;
	};


};