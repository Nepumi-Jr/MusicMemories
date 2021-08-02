return function()
	return {
		Name = "CustomMini",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = {'Normal','10%','20%','30%','40%','50%','60%','70%','80%','90%','100%','-10%','-20%','-50%'},
		LoadSelections = function(self, list, pn)
			local EML = TP[ToEnumShortString(pn)].ActiveModifiers.CustomMini
			local i = FindInTable(EML, self.Choices) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			local sSave

			for i=1,#self.Choices do
				if list[i] then
					sSave = self.Choices[i]
				end
			end

			TP[ToEnumShortString(pn)].ActiveModifiers.CustomMini = sSave
			
				local topscreen = SCREENMAN:GetTopScreen():GetName()
				local modslevel = topscreen  == "ScreenEditOptions" and "ModsLevel_Stage" or "ModsLevel_Preferred"

				local Dim = sSave;
				if Dim == "Normal" then
					Dim = 0
				else
					Dim = Dim:gsub("%%","")/100
				end


				GAMESTATE:GetPlayerState(pn):GetPlayerOptions(modslevel):Mini(Dim)
		end
	}
end