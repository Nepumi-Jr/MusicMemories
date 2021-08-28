return function()
    return {
        Name = "PlayerJudgment",
        LayoutType = "ShowAllInRow",
        SelectType = "SelectOne",
        OneChoiceForAllPlayers = false,
        ExportOnChange = false,
        Choices = LoadModule("Options.JudgmentsList.lua")("short"),
        Values = LoadModule("Options.JudgmentsList.lua")(),
        LoadSelections = function(self, list, pn)
            local userJudgmentGraphic = TP[ToEnumShortString(pn)].ActiveModifiers.JudgmentGraphic
            local i = FindInTable(userJudgmentGraphic, self.Values)
            lua.ReportScriptError(string.format("Try to load %s got %s",userJudgmentGraphic, i));
            if i == nil then
                i = 1
            end
            list[i] = true
            MESSAGEMAN:Broadcast('JudChanged', {Player=pn, Jud=self.Values[i]})
        end,
        SaveSelections = function(self, list, pn)
            local sSave
            for i=1,#list do
                if list[i] then
                    sSave=self.Values[i]
                end
            end

            TP[ToEnumShortString(pn)].ActiveModifiers.JudgmentGraphic = sSave
        end,
        NotifyOfSelection = function(self, pn, choice)
            MESSAGEMAN:Broadcast('JudChanged', {Player=pn, Jud=self.Values[choice]})
            return false
        end,
    }
end