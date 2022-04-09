local PlayerNumber = ...
assert( PlayerNumber )



local song_bpms= {}
local function format_bpm(bpm)
	return ("%.0f"):format(bpm)
end

-- Courses don't have GetDisplayBpms.
if GAMESTATE:GetCurrentSong() then
	song_bpms= GAMESTATE:GetCurrentSong():GetDisplayBpms()
	song_bpms[1]= math.round(song_bpms[1])
	song_bpms[2]= math.round(song_bpms[2])
	if song_bpms[1] == song_bpms[2] then
		T1 = song_bpms[1]
		T2 = song_bpms[1]
	else
		T1 = song_bpms[1]
		T2 = song_bpms[2]
	end
end

local t = Def.ActorFrame {
	Def.Sprite {
		Texture="_Down Receptor Go";
		Frame0000=0;
		Delay0000=1;
		Frame0001=1;
		Delay0001=1;
		Frame0002=2;
		Delay0002=1;
		Frame0003=3;
		Delay0003=1;
		InitCommand=function(self) self:y(100); self:rotationz(0); self:effectclock("beat"); self:diffuseramp(); self:effectcolor1(0.1,0.1,0.1,1); self:effectcolor2(1,1,1,1); self:effectperiod(0.5); self:effecttiming(0.25,0.50,0,0.25); self:effectoffset(-0.25); end;
	};
	LoadActor("black") .. {
	Name="Nep-Nep-Arrow",
	OnCommand=function(self)
					y = 480+50
					s = 1
					m = 1
	song_bpms= GAMESTATE:GetCurrentSong():GetDisplayBpms()
	song_bpms[1]= math.round(song_bpms[1])
	song_bpms[2]= math.round(song_bpms[2])
	if song_bpms[1] == song_bpms[2] then
		bpm = format_bpm(song_bpms[1])
	else
		T1 = format_bpm(song_bpms[1])
		T2 = format_bpm(song_bpms[2])
	end
	bpm = T2
			self:playcommand('Hi')
			self:rotationz(0)
			end,
	HiCommand=function(self)
		if y <= 100 then
			y = 480+50
			if m == 1 and song_bpms[1] ~= song_bpms[2] then
			bpm = T1
			m = 2
			elseif m == 2 and song_bpms[1] ~= song_bpms[2] then
			bpm = T2
			m = 1
			end
		else
			y = y - (0.02 * s * bpm)
		end
		self:y(y)
		self:sleep(0.02)
		self:queuecommand('Hi')
		end,
	},
LoadFont("_8-bit madness 24px")..{
Name="allofWTFcommand",
InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:diffuse(color("#FF1100")); end,
		OnCommand=function(self)
		F = math.random(5,50)
		local speed, mode= GetSpeedModeAndValueFromPoptions(PlayerNumber)
		self:playcommand("SpeedChoiceChanged", {pn= PlayerNumber, mode= mode, speed= speed})
		--self:settext(speed.."/"..mode)
		
		self:sleep(0.02)
		self:queuecommand('loop')
		end,
		SpeedChoiceChangedMessageCommand= function(self, param)
			if param.pn ~= PlayerNumber then return end
			local no_change= true
			if param.mode == "x" then
				if not song_bpms[1] then
					bpm = 800
				else
				s = param.speed*.01
			if m == 1 and song_bpms[1] ~= song_bpms[2] then
			bpm = song_bpms[1]
			elseif m == 2 and song_bpms[1] ~= song_bpms[2] then
			bpm = song_bpms[2]
			else
			bpm = song_bpms[1]
			end
			T1 = song_bpms[1]
			T2 = song_bpms[2]
				end
				no_change= param.speed == 100
			elseif param.mode == "C" then
				bpm = 1
				T1 = 1
				T2 = 1
				s = param.speed
			else
				no_change= param.speed == song_bpms[2]
				if song_bpms[1] == song_bpms[2] then
					s = param.speed
					bpm = param.speed
				else
					local factor= song_bpms[1] / song_bpms[2]
					s = 1
					T1 = format_bpm(param.speed*factor)
					T2 = param.speed
			if m == 1 then
			bpm = format_bpm(param.speed*factor)
			elseif m == 2 then
			bpm = param.speed
			end
				end
			end
			--self:settext(m..'\nSpeed:'..s..' Bpm:'..bpm..'\n'..T1..'/'..T2)
		end
}
}

return t