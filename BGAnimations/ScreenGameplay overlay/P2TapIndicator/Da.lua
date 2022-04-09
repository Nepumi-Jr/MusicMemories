local Dan1Press = {0,0,0,0,0,0};
--Thatmean{L,D,U R,LU,RU}
local InputDanP1 = function( event )

	if not event then return end

	if event.type == "InputEventType_FirstPress" then
		
		if event.button == "Left" and event.PlayerNumber == PLAYER_2 then
			Dan1Press[1] = 1
		end
		if event.button == "UpLeft" and event.PlayerNumber == PLAYER_2 then
			Dan1Press[5] = 1
		end
		if event.button == "Down" and event.PlayerNumber == PLAYER_2 then
			Dan1Press[2] = 1
		end
		if event.button == "Up" and event.PlayerNumber == PLAYER_2 then
			Dan1Press[3] = 1
		end
		if event.button == "Right" and event.PlayerNumber == PLAYER_2 then
			Dan1Press[4] = 1
		end
		if event.button == "UpRight" and event.PlayerNumber == PLAYER_2 then
			Dan1Press[6] = 1
		end
		
	end
	
	if event.type == "InputEventType_Release" then
		
		if event.button == "UpLeft" and event.PlayerNumber == PLAYER_2 then
			Dan1Press[5] = 0
		end
		if event.button == "UpRight" and event.PlayerNumber == PLAYER_2 then
			Dan1Press[6] = 0
		end
		if event.button == "Left" and event.PlayerNumber == PLAYER_2 then
			Dan1Press[1] = 0
		end
		if event.button == "Down" and event.PlayerNumber == PLAYER_2 then
			Dan1Press[2] = 0
		end
		if event.button == "Up" and event.PlayerNumber == PLAYER_2 then
			Dan1Press[3] = 0
		end
		if event.button == "Right" and event.PlayerNumber == PLAYER_2 then
			Dan1Press[4] = 0
		end
		
	end

end
local Dan1Run = {false,false,false,false,false,false}
local Sped = 27;
local Kayay = 0.55;
local Rew = {0.07,0.15} ;
local Dan1Cl = BoostColor((Color[TP[ToEnumShortString(PLAYER_2)].ActiveModifiers.ComboColorstring] or Color.White),1.4);
local Dan1ClF = BoostColor((Color[TP[ToEnumShortString(PLAYER_2)].ActiveModifiers.ComboColorstring] or Color.White),0.2);
local Dan1TF = {true,false}--{D,(LU,RU)}
local t = Def.ActorFrame{};
local CodePor;

if GAMESTATE:IsCourseMode() then
CodePor = GAMESTATE:GetCurrentTrail(PLAYER_2);
else
CodePor = GAMESTATE:GetCurrentSteps(PLAYER_2);
end

if CodePor:GetStepsType() == "StepsType_Dance_Threepanel" then
Dan1TF = {false,false};
elseif CodePor:GetStepsType() == "StepsType_Dance_Solo" then
Dan1TF = {true,true};
else
Dan1TF = {true,false}
end

t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)
		SCREENMAN:GetTopScreen():AddInputCallback(InputDanP1)
		self:x(SCREEN_RIGHT-42)
		self:y(400)

		local upFunc = function(self)
			local this = self:GetChildren()
			local button = {"L","D","R"}
			local ind = {1,2,4}
			if Dan1TF[1] then
				button[#button+1] = "U"
				ind[#ind+1] = 3
			end
			if Dan1TF[2] then
				button[#button+1] = "UL"
				button[#button+1] = "UR"
				ind[#ind+1] = 5
				ind[#ind+1] = 6
			end


			for i = 1,#button do
				if Dan1Press[ind[i]] == 1 then
					this[button[i]]:stoptweening():decelerate(Rew[1]):diffuse(Dan1Cl):zoom(Kayay*0.75)
				else
					this[button[i]]:stoptweening():bounceend(Rew[2]):diffuse(Dan1ClF):zoom(Kayay)
				end
			end
		end

		self:SetUpdateFunction(upFunc);
	end;
	OffCommand=function(self)
		SCREENMAN:GetTopScreen():RemoveInputCallback(InputDanP1)
	end;
	LoadActor("inputoverlay-key")..{--LEFT
		Name = "L";
		InitCommand=function(self) self:x(-Sped); self:zoom(Kayay); self:diffuse(Dan1ClF); end;
	};
	LoadActor("inputoverlay-key")..{--DOWN
		Name = "D";
		InitCommand=function(self) self:y(Sped); self:zoom(Kayay); self:diffuse(Dan1ClF); end;
	};
	LoadActor("inputoverlay-key")..{--Up
		Name = "U";
		Condition=(Dan1TF[1]);
		InitCommand=function(self) self:y(-Sped); self:zoom(Kayay); self:diffuse(Dan1ClF); end;
	};
	LoadActor("inputoverlay-key")..{--RIGHT
		Name = "R";
		InitCommand=function(self) self:x(Sped); self:zoom(Kayay); self:diffuse(Dan1ClF); end; 
	};
	LoadActor("inputoverlay-key")..{--UL
		Name = "UL";
		Condition=(Dan1TF[2]);
		InitCommand=function(self) self:x(-Sped); self:y(-Sped); self:zoom(Kayay); self:diffuse(Dan1ClF); end;
	};
	LoadActor("inputoverlay-key")..{--UR
		Name = "UR";
		Condition=(Dan1TF[2]);
		InitCommand=function(self) self:x(Sped); self:y(-Sped); self:zoom(Kayay); self:diffuse(Dan1ClF); end;
	};
};

return t;