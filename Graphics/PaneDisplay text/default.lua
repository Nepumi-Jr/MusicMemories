local iPN = ...;
assert(iPN,"[Graphics/PaneDisplay text] No PlayerNumber Provided.");

local t = Def.ActorFrame {};
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

local function GetColor(pnPlayer)
	if GAMESTATE:GetCurrentSteps( pnPlayer ) then
		return GameColor.Difficulty[GAMESTATE:GetCurrentSteps( pnPlayer ):GetDifficulty()]
	elseif GAMESTATE:GetCurrentTrail( pnPlayer ) then
		return GameColor.Difficulty[GAMESTATE:GetCurrentTrail( pnPlayer ):GetDifficulty()]
	else
		return Color.White;
	end;
end;

local function Str_Step(pnPlayer)
	local StepsOrTrail;
	if GAMESTATE:GetCurrentSteps( pnPlayer ) then
		StepsOrTrail = GAMESTATE:GetCurrentSteps( pnPlayer );
	elseif GAMESTATE:GetCurrentTrail( pnPlayer ) then
		StepsOrTrail = GAMESTATE:GetCurrentTrail( pnPlayer );
	else
		return "????? : ??"
	end
	
	local TEXT;
	if StepsOrTrail:GetDifficulty() ~= "Difficulty_Edit" then
		TEXT = THEME:GetString("CustomDifficulty",ToEnumShortString(StepsOrTrail:GetDifficulty()));
	elseif  StepsOrTrail:GetDifficulty() == "Difficulty_Edit" then
		if StepsOrTrail:GetDescription() ~= "" then
			if string.len(StepsOrTrail:GetDescription()) > 6 then
				TEXT = string.sub(StepsOrTrail:GetDescription(),1,5).."..."
			else
				TEXT = StepsOrTrail:GetDescription();
			end
		else
			TEXT = THEME:GetString("CustomDifficulty","Edit");
		end
	end
	
	if StepsOrTrail:GetMeter() >= 99 then
		TEXT = TEXT .. " : ??"
	else
		TEXT = TEXT .. " : "..tostring(StepsOrTrail:GetMeter());
	end
	
	return TEXT;
	
end;

local function CreatePaneDisplayItemA( _pnPlayer, _sLabel, _rcRadarCategory )
	return Def.ActorFrame {
		LoadActor("Icon/".._sLabel..".lua")..{
			InitCommand=function(self) self:zoom(0.25):x(-20) end;
		};
		LoadFont("Combo Number") .. {
			Text=string.format("%04i", 0);
			InitCommand=function(self) self:horizalign(right); self:x(20):maxwidth(180); end;
			OnCommand=function(self) self:zoom(0.15); self:shadowlength(1); end;
			CurrentSongChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentStepsP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set"); end;
			SetCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				local thatValue = 0;
				if song or course then
					thatValue = GetRadarData( _pnPlayer, _rcRadarCategory );
				end
				thatValue = math.floor(thatValue);
				local digits = 0;
				if thatValue > 0 then
					digits = math.min(math.floor(math.log10(thatValue)+1), 4);
				end
				
				self:settextf("%04i", thatValue);
				self:AddAttribute(0,{Length = 4 - digits; Diffuse = color("#222222")});
			end;
		};
	};
end;

local function CreatePaneDisplayItemB( _pnPlayer, _sLabel, _rcRadarCategory )
	return Def.ActorFrame {
		LoadFont("Common Normal") .. {
			Text=THEME:GetString("RadarCategory",_sLabel);
			InitCommand=function(self) self:horizalign(left); self:x(-30); end;
			OnCommand=function(self) self:zoom(0.5875); self:shadowlength(1); end;
		};
		Def.Quad{
			InitCommand=function(self) self:horizalign(left); self:x(20); self:diffuse(Color.Gray or {0.5,0.5,0.5,1}); end;
			OnCommand=function(self) self:zoomy(8); self:zoomx(150); self:shadowlength(1); end;
		};
		Def.Quad{
			InitCommand=function(self) self:horizalign(left); self:x(20); self:diffuse(Color.White or {1,1,1,1}); self:zoomy(8); self:zoomx(0); self:shadowlength(1); end;
			OnCommand=function(self) self:playcommand("Set"); end;
			CurrentSongChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentStepsP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set"); end;
			SetCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				self:stoptweening()
				if not song and not course then
					self:linear(0.3):zoomx(0)
				else
					self:linear(0.3):zoomx(math.min(scale(GetRadarData( _pnPlayer, _rcRadarCategory ),0,4.5,0,150),150));
				end
			end;
			OffCommand=function(self)
				self:stoptweening();
			end;
		};
		--[[LoadFont("Common Normal") .. {
			Text=string.format("%.3f", 0);
			InitCommand=function(self) self:horizalign(right); self:x(40); end;
			OnCommand=function(self) self:zoom(0.5875); self:shadowlength(1); end;
			CurrentSongChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentStepsP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set"); end;
			SetCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				
				if not song and not course then
					self:settextf("%.3f", 0);
				else
					self:settextf("%.3f", GetRadarData( _pnPlayer, _rcRadarCategory ) );
				end
			end;
		};]]
	};
end;

--[[local function CreatePaneDisplayGraph( _pnPlayer, _sLabel, _rcRadarCategory )
	return Def.ActorFrame {
		LoadFont("Common Normal") .. {
			Text=_sLabel;
			InitCommand=function(self) self:horizalign(left); end;
			OnCommand=function(self) self:zoom(0.5); self:shadowlength(1); end;
		};
		Def.Quad { 
			InitCommand=function(self) self:x(12); self:zoomto(50,10); self:horizalign(left); end;
			OnCommand=function(self) self:diffuse(Color("Black")); self:shadowlength(1); self:diffusealpha(0.5); end;
		};
		Def.Quad {
			InitCommand=function(self) self:x(12); self:zoomto(50,10); self:horizalign(left); end;
			OnCommand=function(self) self:shadowlength(0); self:diffuse(Color("Green")); self:diffusebottomedge(ColorLightTone(Color("Green"))); end;
			CurrentSongChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentStepsP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set"); end;
			SetCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				if not song and not course then
					self:stoptweening();
					self:decelerate(0.2);
					self:zoomtowidth(0);
				else
					self:stoptweening();
					self:decelerate(0.2);
					self:zoomtowidth( clamp(GetRadarData( _pnPlayer, _rcRadarCategory ) * 50,0,50) );
				end
			end;
		};
		LoadFont("Common Normal") .. {
			InitCommand=function(self) self:x(14); self:zoom(0.5); self:halign(0); end;
			OnCommand=function(self) self:shadowlength(1); self:strokecolor(color("0.15,0.15,0.15,0.625")); end;
			CurrentSongChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentStepsP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
			CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set"); end;
			SetCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				if not song and not course then
					self:settext("")
				else
					self:settextf("%i%%", GetRadarData( _pnPlayer, _rcRadarCategory ) * 100 );
				end
			end;
		};
	};
end;]]

--[[ Numbers ]]
t[#t+1] = Def.ActorFrame {
	LoadActor("BG-1")..{
		InitCommand=function(self) self:zoom(0.5); end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set"); end;
		CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
		CurrentStepsP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
		CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
		CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
		CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set"); end;
		SetCommand=function(self)
			self:stoptweening()
			self:linear(0.3):diffuse(GetColor(iPN))
		end;
	};
	LoadActor("BG-2")..{
		InitCommand=function(self) self:zoom(0.5); end;
	};
	
	
	LoadFont("Common Normal") .. {
		InitCommand=function(self) self:horizalign(left); self:x(-55); self:y(-52); self:zoom(0.75); self:shadowlength(1); end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set"); end;
		CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
		CurrentStepsP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
		CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Set"); end;
		CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Set"); end;
		CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set"); end;
		SetCommand=function(self)
			self:stoptweening()
			self:settext(Str_Step(iPN))
			--self:diffuse({0,0,0,1})
			self:linear(0.3):diffuse(GetColor(iPN))
		end;
	};
	
	--SEG A
	Def.ActorFrame{
		InitCommand=function(self) self:diffusealpha(1); end;
		OnCommand=function(self) self:queuecommand("GOIWAP"); end;
		GOIWAPCommand=function(self) self:sleep(10); self:decelerate(1); self:diffusealpha(0); self:sleep(3); self:decelerate(1); self:diffusealpha(1); self:queuecommand("GOIWAP"); end;
		OffCommand=function(self)
			self:stoptweening();
		end;
		CreatePaneDisplayItemA( iPN, "Taps", 'RadarCategory_TapsAndHolds' ) .. {
			InitCommand=function(self) self:x(-60); self:y(-30+5); self:zoom(1.15); end;
		};
		CreatePaneDisplayItemA( iPN, "Holds", 'RadarCategory_Holds' ) .. {
			InitCommand=function(self) self:x(-60); self:y(-13+5); self:zoom(1.15); end;
		};
		CreatePaneDisplayItemA( iPN, "Jumps", 'RadarCategory_Jumps' ) .. {
			InitCommand=function(self) self:x(-60); self:y(4+5); self:zoom(1.15); end;
		};
		CreatePaneDisplayItemA( iPN, "Hands", 'RadarCategory_Hands' ) .. {
			InitCommand=function(self) self:x(-60); self:y(21+5); self:zoom(1.15); end;
		};
		
		CreatePaneDisplayItemA( iPN, "Rolls", 'RadarCategory_Rolls' ) .. {
			InitCommand=function(self) self:x(50); self:y(-30+5); self:zoom(1.15); end;
		};
		CreatePaneDisplayItemA( iPN, "Mines", 'RadarCategory_Mines' ) .. {
			InitCommand=function(self) self:x(50); self:y(-13+5); self:zoom(1.15); end;
		};
		CreatePaneDisplayItemA( iPN, "Lifts", 'RadarCategory_Lifts' ) .. {
			InitCommand=function(self) self:x(50); self:y(4+5); self:zoom(1.15); end;
		};
		CreatePaneDisplayItemA( iPN, "Fakes", 'RadarCategory_Fakes' ) .. {
			InitCommand=function(self) self:x(50); self:y(21+5); self:zoom(1.15); end;
		};
	};
	
	--SEG B
	Def.ActorFrame{
		InitCommand=function(self) self:visible(true); self:diffusealpha(0); end;
		OnCommand=function(self) self:queuecommand("GOIWAP"); end;
		GOIWAPCommand=function(self) self:sleep(10); self:decelerate(1); self:diffusealpha(1); self:sleep(3); self:decelerate(1); self:diffusealpha(0); self:queuecommand("GOIWAP"); end;
		OffCommand=function(self)
			self:stoptweening();
		end;
		CreatePaneDisplayItemB( iPN, "Stream", 'RadarCategory_Stream' ) .. {
			InitCommand=function(self) self:x(-60); self:y(-25); self:zoom(0.9); end;
		};
		CreatePaneDisplayItemB( iPN, "Voltage", 'RadarCategory_Voltage' ) .. {
			InitCommand=function(self) self:x(-60); self:y(-25+(51/4)*1); self:zoom(0.9); end;
		};
		CreatePaneDisplayItemB( iPN, "Air", 'RadarCategory_Air' ) .. {
			InitCommand=function(self) self:x(-60); self:y(-25+(51/4)*2); self:zoom(0.9); end;
		};
		CreatePaneDisplayItemB( iPN, "Freeze", 'RadarCategory_Freeze' ) .. {
			InitCommand=function(self) self:x(-60); self:y(-25+(51/4)*3); self:zoom(0.9); end;
		};
		CreatePaneDisplayItemB( iPN, "Chaos", 'RadarCategory_Chaos' ) .. {
			InitCommand=function(self) self:x(-60); self:y(-25+(51/4)*4); self:zoom(0.9); end;
		};
	};
	
	
};
return t;