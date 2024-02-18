return function()
	return {
		Name = "SongHaste",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { 'Off', 'On'},
		LoadSelections = function(self, list, pn)
            --from Outfox
			local mod = GAMESTATE:GetSongOptionsObject("ModsLevel_Preferred"):Haste()
			if mod == 1 then
				list[2] = true
				return
			end
			list[1] = true
		end,
		SaveSelections = function(self, list, pn)
            --from Outfox
			GAMESTATE:GetSongOptionsObject("ModsLevel_Preferred"):Haste( list[2] and 1 or 0 )
		end
	}
end