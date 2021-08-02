return function()
	local strrLine  = "1,8,HA,SC"
	if not TP.Battle.IsBattle then
        strrLine = strrLine .. ",12"
	end
    strrLine = strrLine .. ",16,SF,18,MI,3A,TIM,19"

    if ThemePrefs.Get("OptionStyle") == 0 then
        if TP.Battle.IsBattle then
            strrLine = strrLine .. ",NextScreenBat"
        else
            strrLine = strrLine .. ",NextScreen"
        end
    else
        TP.Global.ScreenAfter.PlayerOptions = "ScreenPlayerOptions2"
    end
    return strrLine
end