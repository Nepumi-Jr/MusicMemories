local DiffRow = 1;
local PathS = THEMEDIR().."BGAnimations/ScreenGamesMem overlay/";
--[[
1 = 8Digit
2 = 10Digit
3 = 12Digit
]]
local Number={};--from Set
local input1;--Number of XXXXXXXXXX
local input2;
local Num1={};--Number Row with Set
local Num2={};
local PS1={};
local Ps2={};
local Pon1={};--Yep Nope
local Pon2={};
local Proce = 0;
local P1R;
local P2R;
local ret = 1;
local Ans2Re = false;
--[[Proce
0 = Reset
1 = Select
2 = Watch and Learn
3 = Input of player
4 = re Pon
5 = try?
]]
function Diff4Cl(D)
if D == 1 then
	return color("#66FFAA");
elseif D == 2 then
	return color("#66AAFF");
else
	return color("#FFAA66");
end
end;
local Nya = 0;
local InputOfArrow = function( event )

	-- if (somehow) there's no event, bail
	if not event then return end

	if event.type == "InputEventType_FirstPress" then
		
		if (event.button == "Left" or event.button == "DownLeft" or event.button == "MenuLeft") and event.PlayerNumber == PLAYER_1 then
			if Proce == 1 then
				if DiffRow == 1 then
					DiffRow = 3
				else
					DiffRow = DiffRow - 1
				end
			elseif Proce == 3 then
				if input1 == 1 then
					if DiffRow == 1 then
					input1 = 8
					elseif DiffRow == 2 then
					input1 = 10
					elseif DiffRow == 3 then
					input1 = 12
				end
				else
					input1 = input1 - 1
				end
			elseif Proce == 5 then
				if ret == 1 then
				ret = 2
				else
				ret = 1
				end
			end
			MESSAGEMAN:Broadcast('Chan')
		Nya = math.random(2,9);
		end

		
		if (event.button == "Right" or event.button == "DownRight" or event.button == "MenuRight") and event.PlayerNumber == PLAYER_1 then
			if Proce == 1 then
				if DiffRow == 3 then
					DiffRow = 1
				else
					DiffRow = DiffRow + 1
				end
			elseif Proce == 3 then
				if (DiffRow == 1 and input1 == 8) or (DiffRow == 2 and input1 == 10) or (DiffRow == 3 and input1 == 12) then
					input1 = 1
				else
					input1 = input1 + 1
				end
			elseif Proce == 5 then
				if ret == 1 then
				ret = 2
				else
				ret = 1
				end
			end
			MESSAGEMAN:Broadcast('Chan')
		end
		
		
		if (event.button == "Up" or event.button == "MenuUp" or event.button == "UpLeft") and event.PlayerNumber == PLAYER_1 then
			if Proce == 1 then
				if DiffRow == 1 then
					DiffRow = 3
				else
					DiffRow = DiffRow - 1
				end
			elseif Proce == 3 then
			if Num1[input1] == 0 then
				Num1[input1] = 9
			else
				Num1[input1] = Num1[input1] - 1
			end
			elseif Proce == 5 then
				if ret == 1 then
				ret = 2
				else
				ret = 1
				end
			end
			MESSAGEMAN:Broadcast('Chan')
		end
		
		if (event.button == "Down" or event.button == "MenuDown" or event.button == "UpRight") and event.PlayerNumber == PLAYER_1 then
			if Proce == 1 then
				if DiffRow == 3 then
					DiffRow = 1
				else
					DiffRow = DiffRow + 1
				end
			elseif Proce == 3 then
			if Num1[input1] == 9 then
				Num1[input1] = 0
			else
				Num1[input1] = Num1[input1] + 1
			end
			elseif Proce == 5 then
				if ret == 1 then
				ret = 2
				else
				ret = 1
				end
			end
			MESSAGEMAN:Broadcast('Chan')
		end
		
		if event.button == "Start" and event.PlayerNumber == PLAYER_1 then
		MESSAGEMAN:Broadcast('Yeah')
			if Proce == 1 then
			Proce = Proce + 1
			elseif Proce == 3 then
				P1R = true;
				MESSAGEMAN:Broadcast('P1Rea')
			elseif Proce == 4 and Ans2Re then
				MESSAGEMAN:Broadcast('Ret')
				Proce = 5;
			elseif Proce == 5 then
			if ret == 1 then
				Proce = 0;
			elseif ret == 2 then
				SCREENMAN:GetTopScreen():SetNextScreenName("ScreenSelectMiniGames"):StartTransitioningScreen("SM_GoToNextScreen")
				--SCREENMAN:GetTopScreen():RemoveInputCallback(InputOfArrow)
			end
			MESSAGEMAN:Broadcast('Con');
			end
		end
		
		
		
		if (event.button == "Left" or event.button == "MenuLeft" or event.button == "DownLeft") and event.PlayerNumber == PLAYER_2 then
			if Proce == 1 then
				if DiffRow == 1 then
					DiffRow = 3
				else
					DiffRow = DiffRow - 1
				end
			elseif Proce == 3 then
				if input2 == 1 then
					if DiffRow == 1 then
					input2 = 8
					elseif DiffRow == 2 then
					input2 = 10
					elseif DiffRow == 3 then
					input2 = 12
				end
				else
					input2 = input2 - 1
				end
			elseif Proce == 5 then
				if ret == 1 then
				ret = 2
				else
				ret = 1
				end
			end
		Nya = math.random(2,9);
		MESSAGEMAN:Broadcast('Chan')
		end

		
		if (event.button == "Right" or event.button == "MenuRight" or event.button == "DownRight") and event.PlayerNumber == PLAYER_2 then
			if Proce == 1 then
				if DiffRow == 3 then
					DiffRow = 1
				else
					DiffRow = DiffRow + 1
				end
			elseif Proce == 3 then
				if (DiffRow == 1 and input2 == 8) or (DiffRow == 2 and input2 == 10) or (DiffRow == 3 and input2 == 12) then
					input2 = 1
				else
					input2 = input1 + 1
				end
			elseif Proce == 5 then
				if ret == 1 then
				ret = 2
				else
				ret = 1
				end
			end
		MESSAGEMAN:Broadcast('Chan')
		end
		
		
		if (event.button == "Up" or event.button == "MenuUp" or event.button == "UpLeft") and event.PlayerNumber == PLAYER_2 then
			if Proce == 1 then
				if DiffRow == 1 then
					DiffRow = 3
				else
					DiffRow = DiffRow - 1
				end
			elseif Proce == 3 then
			if Num2[input2] == 0 then
				Num2[input2] = 9
			else
				Num2[input2] = Num2[input2] - 1
			end
			elseif Proce == 5 then
				if ret == 1 then
				ret = 2
				else
				ret = 1
				end
			end
		MESSAGEMAN:Broadcast('Chan')
		end
		
		if (event.button == "Down" or event.button == "MenuDown" or event.button == "UpRight") and event.PlayerNumber == PLAYER_2 then
			if Proce == 1 then
				if DiffRow == 3 then
					DiffRow = 1
				else
					DiffRow = DiffRow + 1
				end
			elseif Proce == 3 then
			if Num2[input2] == 9 then
				Num2[input2] = 0
			else
				Num2[input2] = Num2[input2] + 1
			end
			elseif Proce == 5 then
				if ret == 1 then
				ret = 2
				else
				ret = 1
				end
			end
		MESSAGEMAN:Broadcast('Chan')
		end
		
		if event.button == "Start" and event.PlayerNumber == PLAYER_2 then
			MESSAGEMAN:Broadcast('Yeah')
			if Proce == 1 then
			Proce = Proce + 1
			elseif Proce == 3 then
				P2R = true;
				MESSAGEMAN:Broadcast('P2Rea')
			elseif Proce == 4 and Ans2Re then
				MESSAGEMAN:Broadcast('Ret')
				Proce = 5;
			elseif Proce == 5 then
			if ret == 1 then
				Proce = 0;
			elseif ret == 2 then
				SCREENMAN:GetTopScreen():SetNextScreenName("ScreenSelectMiniGames"):StartTransitioningScreen("SM_GoToNextScreen")
			SCREENMAN:GetTopScreen():RemoveInputCallback(InputOfArrow)
			end
			MESSAGEMAN:Broadcast('Con');
			end
		end
		
		if event.button == "Back" then
			MESSAGEMAN:Broadcast('Nope')
			SCREENMAN:GetTopScreen():SetNextScreenName("ScreenSelectMiniGames"):StartTransitioningScreen("SM_GoToNextScreen")
		end
		
	end

end
local HGHGHGHGHGH = 0;
local Displ = {};
local Disp1 = {};
local Disp2 = {};
local oooooooone = false;
local t = Def.ActorFrame{};
t[#t+1] = Def.ActorFrame{
		name = "I Hope Neptune Have a Good Dream";
LoadActor("VOL1-50-NTSC")..{
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffusealpha,1;zoomtoheight,SCREEN_HEIGHT;zoomtowidth,SCREEN_WIDTH;);
};
Def.Quad {--NOTESKIN
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("#000000");diffusealpha,0.5;zoomtoheight,SCREEN_HEIGHT;zoomtowidth,SCREEN_WIDTH;);
		RemMessageCommand=cmd(linear,1;diffusealpha,0.8);
		RetMessageCommand=cmd(linear,1;diffusealpha,0.5);
};
LoadFont("Common Large")..{
	OnCommand=cmd(Center;zoom,0.17;diffuse,PlayerColor(PLAYER_1);playcommand,'SSSS');
	SSSSCommand=function(self)
				SCREENMAN:GetTopScreen():AddInputCallback(InputOfArrow)
		--[[if Proce == 1 then
		self:settext("Loop?"..Nya.."  "..HGHGHGHGHGH.."\nProce :"..Proce.."\nDiff"..(6+DiffRow*2))
		elseif Proce == 3 then
		self:settext("Loop?"..HGHGHGHGHGH.."\nProce :"..Proce.."\nNum"..Number[1]..Number[2]..Number[3]..Number[4]..Number[5]..Number[6]..Number[7]..Number[8].."\nP1:"..Num1[1]..Num1[2]..Num1[3]..Num1[4]..Num1[5]..Num1[6]..Num1[7]..Num1[8])
		elseif Proce == 4 then
		elseif Proce == 5 then
		self:settext("Loop?"..HGHGHGHGHGH.."\nProce :"..Proce.."\nRes"..ret)
		else
		self:settext("Loop?"..HGHGHGHGHGH.."\nProce :"..Proce)
		end]]
		self:sleep(0.05)
		self:queuecommand('SSSS')
		end;
};	
};
t[#t+1] = Def.ActorFrame{
		OnCommand=cmd(playcommand,'HHE');
		HHECommand=function(self)
		HGHGHGHGHGH = math.random(1,189);
		if Proce == 0 then
		for i = 1,12 do
			Number[i] = 0;
			Num1[i] = 0;
			Num2[i] = 0;
			Displ[i] = nil;
			Disp1[i] = nil;
			Disp2[i] = nil;
			Pon1[i] = false;
			Pon2[i] = false;
			PS1[i] = false;
			Ps2[i] = false;
		end
		DiffRow =  1;
		input1 = 1;
		input2 = 1;
		P1R = false;
		P2R = false;
		Proce = 1;
		oooooooone = false
		Ans2Re = false;
		MESSAGEMAN:Broadcast('Rediff')
		elseif Proce == 2 and not oooooooone then
		for i = 1, 6 + DiffRow*2 do
			if i == 1 then
			Number[1] = math.random(1,9)
			else
			Number[i] = math.random(0,9)
			end
		end
		oooooooone = true
		if DiffRow == 1 then
			for i = 1,8 do
				Displ[i+2] = Number[i]
			end
		elseif DiffRow == 2 then
			for i = 1,10 do
				Displ[i+1] = Number[i]
			end
		else
			for i = 1,12 do
				Displ[i] = Number[i]
			end
		end
		if DiffRow == 1 then
			for i = 1,8 do
				Disp1[i+2] = Num1[i]
				Disp2[i+2] = Num2[i]
			end
		elseif DiffRow == 2 then
			for i = 1,10 do
				Disp1[i+1] = Num1[i]
				Disp2[i+1] = Num2[i]
			end
		else
			for i = 1,12 do
				Disp1[i] = Num1[i]
				Disp2[i] = Num2[i]
			end
		end
		MESSAGEMAN:Broadcast('Rem')
		
		elseif Proce == 3 and P1R and P2R then
		for i = 1, 6+DiffRow*2 do
			if Number[i] == Num1[i] then
				Pon1[i] = true
			else
				Pon1[i] = false
			end
			if Number[i] == Num2[i] then
				Pon2[i] = true
			else
				Pon2[i] = false
			end
			Proce = 4
			MESSAGEMAN:Broadcast('Rea')
			MESSAGEMAN:Broadcast('Kumtom')
		end
		end
		self:sleep(0.05)
		self:queuecommand('HHE')
		end;
		Def.ActorFrame{
			OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y-120;zoom,0);
			RediffMessageCommand=cmd(queuecommand,'Chan');
			ChanMessageCommand=function(self)
			self:finishtweening()
				self:bounceend(0.5)
				if Proce == 1 then
				if DiffRow == 1 then
					self:zoom(0.6)
					self:wag()
				else
					self:zoom(0.5)
					self:stopeffect()
				end
				end
				end;
			RemMessageCommand=cmd(finishtweening;decelerate,0.5;zoom,0);
			LoadModule("Menu.Button.lua")(0,0,color("#AAFFAA"),color("#66FF66"),color("#66FFAA"),color("#000000"),color("#333333"),"Easy","8 Digit")
		};
		Def.ActorFrame{
			OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y;zoom,0);
			RediffMessageCommand=cmd(queuecommand,'Chan');
			ChanMessageCommand=function(self)
			self:finishtweening()
				self:bounceend(0.5)
				if Proce == 1 then
				if DiffRow == 2 then
					self:zoom(0.6)
					self:wag()
				else
					self:zoom(0.5)
					self:stopeffect()
				end
				end
				end;
			RemMessageCommand=cmd(finishtweening;decelerate,0.5;zoom,0);
			LoadModule("Menu.Button.lua")(0,0,color("#AAAAFF"),color("#6666FF"),color("#66AAFF"),color("#000000"),color("#333333"),"Medium","10 Digit")
		};
		Def.ActorFrame{
			OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y+120;zoom,0);
			RediffMessageCommand=cmd(queuecommand,'Chan');
			ChanMessageCommand=function(self)
			self:finishtweening()
				self:bounceend(0.5)
				if Proce == 1 then
				if DiffRow == 3 then
					self:zoom(0.6)
					self:wag()
				else
					self:zoom(0.5)
					self:stopeffect()
				end
				end
				end;
			RemMessageCommand=cmd(finishtweening;decelerate,0.5;zoom,0);
			LoadModule("Menu.Button.lua")(0,0,color("#FFAAAA"),color("#FF6666"),color("#FFAA66"),color("#000000"),color("#333333"),"Hard","12 Digit")
		};
		Def.ActorFrame{
			RemMessageCommand=cmd(sleep,2+2.127;queuecommand,'Sam');
			SamCommand=cmd(sleep,0.662;queuecommand,'Song');
			SongCommand=cmd(sleep,0.5;queuecommand,'Nueng');
			NuengCommand=cmd(sleep,0.5;queuecommand,'ShowN');
			ShowNCommand=cmd(sleep,5;queuecommand,'HideN');
			HideNCommand = function() Proce = 3 MESSAGEMAN:Broadcast('Lagorn') end;
			LoadActor("Intro.wav")..{RemMessageCommand=cmd(play)};
			LoadActor("CD.wav")..{SamMessageCommand=cmd(play)};
			LoadActor("ShowN.wav")..{ReaMessageCommand=cmd(play)};
			LoadActor("End.wav")..{RetMessageCommand=cmd(play)};
			LoadActor( THEME:GetPathS("Common","start") )..{YeahMessageCommand=cmd(play);};
			LoadActor( THEME:GetPathS("Common","cancel") )..{NopeMessageCommand=cmd(play);};
			LoadActor( THEME:GetPathS("Common","value") )..{ChanMessageCommand=cmd(play);};
			LoadFont("Common Large")..{
			OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y*0.15;zoom,0.4;diffuse,Diff4Cl(DiffRow);diffusealpha,0);
			RemMessageCommand=cmd(diffusealpha,0;settext,"Memorize the numbers in   ";linear,1;diffusealpha,1);
			SamMessageCommand=cmd(settext,"Memorize the numbers in 3");
			SongMessageCommand=cmd(settext,"Memorize the numbers in 2");
			NuengMessageCommand=cmd(settext,"Memorize the numbers in 1");
			ShowNMessageCommand=cmd(settext,"");
			HideNMessageCommand=cmd(settext,"Answer number!");
			ReaMessageCommand=cmd(settext,"Check answer!");
			RetMessageCommand=cmd(settext,"");
			};
			LoadFont("Combo Numbers")..{
				OnCommand=cmd(x,SCREEN_CENTER_X-40*(5.5);y,SCREEN_CENTER_Y*0.5;zoom,0.7;diffuse,Diff4Cl(DiffRow));
				RemMessageCommand=function(self) self:sleep(0.1):decelerate(0.25):addy(-50):diffusealpha(1)
					if Displ[1] == nil then self:settext("") else self:settext("?") end self:accelerate(0.25):addy(50) end;
				ShowNMessageCommand=cmd(settext,Displ[1] or ""); HideNMessageCommand=function(self) if Displ[1] == nil then self:settext("") else self:settext("?") end end;
				ReaMessageCommand=cmd(settext,Displ[1] or ""); RetMessageCommand=cmd(decelerate,0.5;diffusealpha,0);
			};
			LoadFont("Combo Numbers")..{
				OnCommand=cmd(x,SCREEN_CENTER_X-40*(4.5);y,SCREEN_CENTER_Y*0.5;zoom,0.7;diffuse,Diff4Cl(DiffRow));
				RemMessageCommand=function(self) self:sleep(0.2):decelerate(0.25):addy(-50):diffusealpha(1)
					if Displ[2] == nil then self:settext("") else self:settext("?") end self:accelerate(0.25):addy(50) end;
				ShowNMessageCommand=cmd(settext,Displ[2] or ""); HideNMessageCommand=function(self) if Displ[2] == nil then self:settext("") else self:settext("?") end end;
				ReaMessageCommand=cmd(settext,Displ[2] or ""); RetMessageCommand=cmd(decelerate,0.5;diffusealpha,0);
			};
			LoadFont("Combo Numbers")..{
				OnCommand=cmd(x,SCREEN_CENTER_X-40*(3.5);y,SCREEN_CENTER_Y*0.5;zoom,0.7;diffuse,Diff4Cl(DiffRow));
				RemMessageCommand=function(self) self:sleep(0.3):decelerate(0.25):addy(-50):diffusealpha(1)
					if Displ[3] == nil then self:settext("") else self:settext("?") end self:accelerate(0.25):addy(50) end;
				ShowNMessageCommand=cmd(settext,Displ[3] or ""); HideNMessageCommand=function(self) if Displ[3] == nil then self:settext("") else self:settext("?") end end;
				ReaMessageCommand=cmd(settext,Displ[3] or ""); RetMessageCommand=cmd(decelerate,0.5;diffusealpha,0);
			};
			LoadFont("Combo Numbers")..{
				OnCommand=cmd(x,SCREEN_CENTER_X-40*(2.5);y,SCREEN_CENTER_Y*0.5;zoom,0.7;diffuse,Diff4Cl(DiffRow));
				RemMessageCommand=function(self) self:sleep(0.4):decelerate(0.25):addy(-50):diffusealpha(1)
					if Displ[4] == nil then self:settext("") else self:settext("?") end self:accelerate(0.25):addy(50) end;
				ShowNMessageCommand=cmd(settext,Displ[4] or ""); HideNMessageCommand=function(self) if Displ[4] == nil then self:settext("") else self:settext("?") end end;
				ReaMessageCommand=cmd(settext,Displ[4] or ""); RetMessageCommand=cmd(decelerate,0.5;diffusealpha,0);
			};
			LoadFont("Combo Numbers")..{
				OnCommand=cmd(x,SCREEN_CENTER_X-40*(1.5);y,SCREEN_CENTER_Y*0.5;zoom,0.7;diffuse,Diff4Cl(DiffRow));
				RemMessageCommand=function(self) self:sleep(0.5):decelerate(0.25):addy(-50):diffusealpha(1)
					if Displ[5] == nil then self:settext("") else self:settext("?") end self:accelerate(0.25):addy(50) end;
				ShowNMessageCommand=cmd(settext,Displ[5] or ""); HideNMessageCommand=function(self) if Displ[5] == nil then self:settext("") else self:settext("?") end end;
				ReaMessageCommand=cmd(settext,Displ[5] or ""); RetMessageCommand=cmd(decelerate,0.5;diffusealpha,0);
			};
			LoadFont("Combo Numbers")..{
				OnCommand=cmd(x,SCREEN_CENTER_X-40*(0.5);y,SCREEN_CENTER_Y*0.5;zoom,0.7;diffuse,Diff4Cl(DiffRow));
				RemMessageCommand=function(self) self:sleep(0.6):decelerate(0.25):addy(-50):diffusealpha(1)
					if Displ[6] == nil then self:settext("") else self:settext("?") end self:accelerate(0.25):addy(50) end;
				ShowNMessageCommand=cmd(settext,Displ[6] or ""); HideNMessageCommand=function(self) if Displ[6] == nil then self:settext("") else self:settext("?") end end;
				ReaMessageCommand=cmd(settext,Displ[6] or ""); RetMessageCommand=cmd(decelerate,0.5;diffusealpha,0);
			};
			LoadFont("Combo Numbers")..{
				OnCommand=cmd(x,SCREEN_CENTER_X-40*(-0.5);y,SCREEN_CENTER_Y*0.5;zoom,0.7;diffuse,Diff4Cl(DiffRow));
				RemMessageCommand=function(self) self:sleep(0.7):decelerate(0.25):addy(-50):diffusealpha(1)
					if Displ[7] == nil then self:settext("") else self:settext("?") end self:accelerate(0.25):addy(50) end;
				ShowNMessageCommand=cmd(settext,Displ[7] or ""); HideNMessageCommand=function(self) if Displ[7] == nil then self:settext("") else self:settext("?") end end;
				ReaMessageCommand=cmd(settext,Displ[7] or ""); RetMessageCommand=cmd(decelerate,0.5;diffusealpha,0);
			};
			LoadFont("Combo Numbers")..{
				OnCommand=cmd(x,SCREEN_CENTER_X-40*(-1.5);y,SCREEN_CENTER_Y*0.5;zoom,0.7;diffuse,Diff4Cl(DiffRow));
				RemMessageCommand=function(self) self:sleep(0.8):decelerate(0.25):addy(-50):diffusealpha(1)
					if Displ[8] == nil then self:settext("") else self:settext("?") end self:accelerate(0.25):addy(50) end;
				ShowNMessageCommand=cmd(settext,Displ[8] or ""); HideNMessageCommand=function(self) if Displ[8] == nil then self:settext("") else self:settext("?") end end;
				ReaMessageCommand=cmd(settext,Displ[8] or ""); RetMessageCommand=cmd(decelerate,0.5;diffusealpha,0);
			};
			LoadFont("Combo Numbers")..{
				OnCommand=cmd(x,SCREEN_CENTER_X-40*(-2.5);y,SCREEN_CENTER_Y*0.5;zoom,0.7;diffuse,Diff4Cl(DiffRow));
				RemMessageCommand=function(self) self:sleep(0.9):decelerate(0.25):addy(-50):diffusealpha(1)
					if Displ[9] == nil then self:settext("") else self:settext("?") end self:accelerate(0.25):addy(50) end;
				ShowNMessageCommand=cmd(settext,Displ[9] or ""); HideNMessageCommand=function(self) if Displ[9] == nil then self:settext("") else self:settext("?") end end;
				ReaMessageCommand=cmd(settext,Displ[9] or ""); RetMessageCommand=cmd(decelerate,0.5;diffusealpha,0);
			};
			LoadFont("Combo Numbers")..{
				OnCommand=cmd(x,SCREEN_CENTER_X-40*(-3.5);y,SCREEN_CENTER_Y*0.5;zoom,0.7;diffuse,Diff4Cl(DiffRow));
				RemMessageCommand=function(self) self:sleep(1):decelerate(0.25):addy(-50):diffusealpha(1)
					if Displ[10] == nil then self:settext("") else self:settext("?") end self:accelerate(0.25):addy(50) end;
				ShowNMessageCommand=cmd(settext,Displ[10] or ""); HideNMessageCommand=function(self) if Displ[10] == nil then self:settext("") else self:settext("?") end end;
				ReaMessageCommand=cmd(settext,Displ[10] or ""); RetMessageCommand=cmd(decelerate,0.5;diffusealpha,0);
			};
			LoadFont("Combo Numbers")..{
				OnCommand=cmd(x,SCREEN_CENTER_X-40*(-4.5);y,SCREEN_CENTER_Y*0.5;zoom,0.7;diffuse,Diff4Cl(DiffRow));
				RemMessageCommand=function(self) self:sleep(1.1):decelerate(0.25):addy(-50):diffusealpha(1)
					if Displ[11] == nil then self:settext("") else self:settext("?") end self:accelerate(0.25):addy(50) end;
				ShowNMessageCommand=cmd(settext,Displ[11] or ""); HideNMessageCommand=function(self) if Displ[11] == nil then self:settext("") else self:settext("?") end end;
				ReaMessageCommand=cmd(settext,Displ[11] or ""); RetMessageCommand=cmd(decelerate,0.5;diffusealpha,0);
			};
			LoadFont("Combo Numbers")..{
				OnCommand=cmd(x,SCREEN_CENTER_X-40*(-5.5);y,SCREEN_CENTER_Y*0.5;zoom,0.7;diffuse,Diff4Cl(DiffRow));
				RemMessageCommand=function(self) self:sleep(1.2):decelerate(0.25):addy(-50):diffusealpha(1)
					if Displ[12] == nil then self:settext("") else self:settext("?") end self:accelerate(0.25):addy(50) end;
				ShowNMessageCommand=cmd(settext,Displ[12] or ""); HideNMessageCommand=function(self) if Displ[12] == nil then self:settext("") else self:settext("?") end end;
				ReaMessageCommand=cmd(settext,Displ[12] or ""); RetMessageCommand=cmd(decelerate,0.5;diffusealpha,0);
			};
		};
};
--P1 Ans
t[#t+1] = Def.ActorFrame{
	ChanMessageCommand=function()
	if Proce == 3 then
		if DiffRow == 1 then
			for i = 1,8 do
				Disp1[i+2] = Num1[i]
				Disp2[i+2] = Num2[i]
			end
		elseif DiffRow == 2 then
			for i = 1,10 do
				Disp1[i+1] = Num1[i]
				Disp2[i+1] = Num2[i]
			end
		else
			for i = 1,12 do
				Disp1[i] = Num1[i]
				Disp2[i] = Num2[i]
			end
		end
	end
	MESSAGEMAN:Broadcast('ND')
	end;
};
for i = 1,12 do
			t[#t+1] = LoadFont("Combo Numbers")..{
				InitCommand=cmd(x,SCREEN_CENTER_X+45*(i-6.5);y,SCREEN_CENTER_Y*1.5-(108*0.35);zoom,0;diffuse,PlayerColor(PLAYER_1));
				LagornMessageCommand=function(self)
				self:sleep(0.1)
				self:settext(Disp1[i] or ""):sleep(0.1*i):bounceend(0.5):zoom(0.7)
				if input1+(3-DiffRow) == i then
				self:decelerate(0.25):zoom(0.85):diffuse(ColorLightTone(PlayerColor(PLAYER_1)))
				end
				end;
				NDMessageCommand=function(self)
				self:sleep(0.1)
				if Proce == 3 then
				if input1+(3-DiffRow) == i then
				self:settext(Disp1[i] or ""):finishtweening():decelerate(0.25):zoom(0.85):diffuse(ColorLightTone(PlayerColor(PLAYER_1)))
				else
				self:settext(Disp1[i] or ""):finishtweening():decelerate(0.25):zoom(0.7):diffuse(PlayerColor(PLAYER_1))
				end
				end
				end;
				KumtomMessageCommand=function(self)
					self:finishtweening()
				if Disp1[i] == nil then
				self:settext("")
				else
				if Num1[1] == 0 then
				self:finishtweening():sleep(0.1*i):decelerate(0.5):y(-60):diffusealpha(0)
				end
				end
				end;
				PingMessageCommand=function(self)
				if Num1[1] ~= 0 then
				if Disp1[i] == nil then
				self:settext("")
				else
				self:sleep(0.5*(i-(DiffRow-2)))
				if Pon1[i-(3-DiffRow)] then
					self:diffuse(color("#00FF00"))
					self:queuecommand("Yey")
				else
					self:diffuse(color("#FF0000"))
					self:queuecommand("Maii")
				end
				end
				end
				end;
				YeyCommand=function() if not PS1[i-(3-DiffRow)] and Proce == 4 then SOUND:PlayOnce(PathS..'Yep.wav') PS1[i-(3-DiffRow)] = true end end;
				MaiiCommand=function() if not PS1[i-(3-DiffRow)] and Proce == 4 then SOUND:PlayOnce(PathS..'Nope.wav') PS1[i-(3-DiffRow)] = true end end;
				ReaMessageCommand=cmd(finishtweening;decelerate,0.5;zoom,0.7;diffuse,PlayerColor(PLAYER_1));
				RetMessageCommand=cmd(finishtweening;bounceend,0.5;zoom,0;diffuse,PlayerColor(PLAYER_1);y,SCREEN_CENTER_Y*1.5-(108*0.35););
			};
end;

for i = 1,12 do
			t[#t+1] = LoadFont("Combo Numbers")..{
				InitCommand=cmd(x,SCREEN_CENTER_X+45*(i-6.5);y,SCREEN_CENTER_Y*1.5+(108*0.35);zoom,0;diffuse,PlayerColor(PLAYER_2));
				LagornMessageCommand=function(self)
				self:sleep(0.1)
				self:settext(Disp2[i] or ""):sleep(0.1*i):bounceend(0.5):zoom(0.7)
				if input2+(3-DiffRow) == i then
				self:decelerate(0.25):zoom(0.85):diffuse(ColorLightTone(PlayerColor(PLAYER_2)))
				end
				end;
				NDMessageCommand=function(self)
				self:sleep(0.1)
				if Proce == 3 then
				if input2+(3-DiffRow) == i then
				self:settext(Disp2[i] or ""):finishtweening():decelerate(0.25):zoom(0.85):diffuse(ColorLightTone(PlayerColor(PLAYER_2)))
				else
				self:settext(Disp2[i] or ""):finishtweening():decelerate(0.25):zoom(0.7):diffuse(PlayerColor(PLAYER_2))
				end
				end
				end;
				KumtomMessageCommand=function(self)
					self:finishtweening()
				if Disp2[i] == nil then
				self:settext("")
				else
				if Num2[1] == 0 then
				self:finishtweening():sleep(0.1*i):decelerate(0.5):y(SCREEN_CENTER_Y*2+60):diffusealpha(0)
				end
				end
				end;
				PingMessageCommand=function(self)
				if Num2[1] ~= 0 then
				if Disp2[i] == nil then
				else
				self:sleep(0.5*(i-(DiffRow-2)))
				if Pon2[i-(3-DiffRow)] then
					self:diffuse(color("#00FF00"))
					self:queuecommand("Yey")
				else
					self:diffuse(color("#FF0000"))
					self:queuecommand("Maii")
				end
				end
				end
				if i == 12 then
				Ans2Re = true
				end
				end;
				YeyCommand=function() if not Ps2[i-(3-DiffRow)] and Proce == 4 then SOUND:PlayOnce(PathS..'Yep.wav') Ps2[i-(3-DiffRow)] = true end end;
				MaiiCommand=function() if not Ps2[i-(3-DiffRow)] and Proce == 4 then SOUND:PlayOnce(PathS..'Nope.wav') Ps2[i-(3-DiffRow)] = true end end;
				ReaMessageCommand=cmd(finishtweening;decelerate,0.5;zoom,0.7;diffuse,PlayerColor(PLAYER_2));
				RetMessageCommand=cmd(finishtweening;bounceend,0.5;zoom,0;diffuse,PlayerColor(PLAYER_2);y,SCREEN_CENTER_Y*1.5+(108*0.35););
			};
end;
t[#t+1] = Def.ActorFrame{
	ReaMessageCommand=cmd(finishtweening;sleep,2;queuecommand,'AAAns');
	AAAnsCommand=function(self) MESSAGEMAN:Broadcast('Ping') end;
	PingMessageCommand=cmd(sleep,2+0.5*(6+DiffRow*2));
	LoadActor("Ready.png")..{
		OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y*1.5-(108*0.35)+20;zoom,5*0.4;diffusealpha,0);
		P1ReaMessageCommand=cmd(decelerate,0.5;diffusealpha,1;zoom,1;rotationz,360*math.random(2,9);zoom,0.4);
		ReaMessageCommand=cmd(finishtweening;sleep,0.1;decelerate,0.5;zoom,2;diffusealpha,0;rotationz,0);
	};
	LoadActor("Ready.png")..{
		OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y*1.5+(108*0.35)+20;zoom,5*0.4;diffusealpha,0);
		P2ReaMessageCommand=cmd(decelerate,0.5;diffusealpha,1;zoom,1;rotationz,360*math.random(2,9);zoom,0.4);
		ReaMessageCommand=cmd(finishtweening;sleep,0.1;decelerate,0.5;zoom,2;diffusealpha,0;rotationz,0);
	};
	Def.ActorFrame{
	OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y-80;zoom,0);
	RetMessageCommand=function(self)
			self:finishtweening()
				self:bounceend(0.5)
				if ret == 1 then
					self:zoom(0.6)
					self:wag()
				else
					self:zoom(0.5)
					self:stopeffect()
				end
				end;
			ChanMessageCommand=function(self)
			self:finishtweening()
				self:bounceend(0.5)
				if Proce == 5 then
				if ret == 1 then
					self:zoom(0.6)
					self:wag()
				else
					self:zoom(0.5)
					self:stopeffect()
				end
				end
				end;
			ConMessageCommand=cmd(finishtweening;decelerate,0.5;zoom,0);
			LoadModule("Menu.Button.lua")(0,0,color("#AAFFAA"),color("#66FF66"),color("#66FFAA"),color("#000000"),color("#333333"),"Retry","Again!")
	};
	Def.ActorFrame{
	OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y+80;zoom,0);
	RetMessageCommand=function(self)
			self:finishtweening()
				self:bounceend(0.5)
				if ret == 2 then
					self:zoom(0.6)
					self:wag()
				else
					self:zoom(0.5)
					self:stopeffect()
				end
				end;
			ChanMessageCommand=function(self)
			self:finishtweening()
				self:bounceend(0.5)
				if Proce == 5 then
				if ret == 2 then
					self:zoom(0.6)
					self:wag()
				else
					self:zoom(0.5)
					self:stopeffect()
				end
				end
				end;
			ConMessageCommand=cmd(finishtweening;decelerate,0.5;zoom,0);
			LoadModule("Menu.Button.lua")(0,0,color("#FFAAAA"),color("#FF6666"),color("#FFAA66"),color("#000000"),color("#333333"),"Back","")
	};
};

return t;