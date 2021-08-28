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
			local modslevel = topscreen  == "ScreenEditOptions" and "ModsLevel_Stage" or "ModsLevel_Preferred"
			local EML = GAMESTATE:GetPlayerState(pn):GetPlayerOptions(modslevel):NoteSkin()
			local ind = -1
            for i,v in pairs(self.Choices) do
                if string.lower( v ) == string.lower( EML ) then
                    ind = i;
                    break
                end
            end
            if ind == -1 then
                --lua.ReportScriptError(EML.." note not found :(")
                ind = 1;
            end
			list[ind] = true
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
			GAMESTATE:GetPlayerState(pn):GetPlayerOptions(modslevel):NoteSkin(sSave)
		end,
		NotifyOfSelection = function(self, pn, choice)
			MESSAGEMAN:Broadcast('NoteChanged', {Player=pn, Noto=(self.Choices)[choice]})
			return false
		end,
	}
end