--[[
W1LateCommand=finishtweening;rotationz,0;shadowlength,0;y,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1.2;addy,-10;decelerate,0.05*2.5;addy,10;zoomy,1;zoom,1;sleep,0.8;decelerate,0.1;diffusealpha,0.05;
W2LateCommand=finishtweening;rotationz,0;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1.15;addy,-7;decelerate,0.05*2.5;addy,7;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;diffusealpha,0.05;
W3LateCommand=finishtweening;rotationz,5;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1.1;addy,-6;decelerate,0.05*2.5;addy,6;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;diffusealpha,0.05;
W4LateCommand=finishtweening;rotationz,7;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1;addy,-5;decelerate,0.05*2.5;addy,5;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;diffusealpha,0.05;
W5LateCommand=finishtweening;rotationz,15;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1;addy,-5;decelerate,0.05*2.5;addy,5;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;diffusealpha,0.05;
MissLateCommand=finishtweening;rotationz,25;y,0;shadowlength,0;diffusealpha,1;zoom,1;y,-20;linear,0.8;y,20;sleep,0.5;linear,0.1;diffusealpha,0;
]]
local function getDefaultJudgeCommand(judge, isEarly, isReverse)
	local judgeRotation = {
		W1 = 0,
		W2 = 0,
		W3 = 5,
		W4 = 7,
		W5 = 15,
		Miss = 25
	}

	local judgeZoom = {
		W1 = 1.2,
		W2 = 1.15,
		W3 = 1.1,
		W4 = 1,
		W5 = 1,
		Miss = 1
	}

	local judgeAddY = {
		W1 = -10,
		W2 = -7,
		W3 = -6,
		W4 = -5,
		W5 = -5,
	}

	return function(self)
		self:finishtweening()
		self:rotationz(judgeRotation[judge] * (isEarly and -1 or 1))
		self:y(0)
		self:shadowlength(0)
		self:diffusealpha(1)
		self:zoomx(1)
		self:zoomy(1.1)
		self:zoom(judgeZoom[judge])

		if judge == "Miss" then
			self:y(-20 + 20 * (isReverse and 1 or 0))
			self:linear(0.8)
			self:y(20 + 20 * (isReverse and 1 or 0))
		else
			self:addy(judgeAddY[judge] * (isReverse and -1 or 1))
			self:decelerate(0.05*2.5)
			self:addy(-judgeAddY[judge] * (isReverse and -1 or 1))
			self:zoomy(1)
			self:zoom(1)
		end

		self:sleep(0.5)
		self:decelerate(0.1)
		self:diffusealpha(0.05)


	end
end

return function(judgeName, isReverse)

	--Default
	local result = {
        W1LateCommand = getDefaultJudgeCommand("W1", false, isReverse);
		W2LateCommand = getDefaultJudgeCommand("W2", false, isReverse);
		W3LateCommand =	getDefaultJudgeCommand("W3", false, isReverse);
		W4LateCommand = getDefaultJudgeCommand("W4", false, isReverse);
		W5LateCommand = getDefaultJudgeCommand("W5", false, isReverse);
		MissLateCommand = getDefaultJudgeCommand("Miss", false, isReverse);

		W1EarlyCommand = getDefaultJudgeCommand("W1", true, isReverse);
		W2EarlyCommand = getDefaultJudgeCommand("W2", true, isReverse);
		W3EarlyCommand =	getDefaultJudgeCommand("W3", true, isReverse);
		W4EarlyCommand = getDefaultJudgeCommand("W4", true, isReverse);
		W5EarlyCommand = getDefaultJudgeCommand("W5", true, isReverse);
		MissEarlyCommand = getDefaultJudgeCommand("Miss", true, isReverse);

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
    
	local path = "/"..getThemeDir().."/CustomStuff/Judgment Animation/";
	local files = FILEMAN:GetDirListing(path)
    --printf("%s....\n%s",getThemeDir().."Graphics/_Judgement Font/Animate",TableToString(files))

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