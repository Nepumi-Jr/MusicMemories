local function OptionNameString(str)
	return THEME:GetString('OptionNames',str)
end



function JudgeFileShortName(str)
	return LoadModule("Options.JudgmentsFileShortName.lua")(str)
end

LoadModule("Prefs.Insert.lua")()



function CustomBG()

	local Con = {"Default"}

	local path = THEMEDIR().."/Resource/BGAV/";-- ThemeNamae That mean Theme's folder
	local files = FILEMAN:GetDirListing(path)

	for k,filename in ipairs(files) do
		if string.match(filename,".mp4") or string.match(filename,".mpg") or string.match(filename,".mpeg") or string.match(filename,".avi") then
			Con[#Con+1] = filename;
		elseif string.match(filename,".lua") then
			Con[#Con+1] = filename;
		elseif not string.match(filename,"[.]") then
			local IsR = false;
			for p,T in ipairs(FILEMAN:GetDirListing(path..filename.."/")) do
				if(string.match(T,"default.lua")) then
					IsR = true;
				end
			end
				if IsR then
					Con[#Con+1] = filename;
				end
		end
	end

	local t = {
		Name = "CusBG",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = Con,
		LoadSelections = function(self, list, pn)
			local EML = TP[ToEnumShortString(pn)].ActiveModifiers.CusBG
			local i = FindInTable(EML, Con) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			local sSave

			for i=1,#Con do
				if list[i] then
					sSave = Con[i]
				end
			end

			TP[ToEnumShortString(pn)].ActiveModifiers.CusBG = sSave
		end
	}
	return t
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

