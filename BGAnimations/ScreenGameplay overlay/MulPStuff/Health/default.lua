local PN=...;


if GAMESTATE:GetPlayerState(PN):GetCurrentPlayerOptions():LifeSetting() == "LifeType_Battery" then
	return Def.ActorFrame{};
end
local colorSegments = {
	Color.Red,
	Color.Yellow,
	Color.Green,
	Color.SkyBlue
};
local lifeWidth = 248

if GAMESTATE:GetPlayerState(PN):GetPlayerOptions("ModsLevel_Preferred"):FailSetting() == "FailType_80Percent" then
	colorSegments = {
		Color.SkyBlue,
		ColorMidTone(Color.SkyBlue),
		Color.SkyBlue,
		ColorMidTone(Color.SkyBlue),
		Color.SkyBlue,
		ColorMidTone(Color.SkyBlue),
		Color.SkyBlue,
		ColorMidTone(Color.SkyBlue),
		Color.Red,
		ColorMidTone(Color.Red)
	};
elseif GAMESTATE:GetPlayerState(PN):GetPlayerOptions("ModsLevel_Preferred"):FailSetting() == "FailType_Off" then
	colorSegments = {
		Color.Green,
		Color.Greener,
		Color.Green,
		Color.Greener
	};
end



local NumF="_computer pixel-7 30px";
local NOWB = 0;
local PX = 0;

if PN == PLAYER_1 then
	PX=SCREEN_CENTER_X*0.5-126.25;
else
	PX=SCREEN_CENTER_X*1.5-120.75;
end

local clmain = GameColor.PlayerDarkColors[PN] or {0,0,0,1};
local clsub = GameColor.PlayerColors[PN] or {1,1,1,1};


local beatPercent = 0.6 * (1 / #colorSegments)

local beatUpdateSync = function(self)
	local c = self:GetChildren();
	c.bBeat:cropright(math.min(math.mod(GAMESTATE:GetSongBeat() + 200,1)*2, 1))
end;

local isHot = true;
local isHot2 = true;


local lifeStream = Def.ActorFrame{
	InitCommand=function(self) self:x(PX); self:y(SCREEN_CENTER_Y-210.25+22); end;
	LifeChangedMessageCommand=function(self,params)
		if(params.Player == PN) then

			local this = self:GetChildren()
			local life = params.LifeMeter:GetLife()

			local per = math.max(0, life - beatPercent)


			this["BeatBar"]:stoptweening():decelerate(0.1)

			if isHot2 then
				if life ~= 1 then
					self:stoptweening():decelerate(0.5):diffusealpha(1)
					isHot2 = false;
				end
			else
				if life == 1 then
					self:stoptweening():decelerate(0.5):diffusealpha(0)
					isHot2 = true;
				end
			end

			for i = 1,#colorSegments do
				this["Seg"..i]:stoptweening():decelerate(0.1)
				this["Seg"..i]:cropright(clamp(scale(per * #colorSegments, i - 1, i, 1, 0), 0, 1))
			end

			local segmentIndex = math.ceil(life * #colorSegments)
			this["BeatBar"]:diffuse(ColorLightTone(colorSegments[segmentIndex] or colorSegments[1]))
			this["BeatBar"]:x(per * lifeWidth)
			this["BeatBar"]:GetChild("Reloader"):GetChild("bBeat"):zoomx(math.min(beatPercent, life) * lifeWidth)
		end
	end;

	Def.ActorFrame{
		Name = "BeatBar";
		Def.ActorFrame{
			Name = "Reloader";
			OnCommand = function(self)
				self:SetUpdateFunction(beatUpdateSync)
			end;
			Def.Quad{
				Name = "bBeat";
				InitCommand=function(self) self:horizalign(left):zoomx(lifeWidth*beatPercent):zoomy(16):faderight(0.1):diffuse(color("#cccccc")) end;
			};
		};
	};

};

for i = 1,#colorSegments do
	lifeStream[#lifeStream+1] = LoadActor(THEME:GetPathG("StreamDisplay", "passing"))..{
		Name = "Seg"..i;
		InitCommand=function(self) self:horizalign(left):x(lifeWidth / #colorSegments *(i-1)):zoomx(2/#colorSegments):zoomy(0.7) end;
		OnCommand=function(self)
			if math.mod(#colorSegments, 2) == 0 then
				local thisSegmentIndex = math.mod((i - 1), #colorSegments/2)
				local startTextureX = thisSegmentIndex * 2/#colorSegments
				local endTextureX = startTextureX + 2/#colorSegments
				self:customtexturerect(startTextureX,0,endTextureX,1);
			else
				lua.ReportScriptError("WARNING : StreamDisplay passing texture is not divisible by 2")
				self:customtexturerect(0,0,2/#colorSegments,1);
			end
			self:texcoordvelocity(-1.5,0);
			self:diffuse(colorSegments[i]):diffusebottomedge(ColorDarkTone(colorSegments[i]))
		end;
	};
end

local t = Def.ActorFrame{

	lifeStream;

	Def.ActorFrame{
		LifeChangedMessageCommand=function(self,params)
			if(params.Player == PN) then
				local life = params.LifeMeter:GetLife()
				if isHot then
					if life ~= 1 then
						self:GetChildren()["lifeMax"]:stoptweening():decelerate(0.5):diffusealpha(0)
						self:GetChildren()["lifeBG"]:stoptweening():decelerate(0.5):diffusealpha(0)
						self:GetChildren()["lifeMaxUp"]:stoptweening():decelerate(0.5):diffusealpha(0)
						isHot = false;
					end
				else
					if life == 1 then
						self:GetChildren()["lifeMax"]:stoptweening():decelerate(0.5):diffusealpha(1)
						self:GetChildren()["lifeBG"]:stoptweening():decelerate(0.5):diffusealpha(1)
						self:GetChildren()["lifeMaxUp"]:stoptweening():decelerate(0.5):diffusealpha(1)
						isHot = true;
					end
				end

			end
		end;
		Def.ActorFrame{
			Name = "lifeBG";
			Def.Quad{
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-210.25+22); self:horizalign(left); self:x(PX); self:zoomy(15); self:zoomx(lifeWidth); self:diffusealpha(1); end;
				OnCommand=function(self) self:effectclock("beat"); self:diffuseramp(); self:effectcolor1({1,1,1,0.7}); self:effectcolor2({1,1,1,0.2}); self:effectperiod(1/16); end;
			};
		};
		LoadActor("Life_Max2.png")..{
			Name = "lifeMax";
			InitCommand=function(self) self:y(SCREEN_CENTER_Y-210.25+22); self:horizalign(left); self:x(PX); self:zoomy(15/128); self:effectclock("beat"); self:customtexturerect(0,0.9,0.9,1); self:texcoordvelocity(0,0.2); end;
			OnCommand=function(self) self:blend("BlendMode_WeightedMultiply"); end;
		};
		LoadActor("Life_MaxUp.png")..{
			Name = "lifeMaxUp";
			InitCommand=function(self) self:y(SCREEN_CENTER_Y-210.25+22); self:horizalign(left); self:zoomy(15/256); self:x(PX); self:customtexturerect(0,0,0.9,0.1); self:texcoordvelocity(0,0.6); end;
			OnCommand=function(self) self:effectclock("beat"); self:diffuseramp(); self:effectcolor1({1,1,1,1}); self:effectcolor2({0.7,0.7,0.7,1}); self:effectperiod(0.5); self:effecttiming(0.25,0.50,0,0.25); self:effectoffset(-0.25); end;
		};
	};

	LoadActor("Life_Bar.png")..{
		InitCommand=function(self) self:x(PX); self:y(SCREEN_CENTER_Y-210.25+22); self:horizalign(left); self:cropright(1); end;
		LifeChangedMessageCommand=function(self,params)
			local life = params.LifeMeter:GetLife()
			if (params.Player == PN) then
				self:finishtweening():decelerate(0.1):cropright(1-life)
			end
		end;
	};

	Def.ActorFrame{
		InitCommand=function(self) self:x(PX); self:y(SCREEN_CENTER_Y-210.25+22); end;
		LifeChangedMessageCommand=function(self,params)
			if(params.Player == PN) then
				local this = self:GetChildren()
				local life = params.LifeMeter:GetLife()

				local segmentIndex = math.ceil(life * #colorSegments)
				this["GlowColor"]:diffuse(colorSegments[segmentIndex] or colorSegments[1])

				self:finishtweening():decelerate(0.1):x(PX+life*lifeWidth)
			end
		end;
		LoadActor("LifeStick.png");
		LoadActor("LifeStickGlow")..{
			Name = "GlowColor";
		};


	};


	Def.Quad{
		InitCommand=function(self)
			self:visible(TP.Battle.IsBattle and TP.Battle.Mode == "Dr" and TP.Battle.Hidden);
		end;
		OnCommand=function(self) self:zoomy(23.75*0.64); self:zoomx(246.5); self:y(SCREEN_CENTER_Y-210.25+22); self:horizalign(left); self:x(PX)
			self:effectclock("beat"); self:diffuseramp(); self:effectcolor1(clmain); self:effectcolor2(clsub); self:effectperiod(0.5); self:effecttiming(0.25,0.50,0,0.25); self:effectoffset(-0.25); end;
		GETOUTOFGAMESMMessageCommand=function(self) self:stoptweening(); self:sleep(0.7); self:accelerate(0.5); self:zoomy(0); end;
	};
};
return t;