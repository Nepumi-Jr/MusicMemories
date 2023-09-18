local PlayerNumber = ...
assert( PlayerNumber )

local bpm_text_zoom = 0.875

local song_bpms= {}
local bpm_text= "??? - ???"
local function format_bpm(bpm)
	return ("%.0f"):format(bpm)
end

-- Courses don't have GetDisplayBpms.
if GAMESTATE:GetCurrentSong() then
	song_bpms= GAMESTATE:GetCurrentSong():GetDisplayBpms()
	song_bpms[1]= math.round(song_bpms[1])
	song_bpms[2]= math.round(song_bpms[2])
	if song_bpms[1] == song_bpms[2] then
		bpm_text= format_bpm(song_bpms[1])
	else
		bpm_text= format_bpm(song_bpms[1]) .. " - " .. format_bpm(song_bpms[2])
	end
end

local t = Def.ActorFrame {
    Def.Quad{
        InitCommand=function(self) self:zoomx(300); self:zoomy(25); self:diffuse(color("#222222")); self:fadeleft(0.12); self:faderight(0.12); end;
    };
	LoadFont("Common Normal") .. {
		Text=ToEnumShortString(PlayerNumber);
		Name="PlayerShortName",
		InitCommand=function(self) self:x(-104); self:maxwidth(32); end,
		OnCommand=function(self) self:diffuse(PlayerColor(PlayerNumber)); self:shadowlength(1); end
	},
	LoadFont("Common Normal") .. {
		Text=bpm_text;
		Name="BPMRangeOld",
		InitCommand=function(self) self:x(-40); self:maxwidth(88/bpm_text_zoom); end,
		OnCommand=function(self) self:shadowlength(1); self:zoom(bpm_text_zoom); end
	},
	LoadActor(THEME:GetPathG("Arrow","Right"),color("#CCCCCC")) .. {
		Name="Seperator",
		InitCommand=function(self) self:x(14):zoom(0.2) end
	},
	LoadFont("Common Normal") .. {
		Text="100 - 200000";
		Name="ILoveStepmania",
		InitCommand= function(self)
			self:x(68):maxwidth(88/bpm_text_zoom):shadowlength(1):zoom(bpm_text_zoom)
			local speed, mode= GetSpeedModeAndValueFromPoptions(PlayerNumber)
			self:playcommand("SpeedChoiceChanged", {pn= PlayerNumber, mode= mode, speed= speed})
		end,
		BPMWillNotChangeCommand=function(self) self:stopeffect(); end,
		BPMWillChangeCommand=function(self) self:diffuseshift(); self:effectcolor1(Color.White); self:effectcolor2(Color.Green); end,
		SpeedChoiceChangedMessageCommand= function(self, param)
			if param.pn ~= PlayerNumber then return end
			local text= ""
			local no_change= true
			if param.mode == "x" then
				if not song_bpms[1] then
					text= "??? - ???"
				elseif song_bpms[1] == song_bpms[2] then
					text= format_bpm(song_bpms[1] * param.speed*.01)
				else
					text= format_bpm(song_bpms[1] * param.speed*.01) .. " - " ..
						format_bpm(song_bpms[2] * param.speed*.01)
				end
				no_change= param.speed == 100
			elseif param.mode == "m" then
				no_change= param.speed == song_bpms[2]
				if song_bpms[1] == song_bpms[2] then
					text= param.mode .. param.speed
				else
					local factor= song_bpms[1] / song_bpms[2]
					text= param.mode .. format_bpm(param.speed * factor) .. " - "
						.. param.mode .. param.speed
				end
			else
				text= param.mode .. param.speed
				no_change= param.speed == song_bpms[2] and song_bpms[1] == song_bpms[2]
			end
			self:settext(text)
			if no_change then
				self:queuecommand("BPMWillNotChange")
			else
				self:queuecommand("BPMWillChange")
			end
		end
	},
	LoadFont("Common Normal") .. {
		Text="Sample Text",
		Name="SpeedModeExplanation",
		InitCommand= function(self)
			self:x(68):y(10):maxwidth(88/(bpm_text_zoom*0.4)):shadowlength(1):zoom(bpm_text_zoom*0.4)
			local speed, mode= GetSpeedModeAndValueFromPoptions(PlayerNumber)
			self:playcommand("SpeedChoiceChanged", {pn= PlayerNumber, mode= mode, speed= speed})
		end,
		SpeedChoiceChangedMessageCommand= function(self, param)
			if param.pn ~= PlayerNumber then return end
			local textModeExplanation = {
				x = "",
				C = "Constant BPM",
				m = "Maximum BPM",
				a = "Average BPM",
				ca = "Constant Average BPM",
				av = "AutoVelocity BPM",
			}
			if textModeExplanation[param.mode] then
				self:settext(textModeExplanation[param.mode])
			else
				--placeholder for now
				self:settext("?????")
			end
		end
	}
}

return t