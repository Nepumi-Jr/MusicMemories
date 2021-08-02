return function()
    local strrLine  = "Turn,Scroll,7,8,9,10"

    if GAMESTATE:GetCurrentGame():GetName() == "gh" then
        strrLine = strrLine .. ",GH"
    end
    strrLine = strrLine .. ",11,12,125,13,14"
    if ThemePrefs.Get("OptionStyle") == 0 then
        strrLine = strrLine .. ",NextScreen"
    elseif ThemePrefs.Get("OptionStyle") == 1 then
        TP.Global.ScreenAfter.PlayerOptions2 = "ScreenSongOptions"
    elseif ThemePrefs.Get("OptionStyle") == 2 then
        TP.Global.ScreenAfter.PlayerOptions2 = "ScreenStageInformation"
    end
    return strrLine
end