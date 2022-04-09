
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

local FailType = math.random(1,20)
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
elseif FailType >= 11 and FailType <= 15 then
	t[#t+1]=LoadActor("Pump");
	Ror = 4
elseif FailType >= 16 and FailType <= 20 then
	t[#t+1]=LoadActor("DefaultLoooong");--So OG
	Ror = 12
end


--[[local WIDS = PLAYER_1,"PlayerP1";

t[#t+1] = Def.ActorFrame{
		OnCommand=function(self) self:z(20); end;
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
	MaCommand=function(self) self:bob(); self:effectmagnitude(0,5,0); end;
	LoadFont("Common Normal")..{
	Text = "O";
	InitCommand = function(self) self:x(-50); self:y(-25); self:zoom(3); self:diffusebottomedge(Color.Red or color("#FF0000")); end;
	OnCommand = function(self) self:y(-SCREEN_CENTER_Y+50-50); self:rotationz(math.random(-10,10)); self:sleep(math.random(1,5)/10); self:bouncebegin(0.7); self:y(-25); self:rotationz(0); end;
	};
	LoadFont("Common Normal")..{
	Text = "h";
	InitCommand = function(self) self:x(0); self:y(-25); self:zoom(3); self:diffusebottomedge(Color.Red or color("#FF0000")); end;
	OnCommand = function(self) self:y(-SCREEN_CENTER_Y+50-50); self:rotationz(math.random(-10,10)); self:sleep(math.random(1,5)/10); self:bouncebegin(0.7); self:y(-25); self:rotationz(0); end;
	};
	LoadFont("Common Normal")..{
	Text = "N";
	InitCommand = function(self) self:x(0-20); self:y(25); self:zoom(3); self:diffusebottomedge(Color.Red or color("#FF0000")); end;
	OnCommand = function(self) self:y(-SCREEN_CENTER_Y+50-50); self:rotationz(math.random(-10,10)); self:sleep(math.random(1,5)/10); self:bouncebegin(0.7); self:y(25); self:rotationz(0); end;
	};
	LoadFont("Common Normal")..{
	Text = "o";
	InitCommand = function(self) self:x(50-30); self:y(25); self:zoom(3); self:diffusebottomedge(Color.Red or color("#FF0000")); end;
	OnCommand = function(self) self:y(-SCREEN_CENTER_Y+50-50); self:rotationz(math.random(-10,10)); self:sleep(math.random(1,5)/10); self:bouncebegin(0.7); self:y(25); self:rotationz(0); end;
	};
	LoadFont("Common Normal")..{
	Text = "!";
	InitCommand = function(self) self:x(80-30); self:y(25); self:zoom(3); self:diffusebottomedge(Color.Red or color("#FF0000")); end;
	OnCommand = function(self) self:y(-SCREEN_CENTER_Y+50-50); self:rotationz(math.random(-10,10)); self:sleep(math.random(1,5)/10); self:bouncebegin(0.7); self:y(25); self:rotationz(0); end;
	};
};
LoadActor("MAY")..{
SigMessageCommand=function(self) self:play(); end;
};
		

LoadActor("MEMEDirected (loop)")..{
	DirectedMessageCommand=function(self) self:play(); end;
};
Def.Quad{
	DirectedMessageCommand=function(self) self:zoom(99999); self:diffuse(color("#000000FF")); end;
};
LoadFont("_century schoolbook 72px")..{
	OnCommand=function(self) self:diffusealpha(0); self:Center(); self:zoom(0.35); end;
	DirectedMessageCommand=function(self)
		

		self:sleep(1.234)
		self:diffusealpha(1)
		self:settext("Directed by\nROBERT B.WEIDE")
		self:sleep(4.526-1.234)
		self:queuecommand("Ex")
	end;
	ExCommand=function(self) self:settext("Executive Producer\nLARRY DAVID"); self:sleep(7.794-4.526); self:queuecommand("me"); end;
	meCommand=function(self)
		local lt = "Executive Producer\n";
		for player in ivalues(GAMESTATE:GetHumanPlayers()) do
			lt=lt..PN_Name(player).." ";
		end
		self:settext(lt)
	end
};


		
Def.Quad{
	InitCommand=function(self) self:FullScreen(); self:diffuse(color("#00000000")); end;
	NeFailMessageCommand=function(self) self:linear(0.2); self:diffusealpha(1); self:linear(0.5); self:diffusealpha(0); self:linear(2); self:diffuse({0.4,0.1,0.1,0.6}); end;
};
Def.Quad{
	InitCommand=function(self) self:FullScreen(); self:diffuse(color("#FF888800")); self:blend("BlendMode_Modulate"); end;
	NeFailMessageCommand=function(self) self:diffusealpha(1); end;
};


Def.Sprite{
	InitCommand=function(self) self:blend("BlendMode_Add"); self:CenterX(); self:y(SCREEN_CENTER_Y-100); self:animate(false); self:zoom(0.9); self:diffuse({1,0,0,0}); end;
	OnCommand=function(self) self:Load(THEME:GetCurrentThemeDirectory().."Graphics/_GraphFont/BigCount/FAIL.png"); end;
	NeFailMessageCommand=function(self) self:sleep(Ror); self:decelerate(0.5); self:diffusealpha(1); self:y(SCREEN_CENTER_Y-50); end;
};
LoadActor("Failll") .. {
		NeFailMessageCommand=function(self) self:play(); end;
};
};]]


--[[
	Control Part
]]

if ToEnumShortString(GAMESTATE:GetCurrentStage()) == "Event" and not IsNetConnected() then

	t[#t+1] = Def.ActorFrame{
	LoadFont("Common Normal")..{
	Text="-Retry-";
		InitCommand=function(self) self:diffusealpha(0); end;
		AFTERFAILMessageCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y+15+80); self:zoom(5); self:diffuse(Color.Magenta); self:diffusealpha(0); self:wag(); self:effectmagnitude(0,0,-2); self:effectperiod(10); self:effectoffset(3); self:sleep(Ror); self:decelerate(0.5); self:diffusealpha(1); self:diffuse(Color.Green); self:zoom(2); end;
		YestoNewMessageCommand=function(self) self:stoptweening(); self:decelerate(0.25); self:diffuse(Color.Green); self:diffusealpha(1); self:zoom(2); end;
		NotoNewMessageCommand=function(self) self:stoptweening(); self:decelerate(0.25); self:diffuse(Color.Magenta); self:diffusealpha(1); self:zoom(1.5); end;
		HideMenuuuMessageCommand=function(self) self:stoptweening(); self:visible(false); end;
	};
	LoadFont("Common Normal")..{
	Text="-Give it up-";
	InitCommand=function(self) self:diffusealpha(0); end;
		AFTERFAILMessageCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y+60+80); self:zoom(5); self:diffuse(Color.Magenta); self:diffusealpha(0); self:wag(); self:effectmagnitude(0,0,-2); self:effectperiod(10); self:effectoffset(5); self:sleep(Ror); self:decelerate(0.5); self:diffusealpha(1); self:zoom(1.5); end;
		YestoSWYDMessageCommand=function(self) self:stoptweening(); self:decelerate(0.25); self:diffuse(Color.Green); self:diffusealpha(1); self:zoom(2); end;
		NotoSWYDMessageCommand=function(self) self:stoptweening(); self:decelerate(0.25); self:diffuse(Color.Magenta); self:diffusealpha(1); self:zoom(1.5); end;
		HideMenuuuMessageCommand=function(self) self:stoptweening(); self:visible(false); end;
	};
	Def.Quad{
	InitCommand=function(self) self:zoom(999999); self:diffuse(color("#55555500")); end;
		AFTERFAILMessageCommand=function(self)
			
				self:sleep(Ror):queuecommand('LOOOP')
			end;
		LOOOPCommand=function(self)
			Allow_Press = true;
		end;
	};
	Def.Quad {
		InitCommand=function(self) self:diffusealpha(0); self:rotationx(35); end;
		BeginCommand=function(self) self:diffuse(color("#00000000")); self:Center(); self:zoom(9999); end;
		RetMessageCommand=function(self) self:decelerate(0.75); self:diffusealpha(1); self:rotationx(0); self:queuecommand("Goo"); end;
		GooCommand=function() 
            TP.Eva.readyState = 2;
            SCREENMAN:GetTopScreen():SetNextScreenName("ScreenProfileSave"):StartTransitioningScreen("SM_DoNextScreen");
        end;
	};
		Def.Quad{
			InitCommand=function(self) self:zoom(9999); self:diffuse(Color.Black); self:diffusealpha(0); end;
			OnCommand=function(self) self:playcommand('GOO'); end;
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
				_FailOkayMessageCommand=function(self) self:play(); end;
			};
			LoadActor( THEME:GetPathS("Common","value") )..{
				_FailArrowMessageCommand=function(self) self:play(); end;
			};
	};

end


return t;