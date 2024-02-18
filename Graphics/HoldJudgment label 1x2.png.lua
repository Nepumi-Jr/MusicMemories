
local PN = Var "Player" or GAMESTATE:GetMasterPlayerNumber();
local JudF = TP[ToEnumShortString(PN)].ActiveModifiers.JudgmentGraphic
return LoadActor(LoadModule("Judgement.GetHoldPath.lua")(JudF));

