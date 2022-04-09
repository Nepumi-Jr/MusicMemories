--SM("\n\n\n\n\n"..TP.GamePlay.Mode)
local ISLA = Def.ActorFrame{
		--|line man..(P1)
	LoadActor("Under lay2")..{
		InitCommand=function(self) self:FullScreen(); self:y(SCREEN_CENTER_Y+10); self:SetTextureFiltering(false); end;
		CurrentSongChangedMessageCommand=function(self) self:queuecommand("Nep"); end;
		NepCommand=function(self)
			if TP.GamePlay.Mode == "Battle" then
				self:diffuse(Color.Blue or color("#5555FF"))
			elseif TP.GamePlay.Mode == "Mission" and false then
				self:diffuse(color("#777777"))
			elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
				self:diffuse({1,1,1,1})
				self:diffuseupperright(Diff2Cl(GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty(),1))
				self:diffuseupperleft(Diff2Cl(GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty(),1))
			elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
				self:diffuse(Diff2Cl(GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty(),1))
			elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
				self:diffuse(Diff2Cl(GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty(),1))
			end
		end;
	};
    LoadActor("TimeBar.png")..{
		InitCommand=function(self) self:FullScreen(); self:y(SCREEN_CENTER_Y+10); self:SetTextureFiltering(false); self:diffuse({0,0,0,1}); end;
	};


};


local x=Def.ActorFrame{


Def.ActorFrame{
OnCommand=function(self) self:queuecommand("Nep"); end;
	ISLA;
	Def.Quad{
		OnCommand=function(self) self:diffuse(Color.White); self:x(SCREEN_CENTER_X-SCREEN_CENTER_X*1.935/2); self:horizalign(left); self:y(14.7+57); self:zoomx(SCREEN_CENTER_X*1.935); self:zoomy(5.9); self:queuecommand("Nep"); end;
		CurrentSongChangedMessageCommand=function(self) self:queuecommand("Nep"); end;
		NepCommand=function(self)
		self:diffuse(Color.White)
		self:diffusealpha(0.45)
		self:playcommand("PRO")
		end;
		PROCommand=function(self)
			if GAMESTATE:GetSongBeat()<GAMESTATE:GetCurrentSong():GetLastBeat() then
				self:zoomx(math.max(math.min(GAMESTATE:GetSongBeat()/GAMESTATE:GetCurrentSong():GetLastBeat(),1)*SCREEN_CENTER_X*1.935,0))
				self:sleep(1/30):queuecommand("PRO")
			end
		end;
		GETOUTOFGAMESMMessageCommand=function(self) self:finishtweening(); self:accelerate(1); self:diffusealpha(0); end;
	};

	};
	Def.ActorFrame{
		OnCommand=function(self) self:diffuseshift(); self:effectcolor1({1,1,1,0.5}); self:effectcolor2({1,1,1,0}); self:effectclock("beat"); self:effectperiod(4); end;
		ISLA;
	};
};
return x;