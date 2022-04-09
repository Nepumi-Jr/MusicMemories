local playMode = GAMESTATE:GetPlayMode()

local sStage = ""
sStage = GAMESTATE:GetCurrentStage()

if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
  sStage = playMode;
end;

local t = Def.ActorFrame {};
LoadActor("../../_save/Battle.lua")
local stage_num_actor= THEME:GetPathG("Games", "Stage " .. ToEnumShortString(sStage), true)
if stage_num_actor ~= "" and FILEMAN:DoesFileExist(stage_num_actor) then
	stage_num_actor= LoadActor(stage_num_actor)
else
	-- Midiman:  We need a "Stage Next" actor or something for stages after
	-- the 6th. -Kyz
	local curStage = GAMESTATE:GetCurrentStage();
	stage_num_actor= Def.BitmapText{
		Font= "Common Normal",  Text= thified_curstage_index(false) .. " Stage",
		InitCommand= function(self)
			self:zoom(1.5)
			self:strokecolor(Color.Black)
			self:diffuse(StageToColor(curStage));
			self:diffusetopedge(ColorLightTone(StageToColor(curStage)));
		end
	}
end
local Say = ToEnumShortString(GAMESTATE:GetCurrentStage()).." Mode";
local Cl = StageToColor(GAMESTATE:GetCurrentStage());
if Isbattle then
	Say = "Battle!!!"
	Cl = color("#FF8800")
end
t[#t+1] = Def.ActorFrame {
LoadFont("_special elite 108px")..{
		Text=Say;
		OnCommand=function(self) self:zoom(0.25); self:x(SCREEN_CENTER_X); self:y(SCREEN_BOTTOM-20); self:diffuse(Cl); self:diffusebottomedge(ColorDarkTone(Cl)); self:diffusetopedge(ColorLightTone(Cl)); end;
	};
};



return t
