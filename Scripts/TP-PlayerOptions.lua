local function OptionNameString(str)
	return THEME:GetString('OptionNames',str)
end



function JudgeFileShortName(str)
	return LoadModule("Options.JudgmentsFileShortName.lua")(str)
end

LoadModule("Prefs.Insert.lua")()

local elements = {"Judge", "SubJudge", "Combo"}

for i, element in ipairs(elements) do
	_G[element.."X"] = function()
		return LoadModule("RowCustomOption.OffsetPosition.lua")(element,"x")
	end

	_G[element.."Y"] = function()
		return LoadModule("RowCustomOption.OffsetPosition.lua")(element,"y")
	end

	_G[element.."Zoom"] = function()
		return LoadModule("RowCustomOption.OffsetZoom.lua")(element)
	end

	_G[element.."Alpha"] = function()
		return LoadModule("RowCustomOption.OffsetAlpha.lua")(element)
	end
end





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





function ForwardOrBackward(removeChoice)
	local nextScreenValueMap = {
		['Gameplay'] = 'ScreenStageInformation',
		['Select Music'] = 'ScreenSelectMusic',
		['Normal Modifiers'] = 'ScreenPlayerOptions',
		['Offset Modifiers'] = 'ScreenPlayerOptionsOffset',
		['Extra Modifiers'] = 'ScreenPlayerOptions2',
		['Song Modifiers'] = 'ScreenSongOptions'
	}
	local nextScreenChoices = { 
		'Gameplay',
		'Select Music',
		'Normal Modifiers',
		'Offset Modifiers',
		'Extra Modifiers',
		'Song Modifiers'  
	}
	table.remove(nextScreenChoices, FindInTable(removeChoice, nextScreenChoices));
	local t = {
		Name = "ForwardOrBackward",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = nextScreenChoices,
		LoadSelections = function(self, list, pn)
			list[1] = true
		end,
		SaveSelections = function(self, list, pn)
			for i = 1,#self.Choices do
				if list[i] then
					TP.Global.ScreenAfterThisOption = nextScreenValueMap[self.Choices[i]]
				end
			end
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




function measureBarStuff()
    --{show?, measure, 4th, 8th, 16th}
    if ThemePrefs.Get("measureBar") == 1 then
        return {1,1,0.2,0,0};
    elseif ThemePrefs.Get("measureBar") == 2 then
        return {1,0.2,0,0,0};
    else
        return {0,1,1,1,1};
    end
end

