local t = Def.ActorFrame{};
local Title;
local Sub;
local Time;




t[#t+1] = Def.Quad{
	InitCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y*1.6); self:zoomx(SCREEN_RIGHT); self:zoomy(200); self:diffuse({0,0,0,0.3}); end;
	OnCommand=function(self) self:sleep(4.5); self:decelerate(0.5); self:zoomy(0); end;
};

t[#t+1] = LoadFont("Common Large")..{
	Text = "1st Memories";
	InitCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y*1.2); self:diffuse(Color.Orange); self:zoom(0.75); end;
	OnCommand=function(self) self:sleep(4.5); self:decelerate(0.5); self:diffusealpha(0); end;
};

t[#t+1] = LoadFont("Common Normal") .. {
InitCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y+150); self:zoom(1); self:cropright(1); end;
OnCommand=function(self)
Title = GAMESTATE:GetCurrentSong():GetDisplayMainTitle();

Sub = GAMESTATE:GetCurrentSong():GetDisplaySubTitle();

Time = GAMESTATE:GetCurrentSong():MusicLengthSeconds();

See = color("#FF8800")
local SE;
SE = "";
if Title == "" then
SE = SE.."No Title\n"
else
SE = SE..Title.."\n"
end
if Sub ~= "" then
SE = SE..Sub.."\n"
end
SE = SE..SecondsToMSSMsMs(Time)

self:settext(SE);


if Time < 3*60 then
self:stopeffect():diffuse(Color("White"))
elseif Time < 5*60 then
self:stopeffect():diffuse(Color("White")):diffusebottomedge(Color("Red"))
else
self:stopeffect():rainbow()
end
self:linear(0.5):cropright(0)
self:sleep(4):decelerate(0.5):diffusealpha(0)
end;
};


return t;