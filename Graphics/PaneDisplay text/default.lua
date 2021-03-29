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
		LoadFont("Common Normal") .. {
			Text=THEME:GetString("RadarCategory",_sLabel);
			InitCommand=cmd(horizalign,left;x,-30);
			OnCommand=cmd(zoom,0.5875;shadowlength,1);
		};
		LoadFont("Common Normal") .. {
			Text=string.format("%04i", 0);
			InitCommand=cmd(horizalign,right;x,40);
			OnCommand=cmd(zoom,0.5875;shadowlength,1);
			CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
			SetCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				if not song and not course then
					self:settextf("%04i", 0);
				else
					self:settextf("%04i", GetRadarData( _pnPlayer, _rcRadarCategory ) );
				end
			end;
		};
	};
end;

local function CreatePaneDisplayItemB( _pnPlayer, _sLabel, _rcRadarCategory )
	return Def.ActorFrame {
		LoadFont("Common Normal") .. {
			Text=THEME:GetString("RadarCategory",_sLabel);
			InitCommand=cmd(horizalign,left;x,-30);
			OnCommand=cmd(zoom,0.5875;shadowlength,1);
		};
		Def.Quad{
			InitCommand=cmd(horizalign,left;x,20;diffuse,Color.Gray or {0.5,0.5,0.5,1});
			OnCommand=cmd(zoomy,8;zoomx,150;shadowlength,1);
		};
		Def.Quad{
			InitCommand=cmd(horizalign,left;x,20;diffuse,Color.White or {1,1,1,1};zoomy,8;zoomx,0;shadowlength,1;);
			OnCommand=cmd(playcommand,"Set");
			CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
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
			InitCommand=cmd(horizalign,right;x,40);
			OnCommand=cmd(zoom,0.5875;shadowlength,1);
			CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
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
			InitCommand=cmd(horizalign,left);
			OnCommand=cmd(zoom,0.5;shadowlength,1);
		};
		Def.Quad { 
			InitCommand=cmd(x,12;zoomto,50,10;horizalign,left);
			OnCommand=cmd(diffuse,Color("Black");shadowlength,1;diffusealpha,0.5);
		};
		Def.Quad {
			InitCommand=cmd(x,12;zoomto,50,10;horizalign,left);
			OnCommand=cmd(shadowlength,0;diffuse,Color("Green");diffusebottomedge,ColorLightTone(Color("Green")));
			CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
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
			InitCommand=cmd(x,14;zoom,0.5;halign,0;);
			OnCommand=cmd(shadowlength,1;strokecolor,color("0.15,0.15,0.15,0.625"));
			CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
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
		InitCommand=cmd(zoom,0.5);
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
		SetCommand=function(self)
			self:stoptweening()
			self:linear(0.3):diffuse(GetColor(iPN))
		end;
	};
	LoadActor("BG-2")..{
		InitCommand=cmd(zoom,0.5);
	};
	
	
	LoadFont("Common Normal") .. {
		InitCommand=cmd(horizalign,left;x,-55;y,-52;zoom,0.75;shadowlength,1);
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
		SetCommand=function(self)
			self:stoptweening()
			self:settext(Str_Step(iPN))
			--self:diffuse({0,0,0,1})
			self:linear(0.3):diffuse(GetColor(iPN))
		end;
	};
	
	--SEG A
	Def.ActorFrame{
		InitCommand=cmd(diffusealpha,1);
		OnCommand=cmd(queuecommand,"GOIWAP");
		GOIWAPCommand=cmd(sleep,3;decelerate,1;diffusealpha,0;sleep,3;decelerate,1;diffusealpha,1;queuecommand,"GOIWAP");
		OffCommand=function(self)
			self:stoptweening();
		end;
		CreatePaneDisplayItemA( iPN, "Taps", 'RadarCategory_TapsAndHolds' ) .. {
			InitCommand=cmd(x,-60;y,-30+5;zoom,1.15);
		};
		CreatePaneDisplayItemA( iPN, "Holds", 'RadarCategory_Holds' ) .. {
			InitCommand=cmd(x,-60;y,-13+5;zoom,1.15);
		};
		CreatePaneDisplayItemA( iPN, "Jumps", 'RadarCategory_Jumps' ) .. {
			InitCommand=cmd(x,-60;y,4+5;zoom,1.15);
		};
		CreatePaneDisplayItemA( iPN, "Hands", 'RadarCategory_Hands' ) .. {
			InitCommand=cmd(x,-60;y,21+5;zoom,1.15);
		};
		
		CreatePaneDisplayItemA( iPN, "Rolls", 'RadarCategory_Rolls' ) .. {
			InitCommand=cmd(x,50;y,-30+5;zoom,1.15);
		};
		CreatePaneDisplayItemA( iPN, "Mines", 'RadarCategory_Mines' ) .. {
			InitCommand=cmd(x,50;y,-13+5;zoom,1.15);
		};
		CreatePaneDisplayItemA( iPN, "Lifts", 'RadarCategory_Lifts' ) .. {
			InitCommand=cmd(x,50;y,4+5;zoom,1.15);
		};
		CreatePaneDisplayItemA( iPN, "Fakes", 'RadarCategory_Fakes' ) .. {
			InitCommand=cmd(x,50;y,21+5;zoom,1.15);
		};
	};
	
	--SEG B
	Def.ActorFrame{
		InitCommand=cmd(visible,true;diffusealpha,0);
		OnCommand=cmd(queuecommand,"GOIWAP");
		GOIWAPCommand=cmd(sleep,3;decelerate,1;diffusealpha,1;sleep,3;decelerate,1;diffusealpha,0;queuecommand,"GOIWAP");
		OffCommand=function(self)
			self:stoptweening();
		end;
		CreatePaneDisplayItemB( iPN, "Stream", 'RadarCategory_Stream' ) .. {
			InitCommand=cmd(x,-60;y,-25;zoom,0.9);
		};
		CreatePaneDisplayItemB( iPN, "Voltage", 'RadarCategory_Voltage' ) .. {
			InitCommand=cmd(x,-60;y,-25+(51/4)*1;zoom,0.9);
		};
		CreatePaneDisplayItemB( iPN, "Air", 'RadarCategory_Air' ) .. {
			InitCommand=cmd(x,-60;y,-25+(51/4)*2;zoom,0.9);
		};
		CreatePaneDisplayItemB( iPN, "Freeze", 'RadarCategory_Freeze' ) .. {
			InitCommand=cmd(x,-60;y,-25+(51/4)*3;zoom,0.9);
		};
		CreatePaneDisplayItemB( iPN, "Chaos", 'RadarCategory_Chaos' ) .. {
			InitCommand=cmd(x,-60;y,-25+(51/4)*4;zoom,0.9);
		};
	};
	
	
};
return t;