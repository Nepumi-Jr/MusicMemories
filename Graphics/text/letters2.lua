Letters2 = Def.ActorFrame{}

for i=1,72 do
	Letters2[#Letters2+1] = LoadActor("dtmFont 8x16")..{
		OnCommand=function(self)
		self:SetTextureFiltering(false);
		_G['det'..i]=self
		self:sleep(0)
		self:visible(false)
		self:x(999)
		self:y(999)
		self:animate(0)
		self:setstate(0)
		end
	}
end


return Def.ActorFrame{

Def.Quad{
InitCommand=function(self)
			
			self:visible(false)
			
			-- Here lies Puuro's wacky sprite text system
			 -- You should be able to just copy this xml and
			  -- slap it to your simfile and the functions will work
			  
			  -- makeText2Command controls which letter will be spat out.
			 -- This system uses bitmap fonts which are output with 
			-- a program called Codehead's Bitmap Font Generator
			 -- Here's instructions for using these functions
			  -- underText gopywrite c Puuro 2015
			
			--[[
				First, set a speech bubble with setBubble(type,width,height,xoffset,yoffset,wrap)
				The parameters are:
				speech bubble type (0 to 5)
				width of the letters (optional, defaults to 10)
				height of the rows (optional, defaults to 12)
				x position of text (optional, defaults to -61)
				y position of text (optional, defaults to -21)
				row width in letters (optional, defaults to 18)
				
				example: 
				setBubble(0,9,12)
				
				Then, use sayThis('string',speed,'filename.ogg')
				Parameters:
				String, aka the thing you want to say
				speed of an individual letter
				character speech sound
				
				example:
				setBubble(0,9,12) <-this is needed
				sayThis('Hello',0.06,'sans.ogg')
				
				remember to ALWAYS run setBubble before running sayThis or the
				previous text won't be cleared.
				
				Extra functions
					colourText(s,e,r,g,b,a)
						This function colours a part of the text
						Parameters:
						 start
						 end
						 red
						 green
						 blue
						 alpha transparency
						 
						 example:
						  setBubble(0,9,12) <-this always comes first
						  colourText(11,15,0,0,1,1) --the word 'blue' is in blue now
						  sayThis('Imagine a blue stop sign',0.06,'sans.ogg')
						  
					setTalkSpeeds(start,end,speed)
						This works similarly to colourText, except it changes the
						speed of the letters between the start and end values
						run this function AFTER sayThis or otherwise the speeds
						will be overridden
						
						example:
						 setBubble(0,9,12)
						 colourText(11,15,0,0,1,1) 
						 sayThis('Imagine a blue stop sign',0.06,'sans.ogg')
						 setTalkSpeeds(11,15,0.4) --the word 'blue' appears slowly
						 
			--]]
			
			
			txtOffset2=9
			spawnAmount2=0;
			textSetter2=1
			testNumber2=1
			letterNumber2=1
			talk_textSpeed2=0.1
			talk_active2=0
			talk_audio2='sound.ogg'
			talk_speeds2={}
			wrapCheck2=1
			wrapCheck2Y=1
			wrapRow2=0
			wrapMult2=0
			
			
			for i=1,80 do --let's make this table just a bit too large as a failsafe
			
				table.insert(talk_speeds2,0.06)
			
			end
			
			talk_widths2={}
			
			--fiskars function fucking founs fo kung dräckelll... skingg skäkl
			
			function setLetterWidth2(ltr,wd)
			
				talk_widths2[ltr] = wd
				
				
			
			end
			
			function spaceLetters2()
				--this shit is kinda dumb
				for i=2,72 do
					for j=i,72 do
						if talk_widths2[sanat2[i]] ~= nil then
							_G['det'..j]:addx((talk_widths2[sanat2[i]]))
							
						else
							--_G['det'..i]:rotationz(20)
							
						end
					end
				end
			end
			
			function spawnLetters2(num)
			
			--spawnAmount2=num
			--letterNumber2=1
			--textSetter2:queuecommand('makeText2')
			
			
			end
			
			function clearThis2()
				
				talk_active2=0
				textSetter2:stoptweening()
				for i=1,72 do
				_G['det'..i]:visible(false)
				end
			
			end
			
			function colourText2(s,e,r,g,b,a)
			
				for i=s,e do
					_G['det'..i]:diffuse(r,g,b,a)
				end
			
			end
			
			function setTalkSpeeds2(s,e,spd)
			
				for i=s,e do
					talk_speeds2[i] = spd
				end
			
			end
			
		
			
			
			
			function sayThis2(stringi,spd,soundfile)
				
				textSetter2:stoptweening()
					sanat2 = {} --this table has been set in letters.xml
					for i = 1,string.len(stringi) do
						--t[i] = string.byte(stringi,i)
						sanat2[i] = string.sub(stringi,i, i)
						
						if sanat2[i] == ' ' then
							sanat2[i] = 'space'
						end
						
						
					end
					
				
				
				
				
				spawnAmount2=string.len(stringi)
				letterNumber2=1
				talk_textSpeed2=spd
				talk_active2=1
				talk_audio2=soundfile
				
				for i=1,table.getn(talk_speeds2) do
					talk_speeds2[i] = spd
				end
				
				if spawnAmount2<=72 then
					textSetter2:queuecommand('makeText2')
				elseif spawnAmount2>72 then
					SCREENMAN:SystemMessage('String is too long')
				end
				
				
				
			end --string thingy ends here
			
			function setBubble2(dir,pxx,pxy,xstart,ystart,wrp)
				wrapCheck2=1
				wrapCheck2Y=1
				wrapRow2=0
				wrapMult2=0
				if not pxx then
					pxx=10
				end
				
				if not pxy then
					pxy=12
				end
				
				if not ystart then
					ystart=-21
				end
				
				if not xstart then
					xstart=-61
				end
				
				if not wrp then
					wrp=18
				end
				
					  
					wrapAmount2=wrp
					for i=1,72 do
					
					_G['det'..i]:visible(false)
					_G['det'..i]:setstate(0)
					_G['det'..i]:diffuse(0,0,0,1)
					
					
					end
					
					
					for i=1,72 do
					
					
					
						_G['det'..i]:x(xstart+((pxx*(wrapCheck2))))
						
						_G['det'..i]:y(ystart+(pxy*wrapMult2))
						
						-- I need to fix this dumb -2 bs lmao
						
						if wrapCheck2<wrapAmount2 then
							wrapCheck2=wrapCheck2+1
						elseif wrapCheck2>=wrapAmount2 then
							wrapCheck2=1
						end
						
						if wrapCheck2Y<wrapAmount2 then
							wrapCheck2Y=wrapCheck2Y+1
						elseif wrapCheck2Y>=wrapAmount2 then
							wrapCheck2Y=1
							wrapRow2=wrapRow2+wrapAmount2
							wrapMult2=wrapMult2+1
						end
						
						
						
						
					end
					--]]
					
					--bubble:x(0)
					--bubble:y(0)
					bubble2:x(bubbleCont2:GetX())
					bubble2:y(bubbleCont2:GetY())
					bubble2:setstate(dir)
					bubble2:visible(true)
				
					
				
				end --bubble thingy ends here

end,

},

--[[

Def.Sprite{

Texture="morebubbles 2x4.png"
OnCommand=function(self)
bubble=self
self:sleep(0)
self:visible(false) 
 self:animate(0) 
 self:setstate(0)
self:x(999)
self:y(999)
end,

}, --]]

------------------------------------------------------------------------------------>
------------------------------------------------------------------------------------>
------------------------------------------------------------------------------------>
------------------------------------- POOL-LAN ------------------------------------->
------------------------------------------------------------------------------------>
------------------------------------------------------------------------------------>
------------------------------------------------------------------------------------>
Letters2,

Def.Quad{
	OnCommand=function(self)
	textSetter2=self
	self:visible(false)
	sanat2={}
	end,
	
	makeText2Command=function(self)
	local songName = GAMESTATE:GetCurrentSong():GetSongDir();
	
			
	--self:sleep(talk_textSpeed2)
	self:sleep(talk_speeds2[letterNumber2])
	
	if spawnAmount2>0 then
		spawnAmount2=spawnAmount2-1
		
		if sanat2[letterNumber2] ~= 'space'
		and sanat2[letterNumber2] ~= '*' then
		SOUND:PlayOnce(songName..'lua/'..talk_audio2);
		end
		
		if sanat2[letterNumber2] == 'A' then
			_G['det'..letterNumber2]:setstate(33)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'B' then
			_G['det'..letterNumber2]:setstate(34)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'C' then
			_G['det'..letterNumber2]:setstate(35)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'D' then
			_G['det'..letterNumber2]:setstate(36)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'E' then
			_G['det'..letterNumber2]:setstate(37)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'F' then
			_G['det'..letterNumber2]:setstate(38)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'G' then
			_G['det'..letterNumber2]:setstate(39)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'H' then
			_G['det'..letterNumber2]:setstate(40)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'I' then
			_G['det'..letterNumber2]:setstate(41)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'J' then
			_G['det'..letterNumber2]:setstate(42)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'K' then
			_G['det'..letterNumber2]:setstate(43)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'L' then
			_G['det'..letterNumber2]:setstate(44)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'M' then
			_G['det'..letterNumber2]:setstate(45)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'N' then
			_G['det'..letterNumber2]:setstate(46)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'O' then
			_G['det'..letterNumber2]:setstate(47)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'P' then
			_G['det'..letterNumber2]:setstate(48)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'Q' then
			_G['det'..letterNumber2]:setstate(49)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'R' then
			_G['det'..letterNumber2]:setstate(50)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'S' then
			_G['det'..letterNumber2]:setstate(51)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'T' then
			_G['det'..letterNumber2]:setstate(52)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'U' then
			_G['det'..letterNumber2]:setstate(53)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'V' then
			_G['det'..letterNumber2]:setstate(54)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'W' then
			_G['det'..letterNumber2]:setstate(55)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'X' then
			_G['det'..letterNumber2]:setstate(56)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'Y' then
			_G['det'..letterNumber2]:setstate(57)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'Z' then
			_G['det'..letterNumber2]:setstate(58)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'a' then
			_G['det'..letterNumber2]:setstate(65)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'b' then
			_G['det'..letterNumber2]:setstate(66)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'c' then
			_G['det'..letterNumber2]:setstate(67)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'd' then
			_G['det'..letterNumber2]:setstate(68)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'e' then
			_G['det'..letterNumber2]:setstate(69)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'f' then
			_G['det'..letterNumber2]:setstate(70)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'g' then
			_G['det'..letterNumber2]:setstate(71)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'h' then
			_G['det'..letterNumber2]:setstate(72)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'i' then
			_G['det'..letterNumber2]:setstate(73)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'j' then
			_G['det'..letterNumber2]:setstate(74)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'k' then
			_G['det'..letterNumber2]:setstate(75)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'l' then
			_G['det'..letterNumber2]:setstate(76)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'm' then
			_G['det'..letterNumber2]:setstate(77)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'n' then
			_G['det'..letterNumber2]:setstate(78)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'o' then
			_G['det'..letterNumber2]:setstate(79)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'p' then
			_G['det'..letterNumber2]:setstate(80)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'q' then
			_G['det'..letterNumber2]:setstate(81)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'r' then
			_G['det'..letterNumber2]:setstate(82)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 's' then
			_G['det'..letterNumber2]:setstate(83)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 't' then
			_G['det'..letterNumber2]:setstate(84)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'u' then
			_G['det'..letterNumber2]:setstate(85)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'v' then
			_G['det'..letterNumber2]:setstate(86)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'w' then
			_G['det'..letterNumber2]:setstate(87)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'x' then
			_G['det'..letterNumber2]:setstate(88)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'y' then
			_G['det'..letterNumber2]:setstate(89)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'z' then
			_G['det'..letterNumber2]:setstate(90)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '0' then
			_G['det'..letterNumber2]:setstate(16)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '1' then
			_G['det'..letterNumber2]:setstate(17)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '2' then
			_G['det'..letterNumber2]:setstate(18)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '3' then
			_G['det'..letterNumber2]:setstate(19)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '4' then
			_G['det'..letterNumber2]:setstate(20)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '5' then
			_G['det'..letterNumber2]:setstate(21)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '6' then
			_G['det'..letterNumber2]:setstate(22)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '7' then
			_G['det'..letterNumber2]:setstate(23)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '8' then
			_G['det'..letterNumber2]:setstate(24)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '9' then
			_G['det'..letterNumber2]:setstate(25)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '?' then
			_G['det'..letterNumber2]:setstate(31)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '!' then
			_G['det'..letterNumber2]:setstate(1)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '.' then
			_G['det'..letterNumber2]:setstate(14)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == ',' then
			_G['det'..letterNumber2]:setstate(12)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == ':' then
			_G['det'..letterNumber2]:setstate(26)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == ';' then
			_G['det'..letterNumber2]:setstate(27)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
			
		
		elseif sanat2[letterNumber2] == '&quot;' then
			_G['det'..letterNumber2]:setstate(2)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '\'' then
			_G['det'..letterNumber2]:setstate(7)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '(' then
			_G['det'..letterNumber2]:setstate(8)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == ')' then
			_G['det'..letterNumber2]:setstate(9)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '\[' then
			_G['det'..letterNumber2]:setstate(59)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '\]' then
			_G['det'..letterNumber2]:setstate(61)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '{' then
			_G['det'..letterNumber2]:setstate(91)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '}' then
			_G['det'..letterNumber2]:setstate(93)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '<' then
			_G['det'..letterNumber2]:setstate(28)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '>' then
			_G['det'..letterNumber2]:setstate(30)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '+' then
			_G['det'..letterNumber2]:setstate(11)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '~' then
			_G['det'..letterNumber2]:setstate(94)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '=' then
			_G['det'..letterNumber2]:setstate(29)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '-' then
			_G['det'..letterNumber2]:setstate(13)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '@' then
			_G['det'..letterNumber2]:setstate(32) 
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '%' then
			_G['det'..letterNumber2]:setstate(5)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '#' then
			_G['det'..letterNumber2]:setstate(3)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '&' then
			_G['det'..letterNumber2]:setstate(6)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '$' then
			_G['det'..letterNumber2]:setstate(4)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '*' then
			_G['det'..letterNumber2]:setstate(10)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '/' then
			_G['det'..letterNumber2]:setstate(15)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '\\' then
			_G['det'..letterNumber2]:setstate(60)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '^' then
			_G['det'..letterNumber2]:setstate(62)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == '_' then
			_G['det'..letterNumber2]:setstate(63)
			_G['det'..letterNumber2]:basezoomx(1) 
			 
		elseif sanat2[letterNumber2] == 'space' then
			_G['det'..letterNumber2]:setstate(1)
			_G['det'..letterNumber2]:basezoomx(0) --]]
		end
		
		_G['det'..letterNumber2]:visible(true)
		
		letterNumber2=letterNumber2+1
		
		if talk_active2==1 then
		self:queuecommand('makeText2')
		testNumber2=testNumber2+1
		--texty:settext(testNumber2)
		end
		
	end
	
	end,
	
	},
	



}