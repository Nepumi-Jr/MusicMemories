return function()
    local strrLine  = ""

    if ThemePrefs.Get("OptionStyle") == 0 then
        strrLine = strrLine .. ",NextScreen"
    else
        TP.Global.ScreenAfterThisOption = "ScreenPlayerOptions2"
    end
    return strrLine
end