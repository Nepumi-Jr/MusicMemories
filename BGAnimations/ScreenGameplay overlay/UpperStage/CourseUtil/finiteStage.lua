return Def.ActorFrame {
    LoadFont("Common", "Normal") .. {
        InitCommand = function(self)
            self:y(5)
        end;
        OnCommand = function(self)
            local totalStage = "??"
            local nowCourseStage = GAMESTATE:GetCourseSongIndex() + 1;
            local colorText = NumStageColor(nowCourseStage)
            if GAMESTATE:GetCurrentCourse():GetNumCourseEntries() then
                totalStage = tostring(GAMESTATE:GetCurrentCourse():GetNumCourseEntries())
            end
            self:diffuse(colorText):settextf("%s of %s", tostring(nowCourseStage), totalStage)
        end
    };
};
