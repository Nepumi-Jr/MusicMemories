local sString;
local t = Def.ActorFrame{
--[[ 	LoadActor("TestStep") .. {
		InitCommand=cmd(zoomto,20,20);
	}; --]]
	LoadActor(THEME:GetPathG("StepStyle","Pad"))..{
		InitCommand=cmd(x,7;zoomto,23,23;pause;SetTextureFiltering,false;effectclock,"beat");
		SetMessageCommand=function(self,param)

			self:pause()
			self:finishtweening()
			self:effectclock("beat")
			local r = Enum.Reverse(StepsType);
			local animate = {};


			sStep = param.StepsType;
			

			animate[#animate+1] = {Frame= (r[sStep] >= 33 and 40 or r[sStep]), Delay= 2}

			tType = 34

			if sStep == "StepsType_Dance_Single" or--single
			sStep == "StepsType_Dance_Solo" or
			sStep == "StepsType_Dance_Threepanel" or
			sStep == "StepsType_Pump_Single" or
			sStep == "StepsType_Kb7_Single" or
			sStep == "StepsType_Ez2_Single" or
			sStep == "StepsType_Para_Single" or
			sStep == "StepsType_Ds3ddx_Single" or
			sStep == "StepsType_Bm_Single5" or
			sStep == "StepsType_Bm_Single7" or
			sStep == "StepsType_Bm_Double7" or
			sStep == "StepsType_Maniax_Single" or
			sStep == "StepsType_Techno_Single4" or
			sStep == "StepsType_Techno_Single5" or
			sStep == "StepsType_Techno_Single8" or
			sStep == "StepsType_Pnm_Five" or
			sStep == "StepsType_Pnm_Nine" then
				tType = 34
			elseif sStep == "StepsType_Dance_Double" or
			sStep == "StepsType_Dance_Double" or
			sStep == "StepsType_Pump_Halfdouble" or
			sStep == "StepsType_Pump_Double" or
			sStep == "StepsType_Ez2_Double" or
			sStep == "StepsType_Ez2_Real" or
			sStep == "StepsType_Bm_Double5" or
			sStep == "StepsType_Bm_Double7" or
			sStep == "StepsType_Maniax_Double" or
			sStep == "StepsType_Techno_Double4" or
			sStep == "StepsType_Techno_Double5" or
			sStep == "StepsType_Techno_Double8" then
				tType = 35
			elseif sStep == "StepsType_Bm_Versus5" or
			sStep == "StepsType_Bm_Versus5" then
				tType = 36
			elseif sStep == "StepsType_Dance_Couple" or
			sStep == "StepsType_Pump_Couple" then
				tType = 37
			elseif sStep == "StepsType_Dance_Routine" or
			sStep == "StepsType_Pump_Routine" then
				tType = 38
			end

			animate[#animate+1] = {Frame= tType, Delay= 2}


			if param.Steps and param.Steps:IsAutogen() then
				animate[#animate+1] = {Frame= 39, Delay= 2}
			end;

			self:SetStateProperties(animate)
			self:play();
		end;
	};
	-- argh this isn't working as nicely as I would've hoped...
	--[[
	Def.Sprite{
		SetMessageCommand=function(self,param)
			self:Load( THEME:GetPathG("","_StepsType/"..ToEnumShortString(param.StepsType)) );
			self:diffusealpha(0.5);
		end;
	};
	--]]
};

return t;