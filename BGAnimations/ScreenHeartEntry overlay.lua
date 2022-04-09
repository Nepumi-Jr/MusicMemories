local cursor_width_padding = 16
local cursor_spacing_value = 30

local heart_xs= {
	[PLAYER_1]= SCREEN_CENTER_X * 0.625,
	[PLAYER_2]= SCREEN_CENTER_X * 1.375,
}

local heart_entries= {}
for i, pn in ipairs(GAMESTATE:GetEnabledPlayers()) do
	local profile= PROFILEMAN:GetProfile(pn)
	if profile and profile:GetIgnoreStepCountCalories() then
		heart_entries[pn]= new_numpad_entry{
			Name= pn .. "_heart_entry",
			InitCommand= function(self) self:xy(heart_xs[pn], SCREEN_CENTER_Y+48); end,
			value = LoadFont("Common Large") .. {
				InitCommand=function(self) self:xy(0,-62); end,
				OnCommand=function(self) self:zoom(0.75); self:diffuse(PlayerColor(pn)); self:strokecolor(ColorDarkTone(PlayerColor(pn))); end;
				SetCommand=function(self, param)
					self:settext(param[1])
				end,
			},
			button = LoadFont("Common Normal") ..{
				InitCommand=function(self) self:shadowlength(1); end,
				SetCommand=function(self, param)
					self:settext(param[1])
				end,
				OnCommand=function(self) self:diffuse(color("0.8,0.8,0.8,1")); self:zoom(0.875); end,
				GainFocusCommand=function(self) self:finishtweening(); self:decelerate(0.125); self:zoom(1); self:diffuse(Color.White); end,
				LoseFocusCommand=function(self) self:finishtweening(); self:smooth(0.1); self:zoom(0.875); self:diffuse(color("0.8,0.8,0.8,1")); end
			},
			button_positions = {{-cursor_spacing_value, -cursor_spacing_value}, {0, -cursor_spacing_value}, {cursor_spacing_value, -cursor_spacing_value},
				{-cursor_spacing_value, 0},   {0, 0},   {cursor_spacing_value, 0},
				{-cursor_spacing_value, cursor_spacing_value}, {0, cursor_spacing_value},   {cursor_spacing_value, cursor_spacing_value},
				{-cursor_spacing_value, cursor_spacing_value*2}, {0, cursor_spacing_value*2},   {cursor_spacing_value, cursor_spacing_value*2}},
			cursor = Def.ActorFrame {
				-- Move whole container
				MoveCommand=function(self, param)
					self:stoptweening()
					self:decelerate(0.15)
					self:xy(param[1], param[2])
					if param[3] then
						self:z(param[3])
					end
				end,
				--
				LoadActor( THEME:GetPathG("_frame", "1D"),
					{ 2/18, 14/18, 2/18 },
					LoadActor(THEME:GetPathB("_frame", "cursors/rounded fill"))
				) .. {
					OnCommand=function(self) self:diffuse(PlayerDarkColor(pn)); end,
					FitCommand=function(self, param)
						self:playcommand("SetSize",{ Width=param:GetWidth()+cursor_width_padding, tween=function(self) self:stoptweening(); self:decelerate(0.15); end})
					end,
				},
				LoadActor( THEME:GetPathG("_frame", "1D"),
					{ 2/18, 14/18, 2/18 },
					LoadActor(THEME:GetPathB("_frame", "cursors/rounded gloss"))
				) .. {
					OnCommand=function(self) self:diffuse(PlayerColor(pn)); end,
					FitCommand=function(self, param)
						self:playcommand("SetSize",{ Width=param:GetWidth()+cursor_width_padding, tween=function(self) self:stoptweening(); self:decelerate(0.15); end})
					end,
				}
			},
			cursor_draw= "first",
			prompt = LoadFont("Common Bold") .. {
				Name="prompt",
				Text=THEME:GetString("ScreenHeartEntry", "Heart Rate"),
				InitCommand=function(self) self:xy(0,-96); end;
				OnCommand=function(self) self:shadowlength(1); self:skewx(-0.125); self:diffusebottomedge(color("#DDDDDD")); self:strokecolor(Color.Outline); end;
			},
			max_value= 300,
			auto_done_value= 100,
		}
	end
end

local function input(event)
	local pn= event.PlayerNumber
	if not pn then return end
	if event.type == "InputEventType_Release" then return end
	if not heart_entries[pn] then return end
	local done= heart_entries[pn]:handle_input(event.GameButton)
	if done then
		SOUND:PlayOnce(THEME:GetPathS("Common", "Start"))
		local all_done= true
		for pn, entry in pairs(heart_entries) do
			if not entry.done then all_done= false break end
		end
		if all_done then
			for pn, entry in pairs(heart_entries) do
				local profile= PROFILEMAN:GetProfile(pn)
				if profile and profile:GetIgnoreStepCountCalories() then
					local calories= profile:CalculateCaloriesFromHeartRate(
						entry.value, GAMESTATE:GetLastGameplayDuration())
					profile:AddCaloriesToDailyTotal(calories)
				end
			end
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
		end
	end
end

local timer_text
local function timer_update(self)
	local time= math.floor((self:GetSecsIntoEffect() % 60) * 10) / 10
	if time < 10 then
		timer_text:settext(("0%.1f"):format(time))
	else
		timer_text:settext(("%.1f"):format(time))
	end
end

local args= {
	--
	Def.ActorFrame{
		Name= "timer",
		InitCommand= function(self)
			self:effectperiod(2^16)
			timer_text= self:GetChild("timer_text")
			self:SetUpdateFunction(timer_update)
		end,
		OnCommand= function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(input)
		end,
		Def.BitmapText{
			Name= "timer_text", Font= "Common Normal", Text= "00.0",
			InitCommand= function(self) self:xy(SCREEN_CENTER_X, SCREEN_CENTER_Y-80); self:diffuse(Color.White); end,
			OnCommand= function(self) self:strokecolor(Color.Outline); end,
		}
	},
	Def.Quad {
		InitCommand=function(self) self:xy(SCREEN_CENTER_X+1, SCREEN_CENTER_Y-100+1); self:zoomto(2,2); end;
		OnCommand=function(self) self:diffuse(Color.Black); self:diffusealpha(0.5); self:linear(0.25); self:zoomtowidth(420); self:fadeleft(0.25); self:faderight(0.25); end;
	};
	Def.Quad {
		InitCommand=function(self) self:xy(SCREEN_CENTER_X, SCREEN_CENTER_Y-100); self:zoomto(2,2); end;
		OnCommand=function(self) self:diffuse(color("#ffd400")); self:shadowcolor(BoostColor(color("#ffd40077"),0.25)); self:linear(0.25); self:zoomtowidth(420); self:fadeleft(0.25); self:faderight(0.25); end;
	};
	Def.BitmapText {
		Name= "explanation", Font= "Common Large",
		Text= string.upper(THEME:GetString("ScreenHeartEntry", "Enter Heart Rate")),
		InitCommand= function(self) self:xy(SCREEN_CENTER_X, SCREEN_CENTER_Y-128); self:diffuse(Color.White); end,
		OnCommand=function(self) self:skewx(-0.125); self:diffuse(color("#ffd400")); self:strokecolor(ColorDarkTone(color("#ffd400"))); end}
	,

	Def.BitmapText{
		Name= "song_len_label", Font= "Common Normal",
		Text= THEME:GetString("ScreenHeartEntry", "Song Length"),
		InitCommand= function(self) self:xy(SCREEN_CENTER_X, SCREEN_CENTER_Y+192-32); self:diffuse(Color.White); end,
		OnCommand= function(self) self:shadowlength(1); end},
	Def.BitmapText{
		Name= "song_len", Font= "Common Normal",
		Text= SecondsToMMSS(GAMESTATE:GetLastGameplayDuration()),
		InitCommand= function(self) self:xy(SCREEN_CENTER_X, SCREEN_CENTER_Y+192-8); self:diffuse(Color.White); end,
		OnCommand= function(self) self:shadowlength(1); self:zoom(0.75); end,
	}

}

for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
	args[#args+1] = LoadActor(THEME:GetPathB("_frame","3x3"),"rounded black", 128, 192) .. {
		InitCommand=function(self) self:x(heart_xs[pn]); self:y(SCREEN_CENTER_Y+28); end,
	}
end

for pn, entry in pairs(heart_entries) do
	args[#args+1]= entry:create_actors()
end

return Def.ActorFrame(args)
