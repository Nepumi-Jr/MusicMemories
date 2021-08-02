return function(namae)
	
	if namae == "!!default!!" then
        local firstOne = LoadModule("Options.JudgmentsList.lua")()[1]
        if firstOne == "!!missing!!" then
            return THEME:GetPathG("Judge","Memory")
        else
            return firstOne
        end
    elseif namae == "!!missing!!" then
		return THEME:GetPathG("Judge","Memory")
	elseif namae == "None" then
		return THEME:GetPathG("","_blank")
	elseif namae == "SM5ProTiming" then
		return THEME:GetPathG("","Sm5")
	else
        local judgeList = LoadModule("Options.JudgmentsList.lua")()
        if FindInTable(namae, judgeList) then
            return namae
        else
            return judgeList[1]
        end
	end
	return THEME:GetPathG("Judge","Memory")
end