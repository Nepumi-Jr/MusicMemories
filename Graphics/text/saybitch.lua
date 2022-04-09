local Neptune_textbox;
local t = Def.ActorFrame{};
t[#t+1] = Def.ActorFrame{
LoadActor("Hi")..{ InitCommand=function(self) end; 
};
		LoadFont("_determination sans 26px")..{
			InitCommand=function(self) self:horizalign(left); self:x(SCREEN_CENTER_X-200); self:y(SCREEN_CENTER_Y+80); self:diffuse(color("#FFFFFF")); self:zoom(1); self:cropright(1); end;
			OnCommand=function(self) self:sleep(1); self:playcommand('Nep'); end;
			NepCommand=function(self)
			self:settext("Madddddd");
			self:linear(0.5);
			self:cropright(0);
		clearThis();
		hideBubble();
	Neptune_textbox:x(SCREEN_CENTER_X-100);
	--Neptune_textbox:y(SCREEN_CENTER_Y+125);
	Neptune_textbox:zoom(3);
						 setBubble(0,9,12);
						 hideBubble();
						 colourText(1,45,1,1,1,1);
						 --effect(8,16,'rainbow',0,1,0,2);
						 setTalkSpeeds(25,28,0.25);
			effect(1,45,'awesome',0,1,0,2);
			sayThis("This is too hard  for you...",0.05,'Asgore.mp3',2);
			end;
		};
	--[[Def.Quad {--mouse!
	OnCommand=function(self)
	clearThis()
	hideBubble()
	GG_textbox:x(SCREEN_CENTER_X+50)
	GG_textbox:zoom(3)
	setBubble(0,9,12)
	hideBubble()
	colourText(1,45,1,1,1,1)
						 --effect(1,45,'awesome',0,1,0,2)
						 --effect(18,45,'rainbow',0,1,0,2)
						-- if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
						-- GG_textbox:y(SCREEN_CENTER_Y-50)
						-- sayThis("*congratulations!",0.05,'Tick.ogg',2)
						-- else
	GG_textbox:y(SCREEN_CENTER_Y+50)
	sayThis("*Cleared!         -Awesome!-",0.05,'')
						-- end
	setTalkSpeeds(18,28,0.1)
	end;
	};]]
};

return t;