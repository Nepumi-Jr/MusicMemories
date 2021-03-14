local NumF="_computer pixel-7 30px";
local NOWB = 0;

local PN=PLAYER_2;
local PX=SCREEN_CENTER_X*1.5-246.5*0.5+2.5;
local clmain = GameColor.PlayerDarkColors.PLAYER_2 or {0,0,0,1};
local clsub = GameColor.PlayerColors.PLAYER_2 or {1,1,1,1};
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
						SCREENMAN:GetTopScreen():GetChild('LifeP2'):stoptweening():decelerate(0.5):diffusealpha(1)
						isHot = false;
					end
				else
					if life == 1 then
						self:GetChildren()["lifeMax"]:stoptweening():decelerate(0.5):diffusealpha(1)
						self:GetChildren()["lifeBG"]:stoptweening():decelerate(0.5):diffusealpha(1)
						self:GetChildren()["lifeMaxUp"]:stoptweening():decelerate(0.5):diffusealpha(1)
						SCREENMAN:GetTopScreen():GetChild('LifeP2'):stoptweening():decelerate(0.5):diffusealpha(0)
						isHot = true;
					end
				end

			end
		end;
		Def.ActorFrame{
			Name = "lifeBG";
			Def.Quad{
				InitCommand=cmd(y,SCREEN_CENTER_Y-210.25+22;horizalign,left;x,PX;zoomy,15;zoomx,248;diffusealpha,1);
				OnCommand=cmd(effectclock,"beat";diffuseramp;effectcolor1,{1,1,1,0.7};effectcolor2,{1,1,1,0.2};effectperiod,1/16);
			};
		};
		LoadActor("../P1Health/Life_Max2.png")..{
			Name = "lifeMax";
			InitCommand=cmd(y,SCREEN_CENTER_Y-210.25+22;horizalign,left;x,PX;zoomy,15/128;effectclock,"beat";customtexturerect,0,0.9,0.9,1;texcoordvelocity,0,0.2);
			OnCommand=cmd(blend,"BlendMode_WeightedMultiply");
		};
		LoadActor("../P1Health/Life_MaxUp.png")..{
			Name = "lifeMaxUp";
			InitCommand=cmd(y,SCREEN_CENTER_Y-210.25+22;horizalign,left;zoomy,15/256;x,PX;customtexturerect,0,0,0.9,0.1;texcoordvelocity,0,0.6);
			OnCommand=cmd(effectclock,"beat";diffuseramp;effectcolor1,{1,1,1,1};effectcolor2,{0.7,0.7,0.7,1};effectperiod,0.5;effecttiming,0.25,0.50,0,0.25;effectoffset,-0.25);
		};
	};

	LoadActor("../P1Health/Life_Bar.png")..{
		InitCommand=cmd(x,PX;y,SCREEN_CENTER_Y-210.25+22;horizalign,left;cropright,1);
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
		InitCommand=cmd(x,PX;y,SCREEN_CENTER_Y-210.25+22);
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


		LoadActor("../P1Health/Life_B.png")..{
			Name = "lifeB";
		};
		LoadActor("../P1Health/Life_G.png")..{
			Name = "lifeG";
		};
		LoadActor("../P1Health/Life_Y.png")..{
			Name = "lifeY";
		};
		LoadActor("../P1Health/Life_R.png")..{
			Name = "lifeR";
		};

	};


	Def.Quad{
		InitCommand=function(self)

			self:visible(TP.Battle.IsBattle and TP.Battle.Mode == "Dr" and TP.Battle.Hidden);
		end;
		OnCommand=cmd(zoomy,23.75*0.64;zoomx,246.5;y,SCREEN_CENTER_Y-210.25+22;horizalign,left;x,PX
			effectclock,"beat";diffuseramp;effectcolor1,clmain;effectcolor2,clsub;effectperiod,0.5;effecttiming,0.25,0.50,0,0.25;effectoffset,-0.25);
		GETOUTOFGAMESMMessageCommand=cmd(stoptweening;sleep,0.7;accelerate,0.5;zoomy,0);
	};
};
return t;
