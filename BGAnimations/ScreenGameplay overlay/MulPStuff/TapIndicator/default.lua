local pn = ...;

local t = Def.ActorFrame{};
local GT = GAMESTATE:GetCurrentGame():GetName();
if GT == 'dance' then
t[#t+1] = LoadActor("Da", pn);
elseif GT == 'pump' then
t[#t+1] = LoadActor("Pu", pn);
end
return t;