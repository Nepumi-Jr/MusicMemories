return function(text, pattern)

    local result = {}

    for i = 1, string.len(text) do
        local complete = true;
        for j = 1 , string.len(pattern) do
            if string.sub( text, i,i ) ~= string.sub( pattern, j,j ) then
                complete = false;
                break
            end
        end

        if complete then
            result[#result+1] = i
        end
    end

    return result
end