return function(diffi)
    return THEME:GetString("CustomDifficulty",ToEnumShortString(diffi:GetDifficulty())).." : "..diffi:GetMeter()
end