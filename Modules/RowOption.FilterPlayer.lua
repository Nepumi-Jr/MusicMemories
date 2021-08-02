return function()
	return {
		Name = "FilterPlayer",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { "Nope",'10%','20%','30%','40%','50%','60%','70%','80%','90%', 'Hide' },
		LoadSelections = function(self, list, pn)
			local EML = TP[ToEnumShortString(pn)].ActiveModifiers.FilterPlayer
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

			TP[ToEnumShortString(pn)].ActiveModifiers.FilterPlayer = sSave
		end
	}
end