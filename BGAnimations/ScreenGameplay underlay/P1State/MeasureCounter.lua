local player = PLAYER_1;
local Help = "PlayerP1";
local pn = ToEnumShortString(player);
local mods = TP[pn].ActiveModifiers;
if not TP[pn].Streams.Measures then return end

local PlayerState = GAMESTATE:GetPlayerState(player);
local streams, current_measure, previous_measure, MeasureCounterBMT;
local current_count, stream_index, current_stream_length;
local pam = false; 
local AppFrame = {};
local endo,starto = 0,0;
local CurFrame = 1;
local Listen = 1;
local OMW;
local W1,W2,W3,W4,W5,Miss,Li,H,M = 0,0,0,0,0,0,0,0,0;
local Judget = {};
local result = 0;
local Fac = 3;
if not GAMESTATE:ShowW1() then
Fac = 2;
end

local function SayYouGood(re,Mi,OMG)
	re = re * 100;
	if OMG == 0 then
		return "All\nPerfect";
	elseif re >= 100 then
		return "Perfect\nStreams";
	elseif Mi == 1 then
		return "Awesome\nChoke";
	elseif re >= 95 then
		return "Awesome\nStreams";
	elseif re >= 90 then
		return "Great\nStreams";
	elseif re >= 80 then
		return "Good\nStreams";
	elseif re >= 70 then
		return "Solid\nStreams";
	elseif re >= 60 then
		return "Okay...\nStreams";
	else
		return "Bad\nStreams";
	end
end;

-- We'll want to reset each of these values for each new song in the case of CourseMode
local function InitializeMeasureCounter()
	streams = TP[pn].Streams
	current_count = 0
	stream_index = 1
	current_stream_length = 0
	previous_measure = nil
	AppFrame = {};
	endo,starto = 0,0;
	CurFrame = 1;
	Listen = 1;
	OMW = GAMESTATE:GetCurrentSteps(player):GetTimingData();
	W1,W2,W3,W4,W5,Miss,Li,H,M = 0,0,0,0,0,0,0,0,0;
	Judget = {};
	result = 0;
	
for i,v in pairs(streams.Measures) do
	if starto == 0 then
		starto = v.streamStart
	end
	endo = v.streamEnd+1
	
	if streams.Measures[i+1] ~= nil then
		if endo < streams.Measures[i+1].streamEnd then
			table.insert(AppFrame,{START=starto,ENDO=endo})
			endo,starto = 0,0;
		end
	else
		table.insert(AppFrame,{START=starto,ENDO=endo})
		endo,starto = 0,0;
	end
	
end

end

local lagoy = false;
local Anuyat = PREFSMAN:GetPreference("TimingWindowSecondsW3");




local function Update(self, delta)

	if not streams.Measures then FFFrame:diffusealpha(0) return end

	current_measure = (math.floor(PlayerState:GetSongPosition():GetSongBeatVisible()))/4
	
	
	
	
	-- previous_measure will initially be nil; set it to be the same as current_measure
	if not previous_measure then previous_measure = current_measure end

	local new_measure_has_occurred = current_measure > previous_measure

	if new_measure_has_occurred then

		previous_measure = current_measure

		-- if the current measure is within the scope of the current stream
		if streams.Measures[stream_index]
		and current_measure >= streams.Measures[stream_index].streamStart
		and current_measure <= streams.Measures[stream_index].streamEnd then

			current_stream_length = streams.Measures[stream_index].streamEnd - streams.Measures[stream_index].streamStart
			current_count = math.floor(current_measure - streams.Measures[stream_index].streamStart) + 1
			
			
			if mods.Streamay == "Measures" then
				MeasureCounterBMT:settext( tostring(current_count .. "/" .. current_stream_length) )
			elseif mods.Streamay == "Remaining Measures" then
				MeasureCounterBMT:settext(string.format(".1f%",streams.Measures[stream_index].streamEnd+1-current_measure-(math.mod(PlayerState:GetSongPosition():GetSongBeatVisible(),4)/4)))
			elseif mods.Streamay == "Remaining Second" then
				MeasureCounterBMT:settext(string.format(".1f%",OMW:GetElapsedTimeFromBeat(streams.Measures[Listen].streamEnd*4)-OMW:GetElapsedTimeFromBeat(PlayerState:GetSongPosition():GetSongBeatVisible())))
			end

			if current_count > current_stream_length then
				stream_index = stream_index + 1
				MeasureCounterBMT:settext( "" )
			end
		else
			MeasureCounterBMT:settext( "" )
		end
	end
	
	if streams.Measures[Listen]
	and PlayerState:GetSongPosition():GetMusicSecondsVisible() >= OMW:GetElapsedTimeFromBeat(streams.Measures[Listen].streamStart*4) then
	if PlayerState:GetSongPosition():GetMusicSecondsVisible() < OMW:GetElapsedTimeFromBeat(streams.Measures[Listen].streamEnd*4) then
		local Anewone = Judget[1];
		
		if Anewone then
			table.remove(Judget,1)
			if Anewone == "TapNoteScore_W1" then
				W1 = W1 + 1
			elseif Anewone == "TapNoteScore_W2" then
				W2 = W2 + 1
			elseif Anewone == "TapNoteScore_W3" then
				W3 = W3 + 1
			elseif Anewone == "TapNoteScore_W4" then
				W4 = W4 + 1
			elseif Anewone == "TapNoteScore_W5" then
				W5 = W5 + 1
			elseif Anewone == "TapNoteScore_Miss" then
				Miss = Miss + 1
			elseif Anewone == "HoldNoteScore_Held" then
				H = H + 1
			elseif Anewone == "HoldNoteScore_LetGo" then
				Li = Li + 1
			elseif Anewone == "TapNoteScore_HitMine" then
				M = M + 1
			end
		end
		if mods.Streamay == "Note Collected(/)" then
			MeasureCounterBMT:settext(tostring(W1+W2+W3).."/"..tostring(math.max(streams.Measures[Listen].May,W1+W2+W3+W4+W5+Miss)))
		elseif mods.Streamay == "Note Collected(%)" then
			MeasureCounterBMT:settext(string.format("%i",(W1+W2+W3)/(math.max(streams.Measures[Listen].May,W1+W2+W3+W4+W5+Miss))*100).."%")
		elseif mods.Streamay == "Accuracy" then
			MeasureCounterBMT:settext(string.format("%.2f",((W1*3+W2*2+W3)-(M*2)+(H*(Fac+1)))/((W5+W4+W3+W2+W1+Miss)*Fac + (Fac+1)*(H+Li))).."%")
		end
		--
		
		---------SAYYYYYY
	elseif PlayerState:GetSongPosition():GetMusicSecondsVisible() < OMW:GetElapsedTimeFromBeat(streams.Measures[Listen].streamEnd*4+2) then
		--BangCup SAYYYYYY
	
		local Anewone = Judget[1];
		
		if Anewone then
			table.remove(Judget,1)
			if Anewone == "TapNoteScore_W1" then
				W1 = W1 + 1
			elseif Anewone == "TapNoteScore_W2" then
				W2 = W2 + 1
			elseif Anewone == "TapNoteScore_W3" then
				W3 = W3 + 1
			elseif Anewone == "TapNoteScore_W4" then
				W4 = W4 + 1
			elseif Anewone == "TapNoteScore_W5" then
				W5 = W5 + 1
			elseif Anewone == "TapNoteScore_Miss" then
				Miss = Miss + 1
			elseif Anewone == "HoldNoteScore_Held" then
				H = H + 1
			elseif Anewone == "HoldNoteScore_LetGo" then
				Li = Li + 1
			elseif Anewone == "TapNoteScore_HitMine" then
				M = M + 1
			end
		end
	
	
	
		MeasureCounterBMT:settext("")
		result = (W1+W2+W3)/(W1+W2+W3+W4+W5+Miss)
		SayHi:settext(string.format("%i", math.min(result,1)*100).."%")
	elseif PlayerState:GetSongPosition():GetMusicSecondsVisible() < OMW:GetElapsedTimeFromBeat(streams.Measures[Listen].streamEnd*4+4) then
		SayHi:settext(SayYouGood(result,Miss+W5+W4,TFO(GAMESTATE:ShowW1(),W2+W3+W4+W5+Miss,W3+W4+W5+Miss)))
	elseif PlayerState:GetSongPosition():GetMusicSecondsVisible() >= OMW:GetElapsedTimeFromBeat(streams.Measures[Listen].streamEnd*4+4) then
		SayHi:settext("")
		Listen = Listen + 1
		W1,W2,W3,W4,W5,Miss,Li,H,M = 0,0,0,0,0,0,0,0,0;
		Judget = {};
		result = 0;
	end
	end
	
	if AppFrame[CurFrame] then
	if current_measure >= AppFrame[CurFrame].START and current_measure < AppFrame[CurFrame].ENDO then
		if not pam then
			pam = true
			FFFrame:stoptweening():zoom(0.3):decelerate(0.15):diffusealpha(0.75):zoom(0.25)
			end
	elseif current_measure >= AppFrame[CurFrame].ENDO then
		pam = false
		CurFrame = CurFrame + 1
		FFFrame:diffusealpha(0)
	end
	end
	
	
	return
end

if mods.Streamu and mods.Streamu ~= "None" then

	local af = Def.ActorFrame{
		OnCommand=function(self)
			self:queuecommand("SetUpdate")
		end;
		CurrentSongChangedMessageCommand=function(self)
			self:sleep(0.1):queuecommand("ONW")
		end;
		ONWCommand=function(self)
			InitializeMeasureCounter()
		end;
		SetUpdateCommand=function(self)
			if streams.Measures then
			self:SetUpdateFunction( Update )
			end
		end;
		Def.Quad {
			JudgmentMessageCommand=function(self, param)
				if streams.Measures then
				if param.Player == player then
					local ma = 0;
					if param.HoldNoteScore then
						ma = 0;
					else
						if param.TapNoteScore == "TapNoteScore_HitMine" or param.TapNoteScore == "TapNoteScore_AvoidMine" then
							ma = 0;
						else
							ma = param.TapNoteOffset;
						end
					end
						if streams.Measures[Listen]
						and PlayerState:GetSongPosition():GetMusicSecondsVisible() >= OMW:GetElapsedTimeFromBeat(streams.Measures[Listen].streamStart*4) + ma
						and PlayerState:GetSongPosition():GetMusicSecondsVisible() < OMW:GetElapsedTimeFromBeat(streams.Measures[Listen].streamEnd*4) + ma then
							
							if param.HoldNoteScore == "HoldNoteScore_Held" or param.HoldNoteScore == "HoldNoteScore_LetGo" then
								table.insert(Judget,param.HoldNoteScore)
							else
								table.insert(Judget,param.TapNoteScore)
							end
						end
				end
				end
			end;
		};
	};

	af[#af+1] = Def.ActorFrame{
		InitCommand=function(self) self:diffuse(Color[TP[pn].ActiveModifiers.ComboColorstring] or color("#00FF00")); self:diffusealpha(0); end;
		OnCommand=function(self)
		self:x(SCREENMAN:GetTopScreen():GetChild(Help):GetX())
		self:y(SCREEN_CENTER_Y*0.75):zoom(.25)
		FFFrame = self
		end;
	LoadActor("InActive");
	LoadActor("Active")..{
		ONWMessageCommand=function(self) self:diffusealpha(0.75); self:playcommand("May"); end;
		MayCommand=function(self)
		if streams.Measures then
		if streams.Measures[stream_index] then
		self:croptop((streams.Measures[stream_index].streamEnd*4-PlayerState:GetSongPosition():GetSongBeatVisible())/(streams.Measures[stream_index].streamEnd*4-streams.Measures[stream_index].streamStart*4))
		self:sleep(1/45):queuecommand("May")
		end
		end
		end;
	};
	};
	af[#af+1] = Def.ActorFrame{
		InitCommand=function(self)
			self:zoom(0.7):shadowlength(1)
			end;
		OnCommand=function(self)
			self:x(SCREENMAN:GetTopScreen():GetChild(Help):GetX()):y(_screen.cy*0.75 )
			end;
		JudgmentMessageCommand=function(self, param)
		if param.Player == player and 
		(param.TapNoteScore == "TapNoteScore_W1" or param.TapNoteScore == "TapNoteScore_W2" or param.TapNoteScore == "TapNoteScore_W3") and 
		(mods.Streamay == "Note Collected(/)" or mods.Streamay == "Note Collected(%)" or mods.Streamay == "Accuracy")
		then
		self:finishtweening():zoom(0.85):decelerate(0.15):zoom(0.7)
		end
		end;
		Def.BitmapText{
		Font="Common Normal";
		InitCommand=function(self)
			MeasureCounterBMT = self
		end;
		};
	};
	af[#af+1] = Def.ActorFrame{
		InitCommand=function(self)
			self:zoom(0.7):shadowlength(1)
			end;
		OnCommand=function(self)
			self:x(SCREENMAN:GetTopScreen():GetChild(Help):GetX()):y(_screen.cy*0.75 )
			end;
		Def.BitmapText{
		Font="Common Normal";
		InitCommand=function(self)
			SayHi = self
		end;
		};
	};

	return af;

else
	return Def.Actor{};
end
