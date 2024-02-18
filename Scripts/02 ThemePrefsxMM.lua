-- StepMania 5 Default Theme Preferences Handler
local function OptionNameString(str)
	return THEME:GetString('OptionNames',str)
end
ThemePrefs.Load()
-- Example usage of new system (not fully implemented yet)

-- custom gameplay progress
-- TODO: Change from module
-- local customizePath = "Gameplay Time Progress";
-- local customGameplayProgress = LoadModule("Utils.GetCustomizeFilesList.lua")( customizePath, {"lua"} );
-- local customGameplayProgressShort = LoadModule("Utils.GetCustomizeFilesList.lua")( customizePath, {"lua"}, false );
-- table.insert(customGameplayProgress,1,"Default")
-- customGameplayProgress[#customGameplayProgress + 1] = "Random"
-- table.insert(customGameplayProgressShort,1,"Default")
-- customGameplayProgressShort[#customGameplayProgressShort + 1] = "Random"
local fullProgressPath = THEME:GetCurrentThemeDirectory().."Customize/Gameplay Time Progress/";
local fullProgressFiles = {};
local progressFiles = {};
for _,file in pairs(FILEMAN:GetDirListing(fullProgressPath)) do
	
	if string.sub(file,1, 1) ~= "_" then
		local extStart,extEnd = string.find( file, "[.]" )
		if extStart ~= nil and extEnd ~= nil then
			local fileType = string.sub( file, extStart + 1, string.len(file) )
			if fileType == "lua" then
				progressFiles[#progressFiles+1] = file
				fullProgressFiles[#fullProgressFiles+1] = fullProgressPath..file
			end
		end
	end
end

if #progressFiles > 0 then
	progressFiles[#progressFiles + 1] = "Random"
	fullProgressFiles[#fullProgressFiles + 1] = "Random"
end

table.insert(progressFiles,1,"Default")
table.insert(fullProgressFiles,1,"Default")



local Prefs =
{
	GameplayShowStepsDisplay = 
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	GameplayShowScore =
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	ShowLotsaOptions =
	{
		Default = true,
		Choices = { OptionNameString('Many'), OptionNameString('Few') },
		Values = { true, false }
	},
	NotePosition =
	{
		Default = true,
		Choices = { OptionNameString('Normal'), OptionNameString('Lower') },
		Values = { true, false }
	},
	ComboOnRolls =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	FlashyCombo =
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	ComboUnderField =
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	FancyUIBG =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	TimingDisplay =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	GameplayFooter =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},

	MEMEMode =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	
	More1PInfo =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
    StartSongStyle =
	{
		Default = 0,
		Choices = { "321/wSound", "321 no sound", "Just go (old school style)", "Just go (321 ticks)", "Just go no sound"},
		Values = { 0 , 1 , 2, 3, 4 }
	},
	
	CustomJudgeAnimation =
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On')},
		Values = { false, true}
	},
    measureBar =
	{
		Default = 0,
		Choices = { OptionNameString('Off'), OptionNameString('On'), OptionNameString('On').." (Only measure)"},
		Values = { 0, 1, 2}
	},
	OptionStyle =
	{
		Default = 0,
		Choices = { "Choose page", "Many page" ,"No Song Option"},
		Values = { 0 , 1 , 2 }
	},
    BackgroundTheme =
	{
		Default = 2,
		Choices = { "Day" , "Night" , "Depend on time"},
		Values = { 0 , 1 , 2 }
	},
	BorderGameplayEffect =
	{
		Default = true,
		Choices = { OptionNameString('Off'), OptionNameString('On')},
		Values = { false, true}
	},
	CenterLifeBar =
	{
		Default = 1,
		Choices = { OptionNameString('Off'), OptionNameString('On').."(Two sides)", OptionNameString('On').."(Center)", OptionNameString('On')},
		Values = { 0, 1, 2, 3}
	},


	--Evaluation Setting
	EvaluationBackground =
	{
		Default = 0,
		Choices = { "Song (default)", "Grade", "Type" },
		Values = { 0, 1, 2 }
	},

	GameplayProgress =
	{
		Default = "Default",
		Choices = progressFiles,
		Values = fullProgressFiles
	},
}

ThemePrefs.InitAll(Prefs)

function InitUserPrefs()
	local Prefs = {
		UserPrefScoringMode = 'DDR Extreme',
        UserPrefSoundPack   = 'default',
		UserPrefProtimingP1 = false,
		UserPrefProtimingP2 = false,
	}
	for k, v in pairs(Prefs) do
		-- kind of xxx
		local GetPref = type(v) == "boolean" and GetUserPrefB or GetUserPref
		if GetPref(k) == nil then
			SetUserPref(k, v)
		end
	end

	-- screen filter
	setenv("ScreenFilterP1",0)
	setenv("ScreenFilterP2",0)
end

function GetProTiming(pn)
	local pname = ToEnumShortString(pn)
	if GetUserPref("ProTiming"..pname) then
		return GetUserPrefB("ProTiming"..pname)
	else
		SetUserPref("ProTiming"..pname,false)
		return false
	end
end

--[[ option rows ]]

-- screen filter
function OptionRowScreenFilter()
	return {
		Name="ScreenFilter",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { THEME:GetString('OptionNames','Off'), '0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7', '0.8', '0.9', '1.0', },
		LoadSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			local filterValue = getenv("ScreenFilter"..pName)
			if filterValue ~= nil then
				local val = scale(tonumber(filterValue),0,1,1,#list )
				list[val] = true
			else
				setenv("ScreenFilter"..pName,0)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						local val = scale(i,1,#list,0,1)
						setenv("ScreenFilter"..pName,val)
						found = true
					end
				end
			end
		end,
	}
end

-- protiming
function OptionRowProTiming()
	return {
		Name = "ProTiming",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = {
			THEME:GetString('OptionNames','Off'),
			THEME:GetString('OptionNames','On')
		},
		LoadSelections = function(self, list, pn)
			if GetUserPrefB("UserPrefProtiming" .. ToEnumShortString(pn)) then
				local bShow = GetUserPrefB("UserPrefProtiming" .. ToEnumShortString(pn))
				if bShow then
					list[2] = true
				else
					list[1] = true
				end
			else
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local bSave = list[2] and true or false
			SetUserPref("UserPrefProtiming" .. ToEnumShortString(pn), bSave)
		end
	}
end

--[[ end option rows ]]
