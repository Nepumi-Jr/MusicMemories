local fac = 16;
local CX = SCREEN_CENTER_X;
local CY = SCREEN_CENTER_Y;
local x = Def.ActorFrame{
		InitCommand=function(self) self:Center(); self:zoom(1); end;
		OnCommand=function(self)
			local B = self:GetChild('Blur')
			local G = self:GetChild('BG')
			local S = self:GetChild('S')

			B:SetSize(SCREEN_WIDTH, SCREEN_HEIGHT)
			B:EnableAlphaBuffer(true)
			B:Create()

			local texture = B:GetTexture()
			S:SetTexture(texture)

			self:SetDrawFunction(function()
			texture:BeginRenderingTo()
					G:visible(true)
					G:Draw()
					G:visible(false)
			texture:FinishRenderingTo()

			S:Draw()
			end)

		end;
	Def.ActorFrameTexture{
		Name="Blur";
	};
	Def.Sprite { Name = 'S';OnCommand=function(self) self:zoom(fac); end; };
	Def.Sprite {
		Name="BG";
		OnCommand=function(self) self:finishtweening(); self:queuecommand("ModifySongBackground"); end;
		ModifySongBackgroundCommand=function(self)
			self:diffusealpha(0.4);
			if GAMESTATE:GetCurrentSong() then
				if GAMESTATE:GetCurrentSong():GetBackgroundPath() then
					self:visible(true);
					self:LoadBackground(GAMESTATE:GetCurrentSong():GetBackgroundPath());
					self:stretchto(CX-CX/fac,CY-CY/fac,CX+CX/fac,CY+CY/fac);
				else
					self:visible(false);
				end
			else
				self:visible(false);
			end
			
		end;	
	};
};
return x;