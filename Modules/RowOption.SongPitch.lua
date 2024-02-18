return function()
    local rateChoices = {}
    local rateValues = {}

    for i = 0.5, 2, 0.1 do
        rateChoices[#rateChoices+1] = string.format("%.1fx", i)
        rateValues[#rateValues+1] = i
    end

	return {
		Name = "SongPitch",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = rateChoices,
        Values = rateValues,
		LoadSelections = function(self, list, pn)

            --modify from Outfox
			local msrate = string.format( "%.1f", GAMESTATE:GetSongOptionsObject("ModsLevel_Preferred"):PitchRate() )
			for k,v2 in pairs(self.Values) do
				if tostring(v2) == msrate then
					list[k] = true
					return
				end
			end
			list[6] = true
		end,
		SaveSelections = function(self, list, pn)
            --modify from Outfox
			if GAMESTATE:GetSongOptionsObject("ModsLevel_Preferred"):Haste() == 0.0 then
                for i=1,#self.Choices do
                    if list[i] then
                        GAMESTATE:GetSongOptionsObject("ModsLevel_Preferred"):PitchRate(self.Values[i])
                        if i ~= 6 then -- if not 1.0x
                            GAMESTATE:GetSongOptionsObject("ModsLevel_Preferred"):SoundEffectSetting("SoundEffectType_Both")
                        end
                        return 
                    end
                end
            end
            GAMESTATE:GetSongOptionsObject("ModsLevel_Preferred"):PitchRate(1.0)
		end
	}
end