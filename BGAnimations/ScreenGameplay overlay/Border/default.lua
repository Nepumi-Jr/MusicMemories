function Diff2Cl(d,A)
CD = GameColor.Difficulty[d];
return { CD[1], CD[2], CD[3], CD[4]*A }
end;
local LP={0,0};
local DP={0,0};
local t = Def.ActorFrame{
	OnCommand=cmd(y,-10);
};


t[#t+1] = Def.ActorFrame{
    Def.ActorFrame{
		GETOUTOFGAMESMMessageCommand=cmd(sleep,0.75;accelerate,1;diffusealpha,0);
		Def.ActorFrame{
			OnCommand=cmd(diffusealpha,0);
			JudgmentMessageCommand=function(self)

                if GAMESTATE:IsPlayerEnabled(PLAYER_2) and SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_2) then
                        LP[2] = math.max((SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_2):GetLife() or 0)*100-50,0)*2;
                end
                if GAMESTATE:IsPlayerEnabled(PLAYER_1) and SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_1) then
                        LP[1] = math.max((SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_1):GetLife() or 0)*100-50,0)*2;
                end
		
                if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
                    if GAMESTATE:GetPlayMode() == "PlayMode_Rave" or (GAMESTATE:GetPlayerState(PLAYER_1):GetCurrentPlayerOptions():DrainSetting() == "DrainType_SuddenDeath" and GAMESTATE:GetPlayerState(PLAYER_2):GetCurrentPlayerOptions():DrainSetting() == "DrainType_SuddenDeath") then
                        self:diffusealpha(1)
                    else
                        self:diffusealpha(math.max(LP[1],LP[2])/100)
                    end
                
                elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
                    if GAMESTATE:GetPlayerState(PLAYER_1):GetCurrentPlayerOptions():DrainSetting() == "DrainType_SuddenDeath" then
                        self:diffusealpha(1)
                    else
                        self:diffusealpha(LP[1]/100)
                        --SM("\n\n\n\n\n"..tostring(LP[1]/100))
                    end
                    
                elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
                    if GAMESTATE:GetPlayerState(PLAYER_2):GetCurrentPlayerOptions():DrainSetting() == "DrainType_SuddenDeath" then
                        self:diffusealpha(1)
                    else
                        self:diffusealpha(LP[2]/100)
                    end
                end
		    end;
			Def.ActorFrame{
				OnCommand=cmd(diffuseshift;effectcolor1,{1,1,1,1};effectcolor2,{1,1,1,0.7};effectclock,"beat";);
				LoadActor("Blur")..{
					InitCommand=cmd(x,SCREEN_CENTER_X;vertalign,top;y,10;zoomtowidth,SCREEN_WIDTH);
					OnCommand=cmd(queuecommand,"Nep");
					CurrentSongChangedMessageCommand=cmd(queuecommand,"Nep");
					NepCommand=function(self)
						if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
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
			};	
		};
	};
};

t[#t+1] = Def.ActorFrame {
    LoadActor("BigBar.png")..{
		InitCommand=cmd(vertalign,top;CenterX;zoomtowidth,SCREEN_WIDTH;y,10;);
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Nep");
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
    LoadActor("TimingBar.lua");
    -- LoadActor("TimeBar.png")..{
	-- 	InitCommand=cmd(vertalign,top;CenterX;zoomtowidth,SCREEN_WIDTH;y,10);
	-- };
    LoadActor("TimeBar Over.png")..{
		InitCommand=cmd(vertalign,top;CenterX;zoomtowidth,SCREEN_WIDTH;y,10);
	};
};

if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
t[#t+1]=LoadActor("Border.png")..{
		Condition = not (TP.Battle.IsBattle and TP.Battle.Mode == "Dr" and TP.Battle.Hidden) and not (GAMESTATE:GetPlayMode() == 'PlayMode_Rave' or GAMESTATE:GetPlayMode() == 'PlayMode_Battle');
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+10;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT;diffuse,color("#FF0000"));
		OnCommand=cmd(queuecommand,"Judgment");
		JudgmentMessageCommand=function(self)
		if SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_1):IsFailing() then
			self:playcommand("Fail1")
		else
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) and SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_1) then
					DP[1] = 50-(math.min(SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_1):GetLife()*100,50));
			end
			
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
				self:cropright(0.5)
			end
			if GAMESTATE:GetPlayerState(PLAYER_1):GetCurrentPlayerOptions():DrainSetting() == "DrainType_SuddenDeath" then
				self:diffuseshift():effectcolor1({1,0,0,1}):effectcolor2({1,0,0,0.5}):effectclock("beat");
				--self:diffusealpha((1-(math.mod(GAMESTATE:GetSongBeat(),1)))/2)
			else
				self:stopeffect();
				self:diffusealpha(DP[1]/50)
			end
		end
		end;
		Fail1Command=cmd(diffuse,PlayerColor(PLAYER_1);decelerate,0.5;diffuse,color("#00000000"));
		GETOUTOFGAMESMMessageCommand=cmd(stoptweening;sleep,0.75;accelerate,1;diffusealpha,0);
		};
end
if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
t[#t+1]=LoadActor("Border.png")..{
		Condition = not (TP.Battle.IsBattle and TP.Battle.Mode == "Dr" and TP.Battle.Hidden) and not (GAMESTATE:GetPlayMode() == 'PlayMode_Rave' or GAMESTATE:GetPlayMode() == 'PlayMode_Battle');
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+10;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT;diffuse,color("#FF0000"));
		OnCommand=cmd(queuecommand,"Judgment");
		JudgmentMessageCommand=function(self)
		if SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_2):IsFailing() then
			self:playcommand("Fail2")
		else
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) and SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_2) then
					DP[2] = 50-(math.min(SCREENMAN:GetTopScreen():GetLifeMeter(PLAYER_2):GetLife()*100,50));
			end
			
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
				self:cropleft(0.5)
			end
			if GAMESTATE:GetPlayerState(PLAYER_2):GetCurrentPlayerOptions():DrainSetting() == "DrainType_SuddenDeath" then
				self:diffuseshift():effectcolor1({1,0,0,1}):effectcolor2({1,0,0,0.5}):effectclock("beat");
				--self:diffusealpha((1-(math.mod(GAMESTATE:GetSongBeat(),1)))/2)
			else
				self:stopeffect();
				self:diffusealpha(DP[2]/50)
			end
		end
		end;
		Fail2Command=cmd(diffuse,PlayerColor(PLAYER_2);decelerate,0.5;diffuse,color("#00000000"));
		GETOUTOFGAMESMMessageCommand=cmd(stoptweening;sleep,0.75;accelerate,1;diffusealpha,0);
		};
end
return t;