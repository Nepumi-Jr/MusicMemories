return function()
    local strrLine  = ""

    local elements = {"Judge", "SubJudge", "Combo"}
    local parts = {"X", "Y", "Zoom", "Alpha"}

    for i, element in ipairs(elements) do
        for j, part in ipairs(parts) do
            strrLine = strrLine .. ","..element..part
        end
    end

    if ThemePrefs.Get("OptionStyle") == 0 then
        strrLine = strrLine .. ",NextScreen"
    else
        TP.Global.ScreenAfterThisOption = "ScreenPlayerOptions2"
    end
    return strrLine
end