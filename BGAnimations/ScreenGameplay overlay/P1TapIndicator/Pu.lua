local Pum1Press = {0,0,0,0,0};
--Thatmean{DL,UL,Cennter,UR,DR}
local InputPumP1 = function( event )

	if not event then return end

	if event.type == "InputEventType_FirstPress" then
		
		if event.button == "DownLeft" and event.PlayerNumber == PLAYER_1 then
			Pum1Press[1] = 1
		end
		if event.button == "UpLeft" and event.PlayerNumber == PLAYER_1 then
			Pum1Press[2] = 1
		end
		if event.button == "Center" and event.PlayerNumber == PLAYER_1 then
			Pum1Press[3] = 1
		end
		if event.button == "UpRight" and event.PlayerNumber == PLAYER_1 then
			Pum1Press[4] = 1
		end
		if event.button == "DownRight" and event.PlayerNumber == PLAYER_1 then
			Pum1Press[5] = 1
		end
		
	end
	
	if event.type == "InputEventType_Release" then
		
		if event.button == "DownLeft" and event.PlayerNumber == PLAYER_1 then
			Pum1Press[1] = 0
		end
		if event.button == "UpLeft" and event.PlayerNumber == PLAYER_1 then
			Pum1Press[2] = 0
		end
		if event.button == "Center" and event.PlayerNumber == PLAYER_1 then
			Pum1Press[3] = 0
		end
		if event.button == "UpRight" and event.PlayerNumber == PLAYER_1 then
			Pum1Press[4] = 0
		end
		if event.button == "DownRight" and event.PlayerNumber == PLAYER_1 then
			Pum1Press[5] = 0
		end
		
	end

end
local Pum1Run = {false,false,false,false,false,false}
local Sped = 27;
local Kayay = 3;
local Rew = {0.04,0.08} ;
local Pum1Cl = BoostColor((Color[TP[ToEnumShortString(PLAYER_1)].ActiveModifiers.ComboColorstring] or Color.White),1.4);
local Pum1ClF = BoostColor((Color[TP[ToEnumShortString(PLAYER_1)].ActiveModifiers.ComboColorstring] or Color.White),0.2);
local t = Def.ActorFrame{};
local CodePor;

if GAMESTATE:IsCourseMode() then
CodePor = GAMESTATE:GetCurrentTrail(PLAYER_1);
else
CodePor = GAMESTATE:GetCurrentSteps(PLAYER_1);
end


t[#t+1] = Def.ActorFrame{
OnCommand=function(self)
SCREENMAN:GetTopScreen():AddInputCallback(InputPumP1)
self:x(42)
self:y(400)
end;
Def.Quad{--control panel
OnCommand=function(self) self:zoom(0); self:playcommand("Nep"); end;
NepCommand=function(self)
	if Pum1Press[1] == 1 then MESSAGEMAN:Broadcast("DL1") else MESSAGEMAN:Broadcast("DL1re") end
	if Pum1Press[2] == 1 then MESSAGEMAN:Broadcast("UL1") else MESSAGEMAN:Broadcast("UL1re") end
	if Pum1Press[3] == 1 then MESSAGEMAN:Broadcast("CT1") else MESSAGEMAN:Broadcast("CT1re") end
	if Pum1Press[4] == 1 then MESSAGEMAN:Broadcast("UR1") else MESSAGEMAN:Broadcast("UR1re") end
	if Pum1Press[5] == 1 then MESSAGEMAN:Broadcast("DR1") else MESSAGEMAN:Broadcast("DR1re") end
self:sleep(1/30)
self:queuecommand("Nep")
end;
};
LoadActor("Arrow")..{--DownLeft
InitCommand=function(self) self:rotationz((180+270)/2); self:SetTextureFiltering(false); self:x(-Sped); self:y(Sped); self:zoom(Kayay); end;
DL1MessageCommand=function(self) self:stoptweening(); self:decelerate(Rew[1]); self:diffuse(Pum1Cl); self:x(-Sped*1.3); self:y(Sped*1.3); end; 
DL1reMessageCommand=function(self) self:stoptweening(); self:bounceend(Rew[2]); self:diffuse(Pum1ClF); self:x(-Sped); self:y(Sped); end; 
};
LoadActor("Arrow")..{--UpLeft
InitCommand=function(self) self:rotationz((270+360)/2); self:SetTextureFiltering(false); self:x(-Sped); self:y(-Sped); self:zoom(Kayay); end;
UL1MessageCommand=function(self) self:stoptweening(); self:decelerate(Rew[1]); self:diffuse(Pum1Cl); self:x(-Sped*1.3); self:y(-Sped*1.3); end; 
UL1reMessageCommand=function(self) self:stoptweening(); self:bounceend(Rew[2]); self:diffuse(Pum1ClF); self:x(-Sped); self:y(-Sped); end; 
};
LoadActor("inputoverlay-key")..{--Center
InitCommand=function(self) self:SetTextureFiltering(false); self:zoom(Kayay*0.2); end;
CT1MessageCommand=function(self) self:stoptweening(); self:decelerate(Rew[1]); self:diffuse(Pum1Cl); self:zoom(Kayay*1.2*0.2); end; 
CT1reMessageCommand=function(self) self:stoptweening(); self:bounceend(Rew[2]); self:diffuse(Pum1ClF); self:zoom(Kayay*0.2); end; 
};
LoadActor("Arrow")..{--UpRight
InitCommand=function(self) self:rotationz((90)/2); self:SetTextureFiltering(false); self:x(Sped); self:y(-Sped); self:zoom(Kayay); end;
UR1MessageCommand=function(self) self:stoptweening(); self:decelerate(Rew[1]); self:diffuse(Pum1Cl); self:x(Sped*1.3); self:y(-Sped*1.3); end; 
UR1reMessageCommand=function(self) self:stoptweening(); self:bounceend(Rew[2]); self:diffuse(Pum1ClF); self:x(Sped); self:y(-Sped); end; 
};
LoadActor("Arrow")..{--DownRight
InitCommand=function(self) self:rotationz((180+90)/2); self:SetTextureFiltering(false); self:x(Sped); self:y(Sped); self:zoom(Kayay); end;
DR1MessageCommand=function(self) self:stoptweening(); self:decelerate(Rew[1]); self:diffuse(Pum1Cl); self:x(Sped*1.3); self:y(Sped*1.3); end; 
DR1reMessageCommand=function(self) self:stoptweening(); self:bounceend(Rew[2]); self:diffuse(Pum1ClF); self:x(Sped); self:y(Sped); end; 
};
};

return t;