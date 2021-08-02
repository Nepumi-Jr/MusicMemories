
local sound = "Introduc2.wav";
if LoadModule("Easter.today.lua")() == "FOOL" then
	sound = "BadTime.ogg";
end

local t = Def.ActorFrame{};

	t[#t+1]=Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,{0,0,0,1});
		OnCommand=cmd(sleep,10.5);
	};



	t[#t+1]=Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,{1,1,1,0});
		OnCommand=cmd(sleep,2+2.5;linear,0.7;diffusealpha,1);
	};
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(Center;zoom,1;rotationz,0;);
		Def.Sprite {
			InitCommand=cmd(diffusealpha,0);
			BeginCommand=cmd(LoadFromCurrentSongBackground);
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
	t[#t+1]=Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,{1,1,1,0});
		OnCommand=cmd(sleep,2.2;diffusealpha,1);
	};
	t[#t+1]=LoadActor("BlurBG.lua")..{
		InitCommand=cmd(visible,false;Center);
		OnCommand=cmd(sleep,2.2;queuecommand,"app");
		appCommand=cmd(visible,true;linear,3.8;zoom,1.1;rotationz,1);
	};
	 
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(zoom,1.2;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-100;visible,false);
		OnCommand=cmd(sleep,2.2;queuecommand,"app");
		appCommand=cmd(visible,true;decelerate,2.5;y,SCREEN_CENTER_Y-70;diffusealpha,1);
		--Song Banner

		
		Def.Sprite{
			OnCommand=function(self)
			
			if GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():HasBanner() then
			self:Load(GAMESTATE:GetCurrentCourse():GetBannerPath())
			elseif GAMESTATE:GetCurrentSong():HasBanner() then
			self:Load(GAMESTATE:GetCurrentSong():GetBannerPath()):scaletoclipped(256,80)
			else
			self:Load(THEMEDIR().."/Graphics/Common fallback banner.png"):scaletoclipped(256,80)
			end
			end;
		};
		LoadActor(THEME:GetPathG("ScreenSelectMusic","BannerFrame"))..{
			OnCommand=cmd();
		};
	
	
	
	};


	t[#t+1]=LoadActor(sound)..{
		OnCommand=cmd(sleep,0.2;queuecommand,"YEP");
		YEPCommand=cmd(play);
	};

--Title Stuff HERE
	t[#t+1]=LoadActor("Title.lua");

	t[#t+1]=Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,{1,1,1,0});
		OnCommand=cmd(sleep,1;accelerate,1.2;diffusealpha,1;decelerate,2;diffusealpha,0);
	};

	t[#t+1]=Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,{0,0,0,0});
		OnCommand=cmd(sleep,5;linear,1;diffusealpha,1);
	};



return t;