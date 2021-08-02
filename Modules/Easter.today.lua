return function()
	if LoadModule("Is.today.lua")(1,4) then
		return "FOOL";
	end
	return "None";
end