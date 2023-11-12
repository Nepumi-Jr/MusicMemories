function Diff2Cl(d,A)
CD = GameColor.Difficulty[d];
return { CD[1], CD[2], CD[3], CD[4]*A }
end;
local LP={0,0};
local DP={0,0};
local isDead = {false,false}
local t = Def.ActorFrame{
	OnCommand=function(self) self:y(-10); end;
};

local bgPath = "Frames/BG.png";

if LoadModule("Gameplay.IsFrameSolo.lua")() then
	bgPath = "Frames/BGSolo.png";
end

t[#t+1] = Def.ActorFrame {
    LoadActor(bgPath)..{
		InitCommand=function(self) self:vertalign(top); self:CenterX(); self:zoomtowidth(SCREEN_WIDTH); self:y(10); end;
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
};

return t;