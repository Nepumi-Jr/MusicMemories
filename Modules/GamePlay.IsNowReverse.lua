return function(player)
    local gamePn = player == "PlayerNumber_P1" and "PlayerP1" or "PlayerP2";
    if SCREENMAN:GetTopScreen():GetChild(gamePn) == nil then return false end;
    if SCREENMAN:GetTopScreen():GetChild(gamePn):GetChild('Judgment') == nil then return false end;
    if SCREENMAN:GetTopScreen():GetChild(gamePn):GetChild('Combo') == nil then return false end;

    -- check y position of judgement and combo
    local yJudge = SCREENMAN:GetTopScreen():GetChild(gamePn):GetChild('Judgment'):GetY();
    local yCombo = SCREENMAN:GetTopScreen():GetChild(gamePn):GetChild('Combo'):GetY();

    return yJudge >= yCombo;

end