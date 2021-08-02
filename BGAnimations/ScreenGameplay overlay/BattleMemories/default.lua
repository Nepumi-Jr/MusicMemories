

local BattleMemories;


local LP = GAMESTATE:GetHumanPlayers()[1]
local BMT = ThemePrefs.Get("BattleMemories")
local LG;
local LIND = 0;

local judType = "";

local Op = TP[ToEnumShortString(LP)].ActiveModifiers.JudgmentGraphic;
judType = LoadModule("Options.JudgmentGetPath.lua")(Op);
local TNSFrames = {
	TapNoteScore_W1 = 0;
	TapNoteScore_W2 = 1;
	TapNoteScore_W3 = 2;
	TapNoteScore_W4 = 3;
	TapNoteScore_W5 = 4;
	TapNoteScore_Miss = 5;
};
local muan = false;

local JudgeCmdsYes = {
	TapNoteScore_W1 = cmd(finishtweening;rotationz,0;shadowlength,0;y,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1.2;addy,-10;decelerate,0.05*2.5;addy,10;zoomy,1;zoom,1;sleep,0.8;decelerate,0.1;zoomy,0.5;zoomx,2;diffusealpha,0;),
	TapNoteScore_W2 = cmd(finishtweening;rotationz,0;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1.15;addy,-7;decelerate,0.05*2.5;addy,7;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;zoomy,0.5;zoomx,2;diffusealpha,0;),
	TapNoteScore_W3 = cmd(finishtweening;rotationz,5;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1.1;addy,-6;decelerate,0.05*2.5;addy,6;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;zoomy,0.5;zoomx,2;diffusealpha,0),
	TapNoteScore_W4 = cmd(finishtweening;rotationz,7;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1;addy,-5;decelerate,0.05*2.5;addy,5;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;zoomy,0.5;zoomx,2;diffusealpha,0;),
	TapNoteScore_W5 = cmd(finishtweening;rotationz,15;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1;addy,-5;decelerate,0.05*2.5;addy,5;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;zoomy,0.5;zoomx,2;diffusealpha,0;),
	TapNoteScore_Miss = cmd(finishtweening;rotationz,25;y,0;shadowlength,0;diffusealpha,1;zoom,1;y,-20;linear,0.8;y,20;sleep,0.5;linear,0.1;zoomy,0.5;zoomx,2;diffusealpha,0)
};
local JudgeCmdsNo = {
	TapNoteScore_W1 = cmd(finishtweening;rotationz,0;shadowlength,0;y,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1.2;addy,-10;decelerate,0.05*2.5;addy,10;zoomy,1;zoom,1;sleep,0.8;decelerate,0.1;zoomy,0.5;zoomx,2;diffusealpha,0;),
	TapNoteScore_W2 = cmd(finishtweening;rotationz,0;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1.15;addy,-7;decelerate,0.05*2.5;addy,7;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;zoomy,0.5;zoomx,2;diffusealpha,0;),
	TapNoteScore_W3 = cmd(finishtweening;rotationz,-5;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1.1;addy,-6;decelerate,0.05*2.5;addy,6;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;zoomy,0.5;zoomx,2;diffusealpha,0),
	TapNoteScore_W4 = cmd(finishtweening;rotationz,-7;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1;addy,-5;decelerate,0.05*2.5;addy,5;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;zoomy,0.5;zoomx,2;diffusealpha,0;),
	TapNoteScore_W5 = cmd(finishtweening;rotationz,-15;y,0;shadowlength,0;diffusealpha,1;zoomx,1;zoomy,1.1;zoom,1;addy,-5;decelerate,0.05*2.5;addy,5;zoomy,1;zoom,1;sleep,0.5;decelerate,0.1;zoomy,0.5;zoomx,2;diffusealpha,0;),
	TapNoteScore_Miss = cmd(finishtweening;rotationz,-25;y,0;shadowlength,0;diffusealpha,1;zoom,1;y,-20;linear,0.8;y,20;sleep,0.5;linear,0.1;zoomy,0.5;zoomx,2;diffusealpha,0;)
};

return Def.ActorFrame{
    Condition = PROFILEMAN:GetProfile(LP):GetDisplayName();
    OnCommand=function(self)
        local ind = 1
        local LIND = 0
        BattleMemories = {
            {1,"TapNoteScore_W1",0.00,"Grade_Tier07"},
            {2,"TapNoteScore_W2",1.00,"Grade_Tier07"},
            {3,"TapNoteScore_W3",7.00,"Grade_Tier06"},
            {4,"TapNoteScore_W4",30.00,"Grade_Tier06"},
            {5,"TapNoteScore_W5",32.00,"Grade_Tier05"},
            {6,"TapNoteScore_Miss",40.00,"Grade_Tier05"},
            {7,"TapNoteScore_W1",42.00,"Grade_Tier05"},
            {8,"TapNoteScore_W2",45.00,"Grade_Tier04"},
            {9,"TapNoteScore_W4",60.00,"Grade_Tier04"},
            {10,"TapNoteScore_W3",78.00,"Grade_Tier03"},
            {11,"TapNoteScore_W1",90.00,"Grade_Tier02"},
            {12,"TapNoteScore_Miss",100.00,"Grade_Tier01"}
        }


        local PathA = tostring(PROFILEMAN:GetProfileDir(LP == PLAYER_1 and "ProfileSlot_Player1" or "ProfileSlot_Player2")).."Memories/BattleMemories/"
        local PathB = (string.gsub( tostring(GAMESTATE:GetCurrentSong():GetSongDir()),"/Songs/","") or "SomeSong/")..tostring(ToEnumShortString(GAMESTATE:GetCurrentSteps(LP):GetStepsType())).."/";

        local PathC;
        if tostring(GAMESTATE:GetCurrentSteps(LP):GetDifficulty()) == "Difficulty_Edit" then
            PathC = tostring(GAMESTATE:GetCurrentSteps(LP):GetHash())..".lua"
        else
            PathC = tostring(ToEnumShortString(GAMESTATE:GetCurrentSteps(LP):GetDifficulty()))..".lua"
        end

        if not FILEMAN:DoesFileExist(PathA..PathB..PathC) then
            return;
        end

        BattleMemories = LoadActor(PathA..PathB..PathC)



        local this = self:GetChildren()
        --this["Testo"]:sleep(0.1):playcommand("Boom",{Testtext= "Hello Param"})
        this["BigScorbi"]:visible(true)
        this["BigJudge"]:visible(true)
        local Is = function(self)

            while ind <= #BattleMemories and GAMESTATE:GetCurMusicSeconds() >= BattleMemories[ind][1] do
                ind = ind +1
            end

            if LIND ~= ind then
                LIND = ind;

                if BattleMemories[ind-1] == nil then
                    return;
                end

                local delta = STATSMAN:GetCurStageStats():GetPlayerStageStats(LP):GetPercentDancePoints()*100 - BattleMemories[ind-1][3]

                if BMT == 2 then
                    this["BigScorbi"]:GetChildren()["Scorbi"]:settextf("%05.2f%%",BattleMemories[ind-1][3]);
                    this["BigScorbi"]:GetChildren()["Scortoke"]:settextf("%05.2f%%",BattleMemories[ind-1][3]);
                else

                    this["BigScorbi"]:GetChildren()["Scorbi"]:settextf("%s%05.2f%%",delta >= 0 and "+" or "-",math.abs(delta));
                    this["BigScorbi"]:GetChildren()["Scortoke"]:settextf("%s%05.2f%%",delta >= 0 and "+" or "-",math.abs(delta));
                end

                
                delta = math.min(math.max(delta,-0.5),0.5)
                local BM_CL;

                if delta >= 0 then
                    BM_CL=ScaleColor(delta,0,0.5,Color.Yellow,Color.Green);
                else
                    BM_CL=ScaleColor(delta,-0.5,0,Color.Red,Color.Yellow)
                end
                --this["BigScorbi"]:GetChildren()["Scorbi"]:strokecolor();
                
                this["BigScorbi"]:GetChildren()["Scortoke"]:textglowmode("TextGlowMode_Stroke");
                this["BigScorbi"]:GetChildren()["Scortoke"]:glowshift():effectclock("beat"):effectcolor1(BM_CL):effectcolor2({1,1,1,0.1}):effectperiod(1);



                
                if LG ~= BattleMemories[ind-1][4] then
                    LG = BattleMemories[ind-1][4]
                    this["BigScorbi"]:GetChildren()["Scorbi"]:diffusebottomedge(GameColor.Grade[LG])
                    this["BigScorbi"]:finishtweening():zoom(0.9):decelerate(0.2):zoom(0.8)
                end


                if BattleMemories[ind-1][2] ~= "nil" and BattleMemories[ind-1][2] ~= "TapNoteScore_AvoidMine" and BattleMemories[ind-1][2] ~= "TapNoteScore_HitMine" then
                    --printf("%s",BattleMemories[ind-1][2])
                    local iNumStates = this["BigJudge"]:GetChildren()["Judge"]:GetNumStates();
                    local iFrame = TNSFrames[BattleMemories[ind-1][2]];

                    if not iFrame then return end
                    if iNumStates == 12 then
                        iFrame = iFrame * 2 + math.random(0,1);
                    end

                    this["BigJudge"]:GetChildren()["Judge"]:visible(true)
                    this["BigJudge"]:GetChildren()["Judge"]:setstate(iFrame)

                    if muan then
                        JudgeCmdsYes[BattleMemories[ind-1][2]](this["BigJudge"]:GetChildren()["Judge"]);
                        muan = false
                    else
                        JudgeCmdsNo[BattleMemories[ind-1][2]](this["BigJudge"]:GetChildren()["Judge"]);
                        muan = true
                    end
                end


            end

        end;
        self:SetUpdateFunction(
             Is
        );

    end;


    Def.ActorFrame{
        Name = "BigScorbi";
        InitCommand=cmd(zoom,0.8;y,25;visible,false;);
        OnCommand=function(self)
            if LP == PLAYER_1 then
                self:x(SCREEN_CENTER_X*2-141.25)
            else
                self:x(SCREEN_CENTER_X-141.25)
            end

        end;
        LoadFont("Combo Numbers")..{
            Name = "Scortoke";
            InitCommand=cmd(settext,"00.00%";zoom,0.4);
        };
        LoadFont("Combo Numbers")..{
            Name = "Scorbi";
            InitCommand=cmd(settext,"00.00%";zoom,0.4);
        };
        
    };


    Def.ActorFrame{
        Name = "BigJudge";
        InitCommand=cmd(zoom,0.4;y,20;visible,false;);
        OnCommand=function(self)
            if LP == PLAYER_1 then
                self:x(SCREEN_CENTER_X*2-250)
            else
                self:x(SCREEN_CENTER_X-250)
            end
            --self:Center()
        end;
        Def.Sprite{                    
            Name="Judge";
            OnCommand=function(self)
            self:pause();
            self:visible(false);
                if string.match(tostring(SCREENMAN:GetTopScreen()),"ScreenEdit") then
                    self:Load(LoadModule("Options.JudgmentGetPath.lua")("Edit 2x6.png"));
                else
                    self:Load(judType);
                end
            end;
            InitCommand=THEME:GetMetric("Judgment","JudgmentOnCommand");
            ResetCommand=cmd(finishtweening;stopeffect;visible,false);
        };
    };

    


    

};



