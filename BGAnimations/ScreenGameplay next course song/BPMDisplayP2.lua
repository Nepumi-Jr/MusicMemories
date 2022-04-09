local numPlayers = GAMESTATE:GetNumPlayersEnabled()
local numSides = GAMESTATE:GetNumSidesJoined();
local bDoubles = (numPlayers == 1 and numSides == 2);
local bUsingCenter1P = PREFSMAN:GetPreference('Center1Player')


local songoptions = GAMESTATE:GetSongOptionsString();
local ratemod = string.match(songoptions, "%d.%d");
if ratemod then
	ratemod = tonumber(ratemod);
else
	ratemod = 1.0
end


local function UpdateSingleBPM(self)
	local bpmDisplay = self:GetChild("BPMDisplay")
	local pn = GAMESTATE:GetMasterPlayerNumber()
	local pState = GAMESTATE:GetPlayerState(pn);
	local songPosition = pState:GetSongPosition()
	local bpm = songPosition:GetCurBPS() * 60 * ratemod
	bpmDisplay:settext( round(bpm) )
end

local t = Def.ActorFrame{
	Name="BottomFrame";
	InitCommand=function(self) self:CenterX(); self:y(SCREEN_TOP+45); self:valign(1); self:zoom(1.33); self:draworder(-1); end;
	BeginCommand=function(self)
	end;
	

	Def.ActorFrame{
		Name="BPMFrame";
		BeginCommand=function(self)
			
			-- if song options are enabled, move the bpm display up
			if GAMESTATE:GetSongOptionsString() ~= "" then
				self:y(-30); -- raised position (bg = 64px)
			end;
		end;
	};
	
	LoadFont("Common Normal")..{
		Name="RatemodDisplay";
		Text=ratemod.."xMusic";
		InitCommand=function(self) self:zoom(0.4); self:NoStroke(); self:draworder(1); end;
		OnCommand=function(self)
			self:addy(19);
			if self:GetText() == "1xMusic" then
				self:settext("");
				
			elseif self:GetText() == "2xMusic" then
				self:settext("2.0xMusic");
				
			elseif self:GetText() == "0.8xMusic" then	
				self:settext("0.85xMusic");
			end;
		end;
	};
};

local displaySingle = Def.ActorFrame{
	LoadFont("Common Editor")..{
		Name="BPMDisplay";
		InitCommand=function(self) self:zoomx(0.65); self:zoomy(0.55); end;
	};
};

displaySingle.InitCommand=function(self) self:SetUpdateFunction(UpdateSingleBPM); end;

-- in CourseMode, both players should always be playing the same charts, right?
if numPlayers == 1 or GAMESTATE:IsCourseMode() then
	t[#t+1] = displaySingle
else
	-- check if both players are playing the same steps
	local stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
	local stepsP2 = GAMESTATE:GetCurrentSteps(PLAYER_2)

	local stP1 = stepsP1:GetStepsType()
	local stP2 = stepsP2:GetStepsType()

	local diffP1 = stepsP1:GetDifficulty()
	local diffP2 = stepsP2:GetDifficulty()

	-- get timing data...
	local timingP1 = stepsP1:GetTimingData()
	local timingP2 = stepsP2:GetTimingData()

	--if stP1 == stP2 and diffP1 == diffP2 then
	if timingP1 == timingP2 then
		-- both players are steps with the same TimingData; only need one.
		t[#t+1] = displaySingle
		return t
	end

	-- otherwise, we have some more work to do.

	local function Update2PBPM(self)
		local dispP1 = self:GetChild("DisplayP1")
		local dispP2 = self:GetChild("DisplayP2")

		-- needs current bpm for p1 and p2
		for pn in ivalues(PlayerNumber) do
			local bpmDisplay = (pn == PLAYER_1) and dispP1 or dispP2
			local pState = GAMESTATE:GetPlayerState(pn);
			local songPosition = pState:GetSongPosition()
			local bpm = songPosition:GetCurBPS() * 60 * ratemod
			-- bpmDisplay:settext( string.format("%03.2f",bpm) )
			bpmDisplay:settext( round(bpm) );
			
		end
	end

	local displayTwoPlayers = Def.ActorFrame{
		-- manual bpm displays
		LoadFont("Common Editor")..{
			Name="DisplayP1";
			InitCommand=function(self) self:zoom(0); self:shadowlength(1); self:NoStroke(); end;
		};
		LoadFont("Common Editor")..{
			Name="DisplayP2";
			InitCommand=function(self) self:zoom(1); self:shadowlength(1); self:NoStroke(); end;
		};
	};

	displayTwoPlayers.InitCommand=function(self) self:SetUpdateFunction(Update2PBPM); end;

	t[#t+1] = displayTwoPlayers
end

return t