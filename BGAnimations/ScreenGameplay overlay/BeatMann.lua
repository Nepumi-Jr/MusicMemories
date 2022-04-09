local Seri = false;
local t = Def.ActorFrame{
	Def.Quad{
		OnCommand=function(self) self:visible(false); self:playcommand("LOOPU"); end;
		LOOPUCommand=function(self)
		
			--SM("\n\n\n\n\n:)"..tostring(math.mod(GAMESTATE:GetSongBeat(),1)));

			if math.mod(GAMESTATE:GetSongBeat(),1) < 0.5 and not Seri then

				local wera = GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(GAMESTATE:GetSongBeat()+1)
				- GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(GAMESTATE:GetSongBeat());

				MESSAGEMAN:Broadcast("BEAT",{beat = GAMESTATE:GetSongBeat(),len = wera*0.95});
				--local screen = SCREENMAN:GetTopScreen() -- grabs the current screen, which is probably ScreenGameplay
        		--local field = screen:GetChild('PlayerP1'):GetChild('NoteField') 
				--field:did_tap_note(1,"TapNoteScore_HitMine",false);
				--MESSAGEMAN:Broadcast("Judgment", {make = true,TapNoteScore = "TapNoteScore_HitMine", Player= "PlayerNumber_P1",TapNoteOffset = 0,Early = false})
				Seri=true;
			elseif math.mod(GAMESTATE:GetSongBeat(),1) >= 0.5 and Seri then
				Seri=false;
			end

			self:sleep(1/60):queuecommand("LOOPU");

		end;
	};
};

return t;