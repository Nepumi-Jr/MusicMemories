local choices = LoadModule("Utils.GetModules.Class.lua")("SubJudgment")
table.insert(choices, 1, "None")
return function()
    return {
		Name = "UserSubJudge",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = choices,
		LoadSelections = function(self, list, pn)
			local userSubcom = TP[ToEnumShortString(pn)].ActiveModifiers.SubJudge
			local i = FindInTable(userSubcom, self.Choices) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			for i = 1,#self.Choices do
				if list[i] then
					TP[ToEnumShortString(pn)].ActiveModifiers.SubJudge = self.Choices[i];
				end
			end
		end
	}
end