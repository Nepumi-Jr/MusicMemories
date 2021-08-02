return function()
	local Tier = 0;
	for player in ivalues(GAMESTATE:GetHumanPlayers()) do
        local thisStageStats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
		local ISLAC = thisStageStats:GetStageAward()
		local ISLAF = thisStageStats:GetPeakComboAward()
		if ISLAC == "StageAward_FullComboW2" or
		ISLAC == "StageAward_SingleDigitW2" or
		ISLAC == "StageAward_OneW2" or
		ISLAC == "StageAward_FullComboW1" or
		ISLAC == "StageAward_80PercentW3" or
		ISLAC == "StageAward_90PercentW3" or
		ISLAC == "StageAward_100PercentW3" then
			Tier = math.max(Tier,3);
		end
		if ISLAC == "StageAward_FullComboW3" or
		ISLAC == "StageAward_SingleDigitW3" or
		ISLAC == "StageAward_OneW3" then
			if ISLAF ~= "" then
				Tier = math.max(Tier,3);
			else
				Tier = math.max(Tier,2);
			end
		end
		
		if thisStageStats:GetTapNoteScores("TapNoteScore_Miss") +
		thisStageStats:GetTapNoteScores("TapNoteScore_W5") +
		thisStageStats:GetTapNoteScores("TapNoteScore_W4") <= 1 then
			if ISLAF ~= "" then
				Tier = math.max(Tier,3);
			else
				Tier = math.max(Tier,2);
			end
		end
		
		if thisStageStats:GetPersonalHighScoreIndex() == 0 then
			Tier = math.max(Tier,1);
		end
		
		if thisStageStats:GetMachineHighScoreIndex() == 0 then
			Tier = math.max(Tier,1);
		end
	end
	
	if Tier == 0 then
		return "NORMAL";
	elseif Tier == 1 then
		return "ISLA";
	elseif Tier >= 2 then
		return "BEAT";
	elseif Tier == 3 then
		return "WOW";
	end
end