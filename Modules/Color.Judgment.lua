return function(tapScore)

    local TName,Length = LoadModule("Options.SmartTapNoteScore.lua")()
    TName = LoadModule("Utils.SortTiming.lua")(TName)
    local colorType = "Judgment"

    if TName[1] == "ProW1" then
        colorType = "AdvancedJudgment"
    elseif TName[1] == "ProW5" then
        colorType = "ECFAJudgment"
    end

    if GameColor[colorType]["JudgmentLine_"..tapScore] ~= nil then
        return GameColor[colorType]["JudgmentLine_"..tapScore]
    else
        return {1,1,1,1}
    end
end