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


local t=Def.ActorFrame{InitCommand=cmd(draworder,1000);};



if #Content1 == 0 and #Content2 == 0 then
	return Def.ActorFrame{};
else

	t[#t+1]=Def.Quad{
		InitCommand=cmd(visible,false;diffuse,color("#00000077");zoom,5000;);
		OnCommand=cmd(sleep,2.5;decelerate,0.5;diffusealpha,0;queuecommand,"TIG");
		TIGCommand=function()
			BBEAT = false;
		end
	};

	t[#t+1]=Def.ActorFrame{
		InitCommand=cmd(Center;spin;zoom,0);
		OnCommand=cmd(bounceend,0.5;zoom,1;sleep,2;bouncebegin,0.5;zoom,0;);
		Def.ActorFrame{
				OnCommand=cmd(sleep,0.01;queuecommand,"JOO");
				JOOCommand=cmd(linear,0.4671*0.05;x,math.random(-20,20);y,math.random( -20, 20 );rotationz,math.random(-5,5);sleep,0.001;
								linear,0.4671*0.05;x,math.random(-10,10);y,math.random( -10, 10 );rotationz,math.random(-3,3);sleep,0.001;
								linear,0.4671*0.05;x,math.random(-5,5);y,math.random( -5, 5 );rotationz,math.random(-2,2);sleep,0.001;
								linear,0.4671*0.05;x,math.random(-2,2);y,math.random( -2, 2 );rotationz,math.random(-1,1);sleep,0.001;
								x,0;y,0;rotationz,0;sleep,0.4671*0.8;queuecommand,BBEAT and "JOO" or "RIP");
				RIPCommand=cmd(visible,false);
			LoadActor("effects0003")..{
				OnCommand=cmd(queuecommand,"JOO");
				JOOCommand=cmd(zoom,1.5;linear,0.4671*0.2;zoom,1;sleep,0.4671*0.8;queuecommand,BBEAT and "JOO" or "RIP");
				RIPCommand=cmd(visible,false);
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
			OnCommand=cmd(sleep,2.5;bouncebegin,0.5;zoom,0;);
			Def.ActorFrame{
				OnCommand=cmd(sleep,0.01;queuecommand,"JOO");
					JOOCommand=cmd(linear,0.4671*0.05;x,math.random(-20,20);y,math.random( -20, 20 );rotationz,math.random(-5,5);sleep,0.001;
									linear,0.4671*0.05;x,math.random(-10,10);y,math.random( -10, 10 );rotationz,math.random(-3,3);sleep,0.001;
									linear,0.4671*0.05;x,math.random(-5,5);y,math.random( -5, 5 );rotationz,math.random(-2,2);sleep,0.001;
									linear,0.4671*0.05;x,math.random(-2,2);y,math.random( -2, 2 );rotationz,math.random(-1,1);sleep,0.001;
									x,0;y,0;rotationz,0;sleep,0.4671*0.8;queuecommand,BBEAT and "JOO" or "RIP");
					RIPCommand=cmd(visible,false);
				LoadActor("B_ICON/"..Content1[i])..{
					OnCommand=cmd(sleep,0.01;queuecommand,"JOO");
					JOOCommand=cmd(zoom,1.5;linear,0.4671*0.2;zoom,1;sleep,0.4671*0.8;queuecommand,BBEAT and "JOO" or "RIP");
					RIPCommand=cmd(visible,false);
				};
			};
		};
		
		t[#t+1]=LoadFont("Common Normal")..{
			InitCommand=cmd(settext,"-P1-";y,(#Content1>0 and #Content2>0 and SCREEN_CENTER_Y*0.7 or SCREEN_CENTER_Y)-90;x,SCREEN_CENTER_X + ((i)-(#Content1+1)/2)*150;diffuse,PlayerColor(PLAYER_1));
			OnCommand=cmd(sleep,2.5;decelerate,0.5;diffusealpha,0);
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
			OnCommand=cmd(sleep,2.5;bouncebegin,0.5;zoom,0;);
			Def.ActorFrame{
				OnCommand=cmd(sleep,0.01;queuecommand,"JOO");
					JOOCommand=cmd(linear,0.4671*0.05;x,math.random(-20,20);y,math.random( -20, 20 );rotationz,math.random(-5,5);sleep,0.001;
									linear,0.4671*0.05;x,math.random(-10,10);y,math.random( -10, 10 );rotationz,math.random(-3,3);sleep,0.001;
									linear,0.4671*0.05;x,math.random(-5,5);y,math.random( -5, 5 );rotationz,math.random(-2,2);sleep,0.001;
									linear,0.4671*0.05;x,math.random(-2,2);y,math.random( -2, 2 );rotationz,math.random(-1,1);sleep,0.001;
									x,0;y,0;rotationz,0;sleep,0.4671*0.8;queuecommand,BBEAT and "JOO" or "RIP");
					RIPCommand=cmd(visible,false);
				LoadActor("B_ICON/"..Content2[i])..{
					OnCommand=cmd(sleep,0.01;queuecommand,"JOO");
					JOOCommand=cmd(zoom,1.5;linear,0.4671*0.2;zoom,1;sleep,0.4671*0.8;queuecommand,BBEAT and "JOO" or "RIP");
					RIPCommand=cmd(visible,false);
				};
			};
		};
		t[#t+1]=LoadFont("Common Normal")..{
			InitCommand=cmd(settext,"-P2-";y,(#Content1>0 and #Content2>0 and SCREEN_CENTER_Y*1.3 or SCREEN_CENTER_Y)+90;x,SCREEN_CENTER_X + ((i)-(#Content2+1)/2)*150;diffuse,PlayerColor(PLAYER_2));
			OnCommand=cmd(sleep,2.5;decelerate,0.5;diffusealpha,0);
		};


	end

	return t;

end