local startTime,endTime;

local function getBpmData(data)
    local result = {}
    
    for i,v in pairs(data:GetBPMsAndTimes()) do
        local chunk = split("=", v)
        table.insert( result, {data:GetElapsedTimeFromBeat(tonumber(chunk[1])),tonumber(chunk[2])} )
    end

    return result;

end;

local function getOtherData(data)
    local result = {}
    
    for i,v in pairs(data:GetDelays()) do
        local chunk = split("=", v)
        table.insert( result, {
            data:GetElapsedTimeFromBeat(tonumber(chunk[1])),
            Color.Orange} )
    end

    for i,v in pairs(data:GetWarps()) do
        local chunk = split("=", v)
        table.insert( result, {
            data:GetElapsedTimeFromBeat(tonumber(chunk[1])),
            Color.SkyBlue} )
    end

    for i,v in pairs(data:GetScrolls()) do
        local chunk = split("=", v)
        table.insert( result, {
            data:GetElapsedTimeFromBeat(tonumber(chunk[1])),
            Color.SkyBlue} )
    end

    for i,v in pairs(data:GetStops()) do
        local chunk = split("=", v)
        table.insert( result, {
            data:GetElapsedTimeFromBeat(tonumber(chunk[1])),
            Color.Yellow} )
    end

    return result;

end;

local function cmp(lhs,rhs)
    return lhs[1] < rhs[1]
end

return Def.ActorFrame{

    Def.ActorMultiVertex{
        InitCommand=function(self)
            self:xy(14,69);
            self:SetDrawState{Mode="DrawMode_Quads"}
        end;
        CurrentSongChangedMessageCommand=function(self) self:queuecommand("Reload"); end;
        OnCommand=function(self) self:queuecommand("Reload"); end;
        ReloadCommand=function(self)
            startTime = GAMESTATE:GetCurrentSong():GetFirstSecond();
            endTime = GAMESTATE:GetCurrentSong():GetLastSecond();
            local disBpms = GAMESTATE:GetCurrentSong():GetDisplayBpms();
            local avgBpm = (disBpms[1] + disBpms[2]) / 2
            if avgBpm < 5 then
                local tempData = getBpmData(GAMESTATE:GetCurrentSong():GetTimingData());
                local tMin = tempData[1][2];
                local tMax = tempData[1][2];
                for i = 2,#tempData do
                    if tempData[1][2] > tMax then tMax = tempData[1][2]; end
                    if tempData[1][2] < tMin then tMin = tempData[1][2]; end
                end
                avgBpm = (tMax + tMin) / 2;
            end
            local diffColor;
            local factor = 4;
            if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
                diffColor = ScaleColor(0.5,0,1,
                GameColor.Difficulty[(GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty())],
                GameColor.Difficulty[(GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty())])
            elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
                diffColor = GameColor.Difficulty[(GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty())];
            else
                diffColor = GameColor.Difficulty[(GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty())];
            end

            local data = {};
            local Vers = {};

            data = getBpmData(GAMESTATE:GetCurrentSong():GetTimingData());
            for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
                tempData = getBpmData(GAMESTATE:GetCurrentSteps(pn):GetTimingData());
                for i,v in pairs(tempData) do
                    table.insert(data, tempData[i])
                end
            end
            table.sort(data, cmp);

            --printf("%s",TableToString(data));


            local lastTime = data[1][1]
            local lastBPM = data[1][2]

            for i = 2, #data do
                if data[i][2] ~= lastBPM then
                    if data[i][1] > startTime and data[i][1] < endTime then
                        
                        --? Add data
                        local factorBpm = lastBPM / avgBpm;
                        local thisBpmColor;
                        thisBpm = lastBPM;
                        if factorBpm >= factor then
                            thisBpmColor = {1,1,1,1};
                        elseif factorBpm >= 1 then
                            thisBpmColor = ScaleColor(
                                factorBpm, 1, factor, diffColor, {1,1,1,1}
                            )
                        elseif factorBpm >= 1/factor then
                            thisBpmColor = ScaleColor(
                                factorBpm, 1/factor, 1, {0.1,0.1,0.1,1}, diffColor
                            )
                        else
                            thisBpmColor = {0.1,0.1,0.1,1};
                        end
                        

                        local nStart = scale(math.max(startTime, lastTime), startTime, endTime, 0, 826);
                        local nEnd = scale(data[i][1], startTime, endTime, 0, 826);

                        table.insert(Vers,{{nStart,0,0},thisBpmColor})
                        table.insert(Vers,{{nStart,7,0},thisBpmColor})
                        table.insert(Vers,{{nEnd,7,0},thisBpmColor})
                        table.insert(Vers,{{nEnd,0,0},thisBpmColor})

                        lastBPM = data[i][2];
                        lastTime = data[i][1];

                    end
                end
            end

            --? Add Last data
            local factorBpm = lastBPM / avgBpm;
            local thisBpmColor;
            thisBpm = lastBPM;
            if factorBpm >= 4 then
                thisBpmColor = {1,1,1,1};
            elseif factorBpm >= 1 then
                thisBpmColor = ScaleColor(
                    factorBpm, 1, 4, diffColor, {1,1,1,1}
                )
            elseif factorBpm >= 0.25 then
                thisBpmColor = ScaleColor(
                    factorBpm, 0.25, 1, {0,0,0,1}, diffColor
                )
            else
                thisBpmColor = {0,0,0,1};
            end
            

            local nStart = scale(math.max(startTime, lastTime), startTime, endTime, 0, 826);
            local nEnd = 826;

            table.insert(Vers,{{nStart,0,0},thisBpmColor})
            table.insert(Vers,{{nStart,7,0},thisBpmColor})
            table.insert(Vers,{{nEnd,7,0},thisBpmColor})
            table.insert(Vers,{{nEnd,0,0},thisBpmColor})


            
            
            self:SetNumVertices(#Vers):SetVertices( Vers )
        end;
    };

    Def.ActorMultiVertex{
        InitCommand=function(self)
            self:xy(14,69);
            self:SetDrawState{Mode="DrawMode_Quads"}
        end;
        CurrentSongChangedMessageCommand=function(self) self:queuecommand("Reload"); end;
        OnCommand=function(self) self:queuecommand("Reload"); end;
        ReloadCommand=function(self)

            local data = {};
            local Vers = {};

            data = getOtherData(GAMESTATE:GetCurrentSong():GetTimingData());
            for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
                tempData = getOtherData(GAMESTATE:GetCurrentSteps(pn):GetTimingData());
                for i,v in pairs(tempData) do
                    table.insert(data, tempData[i])
                end
            end
            table.sort(data, cmp);

            --printf("%s",TableToString(data));

            for i,v in pairs(data) do  
                if  v[1] >= startTime and v[1] <= endTime then
                    local nStart = scale(v[1], startTime, endTime, 0, 826);
                    table.insert(Vers,{{nStart,0,0},v[2]})
                    table.insert(Vers,{{nStart,7,0},v[2]})
                    table.insert(Vers,{{nStart+1,7,0},v[2]})
                    table.insert(Vers,{{nStart+1,0,0},v[2]})
                end
            end
            
            self:SetNumVertices(#Vers):SetVertices( Vers )
        end;
    };

    Def.Quad{
		OnCommand=function(self) self:diffuse(Color.White); self:x(14); self:horizalign(left); self:vertalign(top); self:y(69); self:zoomy(5.9); self:diffuseshift(); self:effectcolor1({0.6,0.6,0.6,0.7}); self:effectcolor2({1,1,1,1}); self:effectperiod(2); self:effectclock("beat"); self:queuecommand("Nep"); end;
		CurrentSongChangedMessageCommand=function(self) self:queuecommand("Nep"); end;
		NepCommand=function(self)
		self:diffuse(Color.White)
		self:diffusealpha(0.45)
		self:playcommand("PRO")
		end;
		PROCommand=function(self)
            local sec = clamp(GAMESTATE:GetCurMusicSeconds(), startTime, endTime)
            self:zoomx(scale(sec,startTime, endTime, 0,826))
            self:sleep(1/30):queuecommand("PRO")
		end;
		GETOUTOFGAMESMMessageCommand=function(self) self:finishtweening(); self:accelerate(1); self:zoomx(0); end;
	};
    Def.Quad{
		OnCommand=function(self) self:diffuse(Color.White); self:x(14); self:horizalign(left); self:vertalign(top); self:y(69); self:zoomy(5.9); self:zoomx(-3); self:diffuseshift(); self:effectcolor1({0,0,0,0.7}); self:effectcolor2({1,1,1,1}); self:effectperiod(2); self:effectclock("beat"); self:queuecommand("Nep"); end;
		CurrentSongChangedMessageCommand=function(self) self:queuecommand("Nep"); end;
		NepCommand=function(self)
		self:diffuse(Color.White)
		self:diffusealpha(0.45)
		self:playcommand("PRO")
		end;
		PROCommand=function(self)
            local sec = clamp(GAMESTATE:GetCurMusicSeconds(), startTime, endTime)
            self:x(scale(sec,startTime, endTime, 14,14+826))
            self:sleep(1/30):queuecommand("PRO")
		end;
		GETOUTOFGAMESMMessageCommand=function(self) self:finishtweening(); self:accelerate(1); self:zoomx(0); end;
	};
    -- Def.Quad{
    --     InitCommand=function(self) self:x(14); self:y(69); self:zoomy(7); self:zoomx(826); self:vertalign(top); self:horizalign(left); self:rainbow(); end;
    -- };
};