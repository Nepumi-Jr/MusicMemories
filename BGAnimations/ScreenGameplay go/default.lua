if IsNetSMOnline() then
	-- don't show "Ready" online; it will obscure the immediately-starting steps.
	return Def.ActorFrame{}
end

return Def.Quad{
	InitCommand=function(self) self:visible(false); end;
	StartTransitioningCommand=function(self) self:zoom(1.3); self:diffusealpha(0); self:bounceend(0.25); self:zoom(1); self:diffusealpha(1); self:linear(0.15); self:glow(BoostColor(Color("Blue"),1.75)); self:decelerate(0.3); self:glow(1,1,1,0); self:sleep(1-0.45); self:linear(0.25); self:diffusealpha(0); end;
};