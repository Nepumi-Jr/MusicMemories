local Pum2Press = {0,0,0,0,0};
--Thatmean{DL,UL,Cennter,UR,DR}
local InputPumP2 = function( event )

	if not event then return end

	if event.type == "InputEventType_FirstPress" then
		
		if event.button == "DownLeft" and event.PlayerNumber == PLAYER_2 then
			Pum2Press[1] = 1
		end
		if event.button == "UpLeft" and event.PlayerNumber == PLAYER_2 then
			Pum2Press[2] = 1
		end
		if event.button == "Center" and event.PlayerNumber == PLAYER_2 then
			Pum2Press[3] = 1
		end
		if event.button == "UpRight" and event.PlayerNumber == PLAYER_2 then
			Pum2Press[4] = 1
		end
		if event.button == "DownRight" and event.PlayerNumber == PLAYER_2 then
			Pum2Press[5] = 1
		end
		
	end
	
	if event.type == "InputEventType_Release" then
		
		if event.button == "DownLeft" and event.PlayerNumber == PLAYER_2 then
			Pum2Press[1] = 0
		end
		if event.button == "UpLeft" and event.PlayerNumber == PLAYER_2 then
			Pum2Press[2] = 0
		end
		if event.button == "Center" and event.PlayerNumber == PLAYER_2 then
			Pum2Press[3] = 0
		end
		if event.button == "UpRight" and event.PlayerNumber == PLAYER_2 then
			Pum2Press[4] = 0
		end
		if event.button == "DownRight" and event.PlayerNumber == PLAYER_2 then
			Pum2Press[5] = 0
		end
		
	end

end
local Pum2Run = {false,false,false,false,false,false}
local Sped = 27;
local Kayay = 3;
local Rew = {0.04,0.08} ;
local Pum2Cl = BoostColor((Color[TP[ToEnumShortString(PLAYER_2)].ActiveModifiers.ComboColorstring] or Color.White),1.4);
local Pum2ClF = BoostColor((Color[TP[ToEnumShortString(PLAYER_2)].ActiveModifiers.ComboColorstring] or Color.White),0.2);
local t = Def.ActorFrame{};
local CodePor;

if GAMESTATE:IsCourseMode() then
CodePor = GAMESTATE:GetCurrentTrail(PLAYER_2);
else
CodePor = GAMESTATE:GetCurrentSteps(PLAYER_2);
end


t[#t+1] = Def.ActorFrame{
OnCommand=function(self)
SCREENMAN:GetTopScreen():AddInputCallback(InputPumP2)
self:x(SCREEN_RIGHT-42)
self:y(400)
end;
Def.Quad{--control panel
OnCommand=function(self) self:zoom(0); self:playcommand("Nep"); end;
NepCommand=function(self)
	if Pum2Press[1] == 1 then MESSAGEMAN:Broadcast("DL2") else MESSAGEMAN:Broadcast("DL2re") end
	if Pum2Press[2] == 1 then MESSAGEMAN:Broadcast("UL2") else MESSAGEMAN:Broadcast("UL2re") end
	if Pum2Press[3] == 1 then MESSAGEMAN:Broadcast("CT2") else MESSAGEMAN:Broadcast("CT2re") end
	if Pum2Press[4] == 1 then MESSAGEMAN:Broadcast("UR2") else MESSAGEMAN:Broadcast("UR2re") end
	if Pum2Press[5] == 1 then MESSAGEMAN:Broadcast("DR2") else MESSAGEMAN:Broadcast("DR2re") end
self:sleep(1/30)
self:queuecommand("Nep")
end;
};
LoadActor("Arrow")..{--DownLeft
InitCommand=function(self) self:rotationz((180+270)/2); self:SetTextureFiltering(false); self:x(-Sped); self:y(Sped); self:zoom(Kayay); end;
DL2MessageCommand=function(self) self:stoptweening(); self:decelerate(Rew[1]); self:diffuse(Pum2Cl); self:x(-Sped*1.3); self:y(Sped*1.3); end; 
DL2reMessageCommand=function(self) self:stoptweening(); self:bounceend(Rew[2]); self:diffuse(Pum2ClF); self:x(-Sped); self:y(Sped); end; 
};
LoadActor("Arrow")..{--UpLeft
InitCommand=function(self) self:rotationz((270+360)/2); self:SetTextureFiltering(false); self:x(-Sped); self:y(-Sped); self:zoom(Kayay); end;
UL2MessageCommand=function(self) self:stoptweening(); self:decelerate(Rew[1]); self:diffuse(Pum2Cl); self:x(-Sped*1.3); self:y(-Sped*1.3); end; 
UL2reMessageCommand=function(self) self:stoptweening(); self:bounceend(Rew[2]); self:diffuse(Pum2ClF); self:x(-Sped); self:y(-Sped); end; 
};
LoadActor("inputoverlay-key")..{--Center
InitCommand=function(self) self:SetTextureFiltering(false); self:zoom(Kayay*0.2); end;
CT2MessageCommand=function(self) self:stoptweening(); self:decelerate(Rew[1]); self:diffuse(Pum2Cl); self:zoom(Kayay*1.2*0.2); end; 
CT2reMessageCommand=function(self) self:stoptweening(); self:bounceend(Rew[2]); self:diffuse(Pum2ClF); self:zoom(Kayay*0.2); end; 
};
LoadActor("Arrow")..{--UpRight
InitCommand=function(self) self:rotationz((90)/2); self:SetTextureFiltering(false); self:x(Sped); self:y(-Sped); self:zoom(Kayay); end;
UR2MessageCommand=function(self) self:stoptweening(); self:decelerate(Rew[1]); self:diffuse(Pum2Cl); self:x(Sped*1.3); self:y(-Sped*1.3); end; 
UR2reMessageCommand=function(self) self:stoptweening(); self:bounceend(Rew[2]); self:diffuse(Pum2ClF); self:x(Sped); self:y(-Sped); end; 
};
LoadActor("Arrow")..{--DownRight
InitCommand=function(self) self:rotationz((180+90)/2); self:SetTextureFiltering(false); self:x(Sped); self:y(Sped); self:zoom(Kayay); end;
DR2MessageCommand=function(self) self:stoptweening(); self:decelerate(Rew[1]); self:diffuse(Pum2Cl); self:x(Sped*1.3); self:y(Sped*1.3); end; 
DR2reMessageCommand=function(self) self:stoptweening(); self:bounceend(Rew[2]); self:diffuse(Pum2ClF); self:x(Sped); self:y(Sped); end; 
};
};

return t;