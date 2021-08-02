local function OptionNameString(str)
	return THEME:GetString('OptionNames',str)
end



function JudgeFileShortName(str)
	return LoadModule("Options.JudgmentsFileShortName.lua")(str)
end

LoadModule("Prefs.Insert.lua")()





function TheStream()
	local STE = {"Nope","4th","8th","12th","16th","24th","32th","AUTO"}
	local t = {
		Name = "UserStream",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = STE,
		LoadSelections = function(self, list, pn)
			local ImSoMad = TP[ToEnumShortString(pn)].ActiveModifiers.Streamu
			local i = FindInTable(ImSoMad, STE) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			for i = 1,#STE do
				if list[i] then
					TP[ToEnumShortString(pn)].ActiveModifiers.Streamu = STE[i]
				end
			end
		end
	}
	return t
end

function TheStreap()
	local STM = {"Measures","Remaining Measures","Note Collected(%)","Note Collected(/)","Remaining Second","Accuracy"}
	local t = {
		Name = "UsermoreStream",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = STM,
		LoadSelections = function(self, list, pn)
			local ImSoMad = TP[ToEnumShortString(pn)].ActiveModifiers.Streamay
			local i = FindInTable(ImSoMad, STM) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			for i = 1,#STM do
				if list[i] then
					TP[ToEnumShortString(pn)].ActiveModifiers.Streamay = STM[i]
				end
			end
		end
	}
	return t
end



function ForwardOrBackward()
	local t = {
		Name = "ForwardOrBackward",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { 'Gameplay', 'Select Music', 'Extra Modifiers', 'Song Modifiers' },
		LoadSelections = function(self, list, pn)
			list[1] = true
		end,
		SaveSelections = function(self, list, pn)
			if list[1] then TP.Global.ScreenAfter.PlayerOptions = "ScreenStageInformation" end
			if list[2] then TP.Global.ScreenAfter.PlayerOptions = "ScreenSelectMusic" end
			if list[3] then TP.Global.ScreenAfter.PlayerOptions = "ScreenPlayerOptions2" end
			if list[4] then TP.Global.ScreenAfter.PlayerOptions = "ScreenSongOptions" end
		end
	}
	return t
end

function ForwardOrBackwardBat()
	local t = {
		Name = "ForwardOrBackward",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { 'Gameplay', 'Select Music'},
		LoadSelections = function(self, list, pn)
			list[1] = true
		end,
		SaveSelections = function(self, list, pn)
			if list[1] then TP.Global.ScreenAfter.PlayerOptions = "ScreenStageInformation" end
			if list[2] then TP.Global.ScreenAfter.PlayerOptions = "ScreenSelectMusic" end
		end
	}
	return t
end



function ForwardOrBackward2()
	local t = {
		Name = "ForwardOrBackward2",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { 'Gameplay', 'Select Music', 'Normal Modifiers', 'Song Modifiers'  },
		LoadSelections = function(self, list, pn)
			list[1] = true
		end,
		SaveSelections = function(self, list, pn)
			if list[1] then TP.Global.ScreenAfter.PlayerOptions2 =  "ScreenStageInformation" end
			if list[2] then TP.Global.ScreenAfter.PlayerOptions2 =  "ScreenSelectMusic" end
			if list[3] then TP.Global.ScreenAfter.PlayerOptions2 =  "ScreenPlayerOptions" end
			if list[4] then TP.Global.ScreenAfter.PlayerOptions2 = "ScreenSongOptions" end
		end
	}
	return t
end

function ForwardOrBackward3()
	local t = {
		Name = "ForwardOrBackward3",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { 'Gameplay', 'Select Music', 'Normal Modifiers', 'Extra Modifiers'  },
		LoadSelections = function(self, list, pn)
			list[1] = true
		end,
		SaveSelections = function(self, list, pn)
			if list[1] then TP.Global.ScreenAfter.PlayerOptions3 =  "ScreenStageInformation" end
			if list[2] then TP.Global.ScreenAfter.PlayerOptions3 =  "ScreenSelectMusic" end
			if list[3] then TP.Global.ScreenAfter.PlayerOptions3 =  "ScreenPlayerOptions" end
			if list[4] then TP.Global.ScreenAfter.PlayerOptions3 =  "ScreenPlayerOptions2" end
		end
	}
	return t
end

function ForwardOrBackward4()
	local t = {
		Name = "ForwardOrBackward4",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { 'Gameplay', 'Select Music'},
		LoadSelections = function(self, list, pn)
			list[1] = true
		end,
		SaveSelections = function(self, list, pn)
			if list[1] then TP.Global.ScreenAfter.PlayerOptions4 =  "ScreenStageInformation" end
			if list[2] then TP.Global.ScreenAfter.PlayerOptions4 =  "ScreenSelectMusic" end
		end
	}
	return t
end




function measureBarStuff()
    if ThemePrefs.Get("measureBar") then
        return {1,1,0.2,0,0};
    else
        return {0,1,1,1,1};
    end
end

