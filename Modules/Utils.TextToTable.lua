return function(t)
    local op = {};
	for i = 1,string.len(t) do
		op[i] = string.sub(t,i,i)
	end
	return op
end