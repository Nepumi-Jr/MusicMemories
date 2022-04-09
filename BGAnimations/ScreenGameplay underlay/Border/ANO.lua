--SM("\n\n\n\n\n"..TP.GamePlay.Mode)
local ISLA = Def.ActorFrame{
		--|line man..(P1)
	LoadActor("Under lay2")..{
		InitCommand=function(self) self:FullScreen(); self:y(SCREEN_CENTER_Y+10); self:SetTextureFiltering(false); end;
	};
	--[[Def.Quad{
		OnCommand=function(self) self:x(17.5); self:y(43.75); self:zoomx(7); self:zoomy(7*7.45); end;
		GETOUTOFGAMESMMessageCommand=function(self) self:sleep(math.random(0,10)/10); self:accelerate(1); self:zoomy(0); end;
	};
	Def.Quad{
		OnCommand=function(self) self:x(17.5+65); self:y(43.75); self:zoomx(7); self:zoomy(7*7.45); end;
		GETOUTOFGAMESMMessageCommand=function(self) self:sleep(math.random(0,10)/10); self:accelerate(1); self:zoomy(0); end;
	};
	
	Def.Quad{
		OnCommand=function(self) self:x(165.75+83); self:y(43.75*1.4-2.5); self:zoomx(7); self:zoomy(7*7.45*0.44); end;
		GETOUTOFGAMESMMessageCommand=function(self) self:sleep(math.random(0,10)/10); self:accelerate(1); self:zoomy(0); end;
	};
	
	Def.Quad{
		OnCommand=function(self) self:x(165.75+83*2+8); self:y(43.75*1.4-2.5); self:zoomx(9); self:zoomy(7*7.45*0.44); end;
		GETOUTOFGAMESMMessageCommand=function(self) self:sleep(math.random(0,10)/10); self:accelerate(1); self:zoomy(0); end;
	};
	Def.Quad{
		OnCommand=function(self) self:x(165.75+83*2+8); self:y(43.75*0.675+3); self:zoomx(9); self:zoomy(7*7.45*0.6); end;
		GETOUTOFGAMESMMessageCommand=function(self) self:sleep(math.random(0,10)/10); self:accelerate(1); self:zoomy(0); end;
	};
	
	--|line man..(P2)
	Def.Quad{
		OnCommand=function(self) self:x(SCREEN_RIGHT-(17.5)); self:y(43.75); self:zoomx(7); self:zoomy(7*7.45); end;
		GETOUTOFGAMESMMessageCommand=function(self) self:sleep(math.random(0,10)/10); self:accelerate(1); self:zoomy(0); end;
	};
	Def.Quad{
		OnCommand=function(self) self:x(SCREEN_RIGHT-(17.5+65)); self:y(43.75); self:zoomx(7); self:zoomy(7*7.45); end;
		GETOUTOFGAMESMMessageCommand=function(self) self:sleep(math.random(0,10)/10); self:accelerate(1); self:zoomy(0); end;
	};
	
	Def.Quad{
		OnCommand=function(self) self:x(SCREEN_RIGHT-(165.75+83)); self:y(43.75*1.4-2.5); self:zoomx(7); self:zoomy(7*7.45*0.44); end;
		GETOUTOFGAMESMMessageCommand=function(self) self:sleep(math.random(0,10)/10); self:accelerate(1); self:zoomy(0); end;
	};
	
	Def.Quad{
		OnCommand=function(self) self:x(SCREEN_RIGHT-(165.75+83*2+8)); self:y(43.75*1.4-2.5); self:zoomx(9); self:zoomy(7*7.45*0.44); end;
		GETOUTOFGAMESMMessageCommand=function(self) self:sleep(math.random(0,10)/10); self:accelerate(1); self:zoomy(0); end;
	};
	Def.Quad{
		OnCommand=function(self) self:x(SCREEN_RIGHT-(165.75+83*2+8)); self:y(43.75*0.675+3); self:zoomx(9); self:zoomy(7*7.45*0.6); end;
		GETOUTOFGAMESMMessageCommand=function(self) self:sleep(math.random(0,10)/10); self:accelerate(1); self:zoomy(0); end;
	};
	
	
	
	
	
	
	-- ____ Man..

	Def.Quad{
		OnCommand=function(self) self:CenterX(); self:y(14.7); self:zoomx(SCREEN_CENTER_X*1.935); self:zoomy(5.9); end;
		GETOUTOFGAMESMMessageCommand=function(self) self:sleep(math.random(0,10)/10); self:accelerate(1); self:zoomx(0); end;
	};
	Def.Quad{
		OnCommand=function(self) self:CenterX(); self:y(44.30+6); self:zoomx(SCREEN_CENTER_X*1.597); self:zoomy(5.9); end;
		GETOUTOFGAMESMMessageCommand=function(self) self:sleep(math.random(0,10)/10); self:accelerate(1); self:zoomx(0); end;
	};
	Def.Quad{
		OnCommand=function(self) self:CenterX(); self:y(14.7+57); self:zoomx(SCREEN_CENTER_X*1.935); self:zoomy(5.9); end;
		GETOUTOFGAMESMMessageCommand=function(self) self:sleep(math.random(0,10)/10); self:accelerate(1); self:zoomx(0); end;
	};]]


};


local x=Def.ActorFrame{


Def.ActorFrame{
OnCommand=function(self) self:queuecommand("Nep"); end;
		CurrentSongChangedMessageCommand=function(self) self:queuecommand("Nep"); end;
		NepCommand=function(self)
		if TP.GamePlay.Mode == "Battle" then
		self:diffuse(Color.Blue or color("#5555FF"))
		elseif TP.GamePlay.Mode == "Mission" and false then
		self:diffuse(color("#777777"))
		elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		self:diffuserightedge(Diff2Cl(GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty(),1))
		self:diffuseleftedge(Diff2Cl(GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty(),1))
		elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
		self:diffuse(Diff2Cl(GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty(),1))
		elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		self:diffuse(Diff2Cl(GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty(),1))
		end
		end;
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