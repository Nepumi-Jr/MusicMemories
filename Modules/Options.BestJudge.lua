return function()
    local TName,Length = LoadModule("Options.SmartTapNoteScore.lua")()
    TName = LoadModule("Utils.SortTiming.lua")(TName)
    if TName[1] ~= "W1" then
        return TName[1]
    else
        if GAMESTATE:ShowW1() then
            return "W1"
        else
            return TName[2] or TName[1]
        end
    end
end