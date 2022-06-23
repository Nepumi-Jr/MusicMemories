local sString;
local picList = {}
local ind = 0
local call = 0


local t = Def.ActorFrame{
--[[ 	LoadActor("TestStep") .. {
		InitCommand=function(self) self:zoomto(20,20); end;
	}; --]]

    Def.ActorFrame{
        InitCommand=function(self) self:x(7); self:zoom(0.5); self:pause(); end;
		SetMessageCommand=function(self,param)
            picList = {}

            sStep = ToEnumShortString(param.StepsType);
			--printf("%s",GAMESTATE:GetCurrentStyle():GetStepsType());
			picStepPFPath = getThemeDir().."/Graphics/StepsPad_Mini/Step "..sStep
			
			--? very hard coded :|
			if FILEMAN:DoesFileExist(picStepPFPath..".png") then
				picList[1] = picStepPFPath..".png"
			elseif FILEMAN:DoesFileExist(picStepPFPath.." (res 64x64).png") then
				picList[1] = picStepPFPath.." (res 64x64).png"
			else
				--! Step picture not found
				picList[1] = THEME:GetPathG("StepsPad_Mini/Step","unknown")
			end

            if string.find( string.lower(sStep),"routine") then
                picList[#picList+1] = THEME:GetPathG("StepsPad_Mini/Type","Routine")
            elseif string.find( string.lower(sStep),"couple") then
                picList[#picList+1] = THEME:GetPathG("StepsPad_Mini/Type","Couple")
            elseif string.find( string.lower(sStep),"versus") then
                picList[#picList+1] = THEME:GetPathG("StepsPad_Mini/Type","Versus")
            elseif string.find( string.lower(sStep),"double") then
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
            InitCommand=function(self) self:x(0); self:SetTextureFiltering(false); end;
            SetMessageCommand=function(self)
                self:visible(#picList >= 1)
                self:Load(picList[1])
                if picList[1] and string.find( picList[1],"(res 64x64)") then self:zoom(0.64) end --bruh
            end;
        };
		LoadFont("Common Normal")..{
            Name = "P1-num";
            InitCommand=function(self) self:x(0):y(9):horizalign(left); end;
            SetMessageCommand=function(self)
				if picList[1] ~= THEME:GetPathG("StepsPad_Mini/Step","unknown") then
					return;
				end

				--* Just display the number of column of each *missing* step
				--? get num collumn in each Step by reverse search
				local styleDatas = GAMEMAN:GetStylesForGame(GAMESTATE:GetCurrentGame():GetName())
				local nCol = -1
				for i,v in ipairs(styleDatas) do
					if ToEnumShortString(v:GetStepsType()) == sStep then
						nCol = v:ColumnsPerPlayer()
						break
					end
				end

				if nCol == -1 then
					--! NOT FOUND somehow
					self:settextf("!")
				else
					self:settextf("%d",nCol)
				end
				self:diffuse({.85,.85,.85,.85})
			end;
        };
        Def.Sprite{
            Name = "P2";
            InitCommand=function(self) self:x(40); self:SetTextureFiltering(false); end;
            SetMessageCommand=function(self)
                self:visible(#picList >= 2)
                self:Load(picList[2])
                if picList[2] and string.find( picList[2],"(res 64x64)") then self:zoom(0.64) end --bruh
            end;
        };
        Def.Sprite{
            Name = "P3";
            InitCommand=function(self) self:x(80); self:SetTextureFiltering(false); end;
            SetMessageCommand=function(self)
                self:visible(#picList >= 3)
                self:Load(picList[3])
                if picList[3] and string.find( picList[3],"(res 64x64)") then self:zoom(0.64) end --bruh
            end;
        };
    };


	--[[LoadActor(THEME:GetPathG("StepStyle","Pad"))..{
		InitCommand=function(self) self:x(7); self:zoomto(23,23); self:pause(); self:SetTextureFiltering(false); self:effectclock("beat"); end;
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