
return function(player)
    local bestNote = nil;
    local maxNote = nil;
    local curNote = 0;
    local tripleScore = {"TapNoteScore_ProW5", "TapNoteScore_ProW4", "TapNoteScore_ProW3", "TapNoteScore_ProW2", "TapNoteScore_ProW1", "TapNoteScore_W1"};
    local doubleScore = {"TapNoteScore_W2"};
    local oneScore = {"TapNoteScore_W3", "TapNoteScore_CheckpointHit", "TapNoteScore_AvoidMine"};
    local oneHoldScore = {"HoldNoteScore_Held"};

    local minusThree = {"TapNoteScore_Miss", "TapNoteScore_W5", "TapNoteScore_W4"};
    local minusTwo = {"TapNoteScore_W3"};
    local minusOne = {"TapNoteScore_W2", "TapNoteScore_HitMine", "TapNoteScore_CheckpointMiss"};
    local minusOneHold = {"HoldNoteScore_LetGo"};

    local function calculateScoreNote(data, isScore)
        local score = 0;
        
        if isScore then
            for i=1, #tripleScore do
                score = score + data:GetTapNoteScore(tripleScore[i]) * 3;
            end
            for i=1, #doubleScore do
                score = score + data:GetTapNoteScore(doubleScore[i]) * 2;
            end
            for i=1, #oneScore do
                score = score + data:GetTapNoteScore(oneScore[i]);
            end
            for i=1, #oneHoldScore do
                score = score + data:GetHoldNoteScore(oneHoldScore[i]);
            end
        else
            for i=1, #tripleScore do
                score = score + data:GetTapNoteScores(tripleScore[i]) * 3;
            end
            for i=1, #doubleScore do
                score = score + data:GetTapNoteScores(doubleScore[i]) * 2;
            end
            for i=1, #oneScore do
                score = score + data:GetTapNoteScores(oneScore[i]);
            end
            for i=1, #oneHoldScore do
                score = score + data:GetHoldNoteScores(oneHoldScore[i]);
            end
        end
        return score;
    end

    return Def.ActorFrame {
        LoadFont("Combo Number") .. {
            InitCommand=function(self) 
                self:x(-35); self:y(5); self:horizalign(left); self:zoom(0.3); 
            end;
            OnCommand=function(self)
                local hst = PROFILEMAN:GetProfile(player):GetHighScoreListIfExists(GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(player)):GetHighScores();
                if hst[1] and not GAMESTATE:IsCourseMode() then
                    local s = 0;
                    bestNote = calculateScoreNote(hst[1], true)
                    local triple = {"TapNoteScore_ProW5", "TapNoteScore_ProW4", "TapNoteScore_ProW3", "TapNoteScore_ProW2", "TapNoteScore_ProW1", "TapNoteScore_W1", "TapNoteScore_W2", "TapNoteScore_W3", "TapNoteScore_W4", "TapNoteScore_W5", "TapNoteScore_Miss"};
                    local one = {"TapNoteScore_HitMine", "TapNoteScore_AvoidMine", "TapNoteScore_CheckpointHit", "TapNoteScore_CheckpointMiss"}
                    local oneHold = {"HoldNoteScore_LetGo", "HoldNoteScore_Held"}
                    for i=1, #triple do
                        s = s + hst[1]:GetTapNoteScore(triple[i]) * 3;
                    end
                    for i=1, #one do
                        s = s + hst[1]:GetTapNoteScore(one[i]);
                    end
                    for i=1, #oneHold do
                        s = s + hst[1]:GetHoldNoteScore(oneHold[i]);
                    end
                    maxNote = s;
                    curNote = maxNote;
                    self:settextf("%d",curNote - bestNote):diffuse(Color.Green)
                end
            end;
            JudgmentMessageCommand=function(self, param)
                if param.Player ==  player then
                    local stat = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
                    local runAnimation = true;
                    if TP.Battle.IsBattle and ((TP.Battle.Hidden and TP.Battle.Mode == "Ac") or (TP.Battle.Mode == "Dr" and TP.Battle.Hidden and not TP.Battle.IsfailorIsDraw)) then
                        self:settext("???")
                    else
                        if bestNote and not GAMESTATE:IsCourseMode() then
                            --another method by calculating from param
                            local isNew = false;
                            if param.HoldNoteScore then
                                if FindInTable(param.HoldNoteScore, minusOneHold) then
                                    curNote = curNote - 1
                                    isNew = true;
                                end
                            elseif param.TapNoteScore then
                                if FindInTable(param.TapNoteScore, minusThree) then
                                    curNote = curNote - 3
                                    isNew = true;
                                elseif FindInTable(param.TapNoteScore, minusTwo) then
                                    curNote = curNote - 2
                                    isNew = true;
                                elseif FindInTable(param.TapNoteScore, minusOne) then
                                    curNote = curNote - 1
                                    isNew = true;
                                end
                            end

                            local diff = (curNote - bestNote)
                            
                            if diff >= 0 then
                                self:settextf("%d",diff)
                                self:diffuse(Color.Green)
                            elseif diff < 0 then
                                self:settextf("%d",diff)
                                self:diffuse(Color.Red)
                                self:diffusealpha(0.2)
                            end
                            runAnimation = isNew;
                        else
                            if param.HoldNoteScore then
                                if FindInTable(param.HoldNoteScore, oneHoldScore) then
                                    curNote = curNote + 1
                                end
                            elseif param.TapNoteScore then
                                if FindInTable(param.TapNoteScore, tripleScore) then
                                    curNote = curNote + 3
                                elseif FindInTable(param.TapNoteScore, doubleScore) then
                                    curNote = curNote + 2
                                elseif FindInTable(param.TapNoteScore, oneScore) then
                                    curNote = curNote + 1
                                end
                            end
                            self:settextf("%d",curNote, false)
                            self:diffuse(Color.Magenta)
                        end
                    end
                    if runAnimation then
                        self:stopeffect():finishtweening():rotationz(-1):addx(5):decelerate(0.05*2.5):rotationz(0):addx(-5)
                    end
                end
            end;
		};
    };
end