local function findSecondLastSlash(str)
    local crt = 0
    for i = string.len(str), 0, -1 do
        if(string.sub(str,i, i) == '/') then crt = crt + 1; end
        if (crt == 2) then return i; end
    end
    return -1
end

local function getDefaultThemeDir()
    local themeDir = getThemeDir()
    local secondLastSlash = findSecondLastSlash(themeDir)
    return string.sub(themeDir, 1, secondLastSlash).."default/"
end

local defaultOutfoxPath = getDefaultThemeDir().."Graphics/ScreenTitleMenu logo/_text.png"

if FILEMAN:DoesFileExist(defaultOutfoxPath) then
    return Def.Sprite{
        InitCommand = function(self)
            self:Load(defaultOutfoxPath)
        end
    };
end

return Def.ActorFrame{
    LoadActor("defaultLogo")..{

    };
};