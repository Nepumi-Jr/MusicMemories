local t = LoadFallbackB();
local num_players = GAMESTATE:GetHumanPlayers();

local NOTE = {};
for i=1,#num_players do
	NOTE[#NOTE+1] = "";
end

local song_bpms= {}

-- Courses don't have GetDisplayBpms.
if GAMESTATE:GetCurrentSong() then
	song_bpms= GAMESTATE:GetCurrentSong():GetDisplayBpms()
	song_bpms[1]= math.round(song_bpms[1])
	song_bpms[2]= math.round(song_bpms[2])
end


local game_name = GAMESTATE:GetCurrentGame():GetName()


local P2I={
	P1=1,
	P2=2
};
local PSpeed={{300,300},{300,300}}

local JudgeAnimation = {};
local columnName = GAMESTATE:GetCurrentStyle():GetColumnInfo( GAMESTATE:GetMasterPlayerNumber(), 1 )["Name"]
if GAMESTATE:GetCurrentStyle():ColumnsPerPlayer() > 2 then
    columnName = GAMESTATE:GetCurrentStyle():GetColumnInfo(
                            GAMESTATE:GetMasterPlayerNumber(), 2)["Name"];
end


t[#t+1] = Def.Quad{
    InitCommand=function(self) self:visible(false); end;
    NoteChangedMessage=function(self,param)
        NOTE[param.Player+1]=param.Noto;
    end;
};

--edit from Outfox
-- Load all noteskins for the previewer.
local icol = 2
if GAMESTATE:GetCurrentStyle():ColumnsPerPlayer() < 2 then
	icol = 1
end
local column = GAMESTATE:GetCurrentStyle():GetColumnInfo( GAMESTATE:GetMasterPlayerNumber(), icol )
for _,v in pairs(NOTESKIN:GetNoteSkinNames()) do
    local note = NOTESKIN:LoadActorForNoteSkin( column["Name"] , "Tap Note", v )
    local recep = NOTESKIN:LoadActorForNoteSkin( column["Name"] , "Receptor", v )

    if note and recep then
        t[#t+1] = note..{
            Name="NSNote"..string.lower(v), InitCommand=function(s) s:visible(false) end,
            OnCommand=function(s) s:diffusealpha(0):sleep(0.2):linear(0.2):diffusealpha(1) end,
            OffCommand=function(s) s:linear(0.2):diffusealpha(0) end
        }
        t[#t+1] = recep..{
            Name="NSRec"..string.lower(v), InitCommand=function(s) s:visible(false) end,
            OnCommand=function(s) s:diffusealpha(0):sleep(0.2):linear(0.2):diffusealpha(1) end,
            OffCommand=function(s) s:linear(0.2):diffusealpha(0) end
        }
    else
        lua.ReportScriptError(string.format("The noteskin %s failed to load.", v))
        t[#t+1] = Def.Actor{ Name="NSNote"..string.lower(v) }
        t[#t+1] = Def.Actor{ Name="NSRec"..string.lower(v) }
    end
end



for i=1,#num_players do
	local metrics_name = "PlayerNameplate" .. ToEnumShortString(num_players[i])
	t[#t+1] = LoadActor( THEME:GetPathG(Var "LoadingScreen", "PlayerNameplate"), num_players[i] ) .. {
		InitCommand=function(self)
			self:name(metrics_name);
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen");
		end
	};
    t[#t+1] = Def.ActorFrame{
        InitCommand=function(self)
            self:x((i==1)and 75 or SCREEN_RIGHT-75):y(110):zoom(1.1)
            self:addx(-100*self:GetZoom()*((i==1)and 1 or -1)):sleep(1):decelerate(0.5):addx(100*self:GetZoom()*((i==1)and 1 or -1))
        end;
        Def.ActorProxy{
            OnCommand=function(self)
                self:playcommand("NoteChanged",{Player=num_players[i], Noto=GAMESTATE:GetPlayerState(num_players[i]):GetCurrentPlayerOptions():NoteSkin()})
            end;
            NoteChangedMessageCommand=function(self,param)
            if param.Player==num_players[i] then
                --printf("Loaded note %s...\n%s...\n%s",param.Noto,tostring(self:GetParent():GetParent():GetChild("NS_"..param.Noto)), dbNote)
                local rec = SCREENMAN:GetTopScreen():GetChild("NSRec".. string.lower(param.Noto))
                if rec then
                    self:SetTarget( rec )
                end
                --self:hibernate(math.huge)
            end
            end;
        };
    };

    t[#t+1]= Def.ActorFrame{
        InitCommand=function(self)
            self:x((i==1)and 75 or SCREEN_RIGHT-75):y(110):zoom(1.1):visible(false)

            self:addx(-100*self:GetZoom()*((i==1)and 1 or -1)):visible(true):sleep(1):decelerate(0.5):addx(100*self:GetZoom()*((i==1)and 1 or -1))
        end;
        Def.ActorFrame{
            OnCommand=function(self)
            self:y(370)
            local speed, mode= GetSpeedModeAndValueFromPoptions(ToEnumShortString(num_players[i]))
            self:playcommand("SpeedChoiceChanged", {pn= num_players[i], mode= mode, speed= speed})
            end;
            SpeedChoiceChangedMessageCommand=function(self,param)
                if param.pn == num_players[i] then
                local ind = P2I[ToEnumShortString(num_players[i])]
                if param.mode == 'x' then
                    PSpeed[ind][1]=song_bpms[1]*param.speed*0.01
                    PSpeed[ind][2]=song_bpms[2]*param.speed*0.01
                elseif param.mode == 'C' then
                    PSpeed[ind][1]=param.speed
                    PSpeed[ind][2]=param.speed
                elseif param.mode == 'M' then
                    PSpeed[ind][1]=scale(song_bpms[1],0,song_bpms[2],0,param.speed)
                    PSpeed[ind][2]=param.speed
                else
                    PSpeed[ind][1]=param.speed
                    PSpeed[ind][2]=param.speed
                end
                --SM("SPEED "..PSpeed[i][1].." and "..PSpeed[i][2]);
                self:stoptweening():queuecommand("WALK")
                end
            end;
            WALKCommand=function(self)
                local ind = P2I[ToEnumShortString(num_players[i])]
                self:sleep(0.01):y(370):linear(370/math.max(PSpeed[ind][1],0.1)):y(0)
                self:sleep(0.01):y(370):linear(370/math.max(PSpeed[ind][2],0.1)):y(0)
                self:sleep(0.01):queuecommand("WALK")
            end;
            Def.ActorProxy{
                OnCommand=function(self)
                    self:playcommand("NoteChanged",{Player=num_players[i], Noto=GAMESTATE:GetPlayerState(num_players[i]):GetCurrentPlayerOptions():NoteSkin()})
                end,
                NoteChangedMessageCommand=function(self,param)
                    local note = SCREENMAN:GetTopScreen():GetChild("NSNote".. string.lower(param.Noto))
                    if note then
                        self:SetTarget( note )
                    end
                end;
            };
        };
    };

local isDouble = {true,true}
local thisTapScores, nthisTapScores = LoadModule("Options.SmartTapNoteScore.lua")()
thisTapScores = LoadModule("Utils.SortTiming.lua")(thisTapScores)
thisTapScores[#thisTapScores + 1] = "Miss"
nthisTapScores = #thisTapScores

    t[#t+1] = Def.Quad{
        InitCommand=function(self) self:visible(false); end;
        UserPlayerJudgmentMessageCommand=function(self)
            thisTapScores, nthisTapScores = LoadModule("Options.SmartTapNoteScore.lua")()
            thisTapScores = LoadModule("Utils.SortTiming.lua")(thisTapScores)
            thisTapScores[#thisTapScores + 1] = "Miss"
            nthisTapScores = #thisTapScores
            --printf("%s",TableToString(thisTapScores))
        end;
    };

	t[#t+1]= Def.ActorFrame{
			InitCommand=function(self)
				self:x((i==1)and 75 or SCREEN_RIGHT-75):y(200):zoom(0.7):visible(false)
				self:addx(-190*self:GetZoom()*((i==1)and 1 or -1)):visible(true):sleep(1):decelerate(0.5):addx(190*self:GetZoom()*((i==1)and 1 or -1))
			end;
        Def.Sprite{
        InitCommand=function(self)
            self:pause()
            self:playcommand("JudChanged",{Player=num_players[i], Jud=TP[ToEnumShortString(num_players[i])].ActiveModifiers.JudgmentGraphic or "!!default!!"})
        end;
        JudChangedMessageCommand=function(self,param)
            if param.Player == num_players[i] then

                local jPath = LoadModule("Options.JudgmentGetPath.lua")(param.Jud)
                self:stoptweening():Load(jPath):visible(false)
                jPath = string.match(jPath, ".*/(.*)")
                isDouble[i] = string.find(jPath, "%[double%]")

                if self:GetNumStates() == nthisTapScores * 2 or string.find(jPath, "2x%d") ~= nil then
                    isDouble[i] = true
                end
                self:queuecommand("CYCLE")
                self:stopeffect()
                self:rotationz(0)--:3
                --printf("\n\n\n\nFucked %s", tostring(LoadModule("Options.JudgmentAnimation.lua")))
                JudgeAnimation[i] = LoadModule("Options.JudgmentAnimation.lua")(param.Jud)
            end
        end;
            CYCLECommand=function(self)
                local EAR=(math.random(1,2)==1) and true or false
                local thisTapind = math.random(1, nthisTapScores)
                local thisTapScore = thisTapScores[thisTapind]
                local judgState = 0

                if isDouble[i] then
                    judgState = (thisTapind-1)*2 + (EAR and 0 or 1)
                else
                    judgState = thisTapind-1
                end

                if thisTapScore == "Miss" then
                    judgState = self:GetNumStates() - 1
                end

                self:setstate(judgState)
                self:visible(true);
                if EAR then
                    JudgeAnimation[i][thisTapScore.."EarlyCommand"](self);
                else
                    JudgeAnimation[i][thisTapScore.."LateCommand"](self);
                end
                self:sleep(0.01):queuecommand("CYCLE")
            end;
	    };
	};

end;



return t;
