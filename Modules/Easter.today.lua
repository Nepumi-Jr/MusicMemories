return function()
	if LoadModule("Is.today.lua")(1,4) then
		return "FOOL";
	elseif LoadModule("Is.today.lua")(31,10) then
		return "HALLOWEEN";
	end
	return "None";
end