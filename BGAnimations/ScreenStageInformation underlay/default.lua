
local sound = "Introduc2.wav";
if LoadModule("Easter.today.lua")() == "FOOL" then
	sound = "BadTime.ogg";
end

local t = Def.ActorFrame{};

	t[#t+1]=Def.Quad{
		InitCommand=function(self) self:FullScreen(); self:diffuse({0,0,0,0}); end;
		OnCommand=function(self) self:sleep(11.5); end;
	};



	-- t[#t+1]=Def.Quad{
	-- 	InitCommand=function(self) self:FullScreen(); self:diffuse({1,1,1,0}); end;
	-- 	OnCommand=function(self) self:sleep(5); self:linear(0.7); self:diffusealpha(1); end;
	-- };
	t[#t+1]=Def.Quad{
		InitCommand=function(self) self:FullScreen(); self:diffuse({0,0,0,1}); end;
		OnCommand=function(self) self:sleep(2.2); self:diffusealpha(0.5); end;
	};
	t[#t+1] = Def.ActorFrame{
		InitCommand=function(self) self:Center(); self:zoom(1); self:rotationz(0); end;
		OnCommand=function(self) self:sleep(2.2); self:queuecommand("app"); end;
		appCommand=function(self) self:visible(false); end;
		Def.Sprite {
			InitCommand=function(self) self:diffusealpha(0); end;
			BeginCommand=function(self) self:LoadFromCurrentSongBackground(); end;
			OnCommand=function(self)
				if PREFSMAN:GetPreference("StretchBackgrounds") then
					self:SetSize(SCREEN_WIDTH,SCREEN_HEIGHT)
				else
					self:scale_or_crop_background()
				end
				self:x(0):y(0)
				self:linear(2):diffusealpha(1)
			end;
		};
	}
	 
	t[#t+1] = Def.ActorFrame{
		InitCommand=function(self) self:zoom(1.2); self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y-100); self:visible(false); end;
		OnCommand=function(self) self:sleep(2.2); self:queuecommand("app"); end;
		appCommand=function(self) self:visible(true); self:decelerate(2.5); self:y(SCREEN_CENTER_Y-70); self:diffusealpha(1); end;
		--Song Banner

		
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


	t[#t+1]=LoadActor(sound)..{
		OnCommand=function(self) self:sleep(0.2); self:queuecommand("YEP"); end;
		YEPCommand=function(self) self:play(); end;
	};

--Title Stuff HERE
	t[#t+1]=LoadActor("Title.lua");

	t[#t+1]=Def.Quad{
		InitCommand=function(self) self:FullScreen(); self:diffuse({1,1,1,0}); end;
		OnCommand=function(self) self:sleep(1); self:accelerate(1.2); self:diffusealpha(1); self:decelerate(2); self:diffusealpha(0); end;
	};

	t[#t+1]=Def.Quad{
		InitCommand=function(self) self:FullScreen(); self:diffuse({0,0,0,0}); end;
		OnCommand=function(self) self:sleep(6); self:linear(1); self:diffusealpha(1); end;
	};



return t;