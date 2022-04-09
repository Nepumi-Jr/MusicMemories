function GetLocalProfiles()
	local ret = {};

	for p = 0,PROFILEMAN:GetNumLocalProfiles()-1 do
		local profile=PROFILEMAN:GetLocalProfileFromIndex(p);
		local item = Def.ActorFrame {
			LoadFont("Common Normal") .. {
				Text=profile:GetDisplayName();
				InitCommand=function(self) self:shadowlength(1); self:y(-10); self:zoom(1); self:ztest(true); end;
			};
			LoadFont("Common Normal") .. {
				InitCommand=function(self) self:shadowlength(1); self:y(8); self:zoom(0.5); self:vertspacing(-8); self:ztest(true); end;
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
			InitCommand=function(self) self:diffuse(cColor); end;
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
			InitCommand=function(self) self:zoomto(200+4,230+4); end;
			OnCommand=function(self) self:shadowlength(1); self:diffuse(color("0,0,0,0.5")); end;
		};
		Def.Quad {
			InitCommand=function(self) self:zoomto(200,230); end;
			OnCommand=function(self) self:diffuse(Color('Orange')); self:diffusealpha(0.5); end;
		}; --]]
		LoadFont("Common Normal") .. {
			Text=THEME:GetString("ScreenSelectProfile","PressStart");
			InitCommand=function(self) self:shadowlength(1); end;
			OnCommand=function(self) self:diffuseshift(); self:effectcolor1(Color('White')); self:effectcolor2(color("0.5,0.5,0.5")); end;
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
			InitCommand=function(self) self:zoomto(170+4,32+4); end;
			OnCommand=function(self) self:shadowlength(1); end;
		}; --]]
		InitCommand=function(self) self:y(-2); end;
		Def.Quad {
			InitCommand=function(self) self:zoomto(200-10,40+2); end;
			OnCommand=function(self) self:diffuse(Color('Black')); self:diffusealpha(0.5); end;
		};
		Def.Quad {
			InitCommand=function(self) self:zoomto(200-10,40); end;
			OnCommand=function(self) self:diffuse(PlayerColor(Player)); self:fadeleft(0.25); self:faderight(0.25); self:glow(color("1,1,1,0.25")); end;
		};
		Def.Quad {
			InitCommand=function(self) self:zoomto(200-10,40); self:y(-40/2+20); end;
			OnCommand=function(self) self:diffuse(Color("Black")); self:fadebottom(1); self:diffusealpha(0.35); end;
		};
		Def.Quad {
			InitCommand=function(self) self:zoomto(200-10,1); self:y(-40/2+1); end;
			OnCommand=function(self) self:diffuse(PlayerColor(Player)); self:glow(color("1,1,1,0.25")); end;
		};	
	};
	table.insert( ret, t );

	t = Def.ActorScroller{
		Name = 'ProfileScroller';
		NumItemsToDraw=6;
-- 		InitCommand=function(self) self:y(-230/2+20); end;
		OnCommand=function(self) self:y(1); self:SetFastCatchup(true); self:SetMask(200,58); self:SetSecondsPerItem(0.15); end;
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
				InitCommand=function(self) self:y(-230/2); self:vertalign(top); self:zoomto(200,8); self:fadebottom(1); end;
				OnCommand=function(self) self:diffuse(Color("Black")); self:diffusealpha(0.25); end;
			};
			Def.Quad {
				InitCommand=function(self) self:y(230/2); self:vertalign(bottom); self:zoomto(200,8); self:fadetop(1); end;
				OnCommand=function(self) self:diffuse(Color("Black")); self:diffusealpha(0.25); end;
			}; --]]
	};
	table.insert( ret, t );
--[[ 	t = Def.BitmapText {
		OnCommand = function(self) self:y(160); end;
		Name = 'SelectedProfileText';
		Font = "Common Normal";
		Text = 'No profile';
	}; --]]
	t = LoadFont("Common Normal") .. {
		Name = 'SelectedProfileText';
		--InitCommand=function(self) self:y(160); self:shadowlength(1); self:diffuse(PlayerColor(Player)); end;
		InitCommand=function(self) self:y(160); self:shadowlength(1); end;
	};
	table.insert( ret, t );
    table.insert( ret,
        Def.ActorFrame{
            Name="Arrows";
            LoadActor(THEME:GetPathG("Arrow","Up")).. {
                InitCommand=function(self) self:y(-130); self:zoom(0.4); end;
            };
            LoadActor(THEME:GetPathG("Arrow","Down")).. {
                InitCommand=function(self) self:y(130); self:zoom(0.4); end;
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
YessssMessageCommand=function(self) self:accelerate(0.5); self:y(-480); end;
NopeMessageCommand=function(self) self:accelerate(0.5); self:y(0); end;
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
			InitCommand=function(self) self:x(SCREEN_CENTER_X-160); self:y(SCREEN_CENTER_Y); end;
			OnCommand=function(self) self:zoom(0); self:bounceend(0.35); self:zoom(1); end;
			OffCommand=function(self) self:bouncebegin(0.35); self:zoom(0); end;
			PlayerJoinedMessageCommand=function(self,param)
				if param.Player == PLAYER_1 then
					(function(self) self:zoom(1.15); self:bounceend(0.175); self:zoom(1.0); end)(self);
				end;
			end;
			children = LoadPlayerStuff(PLAYER_1);
		};
		Def.ActorFrame {
			Name = 'P2Frame';
			InitCommand=function(self) self:x(SCREEN_CENTER_X+160); self:y(SCREEN_CENTER_Y); end;
			OnCommand=function(self) self:zoom(0); self:bounceend(0.35); self:zoom(1); end;
			OffCommand=function(self) self:bouncebegin(0.35); self:zoom(0); end;
			PlayerJoinedMessageCommand=function(self,param)
				if param.Player == PLAYER_2 then
					(function(self) self:zoom(1.15); self:bounceend(0.175); self:zoom(1.0); end)(self);
				end;
			end;
			children = LoadPlayerStuff(PLAYER_2);
		};
        
		-- sounds
		LoadActor( THEME:GetPathS("Common","start") )..{
			StartButtonMessageCommand=function(self) self:play(); end;
		};
		LoadActor( THEME:GetPathS("Common","cancel") )..{
			BackButtonMessageCommand=function(self) self:play(); end;
		};
		LoadActor( THEME:GetPathS("Common","value") )..{
			DirectionButtonMessageCommand=function(self) self:play(); end;
		};
Def.ActorFrame {
	OnCommand=function(self) self:x(SCREEN_CENTER_X); self:y(480*1.5); end;
	YeyyyyyyMessageCommand=function(self) self:y(450*1.5); self:bounceend(0.175); self:y(480*2); end;
LoadActor("FFFFFFF.png")..{
	InitCommand=function(self) self:zoom(0.5); end;
OnCommand=function(self) self:playcommand('hhhat'); end;
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
	OnCommand=function(self) self:diffuse(PlayerColor(PLAYER_1)); end;
LoadFont("common edit") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X-155); self:y(SCREEN_CENTER_Y-66+458); self:vertalign(top); self:zoom(0.75); end;
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
	YeyyyyyyMessageCommand=function(self) self:bounceend(0.175); self:zoom(0); end;
	};
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X-250); self:y(SCREEN_CENTER_Y-66+458+35); self:vertalign(top); self:horizalign(left); self:zoom(0.75); end;
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
	YeyyyyyyMessageCommand=function(self) self:bounceend(0.175); self:zoom(0); end;
	};
LoadFont("common edit") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X-155); self:y(SCREEN_CENTER_Y-66+458+177.5); self:vertalign(top); self:zoom(0.75); end;
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
	YeyyyyyyMessageCommand=function(self) self:bounceend(0.175); self:zoom(0); end;
	};
	};
	
	
	
	Def.ActorFrame {
	OnCommand=function(self) self:diffuse(PlayerColor(PLAYER_2)); end;
LoadFont("common edit") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X+155); self:y(SCREEN_CENTER_Y-66+458); self:vertalign(top); self:zoom(0.75); end;
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
	YeyyyyyyMessageCommand=function(self) self:bounceend(0.175); self:zoom(0); end;
	};
LoadFont("common normal") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X+250); self:y(SCREEN_CENTER_Y-66+458+35); self:vertalign(top); self:horizalign(right); self:zoom(0.75); end;
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
	YeyyyyyyMessageCommand=function(self) self:bounceend(0.175); self:zoom(0); end;
	};
LoadFont("common edit") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X+155); self:y(SCREEN_CENTER_Y-66+458+177.5); self:vertalign(top); self:zoom(0.75); end;
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
	YeyyyyyyMessageCommand=function(self) self:bounceend(0.175); self:zoom(0); end;
	};
	};
	};
};
};

return t;
