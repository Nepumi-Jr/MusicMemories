return function(a)
    local re;
    if TP.Battle.IsBattle and TP.Battle.Mode == "Dr" then
        re = {false,false};
    elseif TP.Battle.IsBattle and TP.Battle.Mode == "Ac" then
        re = {true,false};
    else
        re = {true,true};
    end
    return re[a];
end;