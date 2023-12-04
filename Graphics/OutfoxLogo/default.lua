local defaultOutfoxPath = getThemeDir()
defaultOutfoxPath = string.gsub(defaultOutfoxPath, THEME:GetCurThemeName(), "default")
defaultOutfoxPath = defaultOutfoxPath.."Graphics/ScreenTitleMenu logo/_text.png"

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