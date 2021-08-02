return function(a,b)
	if MonthOfYear() == b-1 and DayOfMonth() == a then
		return true
	end
	return false
end