local nepa = {math.random(1,9)/9/3;math.random(1,10)/10*2};

local function SpeedDet(pla)
	if GAMESTATE:GetCurrentSteps(pla):GetDifficulty() == "Difficulty_Beginner" then
		return 1;
	elseif GAMESTATE:GetCurrentSteps(pla):GetDifficulty() == "Difficulty_Beginner" then
		return 1.5;
	elseif GAMESTATE:GetCurrentSteps(pla):GetDifficulty() == "Difficulty_Easy" then
		return 2;
	elseif GAMESTATE:GetCurrentSteps(pla):GetDifficulty() == "Difficulty_Medium" then
		return 2.5;
	elseif GAMESTATE:GetCurrentSteps(pla):GetDifficulty() == "Difficulty_Hard" then
		return 3;
	elseif GAMESTATE:GetCurrentSteps(pla):GetDifficulty() == "Difficulty_Challenge" then
		return 3.5;
	else
		return 2;
	end
end;

local function Dim(pla)
	if GAMESTATE:GetCurrentSteps(pla):GetDifficulty() == "Difficulty_Beginner" then
		return "0";
	elseif GAMESTATE:GetCurrentSteps(pla):GetDifficulty() == "Difficulty_Beginner" then
		return "0";
	elseif GAMESTATE:GetCurrentSteps(pla):GetDifficulty() == "Difficulty_Easy" then
		return "0";
	elseif GAMESTATE:GetCurrentSteps(pla):GetDifficulty() == "Difficulty_Medium" then
		return "30";
	elseif GAMESTATE:GetCurrentSteps(pla):GetDifficulty() == "Difficulty_Hard" then
		return "50";
	elseif GAMESTATE:GetCurrentSteps(pla):GetDifficulty() == "Difficulty_Challenge" then
		return "70";
	else
		return "30";
	end
end;

local JG = 	getAllJudge();
local NS = NOTESKIN:GetNoteSkinNames();
	
LoadActor("../Scripts/mods-taro.lua");
return Def.ActorFrame{
	OnCommand=function(self)
		for player in ivalues(GAMESTATE:GetHumanPlayers()) do
			taronuke_mods("clearall", tonumber(string.sub(ToEnumShortString(player),2,string.len(ToEnumShortString(player)))))
			taronuke_mods("*999 "..SpeedDet(player).."x",tonumber(string.sub(ToEnumShortString(player),2,string.len(ToEnumShortString(player)))))
			taronuke_mods("*999 "..Dim(player).."% Cover",tonumber(string.sub(ToEnumShortString(player),2,string.len(ToEnumShortString(player)))))
			TP[ToEnumShortString(player)].ActiveModifiers.JudgmentGraphic = JG[math.random(1,#JG)]
			GAMESTATE:ApplyGameCommand('mod,'..NS[math.random(1,#NS)],tonumber(string.sub(ToEnumShortString(player),2,string.len(ToEnumShortString(player)))))
		end
	end;
	Def.Quad{
		InitCommand=function(self) self:FullScreen(); self:diffuse(color("0,0,0,1")); end;
		OnCommand=function(self) self:decelerate(0.5); self:diffusealpha(0); end;
	};
	
	Def.Quad{
		InitCommand=function(self) self:Center(); self:zoomx(SCREEN_RIGHT); self:zoomy(125); self:fadetop(0.15); self:fadebottom(0.15); self:diffuse(color("0,0,0,0")); end;
		OnCommand=function(self) self:sleep(nepa[1]); self:decelerate(0.5); self:diffusealpha(.8); self:sleep(nepa[2]); self:decelerate(0.5); self:y(SCREEN_BOTTOM-75*0.75); end;
	};
	
	Def.BitmapText{
		Font="_determination mono 24px";
		Text="Song Information..";
		InitCommand=function(self) self:x(SCREEN_CENTER_X*0.5); self:y(SCREEN_CENTER_Y*0.85); end;
		OnCommand=function(self) self:sleep(nepa[1]+0.5+nepa[2]+0.1*1); self:decelerate(0.5); self:addy(183.75); end;
	};
	Def.BitmapText{
		Font="_determination mono 24px";
		Text="Song:"..GAMESTATE:GetCurrentSong():GetDisplayMainTitle();
		InitCommand=function(self) self:x(SCREEN_CENTER_X*0.3); self:y(SCREEN_CENTER_Y*0.97); self:horizalign(left); end;
		OnCommand=function(self) self:sleep(nepa[1]+0.5+nepa[2]+0.1*2); self:decelerate(0.5); self:addy(183.75); end;
	};
	Def.BitmapText{
		Font="_determination mono 24px";
		Text="Pack:"..GAMESTATE:GetCurrentSong():GetGroupName();
		InitCommand=function(self) self:x(SCREEN_CENTER_X*0.3); self:y(SCREEN_CENTER_Y*1.09); self:horizalign(left); end;
		OnCommand=function(self) self:sleep(nepa[1]+0.5+nepa[2]+0.1*3); self:decelerate(0.5); self:addy(183.75); end;
	};
};