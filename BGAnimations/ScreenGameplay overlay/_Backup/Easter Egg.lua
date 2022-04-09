local I = math.random(1,6);
local P = 0;
local beat = 16;
local r = 0;
local M = 0;
local tick = 0;
local tick2 = 0;
local tick3 = 0;
local tick4 = 0;
local WTF = 0;
local Hi = 0;
local W = 0;
local p1score = 0;
local p1scorefin = 0;
local cursound = 1;
local H = 0;
local Nep = 0;
local UndertaleName = {"Torial","Sans","Papyrus","Frisk","Chara","Asgore","Asrial","Undyne","Alphy"}
local NeptuneName = {"Neptune","Nepgear","IF","Compa","Noire","Uni","Rom","Ram","Blanc","Vert","Histy"}
local profile1 = PROFILEMAN:GetProfile(PLAYER_1);
local name1 = profile1:GetDisplayName();
local profile2 = PROFILEMAN:GetProfile(PLAYER_2);
local name2 = profile2:GetDisplayName();
local fontP1 = kindof(name1,NeptuneName,"_powerweld 24px",kindof(name1,UndertaleName,"_determination mono 24px","Common Normal"));
local fontP2 = kindof(name2,NeptuneName,"_powerweld 24px",kindof(name2,UndertaleName,"_determination mono 24px","Common Normal"));
local t = Def.ActorFrame{};


t[#t+1] = Def.ActorFrame{
	LoadFont(fontP1)..{
				InitCommand=function(self) self:x(SCREEN_CENTER_X+2.5-160); self:y(56.75214415523215378951351-SCREEN_BOTTOM+40); self:zoom(0.7); self:horizalign(left); end;
		OnCommand=function(self) self:playcommand('Super'); end;--fail! ## i forgeted '(self)'
		SuperCommand=function(self)
		self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
							self:diffuse(color("#ff0000"))
		end;
				
				BeginCommand=function(self)
					local profile = PROFILEMAN:GetProfile(PLAYER_1);
					local name = profile:GetDisplayName();
					
					if GAMESTATE:IsHumanPlayer(PLAYER_1) == true then
						if name=="" then
							self:settext("P1 Guy");
						else
							self:settext( name );
						end
						if kindof(name1,NeptuneName,true,false) then
							self:zoom(0.35)
							self:x(SCREEN_CENTER_X+2.5-160-10)
							self:y(56.75214415523215378951351-SCREEN_BOTTOM+40+4)
						end
					end
					
				end;
};
	LoadFont(fontP2)..{
				InitCommand=function(self) self:x(SCREEN_CENTER_X-2.5+160); self:y(56.75214415523215378951351-SCREEN_BOTTOM+40); self:zoom(0.7); self:horizalign(right); end;
		OnCommand=function(self) self:playcommand('Super'); end;--fail! ## i forgeted '(self)'
		SuperCommand=function(self)
		self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
							self:diffuse(color("#5555FF"))
		end;
				
				BeginCommand=function(self)
					local profile = PROFILEMAN:GetProfile(PLAYER_2);
					local name = profile:GetDisplayName();
					
					if GAMESTATE:IsHumanPlayer(PLAYER_2) == true then
						if name=="" then
							self:settext("P2 Guy");
						else
							self:settext( name );
						end
						if kindof(name2,NeptuneName,true,false) then
							self:zoom(0.35)
							self:x(SCREEN_CENTER_X+2.5+160+10)
							self:y(56.75214415523215378951351-SCREEN_BOTTOM+40+4)
						end
					end
					
				end;
};
	Def.Sprite {
		Texture="Half 1x2";
		Frame0000=0;
		Delay0000=1;
		Frame0001=1;
		Delay0001=1;
		OnCommand=function(self) self:effectclock('beat'); self:x(SCREEN_CENTER_X+10); self:zoom(0.7); self:y(-383+2); self:playcommand('loop'); end;
		loopCommand=function(self)
		WTF=GAMESTATE:GetCurrentSong():GetLastSecond()-GAMESTATE:GetCurMusicSeconds()
		Hi=SecondsToMSSMsMs(GAMESTATE:GetCurrentSong():GetLastSecond()-GAMESTATE:GetCurMusicSeconds())
		kuy=SecondsToMSSMsMs(GAMESTATE:GetCurrentSong():GetLastSecond())
		if P <= 50 then
		self:diffusealpha(0);
		elseif P >= 50 and P <= 55 then
		self:diffusealpha(1);
		elseif P >= 55 and P <= 100 then
		self:diffusealpha(0);
		end
		self:sleep(0.02)
		self:queuecommand('loop')
		end;
};
};
if GAMESTATE:IsCourseMode() then
t[#t+1] = Def.ActorFrame{
	OnCommand=function(self) self:y(-SCREEN_BOTTOM+40); end;
		 LoadFont("_8-bit madness 72px")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-135-85-55-85-17); self:y(SCREEN_TOP+40); self:zoom(1); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
								self:diffuse(color("#FF0000"))
		end;
		BeginCommand=function(self)
					local steps = GAMESTATE:GetCurrentTrail(PLAYER_1)
			local meter = steps:GetMeter()

			if meter then
				if meter == 1943951546 then
				self:settext("??")
				self:zoom(0.8)
				elseif meter >= 10 then
				self:zoom(0.8)
				self:settext(meter)
				elseif meter >= 100 then
				self:zoom(0.5)
				self:settext(meter)
				elseif meter >= 1000 then
				self:zoom(0.3)
				self:settext(meter)
				else
				self:settext(meter)
				self:zoom(1)
				end
			end
		end;
	};
	 LoadFont("_8-bit madness 72px")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+135+85+55+85+17); self:y(SCREEN_TOP+40); self:zoom(1); end;
			OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
								self:diffuse(color("#5555ff"))
		end;
		BeginCommand=function(self)
			local steps = GAMESTATE:GetCurrentTrail(PLAYER_2)
			local meter = steps:GetMeter()
			if meter then	
				if meter == 1943951546 then
				self:settext("??")
				self:zoom(0.8)
				elseif meter >= 10 then
				self:zoom(0.8)
				self:settext(meter)
				elseif meter >= 100 then
				self:zoom(0.5)
				self:settext(meter)
				elseif meter >= 1000 then
				self:zoom(0.3)
				self:settext(meter)
				else
				self:settext(meter)
				self:zoom(1)
				end
			end
		end;
	};
	};
else
	t[#t+1] = Def.ActorFrame{
	OnCommand=function(self) self:y(-SCREEN_BOTTOM+40); end;
		 LoadFont("_8-bit madness 72px")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-135-85-55-85-17); self:y(SCREEN_TOP+40); self:zoom(1); end;
		OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1))
								self:diffuse(color("#FF0000"))
		end;
		BeginCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
			local meter = steps:GetMeter()

			if meter then	
				if meter == 1943951546 then
				self:settext("??")
				self:zoom(0.8)
				elseif meter >= 10 then
				self:zoom(0.8)
				self:settext(meter)
				elseif meter >= 100 then
				self:zoom(0.5)
				self:settext(meter)
				elseif meter >= 1000 then
				self:zoom(0.3)
				self:settext(meter)
				else
				self:settext(meter)
				self:zoom(1)
				end
			end
		end;
	};
	 LoadFont("_8-bit madness 72px")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+135+85+55+85+17); self:y(SCREEN_TOP+40); self:zoom(1); end;
				OnCommand=function(self)
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2))
								self:diffuse(color("#5555ff"))
		end;
		BeginCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
			local meter = steps:GetMeter()

			if meter then
				if meter == 1943951546 then
				self:settext("??")
				self:zoom(0.8)
				elseif meter >= 10 then
				self:zoom(0.8)
				self:settext(meter)
				elseif meter >= 100 then
				self:zoom(0.5)
				self:settext(meter)
				elseif meter >= 1000 then
				self:zoom(0.3)
				self:settext(meter)
				else
				self:settext(meter)
				self:zoom(1)
				end
			end
		end;
	};
	};
end

return t;
