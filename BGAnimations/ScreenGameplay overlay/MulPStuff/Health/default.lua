local PN=...;


if GAMESTATE:GetPlayerState(PN):GetCurrentPlayerOptions():LifeSetting() == "LifeType_Battery" then
    return Def.ActorFrame{};
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
local firstOne = 2;
local isHot = true;



local t = Def.ActorFrame{

	Def.ActorFrame{
		LifeChangedMessageCommand=function(self,params)
			if(params.Player == PN) then
				local life = params.LifeMeter:GetLife()

				if isHot then
					if life ~= 1 then
						self:GetChildren()["lifeMax"]:stoptweening():decelerate(0.5):diffusealpha(0)
						self:GetChildren()["lifeBG"]:stoptweening():decelerate(0.5):diffusealpha(0)
						self:GetChildren()["lifeMaxUp"]:stoptweening():decelerate(0.5):diffusealpha(0)
						if SCREENMAN:GetTopScreen() and SCREENMAN:GetTopScreen():GetChild('LifeP'..(PN == PLAYER_1 and '1' or '2')) then
							SCREENMAN:GetTopScreen():GetChild('LifeP'..(PN == PLAYER_1 and '1' or '2')):stoptweening():decelerate(0.5):diffusealpha(1)
						end
						isHot = false;
					end
				else
					if life == 1 then
						self:GetChildren()["lifeMax"]:stoptweening():decelerate(0.5):diffusealpha(1)
						self:GetChildren()["lifeBG"]:stoptweening():decelerate(0.5):diffusealpha(1)
						self:GetChildren()["lifeMaxUp"]:stoptweening():decelerate(0.5):diffusealpha(1)
						if SCREENMAN:GetTopScreen() and SCREENMAN:GetTopScreen():GetChild('LifeP'..(PN == PLAYER_1 and '1' or '2')) then
							SCREENMAN:GetTopScreen():GetChild('LifeP'..(PN == PLAYER_1 and '1' or '2')):stoptweening():decelerate(0.5):diffusealpha(0)
						end
						isHot = true;
					end
				end

			end
		end;
		Def.ActorFrame{
			Name = "lifeBG";
			Def.Quad{
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-210.25+22); self:horizalign(left); self:x(PX); self:zoomy(15); self:zoomx(248); self:diffusealpha(1); end;
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
			if (params.Player == PN) then

				local life = params.LifeMeter:GetLife()

				self:finishtweening()
				
				if firstOne > 0 then
					self:linear(2.6)
					firstOne = firstOne - 1
				else
					self:decelerate(0.1)
				end
				
				self:cropright(1-life)


			end
		end;
	};

	Def.ActorFrame{
		InitCommand=function(self) self:x(PX); self:y(SCREEN_CENTER_Y-210.25+22); end;
		LifeChangedMessageCommand=function(self,params)
			if(params.Player == PN) then

				local this = self:GetChildren()
				local life = params.LifeMeter:GetLife()

				if life >= 2/3 then
					this["lifeB"]:diffusealpha(scale(life,2/3,1,0,1))
					this["lifeG"]:diffusealpha(scale(life,2/3,1,1,0))
					this["lifeY"]:diffusealpha(0)
					this["lifeR"]:diffusealpha(0)
				elseif life >= 1/3 then
					this["lifeB"]:diffusealpha(0)
					this["lifeG"]:diffusealpha(scale(life,1/3,2/3,0,1))
					this["lifeY"]:diffusealpha(scale(life,1/3,2/3,1,0))
					this["lifeR"]:diffusealpha(0)
				else
					this["lifeB"]:diffusealpha(0)
					this["lifeG"]:diffusealpha(0)
					this["lifeY"]:diffusealpha(scale(life,0,1/3,0,1))
					this["lifeR"]:diffusealpha(scale(life,0,1/3,1,0))
				end


				self:finishtweening()
				
				if firstOne > 0 then
					self:linear(2.6)
					firstOne = firstOne - 1
				else
					self:decelerate(0.1)
				end
				
				self:x(PX+life*248)
			end
		end;


		LoadActor("Life_B.png")..{
			Name = "lifeB";
		};
		LoadActor("Life_G.png")..{
			Name = "lifeG";
		};
		LoadActor("Life_Y.png")..{
			Name = "lifeY";
		};
		LoadActor("Life_R.png")..{
			Name = "lifeR";
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