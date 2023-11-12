return function()
    local optionLifeBar = ThemePrefs.Get("CenterLifeBar")
    -- 0 is off
    -- 1 is two sides
    -- 2 is center
    -- 3 is on

    if GAMESTATE:GetNumPlayersEnabled() == 2 then
        return false
    end

    if optionLifeBar == 0 then
        return false
    elseif optionLifeBar == 1 then
        return GAMESTATE:GetCurrentStyle():GetStyleType() == "StyleType_OnePlayerTwoSides"
    elseif optionLifeBar == 2 then
        return Center1Player() or GAMESTATE:GetCurrentStyle():GetStyleType() == "StyleType_OnePlayerTwoSides" or gamePlayCenter
    elseif optionLifeBar == 3 then
        return true
    end

    return true
end