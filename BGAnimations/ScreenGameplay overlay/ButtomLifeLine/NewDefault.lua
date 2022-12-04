local TS;

local MaxBorder = SCREEN_RIGHT;
local lastnote = -99999;
local BOOMStage = false;


if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
    TS = "PA"
elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
    TS = "P1"
elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
    TS = "P2"
end

local nsP,msP = 1,2; 
if TS == "P1" then msP = 1 elseif TS == "P2" then nsP = 2 end

local MaxAutoGenPi = 1;





local PointPerQSec = {};

local N_Tile = 1;
local BreakTime = {};
local SCS = false;
local BTI = 1

local ALL_Score = {};

local function compareNoteData(lhs,rhs)--? Sort with time and note element
    if lhs[1] == rhs[1] then--?if same time, Hold and roll will be first priority
        local ll = 0;
        if FindInTable(lhs[3], {"TapNoteSubType_Hold","TapNoteSubType_Roll"}) then
            ll = 1;
        elseif FindInTable(lhs[3], {"TapNoteType_Tap", "TapNoteType_Mine","TapNoteType_Fake","TapNoteType_Lift"}) then
            ll = 2;
        else
            ll = 3;
        end

        local rr = 0;
        if FindInTable(rhs[3], {"TapNoteSubType_Hold","TapNoteSubType_Roll"}) then
            rr = 1;
        elseif FindInTable(rhs[3], {"TapNoteType_Tap", "TapNoteType_Mine","TapNoteType_Fake","TapNoteType_Lift"}) then
            rr = 2;
        else
            rr = 3;
        end
        return ll < rr
    else
        return lhs[1] < rhs[1]
    end
end


local t = Def.ActorFrame{

    OnCommand=function(self) self:queuecommand("Reloading"); end;
    CurrentSongChangedMessageCommand=function(self) self:queuecommand("Reloading"); end;
    ReloadingCommand=function(self)

        self:stoptweening();
        PointPerQSec = {};
        BreakTime = {};
        local CRT= 0;


        local DEB = "DEBUG GOES BRR\n"
        local MaxSegment = 1;
        
        for p = nsP,msP do
            
            local thisSteps = GAMESTATE:GetCurrentSteps(_G['PLAYER_'..p]);
            local TD = thisSteps:GetTimingData();
            BreakTime[p] = {};
            local LN = -200;


            local function B2S(x)
                return TD:GetElapsedTimeFromBeat(x)
            end

            local Warps = TD:GetWarps();
            Warps[#Warps+1] = "9999999999 = 1";
            local nHold = 0;
            local nRoll = 0;
            local nWarp = 1;
            local SegmentHoldAndRoll = {};
            local BeatMes= 0;

            

            for k,v in pairs( GAMESTATE:GetCurrentSong():GetAllSteps() ) do
                if v == thisSteps then noteData = GAMESTATE:GetCurrentSong():GetNoteData(k, 0, GAMESTATE:GetCurrentSong():GetLastBeat()) break end
                --GAMESTATE:GetCurrentSong():GetLastSecond()
            end

            
            table.sort(noteData, compareNoteData);
            --printf("%s",TableToString(noteData))


            for k,v in pairs(noteData) do
                --? {time, col, NoteType}
                local NowBeat = v[1];
                local thisCol = v[2];
                local thisNoteType = v[3];
                local Now_Score = 0

                if thisNoteType == "TapNoteType_Tap" or 
                    thisNoteType == "TapNoteSubType_Hold" or 
                    thisNoteType == "TapNoteSubType_Roll" then
                        Now_Score = 1 + (0.7*nHold) + (1.5*nRoll)

                        if thisNoteType == "TapNoteSubType_Hold" then
                            
                            --nHold = nHold + 1;
                            SegmentHoldAndRoll[thisCol] = 'H';
                        end
                        if thisNoteType == "TapNoteSubType_Roll" then
                            --nRoll = nRoll + 1;
                            SegmentHoldAndRoll[thisCol] = 'R';
                        end

                end

                
                if thisNoteType == "TapNoteType_HoldTail" then
                    --TODO: HoldTail
                    --! TapNoteType_HoldTail never found in noteData :|
                    --! or incorrect lua documentation?
                    printf("TapNoteType_HoldTail FOUNDED\nplease change the code to support this");
                    if SegmentHoldAndRoll[thisCol] == "H" then
                        
                        --nHold = nHold - 1;
                        SegmentHoldAndRoll[thisCol] = "-"
                    elseif SegmentHoldAndRoll[thisCol] == "R" then
                        --nRoll = nRoll - 1;
                        SegmentHoldAndRoll[thisCol] = "-"
                    end
                end

                if thisNoteType == "TapNoteType_Mine" then
                    Now_Score = Now_Score + 0.5
                end
                if thisNoteType == "TapNoteType_Fake" then
                    Now_Score = Now_Score + 0.1
                end
                if thisNoteType == "TapNoteType_Lift" then
                    Now_Score = Now_Score + 1.5
                end
                
                if FindInTable(thisNoteType, {"TapNoteType_Tap", "TapNoteSubType_Hold","TapNoteSubType_Roll","TapNoteType_Mine","TapNoteType_Fake","TapNoteType_Lift", "TapNoteType_HoldTail"}) then
                    lastnote = math.max(lastnote,B2S(NowBeat + 4))
                    
                    if math.abs(B2S(NowBeat) - LN) >= 4 and nHold == 0 and nRoll == 0 then
                        BreakTime[p][#BreakTime[p]+1] = {LN,B2S(NowBeat)-2};
                    end
                    LN = B2S(NowBeat)
                end

                local WarpContent = split("=", Warps[nWarp])

                while NowBeat > tonumber(WarpContent[1]+WarpContent[2]) do
                    nWarp = nWarp +1;
                    WarpContent = split("=", Warps[nWarp])
                end


                if NowBeat > tonumber(WarpContent[1]) then
                    Now_Score = Now_Score *0.01;
                end

                PointPerQSec[math.floor(B2S(NowBeat)*4)] = 
                (PointPerQSec[math.floor(B2S(NowBeat)*4)] or 0) + Now_Score;

            end
            --printf(">>>> Final n hold :| %d",nHold)
        end

        

        if msP - nsP >= 1 then
            local Real_BreakTime = {}
            local i,j = 1,1   
            local si,sj = 1,1
            local SC = 0
            local LLN= 0

            while i <= #BreakTime[1] and j <= #BreakTime[2] do

                if BreakTime[1][i][si] < BreakTime[2][j][sj] then
                    if si == 1 then
                        SC = SC + 1
                        if SC == 2 then
                            LLN = BreakTime[1][i][si];
                        end
                        si =2
                    else
                        if SC == 2 then
                            Real_BreakTime[#Real_BreakTime+1] = {LLN,BreakTime[1][i][si]}
                        end
                        SC = SC - 1
                        si = 1;
                        i = i + 1;
                    end
                else
                    if sj == 1 then
                        SC = SC + 1
                        if SC == 2 then
                            LLN = BreakTime[2][j][sj];
                        end
                        sj =2
                    else
                        if SC == 2 then
                            Real_BreakTime[#Real_BreakTime+1] = {LLN,BreakTime[2][j][sj]}
                        end
                        SC = SC - 1
                        sj = 1;
                        j = j + 1
                    end
                end
            end
            BreakTime = Real_BreakTime;

        else
            BreakTime = BreakTime[msP]
        end


        MaxSegment = math.ceil(GAMESTATE:GetCurrentSong():GetLastSecond()*4);

        local middle = 0;
        for i = 1,MaxSegment do
            if PointPerQSec[i] == nil then PointPerQSec[i] = 0 end

            middle =middle + PointPerQSec[i] / MaxSegment;


        end

        local DIV = math.ceil( MaxSegment/MaxBorder );
        local Scaling =  MaxBorder/(MaxSegment/DIV);


        local this = self:GetChildren()
        
        Vers = {};
        local PP = 3;

        for i = 1,MaxSegment/DIV do

            local now_score = 0;

            for j = 0,(DIV-1) do
                now_score = now_score + PointPerQSec[(i-1)*DIV+1+j] / DIV;
            end

            ALL_Score[i] = now_score;

            


            local Starting = GAMESTATE:GetCurrentSong():GetFirstSecond()
            if (i-1)*0.25*DIV <= Starting then

                table.insert(Vers,{{Scaling*(i-2),SCREEN_BOTTOM-PP,0},
                ColorDarkTone(Color.Orange)
                })
                table.insert(Vers,{{Scaling*(i-1)-Scaling*0.5,SCREEN_BOTTOM,0},
                ColorDarkTone(Color.Orange)
                })
                table.insert(Vers,{{Scaling*(i-1),SCREEN_BOTTOM-(math.max(math.min(scale(now_score,0,((middle*2)==0 and 0.01 or middle*2),3,10),10),3)),0},
                ColorDarkTone(Color.Orange)
                })

                
                table.insert(Vers,{{Scaling*(i-1)-Scaling*0.5,SCREEN_BOTTOM,0},
                ColorDarkTone(Color.Orange)
                })
                table.insert(Vers,{{Scaling*(i-1),SCREEN_BOTTOM-(math.max(math.min(scale(now_score,0,((middle*2)==0 and 0.01 or middle*2),3,10),10),3)),0},
                ColorDarkTone(Color.Orange)
                })
                table.insert(Vers,{{Scaling*(i-1)+Scaling*0.5,SCREEN_BOTTOM,0},
                ColorDarkTone(Color.Orange)
                })

            else

                table.insert(Vers,{{Scaling*(i-2),SCREEN_BOTTOM-PP,0},
                {1,1,1,0.5}
                })
                table.insert(Vers,{{Scaling*(i-1)-Scaling*0.5,SCREEN_BOTTOM,0},
                {1,1,1,0.5}
                })
                table.insert(Vers,{{Scaling*(i-1),SCREEN_BOTTOM-(math.max(math.min(scale(now_score,0,((middle*2)==0 and 0.01 or middle*2),3,10),10),3)),0},
                {1,1,1,0.5}
                })


                table.insert(Vers,{{Scaling*(i-1)-Scaling*0.5,SCREEN_BOTTOM,0},
                {1,1,1,0.5}
                })
                table.insert(Vers,{{Scaling*(i-1),SCREEN_BOTTOM-(math.max(math.min(scale(now_score,0,((middle*2)==0 and 0.01 or middle*2),3,10),10),3)),0},
                {1,1,1,0.5}
                })
                table.insert(Vers,{{Scaling*(i-1)+Scaling*0.5,SCREEN_BOTTOM,0},
                {1,1,1,0.5}
                })
            end

            
            PP = (math.max(math.min(scale(now_score,0,((middle*2)==0 and 0.01 or middle*2),3,10),10),3))

            

        end
        this["VertexLife"]:SetNumVertices(#Vers):SetVertices( Vers )
        N_Tile = 1;

        if lastnote == -99999 then
            lastnote = GAMESTATE:GetCurrentSong():GetLastSecond()
        end
        
        
        local xt = function(self)
            CurSec = GAMESTATE:GetCurMusicSeconds()
            local Starting = GAMESTATE:GetCurrentSong():GetFirstSecond()
            
            while CurSec >= N_Tile*0.25*DIV and N_Tile <= MaxBorder do
                
                if CurSec <= Starting then


                    this["VertexLife"]:SetVertex((N_Tile-1)*6+1,
                    {{Scaling*(N_Tile-2),SCREEN_BOTTOM-(math.max(math.min(scale(ALL_Score[N_Tile-1] or 0,0,((middle*2)==0 and 0.01 or middle*2),3,10),10),3)),0},
                    Color.Orange
                    })
                    this["VertexLife"]:SetVertex((N_Tile-1)*6+2,
                    {{Scaling*(N_Tile-1)-Scaling*0.5,SCREEN_BOTTOM,0},
                    Color.Orange
                    })
                    this["VertexLife"]:SetVertex((N_Tile-1)*6+3,
                    {{Scaling*(N_Tile-1),SCREEN_BOTTOM-(math.max(math.min(scale(ALL_Score[N_Tile],0,((middle*2)==0 and 0.01 or middle*2),3,10),10),3)),0},
                    Color.Orange
                    })

                    this["VertexLife"]:SetVertex((N_Tile-1)*6+4,
                    {{Scaling*(N_Tile-1)-Scaling*0.5,SCREEN_BOTTOM,0},
                    Color.Orange
                    })
                    this["VertexLife"]:SetVertex((N_Tile-1)*6+5,
                    {{Scaling*(N_Tile-1),SCREEN_BOTTOM-(math.max(math.min(scale(ALL_Score[N_Tile],0,((middle*2)==0 and 0.01 or middle*2),3,10),10),3)),0},
                    Color.Orange
                    })
                    this["VertexLife"]:SetVertex((N_Tile-1)*6+6,
                    {{Scaling*(N_Tile-1)+Scaling*0.5,SCREEN_BOTTOM,0},
                    Color.Orange
                    })

                else

                    --HP Go BRR

                    local GL = 0;
                    for p = nsP,msP do
                        GL = GL + SCREENMAN:GetTopScreen():GetLifeMeter(_G['PLAYER_'..p]):GetLife()/(msP-nsP+1);
                    end
                    
                    local CCL = {1,1,1,1}
                    
                    if GL >= 2/3 then
                        CCL = ScaleColor(GL,2/3,1,Color.Green or {0,1,0,1},Color.SkyBlue or {0.5,0.5,1,1})
                    elseif GL >= 1/3 then
                        CCL = ScaleColor(GL,1/3,2/3,Color.Yellow or {1,1,0,1},Color.Green or {0,1,0,1})
                    else
                        CCL = ScaleColor(GL,0,1/3,Color.Red or {1,0,0,1},Color.Yellow or {1,1,0,1})
                    end

                    this["VertexLife"]:SetVertex((N_Tile-1)*6+1,
                    {{Scaling*(N_Tile-2),SCREEN_BOTTOM-(math.max(math.min(scale(ALL_Score[N_Tile-1] or 0,0,((middle*2)==0 and 0.01 or middle*2),3,10),10),3)),0},
                    CCL
                    })
                    this["VertexLife"]:SetVertex((N_Tile-1)*6+2,
                    {{Scaling*(N_Tile-1)-Scaling*0.5,SCREEN_BOTTOM,0},
                    CCL
                    })
                    this["VertexLife"]:SetVertex((N_Tile-1)*6+3,
                    {{Scaling*(N_Tile-1),SCREEN_BOTTOM-(math.max(math.min(scale(ALL_Score[N_Tile] or 0,0,((middle*2)==0 and 0.01 or middle*2),3,10),10),3)),0},
                    CCL
                    })



                    this["VertexLife"]:SetVertex((N_Tile-1)*6+4,
                    {{Scaling*(N_Tile-1)-Scaling*0.5,SCREEN_BOTTOM,0},
                    CCL
                    })
                    this["VertexLife"]:SetVertex((N_Tile-1)*6+5,
                    {{Scaling*(N_Tile-1),SCREEN_BOTTOM-(math.max(math.min(scale(ALL_Score[N_Tile] or 0,0,((middle*2)==0 and 0.01 or middle*2),3,10),10),3)),0},
                    CCL
                    })
                    this["VertexLife"]:SetVertex((N_Tile-1)*6+6,
                    {{Scaling*(N_Tile-1)+Scaling*0.5,SCREEN_BOTTOM,0},
                    CCL
                    })

                end

                N_Tile = N_Tile +1;

            end
            
            --SM("\n\n\n\n"..tostring(LoadModule("Eva.CustomStageAward.lua")(PLAYER_1)))
            --printf(">>>? Last note %d", lastnote)
            if CurSec >= lastnote and not GAMESTATE:IsCourseMode() and not BOOMStage then
                local SA = false;
                for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
                    if LoadModule("Eva.CustomStageAward.lua")(pn) ~= "Nope" then
                        SA = true;
                        break
                    end
                end
                
                BOOMStage = true;
                --SM("\n\n\n\n\n\n\nBOOOOOOOOOOOOM")
                if SA then

                    local BE = 6;
                    for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
                        if  string.match( LoadModule("Eva.CustomStageAward.lua")(pn),"W1") then
                            BE = math.min(BE,1);
                        elseif  string.match( LoadModule("Eva.CustomStageAward.lua")(pn),"W2") then
                            BE = math.min(BE,2);
                        elseif  string.match( LoadModule("Eva.CustomStageAward.lua")(pn),"W3") then
                            BE = math.min(BE,3);
                        elseif  string.match( LoadModule("Eva.CustomStageAward.lua")(pn),"Choke") then
                            BE = math.min(BE,4);
                        elseif  string.match( LoadModule("Eva.CustomStageAward.lua")(pn),"NoMiss") then
                            BE = math.min(BE,5);
                        end
                    end
                    
                    if BE <= 5 then
                        SOUND:PlayOnce(THEME:GetPathS("Fc","W"..tostring(BE)) );
                    end

                    
                    MESSAGEMAN:Broadcast("FcStage")
                end
            end

            --printf("BT : %s",TableToString(BreakTime))
            if BTI <= #BreakTime then
                if CurSec >= BreakTime[BTI][1] and not SCS then
                    SCS = true;
                    this["CS_Top"]:stoptweening():decelerate(0.5):y(0)
                    this["CS_Bot"]:stoptweening():decelerate(0.5):y(SCREEN_BOTTOM)
                end
    
                if CurSec >= BreakTime[BTI][2] and SCS then
                    SCS = false;
                    this["CS_Top"]:stoptweening():decelerate(0.5):y(-75)
                    this["CS_Bot"]:stoptweening():decelerate(0.5):y(SCREEN_BOTTOM+75)
                    BTI = BTI + 1
                end
            end

            
            
    end;
        self:SetUpdateFunction(
            xt
        );

    end;


};

t[#t+1] = Def.Quad{
    Name = "CS_Top";
    InitCommand=function(self) self:vertalign(top); self:CenterX(); self:zoomx(SCREEN_RIGHT); self:zoomy(75); self:diffuse({0,0,0,1}); self:fadebottom(1); end;
    OnCommand=function(self) self:y(-75); end
};
t[#t+1] = Def.Quad{
    Name = "CS_Bot";
    InitCommand=function(self) self:vertalign(bottom); self:y(SCREEN_BOTTOM); self:zoomx(SCREEN_RIGHT); self:CenterX(); self:zoomy(75); self:diffuse({0,0,0,1}); self:fadetop(1); end;
    OnCommand=function(self) self:y(SCREEN_BOTTOM+75); end
};

t[#t+1] = Def.ActorMultiVertex{
    Name = "VertexLife";
    InitCommand=function(self)
        self:SetDrawState{Mode="DrawMode_Triangles"}:SetVertices(verts)
    end;
};


return t;