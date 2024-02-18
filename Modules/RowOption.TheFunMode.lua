return function()
    return {
        Name = "TheFunMode",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {"none","RB Brutal", "Hidden Survival", "go boom and rotated","go boom to death","go boom to desktop"},
		LoadSelections = function(self, list, pn)
			local i = FindInTable(TP.Global.FunMode, self.Choices) or 1
			list[1] = true
		end,
		SaveSelections = function(self, list, pn)
			for i = 1,#self.Choices do
				if list[i] then
					TP.Global.FunMode = self.Choices[i]
				end
			end
		end,
    }
end