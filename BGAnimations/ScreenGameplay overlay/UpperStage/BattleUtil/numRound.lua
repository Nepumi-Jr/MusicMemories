local stringNumFormat = "%s Round"
local numStage = GAMESTATE:GetCurrentStageIndex() + 1;
local colorText = ModeIconColors["Rave"]

return Def.ActorFrame {
    LoadFont("Common", "Normal") .. {
        Text = string.format(stringNumFormat, FormatNumberAndSuffix(numStage));
        InitCommand = function(self)
            self:y(5):diffuse(colorText)
        end;
    };
};
