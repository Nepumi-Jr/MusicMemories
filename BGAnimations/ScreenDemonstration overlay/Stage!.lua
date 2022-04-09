local playMode = GAMESTATE:GetPlayMode()

local sStage = ""
sStage = GAMESTATE:GetCurrentStage()

if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
  sStage = playMode;
end;

local t = Def.ActorFrame {};

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

t[#t+1] = Def.ActorFrame {
	stage_num_actor .. {--bounceendChoir Singing Hallelujah- Sound Effect--zoom,0.75;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+65;decelerate,0.15;y,SCREEN_BOTTOM-60-35;sleep,0.15+0.15+0.15+0.15+0.15+0.15+2+3;decelerate,0.15;y,SCREEN_BOTTOM-35
		OnCommand=function(self) self:zoom(0.25); self:x(SCREEN_CENTER_X); self:y(SCREEN_BOTTOM+45); self:decelerate(0.15); self:y(SCREEN_BOTTOM-120-20); self:sleep(0.15+0.15+0.15+0.15+0.15+0.15+2+3); self:decelerate(0.15); self:y(SCREEN_BOTTOM-20); end;
	};
};



return t
