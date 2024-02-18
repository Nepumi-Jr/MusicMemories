--[[
    this function returns a list of files in the directory
    directorys: a list of directorys
    fileTypes: a list of file types (e.g. {"png","jpg"})

    note that all files that start with a "_" will be ignored
]]
return function(directorys, fileTypes)
    local result = {}
    for _, dir in pairs(directorys) do
        local files = FILEMAN:GetDirListing(dir)
        for _,file in pairs(files) do
            
            if string.sub(file,1, 1) ~= "_" then
                local extStart,extEnd = string.find( file, "[.]" )
                if extStart ~= nil and extEnd ~= nil then
                    local fileType = string.sub( file, extStart + 1, string.len(file) )
                    for _,v in pairs(fileTypes) do
                        if fileType == v then
                            result[#result+1] = dir..file
                        end
                    end
                end
            end
        end
    end
    return result
end;

