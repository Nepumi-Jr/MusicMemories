local audioFile = "_silent"

local StateTier = LoadModule("Eva.StateTier.lua")();

if GAMESTATE:GetCurrentSong():GetDisplayMainTitle() == "Ring of Fortune" then
    audioFile = "IslaMemories/IslaChan"
elseif string.match( string.lower(GAMESTATE:GetCurrentSong():GetDisplayFullTitle()), "megalovania") and STATSMAN:GetCurStageStats():AllFailed() then
    audioFile = "Easter/dog"
elseif TP.Battle.IsBattle then
    audioFile = "Easter/Battle"
elseif STATSMAN:GetCurStageStats():AllFailed() then
    audioFile = "IslaMemories/Plastic Memories - OST - What do you say"
    if LoadModule("Easter.today.lua")() == "HALLOWEEN" then
        audioFile = "MinecraftCaveSounds/"..math.random(1,6);
    end
elseif StateTier == "ISLA" or StateTier == "BEAT" or StateTier == "WOW" then
    if math.random(1, 10) == 1 then
        audioFile = "Easter/EPIC"
    else
        audioFile = "IslaMemories/IslaChan"
    end
else
    audioFile = "IslaMemories/Plastic Memories OST 2 - 012 Changing mind"
end

return THEME:GetPathS("", audioFile)