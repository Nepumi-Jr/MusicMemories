return function(pn) -- Code from Kid
    local columnNoteName = GAMESTATE:GetCurrentStyle():GetColumnInfo(
                               GAMESTATE:GetMasterPlayerNumber(), 1)["Name"];
    if GAMESTATE:GetCurrentStyle():ColumnsPerPlayer() > 2 then
        columnNoteName = GAMESTATE:GetCurrentStyle():GetColumnInfo(
                             GAMESTATE:GetMasterPlayerNumber(), 2)["Name"];
    end
    local arrownote
    local noteskin = "default"
    if pn and PlayerOptions.NoteSkin then
        noteskin = GAMESTATE:GetPlayerState(pn):GetPlayerOptions(
                       'ModsLevel_Song'):NoteSkin()
    end

    if NOTESKIN.LoadActorForNoteSkin then
        arrownote = NOTESKIN:LoadActorForNoteSkin(columnNoteName, "Tap Note",
                                                  noteskin)
    end
    if not arrownote then
        arrownote = LoadActor(THEME:GetPathG("OutfoxNote", "_arrow"));
    end
    return arrownote
end;
