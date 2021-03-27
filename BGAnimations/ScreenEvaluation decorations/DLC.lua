local t = Def.ActorFrame{
	OnCommand=cmd(draworder,30000;x,SCREEN_CENTER_X*0.806+248-381;y,SCREEN_CENTER_Y*0.616+212;);
	RIPVISIBLEMessageCommand=cmd(visible,false);
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

local function TtoS(nep)
	if nep == "Grade_Tier01" then
		return "SS";
	elseif nep == "Grade_Tier02" then
		return "S";
	elseif nep == "Grade_Tier03" then
		return "A+";
	elseif nep == "Grade_Tier04" then
		return "A";
	elseif nep == "Grade_Tier05" then
		return "B";
	elseif nep == "Grade_Tier06" then
		return "C";
	elseif nep == "Grade_Tier07" then
		return "D";
	else
		return "F";
	end
end

local Inputne = function( event )

	if not event then return end

	if event.type == "InputEventType_FirstPress" then
		
		local DIR = "?"
		local PNn = 0

		if (event.button == "Left" or event.button == "DownLeft" or event.button == "MenuLeft") then
			DIR = "L"
		elseif (event.button == "Right" or event.button == "DownRight" or event.button == "MenuRight") then
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

		if (event.button == "Start" or
			event.button == "Center") and GAMESTATE:IsPlayerEnabled(event.PlayerNumber) then 
			MESSAGEMAN:Broadcast("RIPmannnn")
		end
		
	end

end

local PNS = {PLAYER_1,PLAYER_2};--INIT man

table.insert( ContentP[1], "StageEva");
table.insert( ContentP[2], "StageEva");

--IQ stuff
--Battle Normal Eva

for i = 1,2 do
	if GAMESTATE:IsPlayerEnabled(PNS[i]) and PROFILEMAN:GetProfile(PNS[i]):GetHighScoreListIfExists(GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(PNS[i])) and not GAMESTATE:IsCourseMode() then
		table.insert( ContentP[i], "HighScore");
		table.insert( ContentP[i], "TapOffset");
	end
end





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

for i = 1,2 do
	
	if GAMESTATE:IsPlayerEnabled(PNS[i]) then
		local x=Def.ActorFrame{};
		--HIGH SCORE
		if FindInTable("HighScore",ContentP[i]) then
			
			local hst = PROFILEMAN:GetProfile(PNS[i]):GetHighScoreListIfExists(GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(PNS[i])):GetHighScores();
			for xi = 1,math.min(#hst,3) do
				x[#x+1]=Def.ActorFrame{
					OnCommand=cmd(y,-35+(xi-1)*40);
					Def.ActorFrame{
						OnCommand=function(self)
							if hst[xi]:GetPercentDP()*100 == STATSMAN:GetCurStageStats():GetPlayerStageStats(PNS[i]):GetPercentDancePoints()*100 then
								self:rainbow()
							else
								self:diffuse(GameColor.Judgment["JudgmentLine_W"..xi])
							end
						end;
						LoadFont("Common Normal")..{
							OnCommand=cmd(zoom,0.95;x,-200+15;settextf,"#%d ",xi;);
						};
						LoadFont("Common Normal")..{
							OnCommand=cmd(zoom,0.95;x,-130+15;settextf,"%2.2f%%(%s)",hst[xi]:GetPercentDP()*100,TtoS(hst[xi]:GetGrade()));
						};
						LoadFont("Common Normal")..{
							OnCommand=cmd(zoom,0.95;x,-25+15;settextf,"MC:%d",math.min(hst[xi]:GetMaxCombo(),99999));
						};
						LoadFont("Common Normal")..{
							OnCommand=cmd(zoom,0.95;x,80+15;settextf,"%.11s",hst[xi]:GetDate());
						};
					};
					LoadActor("ICON/"..(hst[xi]:GetStageAward() or "Lose")..".png")..{
						OnCommand=cmd(zoom,0.3;x,145+15;);
					};
					LoadActor("ICON/"..(hst[xi]:GetPeakComboAward() or "Lose")..".png")..{
						OnCommand=cmd(zoom,0.3;x,170+15;);
					};
					LoadFont("Common Normal")..{
						OnCommand=cmd(zoom,0.65;x,-175+15;y,20;diffuse,GameColor.Judgment.JudgmentLine_W1;settextf,"%d",math.min(hst[xi]:GetTapNoteScore("TapNoteScore_W1"),99999));
					};
					LoadFont("Common Normal")..{
						OnCommand=cmd(zoom,0.65;x,-175+40+15;y,20;diffuse,GameColor.Judgment.JudgmentLine_W2;settextf,"%d",math.min(hst[xi]:GetTapNoteScore("TapNoteScore_W2"),99999));
					};
					LoadFont("Common Normal")..{
						OnCommand=cmd(zoom,0.65;x,-175+40*2+15;y,20;diffuse,GameColor.Judgment.JudgmentLine_W3;settextf,"%d",math.min(hst[xi]:GetTapNoteScore("TapNoteScore_W3"),99999));
					};
					LoadFont("Common Normal")..{
						OnCommand=cmd(zoom,0.65;x,-175+40*3+15;y,20;diffuse,GameColor.Judgment.JudgmentLine_W4;settextf,"%d",math.min(hst[xi]:GetTapNoteScore("TapNoteScore_W4"),99999));
					};
					LoadFont("Common Normal")..{
						OnCommand=cmd(zoom,0.65;x,-175+40*4+15;y,20;diffuse,GameColor.Judgment.JudgmentLine_W5;settextf,"%d",math.min(hst[xi]:GetTapNoteScore("TapNoteScore_W5"),99999));
					};
					LoadFont("Common Normal")..{
						OnCommand=cmd(zoom,0.65;x,-175+40*5+15;y,20;diffuse,GameColor.Judgment.JudgmentLine_Miss;settextf,"%d",math.min(hst[xi]:GetTapNoteScore("TapNoteScore_Miss"),99999));
					};
					LoadFont("Common Normal")..{
						OnCommand=cmd(zoom,0.65;x,-175+40*6+15;y,20;diffuse,Color.Yellow;settextf,"%d",math.min(hst[xi]:GetHoldNoteScore("HoldNoteScore_Held"),99999));
					};
					LoadFont("Common Normal")..{
						OnCommand=cmd(zoom,0.65;x,-175+40*7+15;y,20;diffuse,Color.Magenta;settextf,"%d",math.min(hst[xi]:GetHoldNoteScore("HoldNoteScore_LetGo"),99999));
					};
				};
			end
		end
		t[#t+1]=Def.ActorFrame{
			Condition = FindInTable("HighScore",ContentP[i]);
			InitCommand=cmd(zoomx,0);
			OnCommand = cmd(x,(i==2 and SCREEN_CENTER_X+5 or 0););
			HighScoreOnMessageCommand=function(self,param)	if param.pni==i then 
						self:finishtweening():decelerate(0.3):zoomx(1) end end;
			HighScoreOffMessageCommand=function(self,param) if param.pni==i then 
						self:finishtweening():accelerate(0.3):zoomx(0) end end;
			Def.Quad{
				OnCommand=cmd(diffuse,ColorDarkTone(Color.SkyBlue);diffusealpha,0.9;zoomx,494*680/794;zoomy,170*263/256);
			};
			LoadFont("Common Large")..{
				OnCommand=cmd(x,-230+40;y,-70;settext,"HighScore";horizalign,left;zoom,0.25;shadowlength,3);
			};
			LoadFont("Common Large")..{
				OnCommand=cmd(x,-105+40;y,-65;settextf,"of (%s)",PROFILEMAN:GetProfile(PNS[i]):GetDisplayName() or "P"..i.."Guy";horizalign,left;zoom,0.2/1.4;shadowlength,3);
			};
			x;
		};


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
							
							CL = GameColor.Judgment["JudgmentLine_"..ToEnumShortString(v[1])]
							

						else
							Y = 9999
							CL = GameColor.Judgment.JudgmentLine_Miss
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



		t[#t+1]=Def.ActorFrame{
			Condition = FindInTable("TapOffset",ContentP[i]);
			InitCommand=cmd(zoomx,0);
			OnCommand = cmd(x,(i==2 and SCREEN_CENTER_X+5 or 0););
			TapOffsetOnMessageCommand=function(self,param)	if param.pni==i then 
						self:finishtweening():decelerate(0.3):zoomx(1) end end;
						TapOffsetOffMessageCommand=function(self,param) if param.pni==i then 
						self:finishtweening():accelerate(0.3):zoomx(0) end end;
			Def.Quad{
				OnCommand=cmd(diffuse,ColorDarkTone(Color.Purple);diffusealpha,0.9;zoomx,494*680/794;zoomy,170*263/256);
			};

			Def.Quad{
				OnCommand=cmd(diffuse,GameColor.Judgment.JudgmentLine_Miss;y,70;diffusealpha,0.3;zoomx,494*680/794;zoomy,1);
			};
			Def.Quad{
				OnCommand=cmd(diffuse,GameColor.Judgment.JudgmentLine_Miss;y,-70;diffusealpha,0.3;zoomx,494*680/794;zoomy,1);
			};

			Def.Quad{
				OnCommand=cmd(diffuse,GameColor.Judgment.JudgmentLine_W5;y,scale(PREFSMAN:GetPreference("TimingWindowSecondsW4"),0,PREFSMAN:GetPreference("TimingWindowSecondsW5"),0,70);diffusealpha,0.3;zoomx,494*680/794;zoomy,1);
			};
			Def.Quad{
				OnCommand=cmd(diffuse,GameColor.Judgment.JudgmentLine_W5;y,-scale(PREFSMAN:GetPreference("TimingWindowSecondsW4"),0,PREFSMAN:GetPreference("TimingWindowSecondsW5"),0,70);diffusealpha,0.3;zoomx,494*680/794;zoomy,1);
			};

			Def.Quad{
				OnCommand=cmd(diffuse,GameColor.Judgment.JudgmentLine_W4;y,scale(PREFSMAN:GetPreference("TimingWindowSecondsW3"),0,PREFSMAN:GetPreference("TimingWindowSecondsW5"),0,70);diffusealpha,0.3;zoomx,494*680/794;zoomy,1);
			};
			Def.Quad{
				OnCommand=cmd(diffuse,GameColor.Judgment.JudgmentLine_W4;y,-scale(PREFSMAN:GetPreference("TimingWindowSecondsW3"),0,PREFSMAN:GetPreference("TimingWindowSecondsW5"),0,70);diffusealpha,0.3;zoomx,494*680/794;zoomy,1);
			};

			Def.Quad{
				OnCommand=cmd(diffuse,GameColor.Judgment.JudgmentLine_W3;y,scale(PREFSMAN:GetPreference("TimingWindowSecondsW2"),0,PREFSMAN:GetPreference("TimingWindowSecondsW5"),0,70);diffusealpha,0.3;zoomx,494*680/794;zoomy,1);
			};
			Def.Quad{
				OnCommand=cmd(diffuse,GameColor.Judgment.JudgmentLine_W3;y,-scale(PREFSMAN:GetPreference("TimingWindowSecondsW2"),0,PREFSMAN:GetPreference("TimingWindowSecondsW5"),0,70);diffusealpha,0.3;zoomx,494*680/794;zoomy,1);
			};

			Def.Quad{
				OnCommand=cmd(diffuse,GameColor.Judgment.JudgmentLine_W2;y,scale(PREFSMAN:GetPreference("TimingWindowSecondsW1"),0,PREFSMAN:GetPreference("TimingWindowSecondsW5"),0,70);diffusealpha,0.3;zoomx,494*680/794;zoomy,1);
			};
			Def.Quad{
				OnCommand=cmd(diffuse,GameColor.Judgment.JudgmentLine_W2;y,-scale(PREFSMAN:GetPreference("TimingWindowSecondsW1"),0,PREFSMAN:GetPreference("TimingWindowSecondsW5"),0,70);diffusealpha,0.3;zoomx,494*680/794;zoomy,1);
			};

			Def.Quad{
				OnCommand=cmd(diffuse,Color.White;diffusealpha,0.9;zoomx,494*680/794;zoomy,1);
			};

			to;

			LoadFont("Common Large")..{
				OnCommand=cmd(x,-230+20;y,-85;settext,"TapsOffset";horizalign,left;zoom,0.15;shadowlength,3;diffusealpha,1);
			};

			LoadFont("Common Normal")..{
				OnCommand=cmd(x,170;y,-77;settext,"Early-";horizalign,left;zoom,0.7;shadowlength,3;diffusealpha,0.5);
			};
			LoadFont("Common Normal")..{
				OnCommand=cmd(x,170;y,77;settext,"Late+";horizalign,left;zoom,0.7;shadowlength,3;diffusealpha,0.5);
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


return t;