local steps,meter,LV;
steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
meter = steps:GetMeter();
LV = steps:GetDifficulty();
local t = Def.ActorFrame{};
t[#t+1] = Def.ActorFrame{
		 LoadFont("_squares bold 72px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+(SCREEN_CENTER_X-(SCREEN_CENTER_X-135-85-55-85-17));y,SCREEN_TOP+30+7;zoom,1;visible,GAMESTATE:IsPlayerEnabled(PLAYER_2);diffuse,PlayerColor(PLAYER_2));
		OnCommand=function(self)
			if meter then
				if meter == 1943951546 then
				self:settext("??")
				self:zoom(0.8*0.8)
				elseif meter >= 10 then
				self:zoom(0.8*0.8)
				self:settext(meter)
				elseif meter >= 100 then
				self:zoom(0.5*0.8)
				self:settext(meter)
				elseif meter >= 1000 then
				self:zoom(0.3*0.8)
				self:settext(meter)
				else
				self:settext(meter)
				self:y(SCREEN_TOP+30+7)
				self:zoom(1*0.8)
				end
			end
		end;
		GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;x,-80;);
	};
LoadFont("_differentiator 60px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+(SCREEN_CENTER_X-(SCREEN_CENTER_X+2.5-175-128));y,56.75214415523215378951351-4;zoom,0.25;visible,GAMESTATE:IsPlayerEnabled(PLAYER_2);diffuse,PlayerColor(PLAYER_2));
		OnCommand=function(self)
			if LV then
			if LV == "Difficulty_Beginner" then
			self:settext("Novice");
				elseif  LV == "Difficulty_Easy" then
				self:settext("Easy");
				elseif LV == "Difficulty_Medium" then
				self:settext("Normal");
				elseif  LV == "Difficulty_Hard" then
				self:settext("Hard");
				elseif  LV == "Difficulty_Challenge" then
				self:settext("Expert");
				elseif  LV == "Difficulty_Edit" then
					if steps:GetDescription() ~= "" then
					if string.len(steps:GetDescription()) > 6 then
					self:settext(string.sub(steps:GetDescription(),1,5).."...")
					else
					self:settext(steps:GetDescription());
					end
					else
					self:settext("edit");
					end
				end
			end
		end;
	};
	GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,-100;);
};
return t;