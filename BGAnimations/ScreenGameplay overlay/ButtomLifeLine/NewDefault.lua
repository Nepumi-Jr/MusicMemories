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

local AutoGenSource = {}

AutoGenSource["dance-single"] = {"dance-double","pump-single"};

AutoGenSource["dance-solo"] = {"dance-single","pump-single"};

AutoGenSource["pump-single"] = {"pump-double","dance-single"};


local function regexEncode(var)
	return (var:gsub('%%', '%%%'):gsub('%^', '%%^'):gsub('%$', '%%$'):gsub('%(', '%%('):gsub('%)', '%%)'):gsub('%.', '%%.'):gsub('%[', '%%['):gsub('%]', '%%]'):gsub('%*', '%%*'):gsub('%+', '%%+'):gsub('%-', '%%-'):gsub('%?', '%%?'))
end


local function OPFil()
    --GET INFORMATION
    local files = FILEMAN:GetDirListing(GAMESTATE:GetCurrentSong():GetSongDir())
    local STUFF;
        
        for file in ivalues(files) do
            
            if file:find(".+%.[sS][sS][cC]$") then
                -- Finding a .ssc file is preferable.
                -- If we find one, stop looking.
                fileN = file
                fileT = "ssc"
                break
            elseif file:find(".+%.[sS][mM]$") then
                -- Don't break if we find a .sm file first;
                -- there might still be a .ssc file waiting.
                fileN = file
                fileT = "sm"
            elseif file:find(".+%.[dD][wW][iI]$") then
                fileN = file
                fileT = "dwi"
            end
        end
        if (not (fileN and fileT)) then return nil 
        else return {fileN,fileT} end
    end

local function GetCh(x)

    if x == nil then return nil; end
    
    

    local fileN=x[1];
    local fileT=x[2];
    local MSP = {"",""};
    
    -- create a generic RageFile that we'll use to read the contents
    -- of the desired .ssc or .sm file
    local f = RageFileUtil.CreateRageFile()

    -- the second argument here (the 1) signifies
    -- that we are opening the file in read-only mode
    if f:Open(GAMESTATE:GetCurrentSong():GetSongDir() .. fileN, 1) then
        STUFF = f:Read()
    end

    -- destroy the generic RageFile now that we have the contents
    f:destroy()

    --
    
    for i = nsP,msP do--Get from EVERY PLAYER!
        local step = GAMESTATE:GetCurrentSteps(_G['PLAYER_'..i]);
        local stepkwa = ToEnumShortString( step:GetStepsType() ):gsub("_", "-"):lower()
        local dif = ToEnumShortString( step:GetDifficulty() )
        local des = step:GetDescription()
        --GET STRING NOW
            if fileT == "ssc" then
                -- SSC File
                -- Loop through each chart in the SSC file
                for chart in STUFF:gmatch("#NOTEDATA.-#NOTES:[^;]*") do
                    -- Find the chart that matches our difficulty and game type
                    local DLC=true;
                    if dif == "Edit" then
                        DLC = (chart:match("#DESCRIPTION:"..regexEncode(des)))
                    end
                    
                    if(chart:match("#STEPSTYPE:"..regexEncode(stepkwa)) and chart:match("#DIFFICULTY:"..regexEncode(dif)) and DLC) then
                        --Find just the notes and remove comments
                        MSP[i] = chart:match("#NOTES:[\r\n]+([^;]*)\n?$"):gsub("//[^\r\n]*","") .. ";"						
                    end
                end
                
                local AI = 1;
                while MSP[i] == "" and AutoGenSource[stepkwa] and AI <= #AutoGenSource[stepkwa] do--Cycle until it find
                
                    for chart in STUFF:gmatch("#NOTEDATA.-#NOTES:[^;]*") do
                        -- Find the chart that matches our difficulty and game type
                        local DLC=true;
                        if dif == "Edit" then
                            DLC = (chart:match("#DESCRIPTION:"..regexEncode(des)))
                        end
                        
                        if(chart:match("#STEPSTYPE:"..regexEncode(AutoGenSource[stepkwa][AI])) and chart:match("#DIFFICULTY:"..regexEncode(dif)) and DLC) then
                            MSP[i] = chart:match("#NOTES:[\r\n]+([^;]*)\n?$"):gsub("//[^\r\n]*","") .. ";"
                        end

                    end
                    AI = AI + 1
            
                end

                
                
            elseif fileT == "sm" then
                -- SM FILE
                -- Loop through each chart in the SM file


                for chart in STUFF:gmatch("#NOTES[^;]*") do
                    -- split the entire chart string into pieces on ":"
                    local pieces = {}
                    for str in chart:gmatch("[^:]+") do
                        pieces[#pieces+1] = str
                    end

                    -- the pieces table should contain 7 numerically indexed items
                    -- 2, 4, and 7 are the indices we care about for finding the correct chart
                    -- index 2 will contain the steps_type (like "dance-single")
                    -- index 4 will contain the difficulty (like "challenge")

                    -- use gsub to scrub out line breaks (and other irrelevant characters?)
                    local st = pieces[2]:gsub("[^%w-]", "")
                    local diff = pieces[4]:gsub("[^%w]", "")
                    local DLC=true;
                    
                    if dif == "Edit" then
                        
                        DLC = ((pieces[3]:gsub("[^%w]", ""))==des:gsub("[^%w]", ""))
                    end
                    
                    -- if this particular chart's steps_type matches the desired StepsType
                    -- and its difficulty string matches the desired Difficulty

                    if (st == stepkwa) and (diff == dif) and DLC then
                        
                        -- then index 7 contains the notedata that we're looking for
                        -- use gsub to remove comments, store the resulting string,
                        -- and break out of the chart loop now
                        MSP[i] = pieces[7]:gsub("//[^\r\n]*","") .. ";"
                        break
                    end
                end



                local AI = 1;
                
                while MSP[i] == "" and AutoGenSource[stepkwa] and AI <= #AutoGenSource[stepkwa] do--Cycle until it find

                    for chart in STUFF:gmatch("#NOTES[^;]*") do
                        -- split the entire chart string into pieces on ":"
                        local pieces = {}
                        for str in chart:gmatch("[^:]+") do
                            pieces[#pieces+1] = str
                        end

                        -- the pieces table should contain 7 numerically indexed items
                        -- 2, 4, and 7 are the indices we care about for finding the correct chart
                        -- index 2 will contain the steps_type (like "dance-single")
                        -- index 4 will contain the difficulty (like "challenge")

                        -- use gsub to scrub out line breaks (and other irrelevant characters?)
                        local st = pieces[2]:gsub("[^%w-]", "")
                        local diff = pieces[4]:gsub("[^%w]", "")
                        local DLC=true;
                        if dif == "Edit" then
                            DLC = ((pieces[3]:gsub("[^%w]", ""))==des)
                        end
                        
                        -- if this particular chart's steps_type matches the desired StepsType
                        -- and its difficulty string matches the desired Difficulty
                        if (st == AutoGenSource[stepkwa][AI]) and (diff == dif) and DLC then
                            -- then index 7 contains the notedata that we're looking for
                            -- use gsub to remove comments, store the resulting string,
                            -- and break out of the chart loop now
                            MSP[i] = pieces[7]:gsub("//[^\r\n]*","") .. ";"
                            break
                        end
                    end
                    
                    AI = AI +1

                end
            elseif fileT == "dwi" then
                
                -- for chart in STUFF:gmatch("#NOTES[^;]*") do
                -- end
                --Meow
                
                


            end
    end
    return MSP
end



local PointPerQSec = {};

local N_Tile = 1;
local BreakTime = {};
local SCS = false;
local BTI = 1

local ALL_Score = {};


local t = Def.ActorFrame{

    OnCommand=cmd(queuecommand,"Reloading");
    CurrentSongChangedMessageCommand=cmd(queuecommand,"Reloading");
    ReloadingCommand=function(self)

        self:stoptweening();
        PointPerQSec = {};
        BreakTime = {};
        local CRT= 0;

        All_Chart = GetCh(OPFil());


        local DEB = "DEBUG GOES BRR\n"
        local MaxSegment = 1;
        
        for p = nsP,msP do
            
            local TD = GAMESTATE:GetCurrentSteps(_G['PLAYER_'..p]):GetTimingData();
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

            for e in string.gmatch( All_Chart[p],"[^,^;]+") do
                local Tick = string.gmatch( e,"[^\n^;]+")

                local nTick = 0;
                for f in Tick do if string.len(f) > 1 then nTick = nTick + 1 ; end end
                --DEB = DEB..string.format( "Mes %d has %d\n",CRT,nTick)
                local NowBeat = BeatMes;
                for f in string.gmatch( e,"[^\n^;]+") do
                    local Now_Score = 0;
                    --1 is NOTE
                    --2 is OpenHold
                    --3 is EndedHold/Roll
                    --4 is OpenRoll
                    --L is Lift
                    --F is Fake
                    --M is Mine
                    for i = 1,string.len(f) do
                        if string.sub(f,i,i) == "1" or
                        string.sub(f,i,i) == "2" or
                        string.sub(f,i,i) == "4" then
                            

                            Now_Score = Now_Score + 1 + (0.7*nHold) + (1.5*nRoll)

                            if string.sub(f,i,i) == "2" then
                                SegmentHoldAndRoll[i] = "H";
                                nHold = nHold + 1;
                            end
                            if string.sub(f,i,i) == "4" then
                                SegmentHoldAndRoll[i] = "R";
                                nRoll = nRoll + 1;
                            end
                        end

                        if string.sub(f,i,i) == "3" then
                            if SegmentHoldAndRoll[i] == "H" then
                                nHold = nHold - 1;
                                SegmentHoldAndRoll[i] = "-"
                            elseif SegmentHoldAndRoll[i] == "R" then
                                nRoll = nRoll - 1;
                                SegmentHoldAndRoll[i] = "-"
                            end
                        
                            
                            
                        end

                        if string.sub(f,i,i) == "M" then
                            Now_Score = Now_Score + 0.5
                        end
                        if string.sub(f,i,i) == "F" then
                            Now_Score = Now_Score + 0.1
                        end
                        if string.sub(f,i,i) == "L" then
                            Now_Score = Now_Score + 1.5
                        end
                        
                        if (string.sub(f,i,i) == "1" or 
                        string.sub(f,i,i) == "2" or
                        string.sub(f,i,i) == "3" or
                        string.sub(f,i,i) == "4" or
                        string.sub(f,i,i) == "M" or
                        string.sub(f,i,i) == "F" or
                        string.sub(f,i,i) == "L") then
                            lastnote = math.max(lastnote,B2S(NowBeat))
                            

                                if math.abs(B2S(NowBeat) - LN) >= 4 and nHold == 0 and nRoll == 0 then
                                    --printf("Added!")
                                    BreakTime[p][#BreakTime[p]+1] = {LN,B2S(NowBeat)-2};
                                end
                                LN = B2S(NowBeat)



                        end


                    end

                    --Cal Score HERE
                    
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
                    
                    NowBeat = NowBeat + 4/nTick
                end
                BeatMes = BeatMes + 4;
                CRT = CRT +1;
            end
            --SM("\n\n\n\n\n\n".."MAX is "..MaxSegment)
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
        else
            lastnote = math.min(lastnote,GAMESTATE:GetCurrentSong():GetLastSecond())
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
            
            --SM("\n\n\n\n"..tostring(CurStageAward(PLAYER_1)))

            if CurSec >= lastnote and not GAMESTATE:IsCourseMode() and not BOOMStage then
                local SA = false;
                for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
                    if CurStageAward(pn) ~= "Nope" then
                        SA = true;
                        break
                    end
                end
                
                BOOMStage = true;
                --SM("\n\n\n\n\n\n\nBOOOOOOOOOOOOM")
                if SA then

                    local BE = 6;
                    for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
                        if  string.match( CurStageAward(pn),"W1") then
                            BE = math.min(BE,1);
                        elseif  string.match( CurStageAward(pn),"W2") then
                            BE = math.min(BE,2);
                        elseif  string.match( CurStageAward(pn),"W3") then
                            BE = math.min(BE,3);
                        elseif  string.match( CurStageAward(pn),"Choke") then
                            BE = math.min(BE,4);
                        elseif  string.match( CurStageAward(pn),"NoMiss") then
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
    InitCommand=cmd(vertalign,top;CenterX;zoomx,SCREEN_RIGHT;zoomy,75;diffuse,{0,0,0,1};fadebottom,1);
    OnCommand=cmd(y,-75)
};
t[#t+1] = Def.Quad{
    Name = "CS_Bot";
    InitCommand=cmd(vertalign,bottom;y,SCREEN_BOTTOM;zoomx,SCREEN_RIGHT;CenterX;zoomy,75;diffuse,{0,0,0,1};fadetop,1);
    OnCommand=cmd(y,SCREEN_BOTTOM+75)
};

t[#t+1] = Def.ActorMultiVertex{
    Name = "VertexLife";
    InitCommand=function(self)
        self:SetDrawState{Mode="DrawMode_Triangles"}:SetVertices(verts)
    end;
};


return t;