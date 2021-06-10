local function OptionNameString(str)
	return THEME:GetString('OptionNames',str)
end

function JudgeFileShortName(str)
	-- use regexp to get only the name of the graphic, stripping out the extension
	local real = str:gsub(" %dx%d", ""):gsub(" %(doubleres%)", ""):gsub(".png", ""):gsub(" %[double%]",""):gsub(" %(res %d+x%d+%)","")
	return real;
end

function PlayerJudgment()
	local paths = {THEMEDIR().."/Resource/JudF","/Appearance/Judgments"}
	local judgmentGraphics = {}
	local JudgmentName = {}

	if ThemePrefs.Get("JudgeStyle") == 3 or ThemePrefs.Get("JudgeStyle") == 4 then
		table.insert(paths,1,"/Resource/JudF/SingleVer")
	end

	for _,v in pairs(paths) do

		local files = FILEMAN:GetDirListing(v.."/")
	
		for k,filename in ipairs(files) do
			
			if string.match(filename, " %dx%d") and 
			string.match(filename, ".png") and 
			not string.match(filename, "%[ECFA%]") and 
			not string.match(filename, "%[Pro%]") and
			not string.match(filename, "%[Advanced%]") and
			not string.match(filename, "%[FAPlus%]") and
			not string.match(filename, "%[Hold%]") then
				-- The 3_9 graphic is a special case;
				filename = filename:gsub("3_9","3.9")
				-- Love is a special case; it should always be first.
				-- Ps.These scripts from Simply Love XD
				if string.match(filename, "Love") then
					table.insert(judgmentGraphics, 1, filename)
					--*Respect*
				else
					judgmentGraphics[#judgmentGraphics+1] = filename
				end
			end
		end

	end

	if ThemePrefs.Get("JudgeStyle") == 3 or ThemePrefs.Get("JudgeStyle") == 4 then
		local function CMP(a,b)
			local A,B;
			if string.match(a,"1x6") then A = 1 else A = 2 end
		
			if string.match(b,"1x6") then B = 1 else B = 2 end
			
			if A==B then
				return string.lower(a)<string.lower(b)
			end
			return A<B
		
		end
		
		table.sort( judgmentGraphics, CMP )
		
	end
	
	if #judgmentGraphics == 0 then
		judgmentGraphics[#judgmentGraphics+1] = "!!default!!"
	end
	
	judgmentGraphics[#judgmentGraphics+1] = "SM5ProTiming"
	judgmentGraphics[#judgmentGraphics+1] = "None"
	
	for k, v in pairs(judgmentGraphics) do
		
		JudgmentName[#JudgmentName+1] = JudgeFileShortName(v);
	end

	local t = {
		Name = "UserPlayerJudgment",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = JudgmentName,
		LoadSelections = function(self, list, pn)
			local userJudgmentGraphic = TP[ToEnumShortString(pn)].ActiveModifiers.JudgmentGraphic
			local i = FindInTable(userJudgmentGraphic, judgmentGraphics) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			local sSave

			for i=1,#list do
				if list[i] then
					sSave=judgmentGraphics[i]
				end
			end

			TP[ToEnumShortString(pn)].ActiveModifiers.JudgmentGraphic = sSave
		end,
		NotifyOfSelection = function(self, pn, choice)
			--local real_choice= choice - self.NumPlayers
			--SCREENMAN:SystemMessage("CUTE <3 "..tostring(judgmentGraphics[choice]).." of "..tostring(pn))
			--if pn=="PlayerNumber_P2" then CREENMAN:SystemMessage("P2 LIVE!!") end
			MESSAGEMAN:Broadcast('JudChanged', {Player=pn, Jud=judgmentGraphics[choice]})
			return false
		end,
	}
	return t
end
--PlayerColor(player)
function SubCombo()
	local SO = { 'None', 'Fast/Late', 'Max combo', 'Accuracy', 'Note Collected(/)','Missing Notes' ,'NotePerSecond','KeyPerSecond','MyBestPercent'}
	local t = {
		Name = "UserSubCombo",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = SO,
		LoadSelections = function(self, list, pn)
			local userSubcom = TP[ToEnumShortString(pn)].ActiveModifiers.SubCombo
			local i = FindInTable(userSubcom, SO) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			for i = 1,#SO do
				if list[i] then
					TP[ToEnumShortString(pn)].ActiveModifiers.SubCombo = SO[i];
				end
			end
		end
	}
	return t
end


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

function HideBG()
	local Dark = { "Nope",'10%','20%','30%','40%','50%','60%','70%','80%','90%','99%', 'Hide' }
	local t = {
		Name = "HideBG",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = Dark,
		LoadSelections = function(self, list, pn)
			local EML = TP[ToEnumShortString(pn)].ActiveModifiers.HideBG
			local i = FindInTable(EML, Dark) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			local sSave

			for i=1,#Dark do
				if list[i] then
					sSave = Dark[i]
				end
			end

			TP[ToEnumShortString(pn)].ActiveModifiers.HideBG = sSave
				local topscreen = SCREENMAN:GetTopScreen():GetName()
				local modslevel = topscreen  == "ScreenEditOptions" and "ModsLevel_Stage" or "ModsLevel_Preferred"
			if TP[ToEnumShortString(pn)].ActiveModifiers.CusBG == "Default" then
			local Dim = sSave;
				if Dim == "Nope" then
					Dim = 0
				elseif Dim == "Hide" then
					Dim = 1
				else
					Dim = Dim:gsub("%%","")/100
				end


				GAMESTATE:GetPlayerState(pn):GetPlayerOptions(modslevel):Cover(Dim)
			else
				GAMESTATE:GetPlayerState(pn):GetPlayerOptions(modslevel):Cover(1)
			end
		end
	}
	return t
end

function HidePN()
	local Dark = { "Nope",'10%','20%','30%','40%','50%','60%','70%','80%','90%', 'Hide' }
	local t = {
		Name = "HidePN",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = Dark,
		LoadSelections = function(self, list, pn)
			local EML = TP[ToEnumShortString(pn)].ActiveModifiers.HidePN
			local i = FindInTable(EML, Dark) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			local sSave

			for i=1,#Dark do
				if list[i] then
					sSave = Dark[i]
				end
			end

			TP[ToEnumShortString(pn)].ActiveModifiers.HidePN = sSave
		end
	}
	return t
end

function CusMini()
	local Dark = {'Normal','10%','20%','30%','40%','50%','60%','70%','80%','90%','100%','-10%','-20%','-50%'}
	local t = {
		Name = "CusMini",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = Dark,
		LoadSelections = function(self, list, pn)
			local EML = TP[ToEnumShortString(pn)].ActiveModifiers.CusMini
			local i = FindInTable(EML, Dark) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			local sSave

			for i=1,#Dark do
				if list[i] then
					sSave = Dark[i]
				end
			end

			TP[ToEnumShortString(pn)].ActiveModifiers.CusMini = sSave
			
				local topscreen = SCREENMAN:GetTopScreen():GetName()
				local modslevel = topscreen  == "ScreenEditOptions" and "ModsLevel_Stage" or "ModsLevel_Preferred"

				local Dim = sSave;
				if Dim == "Normal" then
					Dim = 0
				else
					Dim = Dim:gsub("%%","")/100
				end


				GAMESTATE:GetPlayerState(pn):GetPlayerOptions(modslevel):Mini(Dim)
		end
	}
	return t
end

function ShowMBar()
local Choicu = {"Yes","No"}
	local t = {
		Name = "ShowMBar",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = Choicu,
		LoadSelections = function(self, list, pn)
			local EML = (TP[ToEnumShortString(pn)].ActiveModifiers.ShowMBar and "Yes" or "No")
			local i = FindInTable(EML, Choicu) or 1
			list[i] = true
		end,
		SaveSelections = function(self, list, pn)
			local sSave

			for i=1,#Dark do
				if list[i] then
					sSave = Dark[i]
				end
			end
	
			TP[ToEnumShortString(pn)].ActiveModifiers.ShowMBar = (sSave == "Yes")
			
		end
		}
	return t
end

--[[
	local path = THEMEDIR().."/Resource/BgVideo"
	local files = FILEMAN:GetDirListing(path.."/")

	for k,VDO in ipairs(files) do
		if string.match(VDO, ".avi") or string.match(VDO, ".mp4") or string.match(VDO, ".mpg") then
				Dark[#Dark+1] = VDO
		end
	end
]]

function HelpNoteSkin()
	local t = {
		Name = "Noteski",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = NOTESKIN:GetNoteSkinNames(),
		LoadSelections = function(self, list, pn)
			local topscreen = SCREENMAN:GetTopScreen():GetName()
			local EML = TP[ToEnumShortString(pn)].ActiveModifiers.HelpNote or NOTESKIN:GetNoteSkinNames()[1]
			local i = FindInTable(EML, NOTESKIN:GetNoteSkinNames()) or 1
			list[i] = true
			MESSAGEMAN:Broadcast('NoteChanged', {Player=pn, Noto=EML})
		end,
		SaveSelections = function(self, list, pn)
			local sSave
			local NEp = NOTESKIN:GetNoteSkinNames()
			for i=1,#NEp do
				if list[i] then
					sSave = NEp[i]
				end
			end

				local topscreen = SCREENMAN:GetTopScreen():GetName()
				local modslevel = topscreen  == "ScreenEditOptions" and "ModsLevel_Stage" or "ModsLevel_Preferred"
			TP[ToEnumShortString(pn)].ActiveModifiers.HelpNote = sSave;
			GAMESTATE:GetPlayerState(pn):GetPlayerOptions(modslevel):NoteSkin(sSave)
		end,
		NotifyOfSelection = function(self, pn, choice)
			MESSAGEMAN:Broadcast('NoteChanged', {Player=pn, Noto=(NOTESKIN:GetNoteSkinNames())[choice]})
			return false
		end,
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
