return function()
    return {
		Name = "CustomTimeDifficulty",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {"1","2","3","4","5","6","7","8","Justice"},
        Values = {1.5, 1.33, 1.16, 1, 0.84, 0.66, 0.5, 0.33, 0.2},
		LoadSelections = function(self, list, pn)
			local nowPre = PREFSMAN:GetPreference("TimingWindowScale")
            for i = 1, #self.Choices do
                if math.abs(nowPre - self.Values[i]) / math.max(nowPre,self.Values[i]) * 100 < 5 then
                    list[i] = true
                    break
                end
            end
		end,
		SaveSelections = function(self, list, pn)
            for i = 1, #self.Choices do
                if list[i] then
                    PREFSMAN:SetPreference("TimingWindowScale", self.Values[i])
                    break
                end
            end
		end,
        NotifyOfSelection = function(self, pn, choice)
			MESSAGEMAN:Broadcast('TimingScaleChanged', {newScale=(self.Values)[choice]})
		end,
	}
end