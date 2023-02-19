return function(part)
    --! this modifier will store as text, not number due to floating point
    local choices = {}
    local numChoice = 20
    for i = 0, numChoice do
        local posChoice = i/10
        choices[i + 1] = tostring(round(posChoice * 100)).."%"
    end
	return {
		Name = "offset"..part.."Zoom",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = choices,
		LoadSelections = function(self, list, pn)
			local loadData = TP[ToEnumShortString(pn)].ActiveModifiers["Offset"..part.."Zoom"]
			local i = FindInTable(loadData, self.Choices) or 11
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			local sSave

			for i=1,#self.Choices do
				if list[i] then
					sSave = self.Choices[i]
				end
			end

			TP[ToEnumShortString(pn)].ActiveModifiers["Offset"..part.."Zoom"] = sSave
		end,
		NotifyOfSelection = function(self, pn, choice)
            MESSAGEMAN:Broadcast('offset'..part, {Player=pn, zoom = self.Choices[choice]})
            return false
        end,
	}
end