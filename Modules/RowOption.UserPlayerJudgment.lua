local JudgmentName = {}
local judgmentGraphics = LoadModule("Options.JudgmentsList.lua")();

for k, v in pairs(judgmentGraphics) do
    JudgmentName[#JudgmentName+1] = LoadModule("Options.JudgmentsFileShortName.lua")(v);
end


return function()
    return {
        Name = "UserPlayerJudgment",
        LayoutType = "ShowAllInRow",
        SelectType = "SelectOne",
        OneChoiceForAllPlayers = false,
        ExportOnChange = false,
        Choices = JudgmentName,
        Values = judgmentGraphics,
        LoadSelections = function(self, list, pn)
            local userJudgmentGraphic = TP[ToEnumShortString(pn)].ActiveModifiers.JudgmentGraphic
            local i = FindInTable(userJudgmentGraphic, self.Values)

            if i == nil then
                list[1] = true
                MESSAGEMAN:Broadcast('JudChanged', {Player=pn, Jud=self.Values[1]})
            else
                list[i] = true
            end

            
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