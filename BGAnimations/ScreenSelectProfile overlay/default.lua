function GetLocalProfiles()
	local ret = {};

	for p = 0,PROFILEMAN:GetNumLocalProfiles()-1 do
		local profile=PROFILEMAN:GetLocalProfileFromIndex(p);
		local item = Def.ActorFrame {
			LoadFont("Common Normal") .. {
				Text=profile:GetDisplayName();
				InitCommand=cmd(shadowlength,1;y,-10;zoom,1;ztest,true);
			};
			LoadFont("Common Normal") .. {
				InitCommand=cmd(shadowlength,1;y,8;zoom,0.5;vertspacing,-8;ztest,true);
				BeginCommand=function(self)
					local numSongsPlayed = profile:GetNumTotalSongsPlayed();
					local s = numSongsPlayed == 1 and "Song" or "Songs";
					self:settext( string.format(THEME:GetString("ScreenSelectProfile","%d "..s.." Played"),numSongsPlayed) );
				end;
			};
		};
		table.insert( ret, item );
	end;

	return ret;
end;
local wait = 0;
local waiting = true;
local Haa = 0;
function LoadCard(cColor)
	local t = Def.ActorFrame {
		LoadActor( THEME:GetPathG("ScreenSelectProfile","CardBackground") ) .. {
			InitCommand=cmd(diffuse,cColor);
		};
		LoadActor( THEME:GetPathG("ScreenSelectProfile","CardFrame") );
	};
	return t
end
function LoadPlayerStuff(Player)
	local ret = {};

	local pn = (Player == PLAYER_1) and 1 or 2;

--[[ 	local t = LoadActor(THEME:GetPathB('', '_frame 3x3'), 'metal', 200, 230) .. {
		Name = 'BigFrame';
	}; --]]
	local t = Def.ActorFrame {
		Name = 'JoinFrame';
		LoadCard(Color('Orange'));
--[[ 		Def.Quad {
			InitCommand=cmd(zoomto,200+4,230+4);
			OnCommand=cmd(shadowlength,1;diffuse,color("0,0,0,0.5"));
		};
		Def.Quad {
			InitCommand=cmd(zoomto,200,230);
			OnCommand=cmd(diffuse,Color('Orange');diffusealpha,0.5);
		}; --]]
		LoadFont("Common Normal") .. {
			Text=THEME:GetString("ScreenSelectProfile","PressStart");
			InitCommand=cmd(shadowlength,1);
			OnCommand=cmd(diffuseshift;effectcolor1,Color('White');effectcolor2,color("0.5,0.5,0.5"));
		};
	};
	table.insert( ret, t );
	
	t = Def.ActorFrame {
		Name = 'BigFrame';
		LoadCard(PlayerColor(Player));
	};
	table.insert( ret, t );

--[[ 	t = LoadActor(THEME:GetPathB('', '_frame 3x3'), 'metal', 170, 20) .. {
		Name = 'SmallFrame';
	}; --]]
	t = Def.ActorFrame {
		Name = 'SmallFrame';
--[[ 		Def.Quad {
			InitCommand=cmd(zoomto,170+4,32+4);
			OnCommand=cmd(shadowlength,1);
		}; --]]
		InitCommand=cmd(y,-2);
		Def.Quad {
			InitCommand=cmd(zoomto,200-10,40+2);
			OnCommand=cmd(diffuse,Color('Black');diffusealpha,0.5);
		};
		Def.Quad {
			InitCommand=cmd(zoomto,200-10,40);
			OnCommand=cmd(diffuse,PlayerColor(Player);fadeleft,0.25;faderight,0.25;glow,color("1,1,1,0.25"));
		};
		Def.Quad {
			InitCommand=cmd(zoomto,200-10,40;y,-40/2+20);
			OnCommand=cmd(diffuse,Color("Black");fadebottom,1;diffusealpha,0.35);
		};
		Def.Quad {
			InitCommand=cmd(zoomto,200-10,1;y,-40/2+1);
			OnCommand=cmd(diffuse,PlayerColor(Player);glow,color("1,1,1,0.25"));
		};	
	};
	table.insert( ret, t );

	t = Def.ActorScroller{
		Name = 'ProfileScroller';
		NumItemsToDraw=6;
-- 		InitCommand=cmd(y,-230/2+20;);
		OnCommand=cmd(y,1;SetFastCatchup,true;SetMask,200,58;SetSecondsPerItem,0.15);
		TransformFunction=function(self, offset, itemIndex, numItems)
			local focus = scale(math.abs(offset),0,2,1,0);
			self:visible(false);
			self:y(math.floor( offset*40 ));
-- 			self:zoomy( focus );
-- 			self:z(-math.abs(offset));
-- 			self:zoom(focus);
		end;
		children = GetLocalProfiles();
	};
	table.insert( ret, t );
	
	t = Def.ActorFrame {
		Name = "EffectFrame";
	--[[ 		Def.Quad {
				InitCommand=cmd(y,-230/2;vertalign,top;zoomto,200,8;fadebottom,1);
				OnCommand=cmd(diffuse,Color("Black");diffusealpha,0.25);
			};
			Def.Quad {
				InitCommand=cmd(y,230/2;vertalign,bottom;zoomto,200,8;fadetop,1);
				OnCommand=cmd(diffuse,Color("Black");diffusealpha,0.25);
			}; --]]
	};
	table.insert( ret, t );
--[[ 	t = Def.BitmapText {
		OnCommand = cmd(y,160);
		Name = 'SelectedProfileText';
		Font = "Common Normal";
		Text = 'No profile';
	}; --]]
	t = LoadFont("Common Normal") .. {
		Name = 'SelectedProfileText';
		--InitCommand=cmd(y,160;shadowlength,1;diffuse,PlayerColor(Player));
		InitCommand=cmd(y,160;shadowlength,1;);
	};
	table.insert( ret, t );
    table.insert( ret,
        Def.ActorFrame{
            Name="Arrows";
            LoadActor(THEME:GetPathG("Arrow","Up")).. {
                InitCommand=cmd(y,-130;zoom,0.4);
            };
            LoadActor(THEME:GetPathG("Arrow","Down")).. {
                InitCommand=cmd(y,130;zoom,0.4);
            }
        }
        
    );
    

	return ret;
end;

function UpdateInternal3(self, Player)
	local pn = (Player == PLAYER_1) and 1 or 2;
	local frame = self:GetChild(string.format('P%uFrame', pn));
	local scroller = frame:GetChild('ProfileScroller');
	local seltext = frame:GetChild('SelectedProfileText');
	local joinframe = frame:GetChild('JoinFrame');
	local smallframe = frame:GetChild('SmallFrame');
	local bigframe = frame:GetChild('BigFrame');

    local arrow = frame:GetChild('Arrows');

	if GAMESTATE:IsHumanPlayer(Player) then
		frame:visible(true);
        arrow:visible(true)
		if MEMCARDMAN:GetCardState(Player) == 'MemoryCardState_none' then
			--using profile if any
			joinframe:visible(false);
			smallframe:visible(true);
			bigframe:visible(true);
			seltext:visible(true);
			scroller:visible(true);
			local ind = SCREENMAN:GetTopScreen():GetProfileIndex(Player);
			if ind > 0 then
				scroller:SetDestinationItem(ind-1);
				seltext:settext(PROFILEMAN:GetLocalProfileFromIndex(ind-1):GetDisplayName());
			else
				if SCREENMAN:GetTopScreen():SetProfileIndex(Player, 1) then
					scroller:SetDestinationItem(0);
					self:queuecommand('UpdateInternal2');
				else
					joinframe:visible(true);
					smallframe:visible(false);
					bigframe:visible(false);
					scroller:visible(false);
					seltext:settext('No profile');
				end;
			end;
		else
			--using card
			smallframe:visible(false);
			scroller:visible(false);
			seltext:settext('CARD');
			SCREENMAN:GetTopScreen():SetProfileIndex(Player, 0);
		end;
	else
		joinframe:visible(true);
		scroller:visible(false);
		seltext:visible(false);
		smallframe:visible(false);
		bigframe:visible(false);
        arrow:visible(false)
	end;
end;

-- Will be set to the main ActorFrame for the screen in its OnCommand.
local main_frame= false

local function input(event)
	if event.type == "InputEventType_Release" then return end
	local pn= event.PlayerNumber
	local code= event.GameButton
	if not pn or not code then return end
	local input_functions= {
		Start= function()
			MESSAGEMAN:Broadcast("StartButton")
			if Haa == 1 then
			Haa = 0;
			if GAMESTATE:IsHumanPlayer(pn) then
			MESSAGEMAN:Broadcast("Yeyyyyyy")
			SCREENMAN:GetTopScreen():Finish()
			else
			SCREENMAN:GetTopScreen():SetProfileIndex(pn, -1)
			MESSAGEMAN:Broadcast("Nope")
			end
			elseif Haa == 0 then
			
			if GAMESTATE:GetNumPlayersEnabled()==0 then
			else
			if not GAMESTATE:IsHumanPlayer(pn) then
			SCREENMAN:GetTopScreen():SetProfileIndex(pn, -1)
			MESSAGEMAN:Broadcast("Nope")
			Haa = 0;
			else
			if GAMESTATE:IsHumanPlayer(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_2) then
			local ind1 = SCREENMAN:GetTopScreen():GetProfileIndex(PLAYER_1)
			local ind2 = SCREENMAN:GetTopScreen():GetProfileIndex(PLAYER_2)
			if ind1 ~= ind2 then
			MESSAGEMAN:Broadcast("Yessss")
			Haa = 1;
			end
			else
			MESSAGEMAN:Broadcast("Yessss")
			Haa = 1;
end			
			end
			end
			elseif Haa == -1 then
			if not GAMESTATE:IsHumanPlayer(pn) then
				SCREENMAN:GetTopScreen():SetProfileIndex(pn, -1)
			end
			end
		end,
		Back= function()
			if Haa == 0 then
				MESSAGEMAN:Broadcast("BackButton")
				SCREENMAN:GetTopScreen():SetProfileIndex(pn, -2)
				if GAMESTATE:GetNumPlayersEnabled()==0 then
				Haa = -1
				end
			elseif Haa == 1 then
			MESSAGEMAN:Broadcast("Nope")
			Haa = 0;
			MESSAGEMAN:Broadcast("BackButton")
			elseif Haa == -1 then
			SCREENMAN:GetTopScreen():Cancel()
			end
			
		end,
		MenuUp= function()
			if Haa == 0 then
			MESSAGEMAN:Broadcast("DirectionButton")
			if GAMESTATE:IsHumanPlayer(pn) then
				local ind = SCREENMAN:GetTopScreen():GetProfileIndex(pn)
				if ind > 1 then
					if SCREENMAN:GetTopScreen():SetProfileIndex(pn, ind - 1) then
						
						main_frame:queuecommand('UpdateInternal2')
					end
				end
			end
			end
		end,
		MenuDown= function()
			if Haa == 0 then
			MESSAGEMAN:Broadcast("DirectionButton")
			if GAMESTATE:IsHumanPlayer(pn) then
				local ind = SCREENMAN:GetTopScreen():GetProfileIndex(pn)
				if ind > 0 then
					if SCREENMAN:GetTopScreen():SetProfileIndex(pn, ind + 1) then
						
						main_frame:queuecommand('UpdateInternal2')
					end
				end
			end
			end
		end
	}
	input_functions.MenuLeft= input_functions.MenuUp
	input_functions.MenuRight= input_functions.MenuDown
	if input_functions[code] then
		input_functions[code]()
	end
end

local t = Def.ActorFrame {
Def.ActorFrame {
YessssMessageCommand=cmd(accelerate,0.5;y,-480);
NopeMessageCommand=cmd(accelerate,0.5;y,0);
	StorageDevicesChangedMessageCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	PlayerJoinedMessageCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
				Haa = 0;
		MESSAGEMAN:Broadcast("Nope")
	end;

	PlayerUnjoinedMessageCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	OnCommand=function(self, params)
		main_frame= self:GetParent()
		SCREENMAN:GetTopScreen():AddInputCallback(input)
		self:queuecommand('UpdateInternal2');
	end;
--PROFILEMAN:GetLocalProfileFromIndex(ind-1):GetDisplayName()
	UpdateInternal2Command=function(self)
		UpdateInternal3(self, PLAYER_1);
		UpdateInternal3(self, PLAYER_2);
	end;
--FFFFFFF.png
	children = {
		Def.ActorFrame {
			Name = 'P1Frame';
			InitCommand=cmd(x,SCREEN_CENTER_X-160;y,SCREEN_CENTER_Y);
			OnCommand=cmd(zoom,0;bounceend,0.35;zoom,1);
			OffCommand=cmd(bouncebegin,0.35;zoom,0);
			PlayerJoinedMessageCommand=function(self,param)
				if param.Player == PLAYER_1 then
					(cmd(;zoom,1.15;bounceend,0.175;zoom,1.0;))(self);
				end;
			end;
			children = LoadPlayerStuff(PLAYER_1);
		};
		Def.ActorFrame {
			Name = 'P2Frame';
			InitCommand=cmd(x,SCREEN_CENTER_X+160;y,SCREEN_CENTER_Y);
			OnCommand=cmd(zoom,0;bounceend,0.35;zoom,1);
			OffCommand=cmd(bouncebegin,0.35;zoom,0);
			PlayerJoinedMessageCommand=function(self,param)
				if param.Player == PLAYER_2 then
					(cmd(zoom,1.15;bounceend,0.175;zoom,1.0;))(self);
				end;
			end;
			children = LoadPlayerStuff(PLAYER_2);
		};
        
		-- sounds
		LoadActor( THEME:GetPathS("Common","start") )..{
			StartButtonMessageCommand=cmd(play);
		};
		LoadActor( THEME:GetPathS("Common","cancel") )..{
			BackButtonMessageCommand=cmd(play);
		};
		LoadActor( THEME:GetPathS("Common","value") )..{
			DirectionButtonMessageCommand=cmd(play);
		};
Def.ActorFrame {
	OnCommand=cmd(x,SCREEN_CENTER_X;y,480*1.5);
	YeyyyyyyMessageCommand=cmd(y,450*1.5;bounceend,0.175;y,480*2;);
LoadActor("FFFFFFF.png")..{
	InitCommand=cmd(zoom,0.5);
OnCommand=cmd(playcommand,'hhhat');
hhhatCommand=function(self)
	if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	self:cropleft(0)
	self:cropright(0)
	elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	self:cropright(0.5)
	self:cropleft(0)
	elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	self:cropleft(0.5)
	self:cropright(0)
	end
	if wait > 20 then
	elseif waiting then
	wait = wait + 0.05
	end
self:sleep(0.05)
self:queuecommand('hhhat')
end;
};
};
Def.ActorFrame {
	OnCommand=cmd(diffuse,PlayerColor(PLAYER_1));
LoadFont("common edit") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X-155;y,SCREEN_CENTER_Y-66+458;vertalign,top;zoom,0.75);
		YessssMessageCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
			self:visible(GAMESTATE:IsHumanPlayer(PLAYER_1))
			local ind = SCREENMAN:GetTopScreen():GetProfileIndex(PLAYER_1)
			local profile = PROFILEMAN:GetLocalProfileFromIndex(ind-1);
			local name = profile:GetDisplayName();
				if name then
				else
				name = "P1 Guy"
				end
				if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
				self:settext("MEME")
				else
				self:settext(name)
				end
				end
end;
	YeyyyyyyMessageCommand=cmd(bounceend,0.175;zoom,0;);
	};
LoadFont("common normal") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X-250;y,SCREEN_CENTER_Y-66+458+35;vertalign,top;horizalign,left;zoom,0.75);
		YessssMessageCommand=function(self)
			self:visible(GAMESTATE:IsHumanPlayer(PLAYER_1))
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
			local ind = SCREENMAN:GetTopScreen():GetProfileIndex(PLAYER_1)
			local profile = PROFILEMAN:GetLocalProfileFromIndex(ind-1);
			local burn = string.format('%.0f',profile:GetTotalCaloriesBurned());
			local sec = profile:GetTotalGameplaySeconds();
			local numsong = profile:GetTotalNumSongsPlayed();
			local tap = profile:GetTotalTapsAndHolds();
			local mine = profile:GetTotalMines();--GetTotalMines
			if sec >= 60 then
				natee = math.floor(sec/60)
				else
				natee = 0
			end
			if natee >= 60 then
				chourmonk = math.floor(natee/60)
				else
				chourmonk = 0
			end
			
			if chourmonk > 0 then
			sup = natee - chourmonk*60
			else
			sup = natee
			end
			
			if natee > 0 then
			sup2 = sec - (natee)*60
			else
			sup2 = sec
			end
			
			if chourmonk > 0 then
			real = chourmonk..":"..sup..":"..sup2
			elseif natee > 0 then
			real = sup..":"..sup2
			else
			real = sup2
			end
			if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
				self:settext("Burned: 999999999 pound\nHas played in INFINITY second\nHas played Nope songs\nTap: 0 \nYou got MINE 4ty")
				else
				self:settext("Burned: "..burn.." pound\nHas played in "..real.." second\nHas played "..numsong.." songs\nTap: "..tap.."\nYou got MINE "..mine)
			end
			end
end;
	YeyyyyyyMessageCommand=cmd(bounceend,0.175;zoom,0;);
	};
LoadFont("common edit") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X-155;y,SCREEN_CENTER_Y-66+458+177.5;vertalign,top;zoom,0.75);
		YessssMessageCommand=function(self)
			self:visible(GAMESTATE:IsHumanPlayer(PLAYER_1))
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
			local ind = SCREENMAN:GetTopScreen():GetProfileIndex(PLAYER_1)
			local profile = PROFILEMAN:GetLocalProfileFromIndex(ind-1);
			local name = profile:GetTotalDancePoints();
				if name > 100000 then
				self:rainbowscroll(true)
				else
				self:rainbowscroll(false)
				end
				if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
				if name > 100000 then
				self:settext("RAINBOW")
				else
				self:settext("Total : 0 point")
				end
				else
				self:settext("Total : "..name.." point")
				end
				end
end;
	YeyyyyyyMessageCommand=cmd(bounceend,0.175;zoom,0;);
	};
	};
	
	
	
	Def.ActorFrame {
	OnCommand=cmd(diffuse,PlayerColor(PLAYER_2));
LoadFont("common edit") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X+155;y,SCREEN_CENTER_Y-66+458;vertalign,top;zoom,0.75);
		YessssMessageCommand=function(self)
					self:visible(GAMESTATE:IsHumanPlayer(PLAYER_2))
				if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
			local ind = SCREENMAN:GetTopScreen():GetProfileIndex(PLAYER_2)
			local profile = PROFILEMAN:GetLocalProfileFromIndex(ind-1);
			local name = profile:GetDisplayName();
				if name then
				else
				name = "P2 Guy"
				end
			if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
				self:settext("MEME")
				else
				self:settext(name)
			end
			end
end;
	YeyyyyyyMessageCommand=cmd(bounceend,0.175;zoom,0;);
	};
LoadFont("common normal") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X+250;y,SCREEN_CENTER_Y-66+458+35;vertalign,top;horizalign,right;zoom,0.75);
		YessssMessageCommand=function(self)
			self:visible(GAMESTATE:IsHumanPlayer(PLAYER_2))
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
			local ind = SCREENMAN:GetTopScreen():GetProfileIndex(PLAYER_2)
			local profile = PROFILEMAN:GetLocalProfileFromIndex(ind-1);
			local burn = string.format('%.0f',profile:GetTotalCaloriesBurned());
			local sec = profile:GetTotalGameplaySeconds();
			local numsong = profile:GetTotalNumSongsPlayed();
			local tap = profile:GetTotalTapsAndHolds();
			local mine = profile:GetTotalMines();--GetTotalMines
			if sec >= 60 then
				natee = math.floor(sec/60)
				else
				natee = 0
			end
			if natee >= 60 then
				chourmonk = math.floor(natee/60)
				else
				chourmonk = 0
			end
			
			if chourmonk > 0 then
			sup = natee - chourmonk*60
			else
			sup = natee
			end
			
			if natee > 0 then
			sup2 = sec - (natee)*60
			else
			sup2 = sec
			end
			
			if chourmonk > 0 then
			real = chourmonk..":"..sup..":"..sup2
			elseif natee > 0 then
			real = sup..":"..sup2
			else
			real = sup2
			end
			if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
				self:settext("Burned: 999999999 pound\nHas played in INFINITY second\nHas played Nope songs\nTap: 0 \nYou got MINE 4ty")
				else
				self:settext("Burned: "..burn.." pound\nHas played in "..real.." second\nHas played "..numsong.." songs\nTap: "..tap.."\nYou got MINE "..mine)
			end
			end
end;
	YeyyyyyyMessageCommand=cmd(bounceend,0.175;zoom,0;);
	};
LoadFont("common edit") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X+155;y,SCREEN_CENTER_Y-66+458+177.5;vertalign,top;zoom,0.75);
		YessssMessageCommand=function(self)
					self:visible(GAMESTATE:IsHumanPlayer(PLAYER_2))
					if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
			local ind = SCREENMAN:GetTopScreen():GetProfileIndex(PLAYER_2)
			local profile = PROFILEMAN:GetLocalProfileFromIndex(ind-1);
			local name = profile:GetTotalDancePoints();
				if name > 100000 then
				self:rainbowscroll(true)
				else
				self:rainbowscroll(false)
				end
				if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
				if name > 100000 then
				self:settext("RAINBOW")
				else
				self:settext("Total : 0 point")
				end
				else
				self:settext("Total : "..name.." point")
				end
				end
end;
	YeyyyyyyMessageCommand=cmd(bounceend,0.175;zoom,0;);
	};
	};
	};
};
};

return t;
