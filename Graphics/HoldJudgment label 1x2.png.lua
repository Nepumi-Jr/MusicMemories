
local PN = Var "Player" or GAMESTATE:GetMasterPlayerNumber();
local JudF = TP[ToEnumShortString(PN)].ActiveModifiers.JudgmentGraphic
return LoadActor(LoadModule("Options.JudgmentGetHoldPath.lua")(JudF));

