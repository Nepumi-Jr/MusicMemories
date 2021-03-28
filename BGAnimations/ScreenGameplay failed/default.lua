
local MEME = ThemePrefs.Get("MEMEMode");

local Menu = 0
local Allow_Press = false;
local IDontWantLetHerGo = true;
local InputHandler = function( event )

	-- if (somehow) there's no event, bail
	if not event then return end
	if not Allow_Press then return end 
	--printf("Meow !%d! %s->%s\n%d",math.random( 0,99 ),event.type,event.button,Menu);

	if event.type == "InputEventType_FirstPress" then
		
		
		if event.button == "Start" or event.button == "Center" then
			MESSAGEMAN:Broadcast("_FailOkay")
			if Menu == 0 then
				MESSAGEMAN:Broadcast("Ret")
				Allow_Press = false
			elseif Menu == 1 then
				IDontWantLetHerGo = false
				Allow_Press = false
			end
		end
		
		if event.button == "MenuLeft" or event.button == "MenuUp" or 
		event.button == "Left" or event.button == "Up" or
		event.button == "DownLeft"
		then
			Menu = math.mod(Menu - 1 + 2 ,2)
			MESSAGEMAN:Broadcast("_FailArrow")

			
		end

		if event.button == "MenuRight" or event.button == "MenuDown" or 
		event.button == "Right" or event.button == "Down" or
		event.button == "DownRight"
		then
			Menu = math.mod(Menu + 1 ,2)
			MESSAGEMAN:Broadcast("_FailArrow")

			
		end

		if Menu == 0 then
			MESSAGEMAN:Broadcast("NotoSWYD")
			MESSAGEMAN:Broadcast("YestoNew")
		elseif Menu == 1 then
			MESSAGEMAN:Broadcast("YestoSWYD")
			MESSAGEMAN:Broadcast("NotoNew")
		end
		
	end
	

end

local FailType = math.random(1,15)
local Ror = 2.5
local Hoold = 5



local t = Def.ActorFrame{
	StartTransitioningCommand=function(self)
		if ToEnumShortString(GAMESTATE:GetCurrentStage()) == "Event" and not IsNetConnected() then
			SCREENMAN:GetTopScreen():AddInputCallback( InputHandler )
		end
	end;
};

t[#t+1] = Def.Quad{
StartTransitioningCommand=function()
	MESSAGEMAN:Broadcast("AFTERFAIL");
end;
};

if FailType < 7 or not MEME then
	t[#t+1]=LoadActor("Normal");
elseif FailType == 7 then
	t[#t+1]=LoadActor("What");
	Ror = 0.2
elseif FailType == 8 then
	t[#t+1]=LoadActor("IWNKTG");
	Ror = 1.5
elseif FailType == 9 then
	t[#t+1]=LoadActor("Round");
	Ror = 0.2
elseif FailType == 10 then
	t[#t+1]=LoadActor("Directed");
	Ror = 7.794
elseif FailType == 11 then
	t[#t+1]=LoadActor("DeadBody");
	Ror = 1.5
elseif FailType >= 12 and FailType <= 15 then
	t[#t+1]=LoadActor("Pump");
	Ror = 4
end


--[[local WIDS = PLAYER_1,"PlayerP1";

t[#t+1] = Def.ActorFrame{
		OnCommand=cmd(z,20);
Def.ActorFrame{
	InitCommand=function(self)
	self:visible(false)
	end;
	SigMessageCommand=function(self)
	if GAMESTATE:IsHumanPlayer(PLAYER_1) then
	if SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_1):IsFailing() or SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_1):GetLife() == 0 then
		WIDS = "PlayerP1";
	end
	end
	if GAMESTATE:IsHumanPlayer(PLAYER_2) then
	if SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_2):IsFailing() or SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_2):GetLife() == 0 then
		WIDS ="PlayerP2";
	end
	end
	local Me = scale(math.random(0,1),0,1,-1,1);
	SCREENMAN:GetTopScreen():GetChild(WIDS):finishtweening():accelerate(0.7):rotationz(math.random(30)*Me):y(SCREEN_BOTTOM*1.75):addx(30*Me);
	self:x(SCREENMAN:GetTopScreen():GetChild(WIDS):GetX()):y(SCREENMAN:GetTopScreen():GetChild(WIDS):GetY()-50):visible(true):sleep(0.7):queuecommand("Ma")
	end;
	MaCommand=cmd(bob;effectmagnitude,0,5,0);
	LoadFont("Common Normal")..{
	Text = "O";
	InitCommand = cmd(x,-50;y,-25;zoom,3;diffusebottomedge,Color.Red or color("#FF0000"));
	OnCommand = cmd(y,-SCREEN_CENTER_Y+50-50;rotationz,math.random(-10,10);sleep,math.random(1,5)/10;bouncebegin,0.7;y,-25;rotationz,0;);
	};
	LoadFont("Common Normal")..{
	Text = "h";
	InitCommand = cmd(x,0;y,-25;zoom,3;diffusebottomedge,Color.Red or color("#FF0000"));
	OnCommand = cmd(y,-SCREEN_CENTER_Y+50-50;rotationz,math.random(-10,10);sleep,math.random(1,5)/10;bouncebegin,0.7;y,-25;rotationz,0;);
	};
	LoadFont("Common Normal")..{
	Text = "N";
	InitCommand = cmd(x,0-20;y,25;zoom,3;diffusebottomedge,Color.Red or color("#FF0000"));
	OnCommand = cmd(y,-SCREEN_CENTER_Y+50-50;rotationz,math.random(-10,10);sleep,math.random(1,5)/10;bouncebegin,0.7;y,25;rotationz,0;);
	};
	LoadFont("Common Normal")..{
	Text = "o";
	InitCommand = cmd(x,50-30;y,25;zoom,3;diffusebottomedge,Color.Red or color("#FF0000"));
	OnCommand = cmd(y,-SCREEN_CENTER_Y+50-50;rotationz,math.random(-10,10);sleep,math.random(1,5)/10;bouncebegin,0.7;y,25;rotationz,0;);
	};
	LoadFont("Common Normal")..{
	Text = "!";
	InitCommand = cmd(x,80-30;y,25;zoom,3;diffusebottomedge,Color.Red or color("#FF0000"));
	OnCommand = cmd(y,-SCREEN_CENTER_Y+50-50;rotationz,math.random(-10,10);sleep,math.random(1,5)/10;bouncebegin,0.7;y,25;rotationz,0;);
	};
};
LoadActor("MAY")..{
SigMessageCommand=cmd(play);
};
		

LoadActor("MEMEDirected (loop)")..{
	DirectedMessageCommand=cmd(play);
};
Def.Quad{
	DirectedMessageCommand=cmd(zoom,99999;diffuse,color("#000000FF"););
};
LoadFont("_century schoolbook 72px")..{
	OnCommand=cmd(diffusealpha,0;Center;zoom,0.35;);
	DirectedMessageCommand=function(self)
		

		self:sleep(1.234)
		self:diffusealpha(1)
		self:settext("Directed by\nROBERT B.WEIDE")
		self:sleep(4.526-1.234)
		self:queuecommand("Ex")
	end;
	ExCommand=cmd(settext,"Executive Producer\nLARRY DAVID";sleep,7.794-4.526;queuecommand,"me");
	meCommand=function(self)
		local lt = "Executive Producer\n";
		for player in ivalues(GAMESTATE:GetHumanPlayers()) do
			lt=lt..PN_Name(player).." ";
		end
		self:settext(lt)
	end
};


		
Def.Quad{
	InitCommand=cmd(FullScreen;diffuse,color("#00000000"));
	NeFailMessageCommand=cmd(linear,0.2;diffusealpha,1;linear,0.5;diffusealpha,0;linear,2;diffuse,{0.4,0.1,0.1,0.6});
};
Def.Quad{
	InitCommand=cmd(FullScreen;diffuse,color("#FF888800");blend,"BlendMode_Modulate");
	NeFailMessageCommand=cmd(diffusealpha,1);
};


Def.Sprite{
	InitCommand=cmd(blend,"BlendMode_Add";CenterX;y,SCREEN_CENTER_Y-100;animate,false;zoom,0.9;diffuse,{1,0,0,0});
	OnCommand=cmd(Load,THEME:GetCurrentThemeDirectory().."Resource/GraphFont/BigCount/FAIL.png");
	NeFailMessageCommand=cmd(sleep,Ror;decelerate,0.5;diffusealpha,1;y,SCREEN_CENTER_Y-50);
};
LoadActor("Failll") .. {
		NeFailMessageCommand=cmd(play);
};
};]]


--[[
	Control Part
]]

if ToEnumShortString(GAMESTATE:GetCurrentStage()) == "Event" and not IsNetConnected() then

	t[#t+1] = Def.ActorFrame{
	LoadFont("Common Normal")..{
	Text="-Retry-";
		InitCommand=cmd(diffusealpha,0);
		AFTERFAILMessageCommand=cmd(CenterX;y,SCREEN_CENTER_Y+15+80;zoom,5;diffuse,Color.Magenta;diffusealpha,0;wag;effectmagnitude,0,0,-2;effectperiod,10;effectoffset,3;sleep,Ror;decelerate,0.5;diffusealpha,1;diffuse,Color.Green;zoom,2);
		YestoNewMessageCommand=cmd(stoptweening;decelerate,0.25;diffuse,Color.Green;diffusealpha,1;zoom,2);
		NotoNewMessageCommand=cmd(stoptweening;decelerate,0.25;diffuse,Color.Magenta;diffusealpha,1;zoom,1.5);
		HideMenuuuMessageCommand=cmd(stoptweening;visible,false);
	};
	LoadFont("Common Normal")..{
	Text="-Give it up-";
	InitCommand=cmd(diffusealpha,0);
		AFTERFAILMessageCommand=cmd(CenterX;y,SCREEN_CENTER_Y+60+80;zoom,5;diffuse,Color.Magenta;diffusealpha,0;wag;effectmagnitude,0,0,-2;effectperiod,10;effectoffset,5;sleep,Ror;decelerate,0.5;diffusealpha,1;zoom,1.5);
		YestoSWYDMessageCommand=cmd(stoptweening;decelerate,0.25;diffuse,Color.Green;diffusealpha,1;zoom,2);
		NotoSWYDMessageCommand=cmd(stoptweening;decelerate,0.25;diffuse,Color.Magenta;diffusealpha,1;zoom,1.5);
		HideMenuuuMessageCommand=cmd(stoptweening;visible,false);
	};
	Def.Quad{
	InitCommand=cmd(zoom,999999;diffuse,color("#55555500"));
		AFTERFAILMessageCommand=function(self)
			
				self:sleep(Ror):queuecommand('LOOOP')
			end;
		LOOOPCommand=function(self)
			Allow_Press = true;
		end;
	};
	Def.Quad {
		InitCommand=cmd(diffusealpha,0;rotationx,35;);
		BeginCommand=cmd(diffuse,color("#00000000");Center;zoom,9999);
		RetMessageCommand=cmd(decelerate,0.75;diffusealpha,1;rotationx,0;queuecommand,"Goo");
		GooCommand=function() GAMESTATE:ApplyGameCommand('screen,ScreenGameplay'); end;
	};
		Def.Quad{
			InitCommand=cmd(zoom,9999;diffuse,Color.Black;diffusealpha,0);
			OnCommand=cmd(playcommand,'GOO');
			GOOCommand=function(self)
				--printf(" Let her = %s %d",tostring(IDontWantLetHerGo),math.random(00,99))
				if not IDontWantLetHerGo then
					self:accelerate(0.5):diffuse(color("#FFAAAA")):diffusealpha(1)
				else
					self:sleep(0.02):queuecommand("GOO")
				end
			end;
		};
			LoadActor( THEME:GetPathS("Common","start") )..{
				_FailOkayMessageCommand=cmd(play);
			};
			LoadActor( THEME:GetPathS("Common","value") )..{
				_FailArrowMessageCommand=cmd(play);
			};
	};

end


return t;