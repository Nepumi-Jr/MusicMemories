return function(judgeName)
	
	--Default
	local result = {
        W1LateCommand = THEME:GetMetric( "Judgment", "W1LateCommand");
		W2LateCommand = THEME:GetMetric( "Judgment", "W2LateCommand");
		W3LateCommand = THEME:GetMetric( "Judgment", "W3LateCommand");
		W4LateCommand = THEME:GetMetric( "Judgment", "W4LateCommand");
		W5LateCommand = THEME:GetMetric( "Judgment", "W5LateCommand");
		MissLateCommand = THEME:GetMetric( "Judgment", "MissLateCommand");
	
		W1EarlyCommand = THEME:GetMetric( "Judgment", "W1EarlyCommand");
		W2EarlyCommand = THEME:GetMetric( "Judgment", "W2EarlyCommand");
		W3EarlyCommand = THEME:GetMetric( "Judgment", "W3EarlyCommand");
		W4EarlyCommand = THEME:GetMetric( "Judgment", "W4EarlyCommand");
		W5EarlyCommand = THEME:GetMetric( "Judgment", "W5EarlyCommand");
		MissEarlyCommand = THEME:GetMetric( "Judgment", "MissEarlyCommand");

        ProW1LateCommand = THEME:GetMetric( "Judgment", "ProW1LateCommand");
		ProW2LateCommand = THEME:GetMetric( "Judgment", "ProW2LateCommand");
		ProW3LateCommand = THEME:GetMetric( "Judgment", "ProW3LateCommand");
		ProW4LateCommand = THEME:GetMetric( "Judgment", "ProW4LateCommand");
		ProW5LateCommand = THEME:GetMetric( "Judgment", "ProW5LateCommand");
	
		ProW1EarlyCommand = THEME:GetMetric( "Judgment", "ProW1EarlyCommand");
		ProW2EarlyCommand = THEME:GetMetric( "Judgment", "ProW2EarlyCommand");
		ProW3EarlyCommand = THEME:GetMetric( "Judgment", "ProW3EarlyCommand");
		ProW4EarlyCommand = THEME:GetMetric( "Judgment", "ProW4EarlyCommand");
		ProW5EarlyCommand = THEME:GetMetric( "Judgment", "ProW5EarlyCommand");
	};
	

	if not ThemePrefs.Get("CustomJudgeAnimation") then
		return result
	end
	
    
	local JudAni = LoadModule("Options.JudgmentsFileShortName.lua")(judgeName)
	local path = "/Appearance/Judgments/";
	local files = FILEMAN:GetDirListing(path)

	--Check in Appearance/Judgments/
	for k,filename in ipairs(files) do
		if string.match(filename, ".lua") and string.match(filename,JudAni) then
			
			local data = LoadActor(path..filename)
			
			for k,v in pairs(result) do
				if data[k] ~= nil then
					result[k] = data[k]
				end
			end

			break
		end
	end
    
	local path = "/"..THEMEDIR().."/CustomStuff/Judgment Animation/";
	local files = FILEMAN:GetDirListing(path)
    --printf("%s....\n%s",THEMEDIR().."Graphics/_Judgement Font/Animate",TableToString(files))

	for k,filename in ipairs(files) do
		if string.match(filename, ".lua") and string.match(filename,JudAni) then
			
			local data = LoadActor(path..filename)
			
			for k,v in pairs(result) do
				if data[k] ~= nil then
					result[k] = data[k]
				end
			end

			break
		end
	end

	return result

end