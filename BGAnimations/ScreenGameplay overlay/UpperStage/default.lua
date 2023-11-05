
local dispActors = Def.ActorFrame{}

if IsNetConnected() then
    dispActors[#dispActors+1] = LoadActor("stageTitle", "online");
    dispActors[#dispActors+1] = LoadActor("numStage");
elseif TP.Battle.IsBattle then--BattleTor
    dispActors[#dispActors+1] = LoadActor("BattleUtil/scoreBoard");
    dispActors[#dispActors+1] = LoadActor("stageTitle", "battle");
    dispActors[#dispActors+1] = LoadActor("BattleUtil/battleInfo");
    dispActors[#dispActors+1] = LoadActor("BattleUtil/numRound");
elseif GAMESTATE:IsCourseMode() then -- Course
    if GAMESTATE:GetCurrentCourse():IsNonstop() then
        dispActors[#dispActors+1] = LoadActor("stageTitle", "nonstop");
        dispActors[#dispActors+1] = LoadActor("CourseUtil/finiteStage");
    elseif GAMESTATE:GetCurrentCourse():IsOni()  then
        dispActors[#dispActors+1] = LoadActor("stageTitle", "oni");
        dispActors[#dispActors+1] = LoadActor("CourseUtil/finiteStage");
        dispActors[#dispActors+1] = LoadActor("stageTitle", "event");
    elseif GAMESTATE:GetCurrentCourse():IsEndless() then
        dispActors[#dispActors+1] = LoadActor("stageTitle", "endless");
        dispActors[#dispActors+1] = LoadActor("numStage");
    end
    if ToEnumShortString(GAMESTATE:GetCurrentStage()) == "Event" then
        dispActors[#dispActors+1] = LoadActor("stageTitle", "event");
    end
elseif GAMESTATE:GetPlayMode() == 'PlayMode_Rave' or GAMESTATE:GetPlayMode() == 'PlayMode_Battle' then--Rave
    if math.random(1,7) == 7 then
        dispActors[#dispActors+1] = LoadActor("stageTitle", "magic");
    else
        dispActors[#dispActors+1] = LoadActor("stageTitle", "rave");
    end
    if ToEnumShortString(GAMESTATE:GetCurrentStage()) == "Event" then
        dispActors[#dispActors+1] = LoadActor("stageTitle", "event");
    end
else
    if ToEnumShortString(GAMESTATE:GetCurrentStage()) == "Event" then
        dispActors[#dispActors+1] = LoadActor("stageTitle", "event");
        dispActors[#dispActors+1] = LoadActor("numStage");
    else
        local sStage = GAMESTATE:GetCurrentStage();
        dispActors[#dispActors+1] = LoadActor("stageTitle", ToEnumShortString(sStage));
    end
end

--dispActors = Def.ActorFrame{ LoadActor("numStage", "HOLA %s HAHA") };
local curdispIdx = #dispActors - 1;

local t = Def.ActorFrame{
    OnCommand=function(self)
        self:CenterX():y(20);
        if #dispActors > 1 then
            for i=1,#dispActors do
                self:GetChildAt(1):GetChildAt(i):diffusealpha(0);
            end
            self:playcommand("cycleDisp");
        end
    end;
    cycleDispCommand=function(self)
        local prevdispIdx = curdispIdx;
        curdispIdx = (curdispIdx + 1) % #dispActors;
        self:GetChildAt(1):GetChildAt(prevdispIdx + 1):finishtweening():y(0):diffusealpha(1):decelerate(0.5):y(20):diffusealpha(0);
        self:GetChildAt(1):GetChildAt(curdispIdx + 1):finishtweening():y(-20):diffusealpha(0):decelerate(0.5):y(0):diffusealpha(1);
        self:sleep(math.random(7*8,15*8)/8):queuecommand("cycleDisp");
    end;

    dispActors;
};



return t;