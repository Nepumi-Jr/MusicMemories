return function()
    return {--modified from Outfox
        Name = "SmartTimings",
        LayoutType = "ShowAllInRow",
        SelectType = "SelectOne",
        OneChoiceForAllPlayers = true,
        ExportOnChange = false,
        Choices = TimingModes,
        Values = TimingModes,
        LoadSelections = function(self, list, pn)
            local Location = "Save/OutFoxPrefs.ini"
            local CurPref = LoadModule("Config.Load.lua")("SmartTimings",Location)
            
            if GAMESTATE:Env()["SmartTimings"] then
                CurPref = GAMESTATE:Env()["SmartTimings"]
            end
            
            for i,v2 in ipairs(self.Choices) do
                if tostring(v2) == tostring(CurPref) then 
                    list[i] = true return 
                end
            end
            list[1] = true
        end,
        SaveSelections = function(self, list, pn)
            
            local Location = "Save/OutFoxPrefs.ini"
            for i,_ in ipairs(self.Choices) do
                if list[i] == true then
                    LoadModule("Config.save.lua")("SmartTimings",tostring(self.Choices[i]),Location)
                end
            end
        end,
        NotifyOfSelection = function(self, pn, choice)
            setenv(self.Name, self.Choices[choice])
            --printf(" Notify Judge :|")
            
            local oldData = UserPlayerJudgment().Choices;
            for i,v2 in ipairs(oldData) do 
                UserPlayerJudgment().Choices[i] = nil
                UserPlayerJudgment().Values[i] = nil
            end
            local newJudgmentList = LoadModule("Options.JudgmentsList.lua")()
            for i,v2 in ipairs(newJudgmentList) do
                UserPlayerJudgment().Values[i] = v2
                UserPlayerJudgment().Choices[i] = LoadModule("Options.JudgmentsFileShortName.lua")(v2)
            end 
            MESSAGEMAN:Broadcast("UserPlayerJudgment", {pn=pn,choice=choice})
            MESSAGEMAN:Broadcast('JudChanged', {Player=pn, Jud=newJudgmentList[1]})
        end,
    }
end