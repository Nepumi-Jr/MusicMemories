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

local t = LoadFallbackB();
local game_name = GAMESTATE:GetCurrentGame():GetName()
local column = {
	dance = "Up",
	pump = "UpRight",
	techno = "Up",
	kb7 = "Key1"
}


local P2I={
	P1=1,
	P2=2
}
local PSpeed={{300,300},{300,300}}


local JudgeCmdsYes = {
	TapNoteScore_W1 = THEME:GetMetric( "Judgment", "JudgmentW1YesCommand");
	TapNoteScore_W2 = THEME:GetMetric( "Judgment", "JudgmentW2YesCommand");
	TapNoteScore_W3 = THEME:GetMetric( "Judgment", "JudgmentW3YesCommand");
	TapNoteScore_W4 = THEME:GetMetric( "Judgment", "JudgmentW4YesCommand");
	TapNoteScore_W5 = THEME:GetMetric( "Judgment", "JudgmentW4YesCommand");
	TapNoteScore_Miss = THEME:GetMetric( "Judgment", "JudgmentMissYesCommand");
};
local JudgeCmdsNo = {
	TapNoteScore_W1 = THEME:GetMetric( "Judgment", "JudgmentW1NoCommand");
	TapNoteScore_W2 = THEME:GetMetric( "Judgment", "JudgmentW2NoCommand");
	TapNoteScore_W3 = THEME:GetMetric( "Judgment", "JudgmentW3NoCommand");
	TapNoteScore_W4 = THEME:GetMetric( "Judgment", "JudgmentW4NoCommand");
	TapNoteScore_W5 = THEME:GetMetric( "Judgment", "JudgmentW4NoCommand");
	TapNoteScore_Miss = THEME:GetMetric( "Judgment", "JudgmentMissNoCommand");
};
local TNSFrames = {
	TapNoteScore_W1 = 0;
	TapNoteScore_W2 = 1;
	TapNoteScore_W3 = 2;
	TapNoteScore_W4 = 3;
	TapNoteScore_W5 = 4;
	TapNoteScore_Miss = 5;
};

local GetNoteSkinActor = function(ns)--FROM SL <3

	local status, noteskin_actor_Re = pcall(NOTESKIN.LoadActorForNoteSkin, NOTESKIN, column[game_name] or "Down", "Receptor", ns)
	local status, noteskin_actor_No = pcall(NOTESKIN.LoadActorForNoteSkin, NOTESKIN, column[game_name] or "Down", "Tap Note", ns)

	if noteskin_actor_Re and noteskin_actor_No then
		return Def.ActorFrame{
			Name="NoteSkin_"..ns,
				noteskin_actor_No..{
					Name="TN",
					InitCommand=function(self) self:visible(false) end;
					NoteChangedMessageCommand=function(self,param)
						local f = false
						for i=1,#num_players do
							if not f and NOTE[i]==ns then
								f = true;
							end
						end
						self:visible(f);
					end;
				},
				noteskin_actor_Re..{
					Name="Re",
					InitCommand=function(self) self:visible(false) end;
					NoteChangedMessageCommand=function(self,param)
						local f = false
						for i=1,#num_players do
							if not f and NOTE[i]==ns then
								f = true;
							end
						end
						self:visible(f);
					end;
				}
		}
	else
		SM("There are Lua errors in your " .. ns .. " NoteSkin.\nYou should fix them, or delete the NoteSkin.")

		return Def.ActorFrame{
			Name="NoteSkin_"..ns,
				LoadActor(THEME:GetPathG("","_Robot_Note")) .. {
					Name="TN",
					InitCommand=function(self) self:visible(false) end;
					NoteChangedMessageCommand=function(self,param)
						local f = false
						for i=1,#num_players do
							if not f and NOTE[i]==ns then
								f = true;
							end
						end
						self:visible(f);
					end;
				},
				Def.Sprite {
				Texture=THEME:GetPathG("_Down","Receptor");
				Frame0000=0;
				Delay0000=1;
				Frame0001=1;
				Delay0001=1;
				Frame0002=2;
				Delay0002=1;
				Frame0003=3;
				Delay0003=1;
					Name="Re",
					InitCommand=function(self) self:effectclock("beat") self:visible(false) end;
					NoteChangedMessageCommand=function(self,param)
						local f = false
						for i=1,#num_players do
							if not f and NOTE[i]==ns then
								f = true;
							end
						end
						self:visible(f);
					end;
				}
		}
	end
end

	t[#t+1] = Def.Quad{
		InitCommand=cmd(visible,false);
		NoteChangedMessage=function(self,param)
			NOTE[param.Player+1]=param.Noto;
		end;
	};

for noteskin in ivalues( NOTESKIN:GetNoteSkinNames() ) do
	t[#t+1] = GetNoteSkinActor(noteskin)
end

for i=1,#num_players do
	local metrics_name = "PlayerNameplate" .. ToEnumShortString(num_players[i])
	t[#t+1] = LoadActor( THEME:GetPathG(Var "LoadingScreen", "PlayerNameplate"), num_players[i] ) .. {
		InitCommand=function(self)
			self:name(metrics_name);
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen");
		end

	}
		t[#t+1] = Def.ActorFrame{
			InitCommand=function(self)
				self:x((i==1)and 75 or SCREEN_RIGHT-75):y(110):zoom(1.1):visible(false)

				self:addx(-100*self:GetZoom()*((i==1)and 1 or -1)):visible(true):sleep(1):decelerate(0.5):addx(100*self:GetZoom()*((i==1)and 1 or -1))
			end,
			Def.ActorProxy{
				OnCommand=function(self)
					self:playcommand("NoteChanged",{Player=num_players[i], Noto=GAMESTATE:GetPlayerState(num_players[i]):GetCurrentPlayerOptions():NoteSkin()})
				end,
				NoteChangedMessageCommand=function(self,param)
				if param.Player==num_players[i] then
					local noteskin_actor = self:GetParent():GetParent():GetChild("NoteSkin_"..param.Noto):GetChild("Re")
					if noteskin_actor then
						--SM("Founded "..param.Noto);
						self:SetTarget( noteskin_actor )
					end
					--self:hibernate(math.huge)
				end
				end,
			}
		}

		t[#t+1]= Def.ActorFrame{
			InitCommand=function(self)
				self:x((i==1)and 75 or SCREEN_RIGHT-75):y(110):zoom(1.1):visible(false)

				self:addx(-100*self:GetZoom()*((i==1)and 1 or -1)):visible(true):sleep(1):decelerate(0.5):addx(100*self:GetZoom()*((i==1)and 1 or -1))
			end,
			Def.ActorFrame{
				OnCommand=function(self)
				self:y(370)
				local speed, mode= GetSpeedModeAndValueFromPoptions(ToEnumShortString(num_players[i]))
				self:playcommand("SpeedChoiceChanged", {pn= num_players[i], mode= mode, speed= speed})
				end,
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
				end,
							Def.ActorProxy{
				OnCommand=function(self)
					self:playcommand("NoteChanged",{Player=num_players[i], Noto=GAMESTATE:GetPlayerState(num_players[i]):GetCurrentPlayerOptions():NoteSkin()})
				end,
				NoteChangedMessageCommand=function(self,param)
				if param.Player==num_players[i] then
					local noteskin_actor = self:GetParent():GetParent():GetParent():GetChild("NoteSkin_"..param.Noto):GetChild("TN")
					if noteskin_actor then
						--SM("Founded "..param.Noto);
						self:SetTarget( noteskin_actor )
					end
					--self:hibernate(math.huge)
				end
				end,
			}
			}
		}


	t[#t+1]= Def.ActorFrame{
			InitCommand=function(self)
				self:x((i==1)and 75 or SCREEN_RIGHT-75):y(200):zoom(0.7):visible(false)

				self:addx(-190*self:GetZoom()*((i==1)and 1 or -1)):visible(true):sleep(1):decelerate(0.5):addx(190*self:GetZoom()*((i==1)and 1 or -1))
			end,Def.Sprite{
		InitCommand=function(self)




		self:pause()
		self:playcommand("JudChanged",{Player=num_players[i], Jud=TP[ToEnumShortString(num_players[i])].ActiveModifiers.JudgmentGraphic or "LOVE"})
		end,
		JudChangedMessageCommand=function(self,param)
			--SM("RELOADING")
			if param.Player == num_players[i] then
				self:stoptweening():Load(GetPicJudPath(param.Jud)):visible(false):queuecommand("CYCLE");
			end
		end,
		CYCLECommand=function(self)
		local EAR=(math.random(1,2)==1)and true or false
		local TNS=({"TapNoteScore_W1","TapNoteScore_W2","TapNoteScore_W3","TapNoteScore_W4","TapNoteScore_W5","TapNoteScore_Miss"})[math.random(1,6)]
		local iFrame=TNSFrames[TNS]

		if self:GetNumStates() == 12 then
			iFrame = iFrame * 2;
			if not EAR then
				iFrame = iFrame + 1;
			end
		end
		self:setstate(iFrame):visible(true);

					if EAR then
						JudgeCmdsYes[TNS](self);
					else
						JudgeCmdsNo[TNS](self);
					end
				self:sleep(0.01):queuecommand("CYCLE")
		end;
	},
	}



end



return t;
