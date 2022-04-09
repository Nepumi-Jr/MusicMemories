local player = Var "Player"
local blinkTime = 1.2
local barWidth = 256;
local barHeight = 32;
local c;
local LifeMeter, MaxLives, CurLives;
local LifeRatio;


local x = Def.ActorFrame{
	BeginCommand=function(self,param)
		local screen = SCREENMAN:GetTopScreen();
		local glifemeter = screen:GetLifeMeter(player);
		
		local this = self:GetChildren()
		local LF = clamp(glifemeter:GetTotalLives(),0,10)
		

		for i = 1,10 do
			this["LifeL"..tostring(i)]:visible(i <= LF)
		end
	end;
	LifeChangedMessageCommand=function(self,param)
		if param.Player == player then

			local this = self:GetChildren()
			local LF = clamp(param.LivesLeft,0,10)
			

			for i = 1,10 do
				this["LifeL"..tostring(i)]:visible(i <= LF)
			end

		end
	end;
	StartCommand=function(self,param)
		if param.Player == player then
			local this = self:GetChildren()
			local LF = clamp(param.LivesLeft,0,10)
			

			for i = 1,10 do
				this["LifeL"..tostring(i)]:visible(i <= LF)
			end		
		end			
	end;
	FinishCommand=function(self) self:playcommand("Start"); end;

};

for i = 1,10 do
	x[#x+1] = Def.Sprite{
		Name = "LifeL"..tostring(i);
		Texture="Heart 2x4.png";
		Frame0000 = 1;
		Delay0000 = 0.2;
		Frame0001 = 0;
		Delay0001 = 0.8;
		Frame0002 = 3;
		Delay0002 = 0.2;
		Frame0003 = 2;
		Delay0003 = 0.8;
		Frame0004 = 5;
		Delay0004 = 0.2;
		Frame0005 = 4;
		Delay0005 = 0.8;
		Frame0006 = 7;
		Delay0006 = 0.2;
		Frame0007 = 6;
		Delay0007 = 0.8;
		InitCommand=function(self) self:x((i/13)*barWidth-(barWidth)*0.5); self:play(); self:effectclock("Beat"); self:SetTextureFiltering(false); self:zoomy(1.5*1.2); self:zoomx(1.2); end;
	};
end

local t = Def.ActorFrame {

	x;

};

return t;