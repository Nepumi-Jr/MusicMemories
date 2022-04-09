local t = Def.ActorFrame{
	Def.ActorFrame{
	OnCommand=function(self)
if MonthOfYear() == 12-1 then
if DayOfMonth() == 23 then
	self:diffusealpha(0.5);
	elseif DayOfMonth() == 24 then
	self:diffusealpha(0.75);
	elseif DayOfMonth() == 25 then
	self:diffusealpha(1);
	elseif DayOfMonth() == 26 then
	self:diffusealpha(1);
	self:effectclock("beat");
	self:diffuseramp();
	self:effectcolor1(1,0.7,0.7,1);
	self:effectcolor2(0.7,1,0.7,1);
	self:effectperiod(0.5)
	self:effecttiming(0.25,0.50,0,0.25)
	self:effectoffset(-0.25)
	else
	self:zoom(0);
	end
else
self:zoom(0);
end
end;
	

	LoadActor("blurredsnowFar.png")..{
		OnCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:customtexturerect(0,0,1,1); self:texcoordvelocity(1.40,-0.90); self:zoomtowidth(SCREEN_WIDTH); self:zoomtoheight(SCREEN_HEIGHT); end;
	};
	LoadActor("blurredsnow.png")..{
		OnCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:customtexturerect(0,0,1,1); self:texcoordvelocity(1.20,-0.90); self:zoomtowidth(SCREEN_WIDTH); self:zoomtoheight(SCREEN_HEIGHT); end;
	};
	LoadActor("blurredsnowNear.png")..{
		OnCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y); self:customtexturerect(0,0,1,1); self:texcoordvelocity(1,-0.90); self:zoomtowidth(SCREEN_WIDTH); self:zoomtoheight(SCREEN_HEIGHT); end;
	};
	};
};
return t;