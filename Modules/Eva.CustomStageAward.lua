return function(pn)

    local stageStat = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)

	local W1 = stageStat:GetTapNoteScores("TapNoteScore_W1")
	local W2 = stageStat:GetTapNoteScores("TapNoteScore_W2")
	local W3 = stageStat:GetTapNoteScores("TapNoteScore_W3")
	local W4 = stageStat:GetTapNoteScores("TapNoteScore_W4")
	local W5 = stageStat:GetTapNoteScores("TapNoteScore_W5")
	local Mi = stageStat:GetTapNoteScores("TapNoteScore_Miss")
	local Cp = stageStat:GetTapNoteScores("TapNoteScore_CheckpointHit")
	local Cm = stageStat:GetTapNoteScores("TapNoteScore_CheckpointMiss")

	local Hd = stageStat:GetHoldNoteScores("HoldNoteScore_Held")
	local Lg = stageStat:GetHoldNoteScores("HoldNoteScore_LetGo")

	if W2+W3+W4+W5+Mi+Cm+Lg == 0 then
		return "StageAward_FullComboW1"
	elseif W3+W4+W5+Mi+Cm+Lg == 0 and W2 == 1 then
		return "StageAward_OneW2"
	elseif W3+W4+W5+Mi+Cm+Lg == 0 and W2 < 10 then
		return "StageAward_SingleDigitW2"
	elseif W3+W4+W5+Mi+Cm+Lg == 0 then
		return "StageAward_FullComboW2"
	elseif W4+W5+Mi+Cm+Lg == 0 and W3 == 1 then
		return "StageAward_OneW3"
	elseif W4+W5+Mi+Cm+Lg == 0 and W3 < 10 then
		return "StageAward_SingleDigitW3"
	elseif W4+W5+Mi+Cm+Lg == 0 then
		return "StageAward_FullComboW3"
	elseif W4+W5+Mi+Cm+Lg == 1 then
		return "StageAward_Choke"
	elseif Mi+Lg+Cm == 0 then
		return "StageAward_NoMiss"
	end
	return "Nope"

end