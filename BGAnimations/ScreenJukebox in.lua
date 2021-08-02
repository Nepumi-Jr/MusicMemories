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
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,1"));
		OnCommand=cmd(decelerate,0.5;diffusealpha,0);
	};
	
	Def.Quad{
		InitCommand=cmd(Center;zoomx,SCREEN_RIGHT;zoomy,125;fadetop,0.15;fadebottom,0.15;diffuse,color("0,0,0,0"));
		OnCommand=cmd(sleep,nepa[1];decelerate,0.5;diffusealpha,.8;sleep,nepa[2];decelerate,0.5;y,SCREEN_BOTTOM-75*0.75;);
	};
	
	Def.BitmapText{
		Font="_determination mono 24px";
		Text="Song Information..";
		InitCommand=cmd(x,SCREEN_CENTER_X*0.5;y,SCREEN_CENTER_Y*0.85);
		OnCommand=cmd(sleep,nepa[1]+0.5+nepa[2]+0.1*1;decelerate,0.5;addy,183.75);
	};
	Def.BitmapText{
		Font="_determination mono 24px";
		Text="Song:"..GAMESTATE:GetCurrentSong():GetDisplayMainTitle();
		InitCommand=cmd(x,SCREEN_CENTER_X*0.3;y,SCREEN_CENTER_Y*0.97;horizalign,left);
		OnCommand=cmd(sleep,nepa[1]+0.5+nepa[2]+0.1*2;decelerate,0.5;addy,183.75);
	};
	Def.BitmapText{
		Font="_determination mono 24px";
		Text="Pack:"..GAMESTATE:GetCurrentSong():GetGroupName();
		InitCommand=cmd(x,SCREEN_CENTER_X*0.3;y,SCREEN_CENTER_Y*1.09;horizalign,left);
		OnCommand=cmd(sleep,nepa[1]+0.5+nepa[2]+0.1*3;decelerate,0.5;addy,183.75);
	};
};