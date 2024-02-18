local t = Def.ActorFrame{
	OnCommand=function(self) self:draworder(30000); self:x(SCREEN_CENTER_X*0.806+248-381); self:y(SCREEN_CENTER_Y*0.616+212); end;
	RIPVISIBLEMessageCommand=function(self) self:visible(false); end;
};

local ISMISSION1 = false;
local ISMISSION2 = false;

if not GAMESTATE:IsCourseMode() then
	local path=GAMESTATE:GetCurrentSong():GetSongDir();
	if path then
		if FILEMAN:DoesFileExist(path.."MissionTag.lua") then
			LoadActor("../../../../"..path.."MissionTag");
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) and PnMissionState(PLAYER_1,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)) ~= "NotMission" then
				ISMISSION1 = true;
			end
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) and PnMissionState(PLAYER_2,STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)) ~= "NotMission" then
				ISMISSION2 = true;
			end
		end
	end
end
local pageind = {1,1};
local ContentP = {{},{}};

local columnNoteName = GAMESTATE:GetCurrentStyle():GetColumnInfo( GAMESTATE:GetMasterPlayerNumber(), 2 )["Name"];

local Inputne = function( event )

	if not event then return end

	if event.type == "InputEventType_FirstPress" then
		
		local DIR = "?"
		local PNn = 0

		if event.GameButton == "MenuLeft" then
			DIR = "L"
		elseif event.GameButton == "MenuRight" then
			DIR = "R"
		end

		if event.PlayerNumber == PLAYER_1 then
			PNn = 1
		elseif event.PlayerNumber == PLAYER_2 then
			PNn = 2
		end

		if DIR ~= "?" and PNn ~= 0 and GAMESTATE:IsPlayerEnabled(event.PlayerNumber) then
			MESSAGEMAN:Broadcast("ReDLC",{DIR=DIR,PN=PNn})
		end

		if event.GameButton == "Start" and GAMESTATE:IsPlayerEnabled(event.PlayerNumber) then 
			MESSAGEMAN:Broadcast("RIPmannnn")
		end
		
	end

end

local PNS = {PLAYER_1,PLAYER_2};--INIT man



--IQ stuff
--Battle Normal Eva

for i = 1,2 do
    table.insert( ContentP[i], "StageEva");
    table.insert( ContentP[i], "StagePls");
	if GAMESTATE:IsPlayerEnabled(PNS[i]) and PROFILEMAN:GetProfile(PNS[i]):GetHighScoreListIfExists(GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(PNS[i])) and not GAMESTATE:IsCourseMode() then
		table.insert( ContentP[i], "HighScore");
	end
    if TP.Eva.TapTiming[PNS[i]] then
        table.insert( ContentP[i], "TapOffset");
    end
end


local function createCircleGraph(innerSize, outerRadius, colorInactive, colorActive, percent)
    return Def.ActorMultiVertex{
        InitCommand=function(self)
            self:SetDrawState{Mode="DrawMode_Quads"}:SetVertices(verts)
        end;
        OnCommand=function(self)
            local angIter = -90
            local angPlus = 1
            percent = 12

            verts = {}

            while angIter <= 270 do
                
                local selectedColor = colorActive
                if percent <= (angIter + 90)*100/360 then
                    selectedColor = colorInactive
                end
                local px = innerSize * math.cos(angIter/180*math.pi);
                local py = innerSize * math.sin(angIter/180*math.pi);
                local nx = innerSize * math.cos((angIter + angPlus)/180*math.pi);
                local ny = innerSize * math.sin((angIter + angPlus)/180*math.pi);

                local dx = outerRadius * math.cos(angIter/180*math.pi);
                local dy = outerRadius * math.sin(angIter/180*math.pi);
                local dx2 = outerRadius * math.cos((angIter + angPlus)/180*math.pi);
                local dy2 = outerRadius * math.sin((angIter + angPlus)/180*math.pi);

                table.insert( verts,{{px, py,0}, selectedColor })
                table.insert( verts,{{px + dx, py + dy, 0}, selectedColor })
                table.insert( verts,{{nx + dx2, ny + dy2, 0}, selectedColor })
                table.insert( verts,{{nx, ny, 0}, selectedColor })
                angIter = angIter + angPlus;
            end

            self:SetNumVertices(#verts):SetVertices( verts )
        end;
    };
end;



t[#t+1] = Def.ActorFrame{
	OnCommand=function(self)

		SCREENMAN:GetTopScreen():AddInputCallback(Inputne);
		for i = 1,2 do

			if GAMESTATE:IsPlayerEnabled(PNS[i]) then

				for j = 1,#ContentP[i] do
					MESSAGEMAN:Broadcast(ContentP[i][j].."Off",{pni = i});
				end
				pageind[i] = math.mod(pageind[i]-1+#ContentP[i],#ContentP[i])+1;
				--SM(string.format("\n\n\n\nPlayer %d now ind is %d<%s>",i,pageind[i],ContentP[i][pageind[i]]));
				MESSAGEMAN:Broadcast(ContentP[i][pageind[i]].."On",{pni = i});
			end
		end
	end;
	ReDLCMessageCommand=function(self,params)
		local i = params.PN;
			if GAMESTATE:IsPlayerEnabled(PNS[i]) then
				--SM("NEP "..math.random(1,9).." i = "..i);
				for j = 1,#ContentP[i] do
					MESSAGEMAN:Broadcast(ContentP[i][j].."Off",{pni = i});
				end

				if params.DIR == "L" then
					pageind[i] = math.mod((pageind[i]-1)-1+#ContentP[i],#ContentP[i])+1;
				elseif params.DIR == "R" then
					pageind[i] = math.mod((pageind[i]-1)+1,#ContentP[i])+1;
				end
				--SM(string.format("\n\n\n\nPlayer %d now ind is %d<%s>",i,pageind[i],ContentP[i][pageind[i]]));
				MESSAGEMAN:Broadcast(ContentP[i][pageind[i]].."On",{pni = i});

			end
	end;
	OffCommand=function(self)
		MESSAGEMAN:Broadcast("RIPVISIBLE");
	end;
};

--[[
DLC STUFF Start HERE!!!!!!!!!!!!
P2 ADDY 190.5 and Zoomy ADD 10
]]

local function grabNote(pn) -- Code from Kid
    local arrownote
    local noteskin = "default"
    if PlayerOptions.NoteSkin then
        noteskin = GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Song'):NoteSkin()
    end

    if NOTESKIN.LoadActorForNoteSkin then
        arrownote = NOTESKIN:LoadActorForNoteSkin(columnNoteName, "Tap Note", noteskin)
    end
    if not arrownote then
        arrownote= LoadActor("OutFoxNote/_arrow (res 64x64).png");
        
    end
    return arrownote
end;

local function grabBomb(pn) -- Code from Kid
    local arrownote
    local noteskin = "default"
    if PlayerOptions.NoteSkin then
        noteskin = GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Song'):NoteSkin()
    end

    if NOTESKIN.LoadActorForNoteSkin then
        arrownote = NOTESKIN:LoadActorForNoteSkin(columnNoteName, "Tap Mine", noteskin)
    end
    if not arrownote then
        arrownote= LoadActor("OutFoxNote/_bomb (doubleres).png");
        
    end
    return arrownote
end;


local function GetRadarData( pnPlayer, rcRadarCategory )
	local tRadarValues;
	local StepsOrTrail;
	local fDesiredValue = 0;
	if GAMESTATE:GetCurrentSteps( pnPlayer ) then
		StepsOrTrail = GAMESTATE:GetCurrentSteps( pnPlayer );
		fDesiredValue = StepsOrTrail:GetRadarValues( pnPlayer ):GetValue( rcRadarCategory );
	elseif GAMESTATE:GetCurrentTrail( pnPlayer ) then
		StepsOrTrail = GAMESTATE:GetCurrentTrail( pnPlayer );
		fDesiredValue = StepsOrTrail:GetRadarValues( pnPlayer ):GetValue( rcRadarCategory );
	else
		StepsOrTrail = nil;
	end;
	return fDesiredValue;
end;

local stageStates = {}


for i = 1,2 do
	
	if GAMESTATE:IsPlayerEnabled(PNS[i]) then
		stageStates[i] = STATSMAN:GetCurStageStats():GetPlayerStageStats(PNS[i])
        --StagePls
        t[#t+1]=Def.ActorFrame{
			Condition = FindInTable("StagePls",ContentP[i]);
			InitCommand=function(self) self:diffusealpha(0); end;
			OnCommand = function(self) self:x((i==2 and SCREEN_CENTER_X+5 or 0)); end;
			StagePlsOnMessageCommand=function(self,param)	if param.pni==i then 
						self:stoptweening():decelerate(0.2):diffusealpha(1) end end;
			StagePlsOffMessageCommand=function(self,param) if param.pni==i then 
						self:stoptweening():accelerate(0.2):diffusealpha(0) end end;
			Def.Quad{
				OnCommand=function(self) self:diffuse(ColorDarkTone(Color.Green)); self:diffusealpha(0.9); self:zoomx(494*680/794); self:zoomy(170*263/256); end;
			};

            Def.Sprite { 
                InitCommand=function(self)
                    local JudF = TP[i == 1 and "P1" or "P2"].ActiveModifiers.JudgmentGraphic
                    self:Load(LoadModule("Judgement.GetHoldPath.lua")(JudF)):pause():zoom(1.2)
                    self:x(-60):y(-55)
                end;
            };
            Def.ActorFrame{
                InitCommand=function(self) self:x(-50); self:y(-18); end;
                LoadFont("Combo Number")..{
                    InitCommand=function(self)
                        self:x(-30):zoom(0.5):shadowlength(2):
                        settext(stageStates[i]:GetHoldNoteScores('HoldNoteScore_Held'))

                        if stageStates[i]:GetHoldNoteScores('HoldNoteScore_LetGo') + stageStates[i]:GetHoldNoteScores('HoldNoteScore_MissedHold') == 0 then
                            self:diffusebottomedge(Color.Green)
                        end
                    end;
                };
                LoadFont("Common Normal")..{
                    InitCommand=function(self) self:x(10); self:y(5); self:zoom(0.8); self:shadowlength(2); self:settext("/"..(stageStates[i]:GetHoldNoteScores('HoldNoteScore_Held') + stageStates[i]:GetHoldNoteScores('HoldNoteScore_LetGo') + stageStates[i]:GetHoldNoteScores('HoldNoteScore_MissedHold'))); end;
                };
            };
            
            
            Def.ActorFrame{
                InitCommand=function(self) self:x(-170); self:y(35); end;
                Def.ActorFrame{
                    InitCommand=function(self)
                        local mc = stageStates[i]:MaxCombo();

                        self:zoom(1):rotationz(135):wag()
                        :effectmagnitude(0,0,scale(clamp(mc,0,10000), 0, 10000, 0, 20))
                        :effectperiod(scale(clamp(mc,0,10000), 0, 10000, 4, 0.2))
                    end;
                    grabNote(i-1);
                };
                LoadFont("Common Large")..{
                    InitCommand=function(self) self:x(50); self:y(-20); self:zoom(0.2); self:shadowlength(2); self:settext("MC"); end;
                };
                LoadFont("Combo Number")..{
                    InitCommand=function(self) self:x(30); self:y(20); self:zoom(0.5); self:horizalign(left); self:shadowlength(2); self:settext(stageStates[i]:MaxCombo()); end;
                    OnCommand=function(self)
                        curStage = LoadModule("Eva.CustomStageAward.lua")(PNS[i]);
                        if string.find(curStage,"W1") then
                            self:diffusebottomedge(JudgmentLineToColor("W1"))
                        elseif string.find(curStage,"W2") then
                            self:diffusebottomedge(JudgmentLineToColor("W2"))
                        elseif string.find(curStage,"W3") then
                            self:diffusebottomedge(JudgmentLineToColor("W3"))
                        elseif curStage == "StageAward_Choke"  then
                            self:diffusebottomedge(JudgmentLineToColor("W4"))
                        elseif curStage == "StageAward_NoMiss" then
                            self:diffusebottomedge(JudgmentLineToColor("W5"))
                        end
                    end;
                };
                
            };

            Def.ActorFrame{
                InitCommand=function(self) self:x(-20); self:y(35); end;
                grabBomb(i-1);
                LoadFont("Combo Number")..{
                    InitCommand=function(self) self:x(35); self:y(-5); self:zoom(0.5); self:horizalign(left); self:shadowlength(2); self:settext("123"); end;
                    OnCommand=function(self)
                        local hitBomb = stageStates[i]:GetTapNoteScores('TapNoteScore_HitMine')
                        if hitBomb == 0 then
                            self:diffusebottomedge(Color.Green)
                        end
                        self:settext(hitBomb)
                    end;
                };
                LoadFont("Common Normal")..{
                    InitCommand=function(self) self:x(40); self:y(20); self:zoom(0.8); self:horizalign(left); self:shadowlength(2); self:settext("123"); end;
                    OnCommand=function(self)
                        local allBomb = GetRadarData(PNS[i], "RadarCategory_Mines")
                        self:settext("/"..allBomb)
                    end;
                };
                
            };

            Def.ActorFrame{
                InitCommand=function(self) self:x(150); self:y(-10); end;
                LoadActor("Fire.png")..{
                    InitCommand=function(self)
                        local power = clamp(stageStates[i]:GetCaloriesBurned(),0,100);
                        self:zoom(0.25)
                        self:vibrate()
                        self:effectmagnitude(power/5,power/5,0)
                    end;
                };
                LoadFont("Combo number")..{
                    InitCommand=function(self) self:y(60); self:zoom(0.3); self:shadowlength(2); self:settext("123"); end;
                    OnCommand=function(self)
                        local power = clamp(stageStates[i]:GetCaloriesBurned(),0,100);
                        self:diffusebottomedge(ScaleColor(power,0,100,{1,1,1,1},Color.Red))
                        self:settextf("%.2f",stageStates[i]:GetCaloriesBurned())
                    end;
                };
                LoadFont("Common Large")..{
                    InitCommand=function(self) self:y(70); self:zoom(0.2); self:shadowlength(2); self:settext("kcal"); end;
                    OnCommand=function(self)
                        self:settextf("kcal")
                    end;
                };
                
            };

            --createCircleGraph(100,10,{1,0,0,1},{0,1,0,1},37);
            
		};
        
		--HIGH SCORE
        
		if FindInTable("HighScore",ContentP[i]) then
			local temp = Def.ActorFrame{};
			local hst = PROFILEMAN:GetProfile(PNS[i]):GetHighScoreListIfExists(GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(PNS[i])):GetHighScores();
            for xi = 1,math.min(#hst,3) do
				temp[#temp+1]=Def.ActorFrame{
					OnCommand=function(self) self:y(-35+(xi-1)*40); end;
					Def.ActorFrame{
						OnCommand=function(self)
							if hst[xi]:GetScore() == stageStates[i]:GetScore() then
								self:rainbow()
							else
								self:diffuse(JudgmentLineToColor("W"..xi))
							end
						end;
						LoadFont("Common Normal")..{
							OnCommand=function(self) self:zoom(0.95); self:x(-200+15); self:settextf("#%d ",xi); end;
						};
						LoadFont("Combo Number")..{
							InitCommand=function(self) self:zoom(0.27); self:x(-60); self:horizalign(right); self:settextf("%d",hst[xi]:GetScore()); end;
                            OnCommand=function(self) self:playcommand("onLoop"); end;
                            onLoopCommand=function(self) self:sleep(5); self:decelerate(0.5); self:cropleft(1); self:sleep(5); self:decelerate(0.5); self:cropleft(0); self:sleep(0.02); self:queuecommand("onLoop"); end;
                        };
                        LoadFont("Combo Number")..{
							InitCommand=function(self) self:zoom(0.27); self:x(-150); self:horizalign(left); self:settextf("%.02f%%",hst[xi]:GetPercentDP()*100); self:cropright(1); end;
                            OnCommand=function(self) self:playcommand("onLoop"); end;
                            onLoopCommand=function(self) self:sleep(5); self:decelerate(0.5); self:cropright(0); self:sleep(5); self:decelerate(0.5); self:cropright(1); self:sleep(0.02); self:queuecommand("onLoop"); end;
						};
                        
                        LoadFont("Common Normal")..{
							OnCommand=function(self) self:zoom(0.75); self:x(13); self:settextf("MC:%d",math.min(hst[xi]:GetMaxCombo(),99999)); end;
						};
						LoadFont("Common Normal")..{
							OnCommand=function(self) self:zoom(0.75); self:x(80+15); self:settextf("%.11s",hst[xi]:GetDate()); end;
						};
					};
                    Def.Sprite{
                        OnCommand=function(self) self:x(-36); self:y(-2); self:Load(THEME:GetPathG("GradeDisplayEval",ToEnumShortString(hst[xi]:GetGrade()))); self:zoom(0.3); end;
                    };
					LoadActor("ICON/"..(hst[xi]:GetStageAward() or "Lose")..".png")..{
						OnCommand=function(self) self:zoom(0.3); self:x(145+15); end;
					};
					LoadActor("ICON/"..(hst[xi]:GetPeakComboAward() or "Lose")..".png")..{
						OnCommand=function(self) self:zoom(0.3); self:x(170+15); end;
					};
					LoadFont("Common Normal")..{
						OnCommand=function(self) self:zoom(0.65); self:x(-175+15); self:y(20); self:diffuse(JudgmentLineToColor("W1")); self:settextf("%d",math.min(hst[xi]:GetTapNoteScore("TapNoteScore_W1"),99999)); end;
					};
					LoadFont("Common Normal")..{
						OnCommand=function(self) self:zoom(0.65); self:x(-175+40+15); self:y(20); self:diffuse(JudgmentLineToColor("W2")); self:settextf("%d",math.min(hst[xi]:GetTapNoteScore("TapNoteScore_W2"),99999)); end;
					};
					LoadFont("Common Normal")..{
						OnCommand=function(self) self:zoom(0.65); self:x(-175+40*2+15); self:y(20); self:diffuse(JudgmentLineToColor("W3")); self:settextf("%d",math.min(hst[xi]:GetTapNoteScore("TapNoteScore_W3"),99999)); end;
					};
					LoadFont("Common Normal")..{
						OnCommand=function(self) self:zoom(0.65); self:x(-175+40*3+15); self:y(20); self:diffuse(JudgmentLineToColor("W4")); self:settextf("%d",math.min(hst[xi]:GetTapNoteScore("TapNoteScore_W4"),99999)); end;
					};
					LoadFont("Common Normal")..{
						OnCommand=function(self) self:zoom(0.65); self:x(-175+40*4+15); self:y(20); self:diffuse(JudgmentLineToColor("W5")); self:settextf("%d",math.min(hst[xi]:GetTapNoteScore("TapNoteScore_W5"),99999)); end;
					};
					LoadFont("Common Normal")..{
						OnCommand=function(self) self:zoom(0.65); self:x(-175+40*5+15); self:y(20); self:diffuse(JudgmentLineToColor("Miss")); self:settextf("%d",math.min(hst[xi]:GetTapNoteScore("TapNoteScore_Miss"),99999)); end;
					};
					LoadFont("Common Normal")..{
						OnCommand=function(self) self:zoom(0.65); self:x(-175+40*6+15); self:y(20); self:diffuse(Color.Yellow); self:settextf("%d",math.min(hst[xi]:GetHoldNoteScore("HoldNoteScore_Held"),99999)); end;
					};
					LoadFont("Common Normal")..{
						OnCommand=function(self) self:zoom(0.65); self:x(-175+40*7+15); self:y(20); self:diffuse(Color.Magenta); self:settextf("%d",math.min(hst[xi]:GetHoldNoteScore("HoldNoteScore_LetGo"),99999)); end;
					};
				};
			end
            t[#t+1]=Def.ActorFrame{
                Condition = FindInTable("HighScore",ContentP[i]);
                InitCommand=function(self) self:diffusealpha(0); end;
                OnCommand = function(self) self:x((i==2 and SCREEN_CENTER_X+5 or 0)); end;
                HighScoreOnMessageCommand=function(self,param)	if param.pni==i then 
                            self:stoptweening():decelerate(0.2):diffusealpha(1) end end;
                HighScoreOffMessageCommand=function(self,param) if param.pni==i then 
                            self:stoptweening():accelerate(0.2):diffusealpha(0) end end;
                Def.Quad{
                    OnCommand=function(self) self:diffuse(ColorDarkTone(Color.SkyBlue)); self:diffusealpha(0.9); self:zoomx(494*680/794); self:zoomy(170*263/256); end;
                };
                LoadFont("Common Large")..{
                    OnCommand=function(self) self:x(-230+40); self:y(-70); self:settext(THEME:GetString("ScreenHighScores","HeaderText")); self:horizalign(left); self:zoom(0.25); self:shadowlength(3); end;
                };
                LoadFont("Common Large")..{
                    OnCommand=function(self) self:x(140); self:y(-65); self:horizalign(right); self:settextf("(%s)",PROFILEMAN:GetProfile(PNS[i]):GetDisplayName() or "P"..i.."Guy"); self:horizalign(left); self:zoom(0.2/1.4); self:shadowlength(1); end;
                };
                temp;
            };
		end
		


		--Taps Offset

		local to=Def.ActorFrame{};

		if TP.Eva.TapTiming[PNS[i]] then

			to = Def.ActorMultiVertex{
				InitCommand=function(self)
					self:SetDrawState{Mode="DrawMode_Quads"}
				end;
				OnCommand=function(self)
					local Vers = {}
					for k,v in pairs(TP.Eva.TapTiming[PNS[i]]) do
						local X = scale(k,1,#TP.Eva.TapTiming[PNS[i]],-210,210)
						local Y = 0
						local CL = {1,1,1,0}
						if ToEnumShortString(v[1]) ~= "Miss" then
							local p = scale(math.abs(v[2] or 0),0,PREFSMAN:GetPreference("TimingWindowSecondsW5"),0,70)
							if (v[2] or 0) < 0 then
								Y = -p
								--self:bounce()
							else
								Y = p
								--self:bob()
								
							end
							
							CL = JudgmentLineToColor(ToEnumShortString(v[1]))
							

						else
							Y = 9999
							CL = JudgmentLineToColor("Miss")
							CL = {CL[1],CL[2],CL[3],0.3}
						end

						if Y == 9999 then
							table.insert(Vers,{{X-1,70,0},CL})
							table.insert(Vers,{{X+1,70,0},CL})
							table.insert(Vers,{{X+1,-70,0},CL})
							table.insert(Vers,{{X-1,-70,0},CL})
						else
							table.insert(Vers,{{X-1,Y-1,0},CL})
							table.insert(Vers,{{X+1,Y-1,0},CL})
							table.insert(Vers,{{X+1,Y+1,0},CL})
							table.insert(Vers,{{X-1,Y+1,0},CL})
						end

						
					
					end

					self:SetNumVertices(#Vers):SetVertices( Vers )

				end;
			
			
			};		

		end


        if FindInTable("TapOffset",ContentP[i]) then
            t[#t+1]=Def.ActorFrame{
                Condition = FindInTable("TapOffset",ContentP[i]);
                InitCommand=function(self) self:diffusealpha(0); end;
                OnCommand = function(self) self:x((i==2 and SCREEN_CENTER_X+5 or 0)); end;
                TapOffsetOnMessageCommand=function(self,param)	if param.pni==i then 
                            self:stoptweening():decelerate(0.2):diffusealpha(1) end end;
                            TapOffsetOffMessageCommand=function(self,param) if param.pni==i then 
                            self:stoptweening():accelerate(0.2):diffusealpha(0) end end;
                Def.Quad{
                    OnCommand=function(self) self:diffuse(ColorDarkTone(Color.Purple)); self:diffusealpha(0.9); self:zoomx(494*680/794); self:zoomy(170*263/256); end;
                };

                Def.Quad{
                    OnCommand=function(self) self:diffuse(JudgmentLineToColor("Miss")); self:y(70); self:diffusealpha(0.3); self:zoomx(494*680/794); self:zoomy(1); end;
                };
                Def.Quad{
                    OnCommand=function(self) self:diffuse(JudgmentLineToColor("Miss")); self:y(-70); self:diffusealpha(0.3); self:zoomx(494*680/794); self:zoomy(1); end;
                };

                Def.Quad{
                    OnCommand=function(self) self:diffuse(JudgmentLineToColor("W5")); self:y(scale(PREFSMAN:GetPreference("TimingWindowSecondsW4"),0,PREFSMAN:GetPreference("TimingWindowSecondsW5"),0,70)); self:diffusealpha(0.3); self:zoomx(494*680/794); self:zoomy(1); end;
                };
                Def.Quad{
                    OnCommand=function(self) self:diffuse(JudgmentLineToColor("W5")); self:y(-scale(PREFSMAN:GetPreference("TimingWindowSecondsW4"),0,PREFSMAN:GetPreference("TimingWindowSecondsW5"),0,70)); self:diffusealpha(0.3); self:zoomx(494*680/794); self:zoomy(1); end;
                };

                Def.Quad{
                    OnCommand=function(self) self:diffuse(JudgmentLineToColor("W4")); self:y(scale(PREFSMAN:GetPreference("TimingWindowSecondsW3"),0,PREFSMAN:GetPreference("TimingWindowSecondsW5"),0,70)); self:diffusealpha(0.3); self:zoomx(494*680/794); self:zoomy(1); end;
                };
                Def.Quad{
                    OnCommand=function(self) self:diffuse(JudgmentLineToColor("W4")); self:y(-scale(PREFSMAN:GetPreference("TimingWindowSecondsW3"),0,PREFSMAN:GetPreference("TimingWindowSecondsW5"),0,70)); self:diffusealpha(0.3); self:zoomx(494*680/794); self:zoomy(1); end;
                };

                Def.Quad{
                    OnCommand=function(self) self:diffuse(JudgmentLineToColor("W3")); self:y(scale(PREFSMAN:GetPreference("TimingWindowSecondsW2"),0,PREFSMAN:GetPreference("TimingWindowSecondsW5"),0,70)); self:diffusealpha(0.3); self:zoomx(494*680/794); self:zoomy(1); end;
                };
                Def.Quad{
                    OnCommand=function(self) self:diffuse(JudgmentLineToColor("W3")); self:y(-scale(PREFSMAN:GetPreference("TimingWindowSecondsW2"),0,PREFSMAN:GetPreference("TimingWindowSecondsW5"),0,70)); self:diffusealpha(0.3); self:zoomx(494*680/794); self:zoomy(1); end;
                };

                Def.Quad{
                    OnCommand=function(self) self:diffuse(JudgmentLineToColor("W2")); self:y(scale(PREFSMAN:GetPreference("TimingWindowSecondsW1"),0,PREFSMAN:GetPreference("TimingWindowSecondsW5"),0,70)); self:diffusealpha(0.3); self:zoomx(494*680/794); self:zoomy(1); end;
                };
                Def.Quad{
                    OnCommand=function(self) self:diffuse(JudgmentLineToColor("W2")); self:y(-scale(PREFSMAN:GetPreference("TimingWindowSecondsW1"),0,PREFSMAN:GetPreference("TimingWindowSecondsW5"),0,70)); self:diffusealpha(0.3); self:zoomx(494*680/794); self:zoomy(1); end;
                };

                Def.Quad{
                    OnCommand=function(self) self:diffuse(Color.White); self:diffusealpha(0.9); self:zoomx(494*680/794); self:zoomy(1); end;
                };

                to;

                LoadFont("Common Large")..{
                    OnCommand=function(self) self:x(-230+20); self:y(-85); self:settext("TapsOffset"); self:horizalign(left); self:zoom(0.15); self:shadowlength(3); self:diffusealpha(1); end;
                };

                LoadFont("Common Normal")..{
                    OnCommand=function(self) self:x(170); self:y(-77); self:settext("Early-"); self:horizalign(left); self:zoom(0.7); self:shadowlength(3); self:diffusealpha(0.5); end;
                };
                LoadFont("Common Normal")..{
                    OnCommand=function(self) self:x(170); self:y(77); self:settext("Late+"); self:horizalign(left); self:zoom(0.7); self:shadowlength(3); self:diffusealpha(0.5); end;
                };
                LoadFont("Common Normal")..{
                    OnCommand=function(self)
                        self:x(-110):y(-77):horizalign(left):zoom(0.7)
                        :shadowlength(3):diffusealpha(1)

                        local mean = 0;
                        for k,v in pairs(TP.Eva.TapTiming[PNS[i]]) do
                            mean = mean + v[2]
                        end
                        mean = mean / (#TP.Eva.TapTiming[PNS[i]])

                        local sd = 0;
                        for k,v in pairs(TP.Eva.TapTiming[PNS[i]]) do
                            sd = sd + math.pow(v[2] - mean,2)
                        end
                        sd = math.sqrt( sd / (#TP.Eva.TapTiming[PNS[i]]) )

                        self:settextf("Mean = %.1f ms; SD = %.1f",mean*1000, sd*1000)
                    end;
                };
            };
        end

	end
end


return t;