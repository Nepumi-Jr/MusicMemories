local SongNumberInCourse = 0



-- get the PlayerOptions string for any human players and store it now
-- we'll retreive it the next time ScreenSelectMusic loads and re-apply those same mods
-- in this way, we can override the effects of songs that forced modifiers during gameplay
-- the old-school (ie. ITG) way of GAMESTATE:ApplyGameCommand()
--local Players = GAMESTATE:GetHumanPlayers()
local Players = {PLAYER_1,PLAYER_2}

local InitializeMeasureCounterAndModsLevel = function()	
	for player in ivalues(Players) do
		local pn = ToEnumShortString(player)


		-- Check if MeasureCounter is turned on;
		-- we may (or may not) need to parse the chart.
		local mods = TP[pn].ActiveModifiers
		if mods.MeasureCounter and mods.MeasureCounter ~= "None" then

			local song_dir, steps
			if GAMESTATE:IsCourseMode() then
				song_dir = GAMESTATE:GetCurrentTrail(player):GetTrailEntries()[SongNumberInCourse+1]:GetSong():GetSongDir()
				steps = GAMESTATE:GetCurrentTrail(player):GetTrailEntries()[SongNumberInCourse+1]:GetSteps()
			else
				song_dir = GAMESTATE:GetCurrentSong():GetSongDir()
				steps = GAMESTATE:GetCurrentSteps(player)
			end
			
			local steps_type = ToEnumShortString( steps:GetStepsType() ):gsub("_", "-"):lower()
			local difficulty = ToEnumShortString( steps:GetDifficulty() )
			local notes_per_measure = tonumber(mods.MeasureCounter:match("%d+"))
			local threshold_to_be_stream = 2

			-- if any of these don't match what we're currently looking for...
			if TP[pn].Streams.SongDir ~= song_dir or TP[pn].Streams.StepsType ~= step_type or TP[pn].Streams.Difficulty ~= difficulty then

				-- ...then parse the simfile, given the current parameters
				TP[pn].Streams.Measures = GetStreams(song_dir, steps_type, difficulty, notes_per_measure, threshold_to_be_stream)
				-- and set these so we can check again next time.
				TP[pn].Streams.SongDir = song_dir
				TP[pn].Streams.StepsType = steps_type
				TP[pn].Streams.Difficulty = difficulty
			end
		end
	end
end

InitializeMeasureCounterAndModsLevel()

local t = Def.ActorFrame{

	Def.Quad{
		InitCommand=function(self) self:diffuse(Color.Black); self:diffusealpha(1); self:Center(); self:FullScreen(); end,
		OnCommand=function(self) self:sleep(1.4); self:accelerate(0.6); self:diffusealpha(0); end
	},
}

return t