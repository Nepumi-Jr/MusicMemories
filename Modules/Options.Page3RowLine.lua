return function()
    local strrLine  = "1,2,3,4,5,6,7,8,9,10"

    if ThemePrefs.Get("OptionStyle") == 0 then
        strrLine = strrLine .. ",NextScreen"
    else
        TP.Global.ScreenAfter.PlayerOptions3 = "ScreenStageInformation"
    end
    return strrLine
end