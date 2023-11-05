local stringNumFormat = ... or THEME:GetString('ScreenGameplay', "SMemories")
local numStage = GAMESTATE:GetCurrentStageIndex() + 1;
local colorText = NumStageColor(numStage)

return Def.ActorFrame {
    LoadFont("Common", "Normal") .. {
        Text = string.format(stringNumFormat, FormatNumberAndSuffix(numStage));
        InitCommand = function(self)
            self:y(5):diffuse(colorText)
        end;
    };
};
