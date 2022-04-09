local t = Def.ActorFrame{};
if GAMESTATE:GetPlayMode() == "PlayMode_Regular" then
t[#t+1] = LoadActor("ColorofBAR.lua")..{
InitCommand=function(self) self:y(SCREEN_BOTTOM-4); end;
};
end
return t;
