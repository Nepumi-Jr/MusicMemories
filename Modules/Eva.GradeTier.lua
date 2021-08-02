return function(grade)
    local letterGrade = "";
    if grade == "Grade_Tier01" then
        letterGrade = "SS"
    elseif grade == "Grade_Tier02" then
        letterGrade = "S"
    elseif grade == "Grade_Tier03" then
        letterGrade = "A+"
    elseif grade == "Grade_Tier04" then
        letterGrade = "A"
    elseif grade == "Grade_Tier05" then
        letterGrade = "B"
    elseif grade == "Grade_Tier06" then
        letterGrade = "C"
    elseif grade == "Grade_Tier07" then
        letterGrade = "D"
    elseif grade == "Grade_Failed" then
        letterGrade = "F"
    end
    return letterGrade
end