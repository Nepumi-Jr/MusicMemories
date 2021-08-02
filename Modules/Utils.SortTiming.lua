local function compare(a, b)
    local numA = tonumber(a:match("%d+"))
    local numB = tonumber(b:match("%d+"))
    
    if string.match( a,"Pro" ) then numA = numA - 100 end
    if string.match( b,"Pro" ) then numB = numB - 100 end

    return numA < numB
end


return function(timing)
    table.sort( timing, compare )
    return timing
end