--[[
    this function returns a list of files in the theme's customize directory
    dir: single directory that want to search 
    fileTypes: a list of file types (e.g. {"png","jpg"})

    note that all files that start with a "_" will be ignored
]]
return function(dir, fileTypes, isFullDir)
    local isFullDir = isFullDir or true
    local themeCustomizePath = getThemeDir().."Customize/"..dir.."/"
    local fileList = LoadModule("Utils.GetFilesList.lua")({themeCustomizePath}, fileTypes)

    if isFullDir then
        return LoadModule("Utils.GetFilesList.lua")({themeCustomizePath}, fileTypes)
    end
    -- remove the full path (the themeCustomizePath)
    for i,v in ipairs(fileList) do
        fileList[i] = string.gsub(v, themeCustomizePath, "")
    end
    return fileList
end;

