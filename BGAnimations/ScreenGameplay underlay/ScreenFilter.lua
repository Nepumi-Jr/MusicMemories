--[[ Screen Filter ]]
local numPlayers = GAMESTATE:GetNumPlayersEnabled()
local center1P = PREFSMAN:GetPreference("Center1Player")

local padding = 15 * 2

local filterColor = color("#000000")
local filterAlphas = {
	PlayerNumber_P1 = 1,
	PlayerNumber_P2 = 1,
	Default = 0,
}

local t = Def.ActorFrame{};

local style = GAMESTATE:GetCurrentStyle()
local cols = style:ColumnsPerPlayer()
local styleType = ToEnumShortString(style:GetStyleType())
local filterWidth = (96 * cols) + padding
local stepsType = style:GetStepsType()

if numPlayers == 1 then
	local player = GAMESTATE:GetMasterPlayerNumber()
	local pNum = (player == PLAYER_1) and 1 or 2
	filterWidth = style:GetWidth(player) + padding

	if TP[ToEnumShortString(player)].ActiveModifiers.FilterPlayer == 'Hide' then
		filterAlphas[player] = 1;
	elseif TP[ToEnumShortString(player)].ActiveModifiers.FilterPlayer == "Nope" then
		filterAlphas[player] = 0;
	else
		filterAlphas[player] = TP[ToEnumShortString(player)].ActiveModifiers.FilterPlayer:gsub("%%","")/100;
	end

	local pos;
	-- [ScreenGameplay] PlayerP#Player*Side(s)X
	if center1P then
		pos = SCREEN_CENTER_X
	elseif stepsType == "StepsType_Dance_Solo" then
		pos = SCREEN_CENTER_X
	else
		local metricName = string.format("PlayerP%i%sX",pNum,styleType)
		pos = THEME:GetMetric("ScreenGameplay",metricName)
	end
	t[#t+1] = Def.Quad{
		Name="SinglePlayerFilter";
		InitCommand=function(self) self:x(pos); self:CenterY(); self:zoomto(filterWidth,SCREEN_HEIGHT); self:diffusecolor(filterColor); self:diffusealpha(filterAlphas[player]); end;
	};
	t[#t+1] = LoadActor("Border.png")..{
		Name="BorderRight";
		InitCommand=function(self) self:x(pos + filterWidth / 2); self:CenterY(); self:zoomtoheight(SCREEN_HEIGHT); self:diffusecolor(PlayerColor(player)); self:visible(filterAlphas[player] ~= 0); end;
	};
	t[#t+1] = LoadActor("Border.png")..{
		Name="BorderLeft";
		InitCommand=function(self) self:x(pos - filterWidth / 2); self:CenterY(); self:zoomtoheight(SCREEN_HEIGHT); self:diffusecolor(PlayerColor(player)); self:visible(filterAlphas[player] ~= 0); end;
	};
else
	-- two players... a bit more complex.
	if styleType == "TwoPlayersSharedSides" then
		-- routine, just use one in the center.
		local player = GAMESTATE:GetMasterPlayerNumber()
		local pNum = player == PLAYER_1 and 1 or 2
		filterWidth = style:GetWidth(player) + padding
		local metricName = "PlayerP".. pNum .."TwoPlayersSharedSidesX"
		t[#t+1] = Def.Quad{
			Name="RoutineFilter";
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenGameplay",metricName)); self:CenterY(); self:zoomto(filterWidth,SCREEN_HEIGHT); self:diffusecolor(filterColor); self:diffusealpha(filterAlphas[player]); end;
		};
		t[#t+1] = LoadActor("Border.png")..{
			Name="BorderRight";
			InitCommand=function(self) self:x(pos + filterWidth / 2); self:CenterY(); self:zoomtoheight(SCREEN_HEIGHT); self:diffusecolor(PlayerColor(PLAYER_1)); self:visible(filterAlphas[player] ~= 0); end;
		};
		t[#t+1] = LoadActor("Border.png")..{
			Name="BorderLeft";
			InitCommand=function(self) self:x(pos - filterWidth / 2); self:CenterY(); self:zoomtoheight(SCREEN_HEIGHT); self:diffusecolor(PlayerColor(PLAYER_2)); self:visible(filterAlphas[player] ~= 0); end;
		};
	else
		-- otherwise we need two separate ones. to the pairsmobile!
		for i, player in ipairs(PlayerNumber) do
			local pNum = (player == PLAYER_1) and 1 or 2
			filterWidth = style:GetWidth(player) + padding

			if TP[ToEnumShortString(player)].ActiveModifiers.FilterPlayer == 'Hide' then
				filterAlphas[player] = 1;
			elseif TP[ToEnumShortString(player)].ActiveModifiers.FilterPlayer == "Nope" then
				filterAlphas[player] = 0;
			else
				filterAlphas[player] = TP[ToEnumShortString(player)].ActiveModifiers.FilterPlayer:gsub("%%","")/100;
			end
			
			local metricName = string.format("PlayerP%i%sX",pNum,styleType)
			local pos = THEME:GetMetric("ScreenGameplay",metricName)
			t[#t+1] = Def.Quad{
				Name="Player"..pNum.."Filter";
				InitCommand=function(self) self:x(pos); self:CenterY(); self:zoomto(filterWidth,SCREEN_HEIGHT); self:diffusecolor(filterColor); self:diffusealpha(filterAlphas[player]); end;
			};
			t[#t+1] = LoadActor("Border.png")..{
				Name="Player"..pNum.."BorderRight";
				InitCommand=function(self) self:x(pos + filterWidth / 2); self:CenterY(); self:zoomtoheight(SCREEN_HEIGHT); self:diffusecolor(PlayerColor(player)); self:visible(filterAlphas[player] ~= 0); end;
			};
			t[#t+1] = LoadActor("Border.png")..{
				Name="Player"..pNum.."BorderLeft";
				InitCommand=function(self) self:x(pos - filterWidth / 2); self:CenterY(); self:zoomtoheight(SCREEN_HEIGHT); self:diffusecolor(PlayerColor(player)); self:visible(filterAlphas[player] ~= 0); end;
			};
		end
	end
end

return t;
