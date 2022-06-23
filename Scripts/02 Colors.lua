-- xxx: everything below the big line of ...========... needs to be redone
Color = {
-- Color Library
-- These colors are pure swatch colors and are here purely to be used
-- on demand without having to type color("stuff") or dig through
-- a palette to get the color you want.
	Black		=	color("0,0,0,1"),
	White		=	color("1,1,1,1"),
	Red			=	color("#FF2B44"),
	Blue		=	color("#2D2DFF"),
	SkyBlue		=	color("#68BDFF"),
	Green		=	color("#66FFAD"),
	Greener		=	color("#27D169"),
	Yellow		=	color("#FFE15E"),
	Orange		=	color("#FF964C"),
	Purple		=	color("#BF2BFF"),
	Magenta		=	color("#FF00F6"),
	Pink		=	color("#FF8CDE"),
	Outline		=	color("0,0,0,0.5"),
	Invisible	=	color("1,1,1,0"),
	Stealth		=	color("0,0,0,0"),
-- Android Design Stencil Colors
-- https://developer.android.com/design/style/color.html
	HoloBlue		= color("#33B5E5"),
	HoloDarkBlue	= color("#0099CC"),
	HoloPurple		= color("#AA66CC"),
	HoloDarkPurple	= color("#9933CC"),
	HoloGreen		= color("#99CC00"),
	HoloDarkGreen	= color("#669900"),
	HoloOrange		= color("#FFBB33"),
	HoloDarkOrange	= color("#FF8800"),
	HoloRed			= color("#FF4444"),
	HoloDarkRed		= color("#CC0000"),
-- Color Functions
-- These functions alter colors in a certain way so that you can make
-- new ones without having to copy a color or find a new one.
--[[     Brightness(fInput)
    Hue(hInput)
    Saturation(hInput)
    Alpha(hInput)
    HSV(iHue,fSaturation,fValue or any other overload) --]]
	Alpha = function(c, fAlpha)
		return { c[1],c[2],c[3], fAlpha }
	end
}

function ColorRandom()
	local ALCL = {"White","Red","Blue","SkyBlue","Green"
	,"Greener","Yellow","Orange","Purple","Magenta","Pink"};
	return Color[ALCL[math.random(1,#ALCL)]];
end

setmetatable(Color, { __call = function(self, c) return self[c] end })

-- Remapped Color Module, since some themes are crazy
-- Colors = Color;


ModeIconColors = {
	Normal		= Color.Green,
	Rave		= Color.Magenta,
	Nonstop		= Color.Orange,
	Oni			= Color.Purple,
	Endless		= Color.Blue, -- steel
}

GameColor = {
	PlayerColors = {
		PLAYER_1 = Color.Pink,
		PLAYER_2 = Color.SkyBlue,
	},
	BattlePlayerColors = {
		PLAYER_1 = Color.Orange,
		PLAYER_2 = Color.Green,
	},
	PlayerDarkColors = {
		PLAYER_1 = color("#E07BA0"),
		PLAYER_2 = color("#586ED8"),
	},
	Difficulty = {
		Beginner	= Color.Pink,
		Easy		= Color.Green,
		Medium		= Color.Yellow,
		Hard		= Color.Orange,
		Challenge	= Color.Red,
		Edit		= Color.Purple,
		Couple		= color("#ed0972"),			-- hot pink
		Routine		= color("#ff9a00"),			-- orange
		Difficulty_Beginner	= Color.Pink,		
		Difficulty_Easy		= Color.Green,		
		Difficulty_Medium	= Color.Yellow,		
		Difficulty_Hard		= Color.Orange,		
		Difficulty_Challenge	= Color.Red,	
		Difficulty_Edit 	= Color.Purple,		
		Difficulty_Couple	= color("#ed0972"),				-- hot pink
		Difficulty_Routine	= color("#ff9a00")				-- orange
	},
	Stage = {
		Stage_1st	= color("#00D877"),
		Stage_2nd	= color("#00FF21"),
		Stage_3rd	= color("#B200FF"),
		Stage_4th	= color("#00FF90"),
		Stage_5th	= color("#B200FF"),
		Stage_6th	= color("#96E178"),
		Stage_Next	= color("#73ff00"),
		Stage_Final	= color("#FF0000"),
		Stage_Extra1	= color("#FFD800"),
		Stage_Extra2	= color("#FF0000"),
		Stage_Nonstop	= color("#FF6A00"),
		Stage_Oni	= color("#FF00DC"),
		Stage_Endless	= color("#FF00DC"),
		Stage_Event	= color("#51FFD9"),
		Stage_Online =color("#51f1ff"),
		Stage_Demo	= color("#FFFFFF")
	},
	Judgment = {
		JudgmentLine_W1		= color("#60d2ff"),
		JudgmentLine_W2		= color("#ffcc20"),
		JudgmentLine_W3		= color("#00df1d"),
		JudgmentLine_W4		= color("#5f40ff"),
		JudgmentLine_W5		= color("#ec40ff"),
		JudgmentLine_Held	= Color.Orange,
		JudgmentLine_Miss	= color("#FF0000"),
		JudgmentLine_MaxCombo	= color("#ffc600")
	},
    ECFAJudgment = {
        JudgmentLine_ProW5  = color("#F785D8"),
		JudgmentLine_W1		= color("#60d2ff"),
		JudgmentLine_W2		= color("#ffcc20"),
		JudgmentLine_W3		= color("#00df1d"),
		JudgmentLine_W4		= color("#5f40ff"),
		JudgmentLine_W5		= color("#ec40ff"),
		JudgmentLine_Held	= Color.Orange,
		JudgmentLine_Miss	= color("#FF0000"),
		JudgmentLine_MaxCombo	= color("#ffc600")
	},
    AdvancedJudgment = {
        JudgmentLine_ProW1	= color("#ACF0FF"),
		JudgmentLine_ProW2	= color("#60D2FF"),
		JudgmentLine_ProW3	= color("#FFDD83"),
		JudgmentLine_ProW4	= color("#FFCC20"),
		JudgmentLine_ProW5  = color("#61DD95"),
		JudgmentLine_W1		= color("#00DF1D"),
		JudgmentLine_W2		= color("#29AD72"),
		JudgmentLine_W3		= color("#0C6DFF"),
		JudgmentLine_W4		= color("#5f40ff"),
		JudgmentLine_W5		= color("#ec40ff"),
		JudgmentLine_Held	= Color.Orange,
		JudgmentLine_Miss	= color("#FF0000"),
		JudgmentLine_MaxCombo	= color("#ffc600")
	},
	Grade = {
		Grade_Tier01 = color("#FFAA42");--SS
		Grade_Tier02 = color("#FFC935");--S
		Grade_Tier03 = color("#AFAFAF");--A+
		Grade_Tier04 = color("#3EC400");--A
		Grade_Tier05 = color("#FF54B2");--B
		Grade_Tier06 = color("#9384C9");--C
		Grade_Tier07 = color("#2B696D");--D
		Grade_Failed = {1,0,0,1};--F
	},
}

function Meter2Color(meter)
local NV = GameColor.Difficulty.Beginner
local EZ = GameColor.Difficulty.Easy
local NM = GameColor.Difficulty.Medium
local HD = GameColor.Difficulty.Hard
local EP = GameColor.Difficulty.Challenge
	if meter <= 4 then
		return {scale(meter,1,4,NV[1],EZ[1]),
				scale(meter,1,4,NV[2],EZ[2]),
				scale(meter,1,4,NV[3],EZ[3]),
				scale(meter,1,4,NV[4],EZ[4])}
	elseif meter <= 7 then
		return {scale(meter,4,7,EZ[1],NM[1]),
				scale(meter,4,7,EZ[2],NM[2]),
				scale(meter,4,7,EZ[3],NM[3]),
				scale(meter,4,7,EZ[4],NM[4])}
	elseif meter <= 10 then
		return {scale(meter,7,10,NM[1],HD[1]),
				scale(meter,7,10,NM[2],HD[2]),
				scale(meter,7,10,NM[3],HD[3]),
				scale(meter,7,10,NM[4],HD[4])}
	elseif meter <= 13 then
		return {scale(meter,10,13,HD[1],EP[1]),
				scale(meter,10,13,HD[2],EP[2]),
				scale(meter,10,13,HD[3],EP[3]),
				scale(meter,10,13,HD[4],EP[4])}
	else
		return EP
	end
end

GameColor.Difficulty["Crazy"] = GameColor.Difficulty["Hard"]
GameColor.Difficulty["Freestyle"] = GameColor.Difficulty["Easy"]
GameColor.Difficulty["Nightmare"] = GameColor.Difficulty["Challenge"]
GameColor.Difficulty["HalfDouble"] = GameColor.Difficulty["Medium"]

--[[ Fallbacks ]]
function BoostColor( cColor, fBoost )
	local c = cColor
	return { c[1]*fBoost, c[2]*fBoost, c[3]*fBoost, c[4] }
end

function ColorLightTone(c)
	return { c[1]+(c[1]/2), c[2]+(c[2]/2), c[3]+(c[3]/2), c[4] }
end

function ColorMidTone(c)
	return { c[1]/1.5, c[2]/1.5, c[3]/1.5, c[4] }
end

function ColorDarkTone(c)
	return { c[1]/2, c[2]/2, c[3]/2, c[4] }
end

local pn_to_color_name= {[PLAYER_1]= "PLAYER_1", [PLAYER_2]= "PLAYER_2"}
local default_color= color("1,1,1,1")

function PlayerColor( pn )

	if TP.Battle.IsBattle then
		return GameColor.BattlePlayerColors[pn_to_color_name[pn]]
	end

	if not GameColor or not GameColor.PlayerColors then
		return default_color
	end
	return GameColor.PlayerColors[pn_to_color_name[pn]] or default_color
end

function PlayerScoreColor( pn )
	return PlayerColor( pn );
end

function PlayerDarkColor( pn )
	if not GameColor then return default_color end
	if not GameColor.PlayerDarkColors then return PlayerColor(pn) end
	return GameColor.PlayerDarkColors[pn_to_color_name[pn]] or default_color
end

local function GameColorDifficultyWrapper(diff)
	assert(GameColor.Difficulty[diff], "GameColor:  There is no entry in GameColor.Difficulty for CustomDifficulty '" .. tostring(diff) .. "'.")
	return GameColor.Difficulty[diff]
end

function CustomDifficultyToColor( sCustomDifficulty )
	return GameColorDifficultyWrapper(sCustomDifficulty)
end

function CustomDifficultyToDarkColor( sCustomDifficulty ) 
	local c = GameColorDifficultyWrapper(sCustomDifficulty)
	return { c[1]/2, c[2]/2, c[3]/2, c[4] }
end

function CustomDifficultyToLightColor( sCustomDifficulty ) 
	local c = GameColorDifficultyWrapper(sCustomDifficulty)
	return { scale(c[1],0,1,0.5,1), scale(c[2],0,1,0.5,1), scale(c[3],0,1,0.5,1), c[4] }
end

function StepsOrTrailToColor(StepsOrTrail)
	return CustomDifficultyToColor( StepsOrTrailToCustomDifficulty(stepsOrTrail) )
end

local stage_default= color("#000000")
function StageToColor( stage )
	if not GameColor or not GameColor.Stage then return stage_default end
	return GameColor.Stage[stage] or stage_default
end

function StageToStrokeColor( stage )
	local c = StageToColor(stage)
	return { c[1]/2, c[2]/2, c[3]/2, c[4] }
end

function JudgmentLineToColor( i )
	if not GameColor or not GameColor.Judgment then return stage_default end
	return GameColor.Judgment[i] or stage_default
end

function JudgmentLineToStrokeColor( i )
	local c = JudgmentLineToColor(i)
	return { c[1]/2, c[2]/2, c[3]/2, c[4] }
end

--[[==========================================================================]]

-- color utilities
function HasAlpha(c)
	if c[4] then return c[4] end
	return 1
end

-- ColorToHex(c)
-- Takes in a normal color("") and returns the hex representation.
function ColorToHex(c)
	local r = c[1]
	local g = c[2]
	local b = c[3]
	local a = HasAlpha(c)

	local function hex(value)
		return ("%02X"):format(value)
	end

	local rX = hex( scale(r, 0, 1, 0, 255) )
	local gX = hex( scale(g, 0, 1, 0, 255) )
	local bX = hex( scale(b, 0, 1, 0, 255) )
	local aX = hex( scale(a, 0, 1, 0, 255) )

	return rX .. gX .. bX .. aX
end

-- HSV utilities (adapted from http://www.cs.rit.edu/~ncs/color/t_convert.html)

-- HSVToColor(hsv)
-- Converts a set of HSV values to a color. hsv is a table.
-- See also: HSV(h, s, v)
function HSVToColor(hsv)
	local i
	local f, q, p, t
	local r, g, b
	local h, s, v

	local a

	s = hsv.Sat
	v = hsv.Value

	if hsv.Alpha then
		a = hsv.Alpha
	else
		a = 0
	end

	if s == 0 then
		return { v, v, v, a }
	end

	h = hsv.Hue / 60

	i = math.floor(h)
	f = h - i
	p = v * (1-s)
	q = v * (1-s*f)
	t = v * (1-s*(1-f))

	if i == 0 then		return { v, t, p, a }
	elseif i == 1 then	return { q, v, p, a }
	elseif i == 2 then	return { p, v, t, a }
	elseif i == 3 then	return { p, q, v, a }
	elseif i == 4 then	return { t, p, v, a }
	else				return { v, p, q, a }
	end
end

-- quick (assumes alpha = 1)
function HSV(h, s, v)
	local t = {
		Hue = h,
		Sat = s,
		Value = v,
		Alpha = 1
	}
	return HSVToColor(t)
end
-- full
function HSVA(h, s, v, a)
	local t = {
		Hue = h,
		Sat = s,
		Value = v,
		Alpha = a
	}
	return HSVToColor(t)
end

function HSVToHex(hsv)
	return ColorToHex( HSVToColor(hsv) )
end

-- ColorToHSV(c)
-- Takes in a normal color("") and returns a table with the HSV values.
function ColorToHSV(c)
	local r = c[1]
	local g = c[2]
	local b = c[3]
	-- alpha requires error checking sometimes.
	local a = HasAlpha(c)

	local h = 0
	local s = 0
	local v = 0

	local min = math.min( r, g, b )
	local max = math.max( r, g, b )
	v = max

	local delta = max - min

	-- xxx: how do we deal with complete black?
	if min == 0 and max == 0 then
		-- we have complete darkness; make it cheap.
		return {
			Hue = 0,
			Sat = 0,
			Value = 0,
			Alpha = a
		}
	end

	if max ~= 0 then
		s = delta / max -- rofl deltamax :|
	else
		-- r = g = b = 0; s = 0, v is undefined
		s = 0
		h = -1
		return {
			Hue = h,
			Sat = s,
			Value = v,
			Alpha = 1
		}
	end

	if r == max then
		h = ( g - b ) / delta     -- yellow/magenta
	elseif g == max then
		h = 2 + ( b - r ) / delta -- cyan/yellow
	else
		h = 4 + ( r - g ) / delta -- magenta/cyan
	end

	h = h * 60 -- degrees

	if h < 0 then
		h = h + 360
	end

	return {
		Hue = h,
		Sat = s,
		Value = v,
		Alpha = a
	}
end

function Hue(color,newHue)
	local c = ColorToHSV(color)
	-- handle wrapping
	if newHue < 0 then
		newHue = 360 + newHue
	elseif newHue > 360 then
		--newHue = math.mod(newHue, 360); -- ?? untested
		newHue = newHue - 360
	end
	c.Hue = newHue
	return HSVToColor(c)
end;
function Saturation(color,percent)
	local c = ColorToHSV(color)
	-- error checking
	if percent < 0 then
		percent = 0.0
	elseif percent > 1 then
		percent = 1.0
	end
	c.Sat = percent
	return HSVToColor(c)
end

function Brightness(color,percent)
	local c = ColorToHSV(color)
	-- error checking
	if percent < 0 then
		percent = 0.0
	elseif percent > 1 then
		percent = 1.0
	end
	c.Value = percent
	return HSVToColor(c)
end

function Alpha(color,percent)
	local c = ColorToHSV(color);
	-- error checking
	if percent < 0 then
		percent = 0.0;
	elseif percent > 1 then
		percent = 1.0;
	end;
	c.Alpha = percent;
	return HSVToColor(c);
end;


function NumStageColor(st)
	if st < 10 then
		return {0.1,1,scale(st,1,10,0.3,1),1};
	elseif st < 15 then
		return {0.1,scale(st,10,15,1,0.3),1,1};
	elseif st < 20 then
		return {scale(st,15,20,0.1,1),0.3,1,1};
	elseif st < 30 then
		return {1,0.3,scale(st,20,30,1,0.3),1};
	else
		return {1,0.3,0.3,1};
	end
end

function BPMColor(Bpm)
	if Bpm > 300 then
		return ColorDarkTone(Color.Red);
	elseif Bpm > 250 then
		return ScaleColor(Bpm,250,300,Color.Red,ColorDarkTone(Color.Red));
	elseif Bpm > 210 then
		return ScaleColor(Bpm,210,250,Color.Orange,Color.Red);
	elseif Bpm > 180 then
		return ScaleColor(Bpm,180,210,Color.Yellow,Color.Orange);
	elseif Bpm > 150 then
		return ScaleColor(Bpm,150,180,Color.Green,Color.Yellow);
	elseif Bpm > 120 then
		return ScaleColor(Bpm,120,150,Color.SkyBlue,Color.Green);
	elseif Bpm > 80 then
		return ScaleColor(Bpm,80,120,Color.Blue,Color.SkyBlue);
	else
		return Color.Blue;
	end
end

function ScaleColor(num,l,r,cl,cr)
	return {scale(num,l,r,cl[1],cr[1]),
			scale(num,l,r,cl[2],cr[2]),
			scale(num,l,r,cl[3],cr[3]),
			scale(num,l,r,cl[4],cr[4])
			}
end

function ColorTone(c)
    -- Y = 0.299 R + 0.587 G + 0.114 B
	local sum = 0.299 * c[1] + 0.587 * c[2] + 0.114 * c[3];

	if sum > 0.5 then
		return {0,0,0,c[4]}
	else
		return {1,1,1,c[4]}
	end
end

function ColorCmp(a,b)
	return (a[0]==b[0] and a[1]==b[1] and a[2]==b[2])
end

--? Overload from Fallback
function JudgmentLineToColor( tapNoteScore, forceStyleTiming)
	
    local colorType = forceStyleTiming

	if colorType == nil then
		local TName,Length = LoadModule("Options.SmartTapNoteScore.lua")()
    	TName = LoadModule("Utils.SortTiming.lua")(TName)

		if TName[1] == "ProW1" then
			colorType = "AdvancedJudgment"
		elseif TName[1] == "ProW5" then
			colorType = "ECFAJudgment"
		else
			colorType = "Judgment"
		end
	end

	local indUnder = string.find(tapNoteScore,"_")
	if x ~= nil then
		tapNoteScore = string.sub(tapNoteScore, string.find(tapNoteScore,"_") + 1, string.len(tapNoteScore))
	end

    if GameColor[colorType]["JudgmentLine_"..tapNoteScore] ~= nil then
        return GameColor[colorType]["JudgmentLine_"..tapNoteScore]
    else
        return {1,1,1,1}
    end
end

function JudgmentLineToStrokeColor( tapNoteScore )
	local c = JudgmentLineToColor(tapNoteScore)
	return { c[1]/2, c[2]/2, c[3]/2, c[4] }
end