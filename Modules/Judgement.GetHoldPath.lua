return function(JudF)
	JudF = JudgeFileShortName(JudF)
	-- secondly, Get hold judge from 
	local path = "/Appearance/Judgments/";
	local files = FILEMAN:GetDirListing(path)
	for k,filename in ipairs(files) do
		if string.match(filename, "%[Hold%]") and string.match(filename, " 1x2") and string.match(filename,JudF) then
			return path..filename
		end
	end
	
	return THEME:GetPathG("Def","HoldJ");
end