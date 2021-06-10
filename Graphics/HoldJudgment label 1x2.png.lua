
local PN = Var "Player" or GAMESTATE:GetMasterPlayerNumber();
--Var "Player" is null :(


local JudF = TP[ToEnumShortString(PN)].ActiveModifiers.JudgmentGraphic
JudF = JudgeFileShortName(JudF)


-- Get hold judge from Resource/JudF/Hold/ first
local path = "/"..THEMEDIR().."Resource/JudF/Hold/";
local files = FILEMAN:GetDirListing(path)
for k,filename in ipairs(files) do
    if string.match(filename, " 1x2") and string.match(filename,JudF) then
        return LoadActor(path..filename);
    end
end

-- secondly, Get hold judge from 
local path = "/Appearance/Judgments/";
local files = FILEMAN:GetDirListing(path)
for k,filename in ipairs(files) do
    if string.match(filename, "%[Hold%]") and string.match(filename, " 1x2") and string.match(filename,JudF) then
        return LoadActor(path..filename);
    end
end



return LoadActor(THEME:GetPathG("Def","HoldJ"));

