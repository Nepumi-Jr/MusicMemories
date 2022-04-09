local Player = ...;
local style = GAMESTATE:GetCurrentStyle();
local styleType = style:GetStyleType();
local bDoubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides');
local center1P = PREFSMAN:GetPreference("Center1Player")

-- initialize each stage at a HealthState of "alive"
local prevHealth = "HealthState_Alive";

local t = Def.ActorFrame{
	Name="Danger" .. ToEnumShortString(Player);
	HealthStateChangedMessageCommand=function(self, param)
		if param.PlayerNumber == Player then
			if param.HealthState == "HealthState_Danger" then				
				self:RunCommandsOnChildren(function(self) self:playcommand("Danger"); end);
				prevHealth = "HealthState_Danger"
				
			elseif param.HealthState == "HealthState_Dead" then
				self:RunCommandsOnChildren(function(self) self:playcommand("Dead"); end);
				
			else
				if prevHealth == "HealthState_Danger" then
					self:RunCommandsOnChildren(function(self) self:playcommand("OutOfDanger"); end);
				else
					self:RunCommandsOnChildren(function(self) self:playcommand("Hide"); end);
				end
				prevHealth = "HealthState_Alive";
			end
		end
	end;
};


t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:diffusealpha(0);
		
		if bDoubles then
			self:stretchto(0,0,_screen.w,_screen.h);
		elseif center1P and not (GAMESTATE:IsHumanPlayer(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_2)) then
			self:stretchto(0,0,_screen.w,_screen.h);
		elseif not bDoubles and Player == PLAYER_1 then
			self:faderight(0.1); self:stretchto(0,0,_screen.cx,_screen.h);
		elseif not bDoubles and Player == PLAYER_2 then
			self:fadeleft(0.1); self:stretchto(_screen.cx,0,_screen.w,_screen.h);
		end
	end;
	DangerCommand=function(self) self:linear(0.3); self:diffusealpha(0.7); self:diffuseshift(); self:effectcolor1(color("1,0,0.24,0.3")); self:effectcolor2(color("1,0,0,0.8")); end;
	DeadCommand=function(self) self:diffusealpha(0); self:stopeffect(); self:stoptweening(); self:diffuse(color("1,0,0")); self:linear(0.3); self:diffusealpha(0.8); self:linear(0.3); self:diffusealpha(0); end;
	OutOfDangerCommand=function(self) self:diffusealpha(0); self:stopeffect(); self:stoptweening(); self:diffuse(color("0,1,0")); self:linear(0.3); self:diffusealpha(0.8); self:linear(0.3); self:diffusealpha(0); end;
	HideCommand=function(self) self:stopeffect(); self:stoptweening(); self:linear(0.3); self:diffusealpha(0); end;
};

t[#t+1] =Def.ActorFrame{
	OnCommand=function(self) self:vibrate(); end;
 	LoadFont("_8-bit madness 40px")..{
		Text="Better!";
	InitCommand=function(self)
		self:diffusealpha(0);
		
		if bDoubles then
			self:Center();
		elseif center1P then
			self:Center();
		elseif not bDoubles and Player == PLAYER_1 then
			self:x(360-180); self:y(240);
		elseif not bDoubles and Player == PLAYER_2 then
			self:x(360+180); self:y(240);
		end
	end;
			OnCommand=function(self) self:vibrate(); end;
	DangerCommand=function(self) self:linear(0.3); self:diffusealpha(0.7); self:diffuseshift(); self:effectcolor1(color("1,0,0.24,0.3")); self:effectcolor2(color("1,0,0,0.8")); end;
	DeadCommand=function(self) self:diffusealpha(0); self:stopeffect(); self:stoptweening(); self:diffuse(color("1,0,0")); self:linear(0.3); self:diffusealpha(0.8); self:linear(0.3); self:diffusealpha(0); end;
	OutOfDangerCommand=function(self) self:diffusealpha(0); self:stopeffect(); self:stoptweening(); self:diffuse(color("0,1,0")); self:linear(0.3); self:diffusealpha(0.8); self:linear(0.3); self:diffusealpha(0); end;
	HideCommand=function(self) self:stopeffect(); self:stoptweening(); self:linear(0.3); self:diffusealpha(0); end;
};
};

return t;