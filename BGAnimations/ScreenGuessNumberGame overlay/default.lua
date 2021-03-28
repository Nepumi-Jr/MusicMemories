local DiffRow = 1;
local PathS = THEMEDIR().."BGAnimations/ScreenGuessNumberGame overlay/";
--[[
1 = 1 - 10 with 3 tries
2 = 1 - 35 with 5 tries
3 = 1 - 135 with 7 tries
]]

local phase = 0
local selectDiff = 0
local diffText = {"Easy","Medium","Hard"}
local diffDes = {"1-10 3 Tries","1-35 5 Tries","1-135 7 Tries"}
local maxNum = {10,35,135}
local CL1 = {color("#AAFFAA"), color("#AAAAFF"), color("#FFAAAA")}
local CL2 = {color("#66FF66"), color("#6666FF"), color("#FF6666")}
local CL3 = {color("#66FFAA"), color("#66AAFF"), color("#FFAA66")}

local BQText = {"Retry","Quit"}
local BQDes = {"Play Again","Back to Games"}
local CLBQ1 = {color("#AAFFAA"), color("#FFAAAA")}
local CLBQ2 = {color("#66FF66"), color("#FF6666")}
local CLBQ3 = {color("#66FFAA"), color("#FFAA66")}

local numRemain = 0;
local numGuess = 0;
local numAnswer = 0;

local selectNext = 0;

--[[phase
0 = Select
1 = Explain
2 = Play
3 = Halt 
]]

local InputOfArrow = function( event )

	if not event then return end

	if event.type == "InputEventType_FirstPress" then

		for i = 0,9 do
			if event.DeviceInput.button == "DeviceButton_"..tostring(i) or
			event.DeviceInput.button == "DeviceButton_KP "..tostring(i) then
				if phase == 2 then
					MESSAGEMAN:Broadcast('NumPress',{num = i})
					MESSAGEMAN:Broadcast('Tick')
				end
			end
			
		end
		
		if event.DeviceInput.button == "DeviceButton_backspace" then
			if phase == 2 then
				MESSAGEMAN:Broadcast('NumPress',{num = -1})
				MESSAGEMAN:Broadcast('Tick')
			end
		end

		if event.button == "Left" or event.button == "Up" or
		event.button == "DownLeft" or event.button == "UpRight" or
		event.button == "MenuLeft" or event.button == "MenuUp" then

			if phase == 0 then
				selectDiff = math.mod(selectDiff  + 2,3)
				MESSAGEMAN:Broadcast('ArrowPress')
				MESSAGEMAN:Broadcast('Tick')
			elseif phase == 5 then
				selectNext = math.mod(selectNext  + 1,2)
				MESSAGEMAN:Broadcast('ArrowPress')
				MESSAGEMAN:Broadcast('Tick')
			end
		end

		if event.button == "Right" or event.button == "Down" or
		event.button == "DownRight" or event.button == "UpRight" or
		event.button == "MenuRight" or event.button == "MenuDown" then
			if phase == 0 then
				selectDiff = math.mod(selectDiff  + 1,3)
				MESSAGEMAN:Broadcast('ArrowPress')
				MESSAGEMAN:Broadcast('Tick')
			elseif phase == 5 then
				selectNext = math.mod(selectNext  + 1,2)
				MESSAGEMAN:Broadcast('ArrowPress')
				MESSAGEMAN:Broadcast('Tick')
			end
		end

		if event.button == "Start" then
			if phase == 0 then
				numRemain = 3 + selectDiff * 2
				numAnswer = math.random(1,maxNum[selectDiff + 1])
				numGuess = 0
				phase = 1
				MESSAGEMAN:Broadcast('Enter')
			elseif phase == 2 then
				phase = 3
				MESSAGEMAN:Broadcast('Enter')
			elseif phase == 4 then
				phase = 5
				selectNext = 0
				MESSAGEMAN:Broadcast('Enter')
				MESSAGEMAN:Broadcast('QuitOrRet')
			elseif phase == 5 then
				if selectNext == 0 then
					phase = 0
				else
					SCREENMAN:GetTopScreen():SetNextScreenName("ScreenSelectMiniGames"):StartTransitioningScreen("SM_GoToNextScreen")
				end
				MESSAGEMAN:Broadcast('Enter')
			end
		end

		if event.button == "Back" then
			MESSAGEMAN:Broadcast('BackS')
			SCREENMAN:GetTopScreen():SetNextScreenName("ScreenSelectMiniGames"):StartTransitioningScreen("SM_GoToNextScreen")
		end
	end

end




local t = Def.ActorFrame{};
t[#t+1] = Def.ActorFrame{
		name = "Sample Text";
	LoadActor("BG.png")..{
		OnCommand=cmd(FullScreen);
	};

	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,{0,0,0,0.5});
		EnterMessageCommand=function(self)
			if phase == 1 then
				self:finishtweening():decelerate(0.7):diffusealpha(0)
			elseif phase == 5 then
				self:finishtweening():decelerate(0.7):diffusealpha(0.5)
			end
		end;
	};

	Def.Quad{
		InitCommand=cmd(visible,false);
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(InputOfArrow)
			self:sleep(1000)
		end;
	};

	LoadFont("Common Large")..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y*0.3;diffuse,{0,0,0,1}
		;zoom,0.4;vertalign,top;cropright,1);
		EnterMessageCommand=function(self)
			if phase == 1 then
				self:settext("Please guess a number\nthat I am thinking...")
				SOUND:PlayOnce(PathS..'Title.ogg')
				self:cropright(1):linear(1.5):cropright(0)
				self:sleep(0.001):queuecommand("StartGuess")
			end
		end;
		StartGuessCommand=function(self)
			MESSAGEMAN:Broadcast('StartGuess')
			phase = 2
		end;
		QuitOrRetMessageCommand=cmd(decelerate,1.5;cropright,1);
	};


	LoadFont("Common Normal")..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y*0.9;diffuse,Color.Magenta;diffusealpha,0);
		StartGuessMessageCommand=function(self)
			self:settext("From 1 to "..maxNum[selectDiff + 1])
			self:linear(2):diffusealpha(1)
		end;
		QuitOrRetMessageCommand=cmd(decelerate,2;diffusealpha,0);
	};

	LoadFont("Common Normal")..{
		InitCommand=cmd(Center;diffuse,Color.Blue;diffusealpha,0);
		StartGuessMessageCommand=function(self)
			self:settext("Number of remaining tries:"..numRemain)
			self:linear(2):diffusealpha(1)
		end;
		ReNumRemainMessageCommand=function(self)
			self:settext("Number of remaining tries:"..numRemain)
		end;
		QuitOrRetMessageCommand=cmd(decelerate,2;diffusealpha,0);
	};

	LoadFont("Combo Number")..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y*1.4;diffuse,Color.Orange;
		zoom,0);
		StartGuessMessageCommand=function(self)
			self:settext("0")
			self:bounceend(1.2):zoom(1.3)
		end;
		NumPressMessageCommand=function(self, params)
			if params.num == -1 then
				numGuess = math.floor(numGuess / 10)
			else
				numGuess = math.min(numGuess * 10 + params.num,maxNum[selectDiff + 1])
			end
			
			self:settextf("%d",numGuess)
		end;
		QuitOrRetMessageCommand=cmd(decelerate,1.5;zoom,0);
	};

	LoadFont("Common Normal")..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y*1.7;diffuse,Color.Blue;diffusealpha,0);
		EnterMessageCommand=function(self)
			if phase == 3 then
				self:stopeffect()
				self:diffusealpha(1)
				if numRemain == 1 and numGuess ~= numAnswer then
					numRemain = 0
					MESSAGEMAN:Broadcast('ReNumRemain')
					SOUND:PlayOnce(PathS..'Lost.ogg')
					phase = 4
					self:diffuse(Color.Red)
					self:settext("The Correct number is "..numAnswer)
				elseif numGuess == numAnswer then
					SOUND:PlayOnce(PathS..'Congrat.ogg')
					phase = 4
					self:rainbow()
					self:settext("Congratulations! That's correct")
				elseif numGuess > numAnswer then
					SOUND:PlayOnce(PathS..'Lower.ogg')
					numRemain = numRemain - 1
					phase = 2
					self:settext(numGuess.." is too high, Please type a lower number!")
					numGuess = 0;
					MESSAGEMAN:Broadcast('ReNumRemain')
				elseif numGuess < numAnswer then
					SOUND:PlayOnce(PathS..'Higher.ogg')
					numRemain = numRemain - 1
					phase = 2
					self:settext(numGuess.." is too low, Please type a higher number!")
					numGuess = 0;
					MESSAGEMAN:Broadcast('ReNumRemain')
				end
			end
		end;
		QuitOrRetMessageCommand=cmd(decelerate,1.5;diffusealpha,0);
	};

	

	LoadActor( THEME:GetPathS("Common","start") )..{EnterMessageCommand=cmd(play);};
	LoadActor( THEME:GetPathS("Common","cancel") )..{BackSMessageCommand=cmd(play);};
	LoadActor( THEME:GetPathS("Common","value") )..{TickMessageCommand=cmd(play);};	
};

for i = 0,2 do
	t[#t+1] = Def.ActorFrame{
		OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y-120+120*i;zoom,0;queuecommand,"ArrowPress");
		ArrowPressMessageCommand = function(self)
			if phase == 0 then
				self:finishtweening()
				self:bounceend(0.5)
				if selectDiff == i then
					self:zoom(0.6)
					self:wag()
				else
					self:zoom(0.5)
					self:stopeffect()
				end
			end
		end;
		EnterMessageCommand = function(self)
			self:finishtweening()
			if phase == 0 then
				self:queuecommand("ArrowPress")
			else
				self:decelerate(0.5)
				self:zoom(0)
			end
		end;
		MCBT(0,0,CL1[i+1],CL2[i+1],CL3[i+1],color("#000000"),color("#333333"),diffText[i+1],diffDes[i+1]);
	};
end

for i = 0,1 do
	t[#t+1] = Def.ActorFrame{
		OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y-80+160*i;zoom,0;queuecommand,"ArrowPress");
		QuitOrRetMessageCommand=cmd(queuecommand,"ArrowPress");
		ArrowPressMessageCommand = function(self)
			if phase == 5 then
				self:finishtweening()
				self:bounceend(0.5)
				if selectNext == i then
					self:zoom(0.6)
					self:wag()
				else
					self:zoom(0.5)
					self:stopeffect()
				end
			end
		end;
		EnterMessageCommand = function(self)
			self:finishtweening()
			if phase == 5 then
				self:queuecommand("ArrowPress")
			else
				self:decelerate(0.5)
				self:zoom(0)
			end
		end;
		MCBT(0,0,CLBQ1[i+1],CLBQ2[i+1],CLBQ3[i+1],color("#000000"),color("#333333"),BQText[i+1],BQDes[i+1]);
	};
end


return t;