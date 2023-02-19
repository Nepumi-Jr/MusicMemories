return function(part, xOry)
    local choices = {}
    local values = {}
    local numChoice = 31 --? it should be odd number
    local numChoiceHalf = math.ceil(numChoice / 2)
    for i = 1, numChoice do
        local posChoice = (i - numChoiceHalf) * 5
        choices[i] = (posChoice > 0 and "+" or "")..tostring(posChoice)
        values[i] = posChoice
    end
	return {
		Name = "offset"..part..string.upper(xOry),
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = choices,
        Values = values,
		LoadSelections = function(self, list, pn)
			local loadData = TP[ToEnumShortString(pn)].ActiveModifiers["Offset"..part..string.upper(xOry)]
			local i = FindInTable(loadData, self.Values) or numChoiceHalf
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			local sSave

			for i=1,#self.Choices do
				if list[i] then
					sSave = self.Values[i]
				end
			end

			TP[ToEnumShortString(pn)].ActiveModifiers["Offset"..part..string.upper(xOry)] = sSave
		end
	}
end