local jx,jy,cx,cy;
local BRU = -0.5;
return Def.ActorFrame{

	Def.Quad{
		OnCommand=function(self)
			GAMESTATE:GetPlayerState(PLAYER_1):GetPlayerOptions('ModsLevel_Song'):Hidden(1,3);
			GAMESTATE:GetPlayerState(PLAYER_1):GetPlayerOptions('ModsLevel_Song'):HiddenOffset(BRU,20);
		end;
			
		JudgmentMessageCommand=function(self,Isla)
			
			if Isla.TapNoteScore == "TapNoteScore_HitMine" then
				BRU = -0.5
			elseif Isla.TapNoteScore == "TapNoteScore_Miss" then
				BRU = math.max(BRU - 0.15,-0.5);
			elseif Isla.TapNoteScore == "TapNoteScore_W5" then
				BRU = math.max(BRU - 0.1,-0.5);
			elseif Isla.TapNoteScore == "TapNoteScore_W4" then
				BRU = math.max(BRU - 0.08,-0.5);
			elseif Isla.TapNoteScore == "TapNoteScore_W3" then
				BRU = math.min(BRU + 0.01,1.3);
			elseif Isla.TapNoteScore == "TapNoteScore_W2" then
				BRU = math.min(BRU + 0.02,1.3);
			elseif Isla.TapNoteScore == "TapNoteScore_W1" then
				BRU = math.min(BRU + 0.03,1.3);
			elseif Isla.TapNoteScore == "TapNoteScore_CheckpointHit" then
				BRU = math.min(BRU + 0.001,1.3);
			elseif Isla.TapNoteScore == "TapNoteScore_CheckpointMiss" then
				BRU = math.max(BRU - 0.15,-0.5);
			end
			
			GAMESTATE:GetPlayerState(PLAYER_1):GetPlayerOptions('ModsLevel_Song'):HiddenOffset(BRU,20);
		end;
	};

};