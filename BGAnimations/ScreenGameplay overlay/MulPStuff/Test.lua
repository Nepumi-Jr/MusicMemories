local pn = ...;
local CX = SCREEN_CENTER_X;
local CY = SCREEN_CENTER_Y;


return LoadFont("Common normal")..{
    Text = "I am ".. (pn == PLAYER_1 and "P1" or "P2");
    InitCommand=function(self) self:x((pn == PLAYER_1) and CX*0.5 or CX*1.5); self:CenterY(); self:rainbow(); end;
};
