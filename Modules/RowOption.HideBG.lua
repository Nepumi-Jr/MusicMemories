return function()
    return {
		Name = "HideBG",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Nope",'10%','20%','30%','40%','50%','60%','70%','80%','90%','99%', 'Hide' },
		LoadSelections = function(self, list, pn)
			local EML = TP[ToEnumShortString(pn)].ActiveModifiers.HideBG
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

			TP[ToEnumShortString(pn)].ActiveModifiers.HideBG = sSave
				local topscreen = SCREENMAN:GetTopScreen():GetName()
				local modslevel = topscreen  == "ScreenEditOptions" and "ModsLevel_Stage" or "ModsLevel_Preferred"
			if TP[ToEnumShortString(pn)].ActiveModifiers.CusBG == "Default" then
			local Dim = sSave;
				if Dim == "Nope" then
					Dim = 0
				elseif Dim == "Hide" then
					Dim = 1
				else
					Dim = round(Dim:gsub("%%","")/10)/10
				end


				GAMESTATE:GetPlayerState(pn):GetPlayerOptions(modslevel):Cover(Dim)
			else
				GAMESTATE:GetPlayerState(pn):GetPlayerOptions(modslevel):Cover(1)
			end
		end
	}
end