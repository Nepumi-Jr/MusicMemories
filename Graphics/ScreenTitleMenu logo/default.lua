TP.Battle.IsBattle = false;
local t = Def.ActorFrame{
	InitCommand=function(self) self:fov(70); end;
	LoadActor("_arrow")..{
		OnCommand=function(self) self:x(200); end;
	};
	LoadFont("Common Normal")..{
		InitCommand=function(self) self:x(205); self:y(45); self:rotationz(-10); self:zoom(1.5); end;
		OnCommand=function(self) self:diffuse(Color.Pink); self:playcommand("Update"); end;
			UpdateCommand=function(self)
			if (MonthOfYear() == 10-1 and DayOfMonth() == 8 ) or (MonthOfYear() == 8-1 and DayOfMonth() == 5) then
				self:settext("<3");
			elseif MonthOfYear() == 4-1 and DayOfMonth() == 1 then
				self:settext("Free MEME..");
			else
				self:settext("Music Memories...");
			end
			self:pulse():effectclock("beat"):effectmagnitude(1,1.2,0):effectperiod(120/124);
			end;
	};
	LoadActor("_text")..{
		Name="TextGlow";
		OnCommand=function(self) self:diffuse(Color.White); self:bob(); self:effectclock("beat"); self:effectmagnitude(0,3,0); self:effectperiod(120/124*2); self:effectoffset(0.25); end;
	};
	LoadActor("_title")..{
		Name="TextGlow2";
		OnCommand=function(self) self:diffuse({0.8,0.8,0.8,1}); self:bob(); self:effectclock("beat"); self:effectmagnitude(0,-3,0); self:effectperiod(120/124*2); self:effectoffset(0.25); end;
	};
};

return t;

