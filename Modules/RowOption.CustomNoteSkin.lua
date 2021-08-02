return function()
	return {
		Name = "CustomNoteSkin",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = NOTESKIN:GetNoteSkinNames(),
		LoadSelections = function(self, list, pn)
			local topscreen = SCREENMAN:GetTopScreen():GetName()
			local EML = TP[ToEnumShortString(pn)].ActiveModifiers.HelpNote
			local i = FindInTable(EML, self.Choices) or 1
			list[i] = true
			MESSAGEMAN:Broadcast('NoteChanged', {Player=pn, Noto=EML})
		end,
		SaveSelections = function(self, list, pn)
			local sSave = self.Choices[1]
			local NEp = self.Choices
			for i=1,#NEp do
				if list[i] then
					sSave = NEp[i]
				end
			end

			local topscreen = SCREENMAN:GetTopScreen():GetName()
			local modslevel = topscreen  == "ScreenEditOptions" and "ModsLevel_Stage" or "ModsLevel_Preferred"
			TP[ToEnumShortString(pn)].ActiveModifiers.HelpNote = sSave;
			GAMESTATE:GetPlayerState(pn):GetPlayerOptions(modslevel):NoteSkin(sSave)
		end,
		NotifyOfSelection = function(self, pn, choice)
			MESSAGEMAN:Broadcast('NoteChanged', {Player=pn, Noto=(self.Choices)[choice]})
			return false
		end,
	}
end