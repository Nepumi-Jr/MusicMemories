return function(prefix)
    local result = {}
    local files = FILEMAN:GetDirListing(getThemeDir().."/Modules/",false,false)
    for _,file in pairs(files) do
        local pl,pr = string.find( file, prefix.."." )
        local sl,sr = string.find( file, ".lua" )
        if pl ~= nil and pl == 1 and pr + 1 <= sl - 1 then
            result[#result+1] = string.sub( file, pr + 1, sl - 1 )
        end
    end
    return result
end;

