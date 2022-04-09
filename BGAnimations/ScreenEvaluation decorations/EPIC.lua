local Content1 = {};
local Content2 = {};
local ISMISSION1 = false;
local ISMISSION2 = false;

local BBEAT = true;

if not GAMESTATE:IsCourseMode() then
	local path=GAMESTATE:GetCurrentSong():GetSongDir();
	if path then
		if FILEMAN:DoesFileExist(path.."MissionTag.lua") then
			LoadActor("../../../../"..path.."MissionTag");

			if GAMESTATE:IsPlayerEnabled(PLAYER_1) and PnMissionState(PLAYER_1,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)) ~= "NotMission" then
				ISMISSION1 = true;
			end
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) and PnMissionState(PLAYER_2,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)) ~= "NotMission" then
				ISMISSION2 = true;
			end
		end
	end
end

if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	if ISMISSION1 then

		table.insert( Content1,"MISSION_"..PnMissionState(PLAYER_1,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)));
	end
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPeakComboAward() then
		table.insert( Content1,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPeakComboAward());
	end
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetStageAward() then
		table.insert( Content1,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetStageAward());
	end
end

if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	if ISMISSION then
		table.insert( Content2,"MISSION_"..PnMissionState(PLAYER_2,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)));
	end
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPeakComboAward() then
		table.insert( Content2,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPeakComboAward());
	end
	if STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetStageAward() then
		table.insert( Content2,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetStageAward());
	end
end


local t=Def.ActorFrame{InitCommand=function(self) self:draworder(1000); end;};



if #Content1 == 0 and #Content2 == 0 then
	return Def.ActorFrame{};
else

	t[#t+1]=Def.Quad{
		InitCommand=function(self) self:visible(false); self:diffuse(color("#00000077")); self:zoom(5000); end;
		OnCommand=function(self) self:sleep(2.5); self:decelerate(0.5); self:diffusealpha(0); self:queuecommand("TIG"); end;
		TIGCommand=function()
			BBEAT = false;
		end
	};

	t[#t+1]=Def.ActorFrame{
		InitCommand=function(self) self:Center(); self:spin(); self:zoom(0); end;
		OnCommand=function(self) self:bounceend(0.5); self:zoom(1); self:sleep(2); self:bouncebegin(0.5); self:zoom(0); end;
		Def.ActorFrame{
				OnCommand=function(self) self:sleep(0.01); self:queuecommand("JOO"); end;
				JOOCommand=function(self) self:linear(0.4671*0.05); self:x(math.random(-20,20)); self:y(math.random( -20, 20 )); self:rotationz(math.random(-5,5)); self:sleep(0.001); self:linear(0.4671*0.05); self:x(math.random(-10,10)); self:y(math.random( -10, 10 )); self:rotationz(math.random(-3,3)); self:sleep(0.001); self:linear(0.4671*0.05); self:x(math.random(-5,5)); self:y(math.random( -5, 5 )); self:rotationz(math.random(-2,2)); self:sleep(0.001); self:linear(0.4671*0.05); self:x(math.random(-2,2)); self:y(math.random( -2, 2 )); self:rotationz(math.random(-1,1)); self:sleep(0.001); self:x(0); self:y(0); self:rotationz(0); self:sleep(0.4671*0.8); self:queuecommand(BBEAT and "JOO" or "RIP"); end;
				RIPCommand=function(self) self:visible(false); end;
			LoadActor("effects0003")..{
				OnCommand=function(self) self:queuecommand("JOO"); end;
				JOOCommand=function(self) self:zoom(1.5); self:linear(0.4671*0.2); self:zoom(1); self:sleep(0.4671*0.8); self:queuecommand(BBEAT and "JOO" or "RIP"); end;
				RIPCommand=function(self) self:visible(false); end;
			};
		};
	};

	for i = 1, #Content1 do
		
		t[#t+1]=Def.ActorFrame{
			InitCommand=function(self)
				if #Content1>0 and #Content2>0 then
					self:y(SCREEN_CENTER_Y*0.7)
				else
					self:y(SCREEN_CENTER_Y)
				end
				
				self:x(SCREEN_CENTER_X + ((i)-(#Content1+1)/2)*150);
				self:zoom(0.75);
			end;
			OnCommand=function(self) self:sleep(2.5); self:bouncebegin(0.5); self:zoom(0); end;
			Def.ActorFrame{
				OnCommand=function(self) self:sleep(0.01); self:queuecommand("JOO"); end;
					JOOCommand=function(self) self:linear(0.4671*0.05); self:x(math.random(-20,20)); self:y(math.random( -20, 20 )); self:rotationz(math.random(-5,5)); self:sleep(0.001); self:linear(0.4671*0.05); self:x(math.random(-10,10)); self:y(math.random( -10, 10 )); self:rotationz(math.random(-3,3)); self:sleep(0.001); self:linear(0.4671*0.05); self:x(math.random(-5,5)); self:y(math.random( -5, 5 )); self:rotationz(math.random(-2,2)); self:sleep(0.001); self:linear(0.4671*0.05); self:x(math.random(-2,2)); self:y(math.random( -2, 2 )); self:rotationz(math.random(-1,1)); self:sleep(0.001); self:x(0); self:y(0); self:rotationz(0); self:sleep(0.4671*0.8); self:queuecommand(BBEAT and "JOO" or "RIP"); end;
					RIPCommand=function(self) self:visible(false); end;
				LoadActor("B_ICON/"..Content1[i])..{
					OnCommand=function(self) self:sleep(0.01); self:queuecommand("JOO"); end;
					JOOCommand=function(self) self:zoom(1.5); self:linear(0.4671*0.2); self:zoom(1); self:sleep(0.4671*0.8); self:queuecommand(BBEAT and "JOO" or "RIP"); end;
					RIPCommand=function(self) self:visible(false); end;
				};
			};
		};
		
		t[#t+1]=LoadFont("Common Normal")..{
			InitCommand=function(self) self:settext("-P1-"); self:y((#Content1>0 and #Content2>0 and SCREEN_CENTER_Y*0.7 or SCREEN_CENTER_Y)-90); self:x(SCREEN_CENTER_X + ((i)-(#Content1+1)/2)*150); self:diffuse(PlayerColor(PLAYER_1)); end;
			OnCommand=function(self) self:sleep(2.5); self:decelerate(0.5); self:diffusealpha(0); end;
		};


	end


	for i = 1, #Content2 do
		
		t[#t+1]=Def.ActorFrame{
			InitCommand=function(self)
				if #Content1>0 and #Content2>0 then
					self:y(SCREEN_CENTER_Y*103)
				else
					self:y(SCREEN_CENTER_Y)
				end
				
				self:x(SCREEN_CENTER_X + ((i)-(#Content2+1)/2)*150);
				self:zoom(0.75);
			end;
			OnCommand=function(self) self:sleep(2.5); self:bouncebegin(0.5); self:zoom(0); end;
			Def.ActorFrame{
				OnCommand=function(self) self:sleep(0.01); self:queuecommand("JOO"); end;
					JOOCommand=function(self) self:linear(0.4671*0.05); self:x(math.random(-20,20)); self:y(math.random( -20, 20 )); self:rotationz(math.random(-5,5)); self:sleep(0.001); self:linear(0.4671*0.05); self:x(math.random(-10,10)); self:y(math.random( -10, 10 )); self:rotationz(math.random(-3,3)); self:sleep(0.001); self:linear(0.4671*0.05); self:x(math.random(-5,5)); self:y(math.random( -5, 5 )); self:rotationz(math.random(-2,2)); self:sleep(0.001); self:linear(0.4671*0.05); self:x(math.random(-2,2)); self:y(math.random( -2, 2 )); self:rotationz(math.random(-1,1)); self:sleep(0.001); self:x(0); self:y(0); self:rotationz(0); self:sleep(0.4671*0.8); self:queuecommand(BBEAT and "JOO" or "RIP"); end;
					RIPCommand=function(self) self:visible(false); end;
				LoadActor("B_ICON/"..Content2[i])..{
					OnCommand=function(self) self:sleep(0.01); self:queuecommand("JOO"); end;
					JOOCommand=function(self) self:zoom(1.5); self:linear(0.4671*0.2); self:zoom(1); self:sleep(0.4671*0.8); self:queuecommand(BBEAT and "JOO" or "RIP"); end;
					RIPCommand=function(self) self:visible(false); end;
				};
			};
		};
		t[#t+1]=LoadFont("Common Normal")..{
			InitCommand=function(self) self:settext("-P2-"); self:y((#Content1>0 and #Content2>0 and SCREEN_CENTER_Y*1.3 or SCREEN_CENTER_Y)+90); self:x(SCREEN_CENTER_X + ((i)-(#Content2+1)/2)*150); self:diffuse(PlayerColor(PLAYER_2)); end;
			OnCommand=function(self) self:sleep(2.5); self:decelerate(0.5); self:diffusealpha(0); end;
		};


	end

	return t;

end