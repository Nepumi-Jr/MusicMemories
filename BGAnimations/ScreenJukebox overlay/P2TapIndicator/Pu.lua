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
OnCommand=cmd(zoom,0;playcommand,"Nep");
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
InitCommand=cmd(rotationz,(180+270)/2;SetTextureFiltering,false;x,-Sped;y,Sped;zoom,Kayay);
DL2MessageCommand=cmd(stoptweening;decelerate,Rew[1];diffuse,Pum2Cl;x,-Sped*1.3;y,Sped*1.3); 
DL2reMessageCommand=cmd(stoptweening;bounceend,Rew[2];diffuse,Pum2ClF;x,-Sped;y,Sped); 
};
LoadActor("Arrow")..{--UpLeft
InitCommand=cmd(rotationz,(270+360)/2;SetTextureFiltering,false;x,-Sped;y,-Sped;zoom,Kayay);
UL2MessageCommand=cmd(stoptweening;decelerate,Rew[1];diffuse,Pum2Cl;x,-Sped*1.3;y,-Sped*1.3); 
UL2reMessageCommand=cmd(stoptweening;bounceend,Rew[2];diffuse,Pum2ClF;x,-Sped;y,-Sped); 
};
LoadActor("inputoverlay-key")..{--Center
InitCommand=cmd(SetTextureFiltering,false;zoom,Kayay*0.2);
CT2MessageCommand=cmd(stoptweening;decelerate,Rew[1];diffuse,Pum2Cl;zoom,Kayay*1.2*0.2); 
CT2reMessageCommand=cmd(stoptweening;bounceend,Rew[2];diffuse,Pum2ClF;zoom,Kayay*0.2); 
};
LoadActor("Arrow")..{--UpRight
InitCommand=cmd(rotationz,(90)/2;SetTextureFiltering,false;x,Sped;y,-Sped;zoom,Kayay);
UR2MessageCommand=cmd(stoptweening;decelerate,Rew[1];diffuse,Pum2Cl;x,Sped*1.3;y,-Sped*1.3); 
UR2reMessageCommand=cmd(stoptweening;bounceend,Rew[2];diffuse,Pum2ClF;x,Sped;y,-Sped); 
};
LoadActor("Arrow")..{--DownRight
InitCommand=cmd(rotationz,(180+90)/2;SetTextureFiltering,false;x,Sped;y,Sped;zoom,Kayay);
DR2MessageCommand=cmd(stoptweening;decelerate,Rew[1];diffuse,Pum2Cl;x,Sped*1.3;y,Sped*1.3); 
DR2reMessageCommand=cmd(stoptweening;bounceend,Rew[2];diffuse,Pum2ClF;x,Sped;y,Sped); 
};
};

return t;