local sString;
local picList = {}
local ind = 0
local call = 0


local t = Def.ActorFrame{
--[[ 	LoadActor("TestStep") .. {
		InitCommand=cmd(zoomto,20,20);
	}; --]]

    Def.ActorFrame{
        InitCommand=cmd(x,7;zoom,0.5;pause);
		SetMessageCommand=function(self,param)
            picList = {}

            sStep = param.StepsType;
            
            printf("%s",ToEnumShortString(sStep))
            
            picList[#picList+1] = THEME:GetPathG("StepsPad_Mini/Step",ToEnumShortString(sStep))

            if string.find( string.lower(ToEnumShortString(sStep)),"routine") then
                picList[#picList+1] = THEME:GetPathG("StepsPad_Mini/Type","Routine")
            elseif string.find( string.lower(ToEnumShortString(sStep)),"couple") then
                picList[#picList+1] = THEME:GetPathG("StepsPad_Mini/Type","Couple")
            elseif string.find( string.lower(ToEnumShortString(sStep)),"versus") then
                picList[#picList+1] = THEME:GetPathG("StepsPad_Mini/Type","Versus")
            elseif string.find( string.lower(ToEnumShortString(sStep)),"double") then
                picList[#picList+1] = THEME:GetPathG("StepsPad_Mini/Type","Double")
            else
                picList[#picList+1] = THEME:GetPathG("StepsPad_Mini/Type","Single")
            end
            

            if param.Steps and param.Steps:IsAutogen() then
                picList[#picList+1] = THEME:GetPathG("StepsPad_Mini/Auto","gen")
                
			end
            self:finishtweening()
            self:playcommand("Cycle");
        end;
        Def.Sprite{
            Name = "P1";
            InitCommand=cmd(x,0;SetTextureFiltering,false);
            SetMessageCommand=function(self)
                self:visible(#picList >= 1)
                self:Load(picList[1])
                if picList[1] and string.find( picList[1],"(res 64x64)") then self:zoom(0.64) end --bruh
            end;
        };
        Def.Sprite{
            Name = "P2";
            InitCommand=cmd(x,40;SetTextureFiltering,false);
            SetMessageCommand=function(self)
                self:visible(#picList >= 2)
                self:Load(picList[2])
                if picList[2] and string.find( picList[2],"(res 64x64)") then self:zoom(0.64) end --bruh
            end;
        };
        Def.Sprite{
            Name = "P3";
            InitCommand=cmd(x,80;SetTextureFiltering,false);
            SetMessageCommand=function(self)
                self:visible(#picList >= 3)
                self:Load(picList[3])
                if picList[3] and string.find( picList[3],"(res 64x64)") then self:zoom(0.64) end --bruh
            end;
        };
    };


	--[[LoadActor(THEME:GetPathG("StepStyle","Pad"))..{
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
	};]]
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