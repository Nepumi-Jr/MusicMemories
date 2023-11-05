--THEME:GetPathG("ScreenStageInformation stage","event")
local stage = ... or "event"
return Def.ActorFrame{
    Def.Sprite{
        Texture=THEME:GetPathG("ScreenStageInformation stage", stage);
        InitCommand=function(self) self:zoom(0.15):y(3) end;
    };
};