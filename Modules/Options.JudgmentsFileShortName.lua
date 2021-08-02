return function(fileName)
    local shortName = string.match(fileName,".+/(.-) %d") or fileName
    local shortNameLv2 = string.match(shortName,"(.-) %[")
    local result = shortNameLv2 or shortName
    result = result:gsub(" %(doubleres%)", ""):gsub(" %(res %d+x%d+%)","")
    return result
end