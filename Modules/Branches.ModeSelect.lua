return function()
    if TP.Battle.IsBattle then
        return "Normal,Nonstop"
    else
        return "Normal,Nonstop,Oni,Endless";
    end
end;