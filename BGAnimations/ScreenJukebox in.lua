local nepa = {math.random(1,9)/9/3;math.random(1,10)/10*2};

local function SpeedDet(pla)
	local pps = 500;

	if GAMESTATE:GetCurrentSteps(pla):GetDifficulty() == "Difficulty_Beginner" then
		pps = 200;
	elseif GAMESTATE:GetCurrentSteps(pla):GetDifficulty() == "Difficulty_Easy" then
		pps = 350;
	elseif GAMESTATE:GetCurrentSteps(pla):GetDifficulty() == "Difficulty_Medium" then
		pps = 450;
	elseif GAMESTATE:GetCurrentSteps(pla):GetDifficulty() == "Difficulty_Hard" then
		pps = 550;
	elseif GAMESTATE:GetCurrentSteps(pla):GetDifficulty() == "Difficulty_Challenge" then
		pps = 620;
	end
	--get max bpm
	local maxbpm = GAMESTATE:GetCurrentSong():GetDisplayBpms()[2];
	return math.floor(pps/maxbpm*10)/10;

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


local JG = 	LoadModule("Options.JudgmentsList.lua")("Full");
local NS = NOTESKIN:GetNoteSkinNames();
local thisColor;
	
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
		thisColor = NumStageColor(math.random(1,30))
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
		Font="Common Normal";
		Text=GAMESTATE:GetCurrentSong():GetDisplayMainTitle();
		InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y*0.88); end;
		OnCommand=function(self) self:sleep(nepa[1]+0.5+nepa[2]+0.1*1); self:decelerate(0.5); self:addy(183.75); self:diffuse(thisColor) end;
	};
	Def.BitmapText{
		Font="Common Normal";
		Text=(GAMESTATE:GetCurrentSong():GetDisplayArtist() or GAMESTATE:GetCurrentSong():GetDisplaySubTitle()) or "Unkown Artist";
		InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y*0.97); self:zoom(0.8) end;
		OnCommand=function(self) self:sleep(nepa[1]+0.5+nepa[2]+0.1*2); self:decelerate(0.5); self:addy(183.75); self:diffuse(thisColor) end;
	};
	Def.BitmapText{
		Font="Common Normal";
		Text=GAMESTATE:GetCurrentSong():GetGroupName();
		InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y*1.09); end;
		OnCommand=function(self) self:sleep(nepa[1]+0.5+nepa[2]+0.1*3); self:decelerate(0.5); self:addy(183.75); self:diffuse(thisColor) end;
	};

	Def.BitmapText{
		Font="Common Normal";
		Text="Song :";
		InitCommand=function(self) self:x(SCREEN_CENTER_X*0.2); self:y(SCREEN_CENTER_Y*0.88); self:horizalign(left) end;
		OnCommand=function(self) self:sleep(nepa[1]+0.5+nepa[2]+0.1*1); self:decelerate(0.5); self:addy(183.75); self:diffuseleftedge({1,1,1,1}):diffuserightedge(thisColor) end;
	};
	Def.BitmapText{
		Font="Common Normal";
		Text="Pack :";
		InitCommand=function(self) self:x(SCREEN_CENTER_X*0.2); self:y(SCREEN_CENTER_Y*1.09); self:horizalign(left) end;
		OnCommand=function(self) self:sleep(nepa[1]+0.5+nepa[2]+0.1*3); self:decelerate(0.5); self:addy(183.75); self:diffuseleftedge({1,1,1,1}):diffuserightedge(thisColor) end;
	};
};