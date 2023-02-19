-- This script needs to be loaded before other scripts that use it.

local PlayerDefaults = {
	__index = {
		initialize = function(self)
			self.ActiveModifiers = {
				JudgmentGraphic = "!!default!!",
				ComboColor = color("#FFFFFF"),
				ComboColorstring = "White",
				HideBG = "Nope",
				FilterPlayer = "Nope",
				CustomMini = "Normal",
				CusBG = "Default",
				SubJudge = "None",
				Streamu = "None",
				Streamay = "Measures",
				IconDir = "",
			}
			--[[self.Mission = {  //// comming soon
				Level = 1,
				Exp = 0,
			}]]
			self.Streams = {
				SongDir = nil,
				StepsType = nil,
				Difficulty = nil,
				Measures = nil,
			}
			self.HighScores = {
				EnteringName = false, 
				Name = nil
			}
			self.Stages = {
				Played = {},
			}
		end
	}
}

local GlobalDefaults = {
	__index = {
		initialize = function(self)
			self.ScreenAfterThisOption = "ScreenGameplay"
            self.enableMeasure = true
		end
	}
}

local BattleDefaults = {--I think this mode is fun :D
	__index = {
		initialize = function(self)
			self.IsBattle = false
			self.Score = {
			P1 = 0,
			P2 = 0
			}
			self.Limit = {
			Mode = "Round",
			Num = 5
			}
			self.Mode = "Ac"
			self.IsfailorIsDraw = true
			--[[
			If Battle's mode is "Ac" That will set for Fail or Not
			else is "Dr" if true ,result is Draw But if false,result will determineted by Score
			]]
			self.Level = "Random"
			--[[ There's 4 Option
			Ps. These will happen by 2 player select diffrent level
			Random :It will Random 2 Player level
			Max :It will Use Hardest of 2 player level
			Min :It will Use Easiest of 2 player level
			None:It do nothing(Not Recommand Because it's not balance 100%)
			]]
			self.Hidden = false
			self.Info = {}
		end
	}
}

local GPDefaults = {--I think this mode is fun :D
	__index = {
		initialize = function(self)
			self.Mode = "Mission"
			self.Data = {

			}
		end
	}

}

local EvaDefaults = {
	__index = {
		initialize = function(self)
			self.TapTiming = {}
            self.retryState = 0
		end
	}
}


-- "TP" is a general-purpose table that can be accessed from anywhere
-- within the theme and stores info that needs to be passed between screens
TP = {
	P1 = setmetatable( {}, PlayerDefaults),
	P2 = setmetatable( {}, PlayerDefaults),
	Global = setmetatable( {}, GlobalDefaults),
	Battle = setmetatable( {}, BattleDefaults),
	GamePlay = setmetatable( {}, GPDefaults ),
	Eva = setmetatable( {}, EvaDefaults )
}

function Initializetor12315za()
	TP.P1:initialize()
	TP.P2:initialize()
	TP.Global:initialize()
	TP.Battle:initialize()
	TP.GamePlay:initialize()
	TP.Eva:initialize()
end

Initializetor12315za()