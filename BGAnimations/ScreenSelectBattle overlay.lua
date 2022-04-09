local t = Def.ActorFrame{};
return t;
local S = 1;
local Scree = 1;
--[[
1 = Select mode
2 = Option
3 = R U Sure!
]]
local til = 1;
--[[
1 = Song,Point
2 = How much
3 = FailorDraw
4 = Level
5 = Hidden
]]
local dechoi = {"Round",5,false,"None",false};
local RUS = false;

local Con = false;
local OpB = function( event )
	if not event then return end

	if event.type == "InputEventType_FirstPress" then
	
	
	if event.button == "Left" or event.button == "DownLeft" then
	if Scree == 1 then if S == 1 then S = 2 else S = 1 end MESSAGEMAN:Broadcast("Re1")
	elseif Scree == 2 then
		if til == 1 then if dechoi[1] == "Round" then dechoi[1] = "Point" else dechoi[1] = "Round" end
		elseif til == 2 then dechoi[2] = math.max(dechoi[2]-1,1)
		elseif til == 3 then if dechoi[3] then dechoi[3] = false; else dechoi[3] = true; end
		elseif til == 4 then 
			if dechoi[4] == "None" then dechoi[4] = "Harder"
			elseif dechoi[4] == "Harder" then dechoi[4] = "Easier"
			elseif dechoi[4] == "Easier" then dechoi[4] = "Random"
			elseif dechoi[4] == "Random" then dechoi[4] = "None" end 
		elseif til == 5 then if dechoi[5] then dechoi[5] = false; else dechoi[5] = true; end
		end
	MESSAGEMAN:Broadcast("Re2")
	elseif Scree == 3 then if RUS then RUS = false; else RUS = true; end
	MESSAGEMAN:Broadcast("Re3")
	end
	MESSAGEMAN:Broadcast("Arrow")
	end
	
	if event.button == "Right" or event.button == "DownRight" then
	if Scree == 1 then if S == 1 then S = 2 else S = 1 end MESSAGEMAN:Broadcast("Re1")
	elseif Scree == 2 then
		if til == 1 then if dechoi[1] == "Round" then dechoi[1] = "Point" else dechoi[1] = "Round" end
		elseif til == 2 then dechoi[2] = dechoi[2]+1
		elseif til == 3 then if dechoi[3] then dechoi[3] = false; else dechoi[3] = true; end
		elseif til == 4 then 
			if dechoi[4] == "None" then dechoi[4] = "Random"
			elseif dechoi[4] == "Random" then dechoi[4] = "Easier"
			elseif dechoi[4] == "Easier" then dechoi[4] = "Harder"
			elseif dechoi[4] == "Harder" then dechoi[4] = "None" end
		elseif til == 5 then if dechoi[5] then dechoi[5] = false; else dechoi[5] = true; end
		end
	MESSAGEMAN:Broadcast("Re2")
	elseif Scree == 3 then if RUS then RUS = false; else RUS = true; end
	MESSAGEMAN:Broadcast("Re3")
	end
	MESSAGEMAN:Broadcast("Arrow")
	end
	
	if event.button == "Up" or event.button == "UpLeft" then
	if Scree == 2 then
		til = math.max(til-1,1)
		MESSAGEMAN:Broadcast("Re2")
	end
	MESSAGEMAN:Broadcast("Arrow")
	end
	
	if event.button == "Down" or event.button == "UpRight" then
	if Scree == 2 then
		til = math.min(til+1,5)
		MESSAGEMAN:Broadcast("Re2")
	end
	MESSAGEMAN:Broadcast("Arrow")
	end
	
	
	if event.button == "Start" or event.button == "Center" then
	if Scree == 1 then Scree = 2; MESSAGEMAN:Broadcast("Con1")
	elseif Scree == 2 then Scree = 3; MESSAGEMAN:Broadcast("Con2")
	elseif Scree == 3 and RUS then MESSAGEMAN:Broadcast("Con3") 
	--[[NEXT SCREEN HEREEEEEEEE]]
	TP.Battle.IsBattle = true;
	TP.Battle.Limit.Mode = dechoi[1]
	TP.Battle.Limit.Num = dechoi[2]
	if S == 1 then
	TP.Battle.Mode = "Ac"
	else
	TP.Battle.Mode = "Dr"
	end
	TP.Battle.IsfailorIsDraw = dechoi[3]
	TP.Battle.Level = dechoi[4]
	TP.Battle.Hidden = dechoi[5]
	SCREENMAN:GetTopScreen():SetNextScreenName("ScreenSelectPlayMode"):StartTransitioningScreen("SM_GoToNextScreen")
	else Scree = 2 MESSAGEMAN:Broadcast("Can3")
	end
	MESSAGEMAN:Broadcast("Okay")
	end

	if event.button == "Back" then
	if Scree == 3 then Scree = 2; MESSAGEMAN:Broadcast("Can3")
	elseif Scree == 2 then Scree = 1; MESSAGEMAN:Broadcast("Can2")
	elseif Scree == 1 then MESSAGEMAN:Broadcast("Can1") SCREENMAN:GetTopScreen():SetNextScreenName("ScreenSelectBattleSM"):StartTransitioningScreen("SM_GoToNextScreen")
	end
	MESSAGEMAN:Broadcast("Nope")
	end
	
end
end
t[#t+1] = Def.ActorFrame{
	Con1MessageCommand=function(self) self:decelerate(0.5); self:y(-SCREEN_BOTTOM); end;
	Can2MessageCommand=function(self) self:decelerate(0.5); self:y(0); end;	

	
Def.ActorFrame{
OnCommand=function(self) self:playcommand("Lo"); end;
LoCommand=function(self) SCREENMAN:GetTopScreen():AddInputCallback(OpB) self:sleep(0.02):queuecommand("Lo") end;
Def.ActorFrame{
OnCommand=function(self) self:x(SCREEN_CENTER_X*0.5); self:y(SCREEN_CENTER_Y); self:zoom(0); self:decelerate(0.5); self:zoom(1); end;
Re1MessageCommand=function(self)
if S == 1 then
self:stoptweening():decelerate(0.3):zoom(1)
else
self:stoptweening():decelerate(0.3):zoom(0.75)
end
end;
LoadModule("Menu.Button.lua")(0,0,color("#77FF77"),color("#33AA33"),color("#33AA33"),color("#33AA33"),color("#33AA33"),"Accuracy","Play Perfectly");
};
Def.ActorFrame{
OnCommand=function(self) self:x(SCREEN_CENTER_X*1.5); self:y(SCREEN_CENTER_Y); self:zoom(0); self:decelerate(0.5); self:zoom(0.75); end;
Re1MessageCommand=function(self)
if S == 2 then
self:stoptweening():decelerate(0.3):zoom(1)
else
self:stoptweening():decelerate(0.3):zoom(0.75)
end
end;
LoadModule("Menu.Button.lua")(0,0,color("#FF9900"),color("#AA6600"),color("#AA6600"),color("#AA6600"),color("#AA6600"),"Knock out!","Smash your friend!");
};
};

Def.ActorFrame{
OnCommand=function(self) self:y(SCREEN_BOTTOM); end;
Def.Quad{
OnCommand=function(self) self:Center(); self:zoomx(650); self:zoomy(400); end;
Con1MessageCommand=function(self)
if S == 1 then
self:diffuse(color("#77FF77"))
else
self:diffuse(color("#FF9900"))
end
end;
};

LoadFont( "Common Normal") ..{
OnCommand=function(self) self:x(SCREEN_CENTER_X*0.25); self:y(375); self:horizalign(left); self:diffuse(color("#2222FF")); self:zoom(0.7); end;
Con1MessageCommand=function(self)
if til == 1 then self:settext("Round:Game will end if it reach to ___ round\nPointGame will end if someone reach to ___ point")
elseif til == 2 then self:settext("How much?")
elseif til == 3 then
if S == 1 then 
self:settext("Enable Fail?")
elseif S == 2 then 
self:settext("If 2 players survive this round\nYes:This round result is draw\nNo:Use Accuracy to determineted instead") 
end
elseif til == 4 then self:settext("This option will use only 2 player select different level\nRandom :It will Random 2 Player level\nMax :It will Use Hardest of 2 player level\nMin :It will Use Easiest of 2 player level\nNone:It do nothing(Not Recommand Because it's not balance 100%)")
elseif til == 5 then
if S == 1 then self:settext("Score will hidden")
elseif S == 2 then self:settext("life will hidden") end
end
end;
Re2MessageCommand=function(self)
if til == 1 then self:settext("Round:Game will end if it reach to ___ round\nPointGame will end if someone reach to ___ point")
elseif til == 2 then self:settext("How much?")
elseif til == 3 then
if S == 1 then 
self:settext("Enable Fail?")
elseif S == 2 then 
self:settext("If 2 players survive this round\nYes:This round result is draw\nNo:Use Accuracy to determineted instead") 
end
elseif til == 4 then self:settext("This option will use only 2 player select different level\nRandom :It will Random 2 Player level\nMax :It will Use Hardest of 2 player level\nMin :It will Use Easiest of 2 player level\nNone:It do nothing(Not Recommand Because it's not balance 100%)")
elseif til == 5 then
if S == 1 then self:settext("Score will hidden")
elseif S == 2 then self:settext("life will hidden") end
end
end;
};
Def.Quad{
	OnCommand=function(self) self:Center(); self:zoomx(99999); self:zoomy(0); self:diffuse(color("#000000AA")); end;
	Con2MessageCommand=function(self) self:stoptweening(); self:decelerate(0.5); self:zoomy(SCREEN_CENTER_Y*2); end;
	Can3MessageCommand=function(self) self:stoptweening(); self:decelerate(0.5); self:zoomy(0); end;
};
LoadFont( "_rockwell 72px") ..{
OnCommand=function(self) self:x(130); self:y(100); self:settext("Song or Round"); self:diffuse(color("#2222FF")); self:zoom(0.45); self:horizalign(left); end;
};
LoadFont( "_rockwell 72px") ..{
OnCommand=function(self) self:x(130); self:y(100+50); self:settext("How much?"); self:diffuse(color("#2222FF")); self:zoom(0.45); self:horizalign(left); end;
};
LoadFont( "_rockwell 72px") ..{
OnCommand=function(self) self:x(130); self:y(100+100); self:diffuse(color("#2222FF")); self:zoom(0.45); self:horizalign(left); end;
Con1MessageCommand=function(self)
if S == 1 then
self:settext("It's Fail?")
else
self:settext("It's Draw?")
end
end;
};
LoadFont( "_rockwell 72px") ..{
OnCommand=function(self) self:x(130); self:y(100+150); self:settext("Level"); self:diffuse(color("#2222FF")); self:zoom(0.45); self:horizalign(left); end;
};
LoadFont( "_rockwell 72px") ..{
OnCommand=function(self) self:x(130); self:y(100+200); self:settext("Hidden"); self:diffuse(color("#2222FF")); self:zoom(0.45); self:horizalign(left); end;
};

LoadFont( "Common Normal") ..{
OnCommand=function(self) self:x(SCREEN_CENTER_X*1.35); self:y(100); self:settext("Round"); self:diffuse(color("#2222FF")); self:zoom(1.5); end;
Con1MessageCommand=function(self)
self:settext(dechoi[1])
if til == 1 then self:stoptweening():diffuse(color("#008800")):zoom(2):decelerate(0.3):zoom(1.7)
else self:stoptweening():diffuse(color("#2222FF")):decelerate(0.3):zoom(1.5) end
end;
Re2MessageCommand=function(self)
self:settext(dechoi[1])
if til == 1 then self:stoptweening():diffuse(color("#008800")):zoom(2):decelerate(0.3):zoom(1.7)
else self:stoptweening():diffuse(color("#2222FF")):decelerate(0.3):zoom(1.5) end
end;
};

LoadFont( "Common Normal") ..{
OnCommand=function(self) self:x(SCREEN_CENTER_X*1.35); self:y(100+50); self:settext("5 Round(s)"); self:diffuse(color("#2222FF")); self:zoom(1.5); end;
Re2MessageCommand=function(self)
self:settext(dechoi[2].." "..dechoi[1].."(s)")
if til == 2 then self:stoptweening():diffuse(color("#008800")):zoom(2):decelerate(0.3):zoom(1.7)
else self:stoptweening():diffuse(color("#2222FF")):decelerate(0.3):zoom(1.5) end
end;
};
LoadFont( "Common Normal") ..{
OnCommand=function(self) self:x(SCREEN_CENTER_X*1.35); self:y(100+100); self:settext("No"); self:diffuse(color("#2222FF")); self:zoom(1.5); end;
Re2MessageCommand=function(self)
if dechoi[3] then self:settext("Yes") else self:settext("No") end
if til == 3 then self:stoptweening():diffuse(color("#008800")):zoom(2):decelerate(0.3):zoom(1.7)
else self:stoptweening():diffuse(color("#2222FF")):decelerate(0.3):zoom(1.5) end
end;
};
LoadFont( "Common Normal") ..{
OnCommand=function(self) self:x(SCREEN_CENTER_X*1.35); self:y(100+150); self:settext("None"); self:diffuse(color("#2222FF")); self:zoom(1.5); end;
Re2MessageCommand=function(self)
self:settext(dechoi[4])
if til == 4 then self:stoptweening():diffuse(color("#008800")):zoom(2):decelerate(0.3):zoom(1.7)
else self:stoptweening():diffuse(color("#2222FF")):decelerate(0.3):zoom(1.5) end
end;
};
LoadFont( "Common Normal") ..{
OnCommand=function(self) self:x(SCREEN_CENTER_X*1.35); self:y(100+200); self:settext("No"); self:diffuse(color("#2222FF")); self:zoom(1.5); end;
Re2MessageCommand=function(self)
if dechoi[5] then self:settext("Yes") else self:settext("No") end
if til == 5 then self:stoptweening():diffuse(color("#008800")):zoom(2):decelerate(0.3):zoom(1.7)
else self:stoptweening():diffuse(color("#2222FF")):decelerate(0.3):zoom(1.5) end
end;
};

LoadFont( "Common Normal") ..{
	OnCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y*0.2); self:settext("This is correct?"); self:zoom(2); self:zoomx(0); end;
	Con2MessageCommand=function(self) self:stoptweening(); self:decelerate(0.5); self:zoomx(2); end;
	Can3MessageCommand=function(self) self:stoptweening(); self:decelerate(0.5); self:zoomx(0); end;
	Con3MessageCommand=function(self) self:stoptweening(); self:decelerate(0.5); self:zoom(0); end;
};
LoadFont( "Common Normal") ..{
	OnCommand=function(self) self:x(SCREEN_CENTER_X*0.5); self:y(SCREEN_CENTER_Y*1.65); self:settext("Yes"); self:zoom(2); self:zoomx(0); end;
	Con2MessageCommand=function(self)
	self:stoptweening():decelerate(0.5)
	if RUS then
if S == 1 then
self:diffuse(color("#77FF77"))
else
self:diffuse(color("#FF9900"))
end
self:zoom(3)
	else
	self:diffuse({1,1,1,1}):zoom(2)
	end
	end;
	Re3MessageCommand=function(self)
	self:stoptweening()
	if RUS then
		self:zoom(3.5):decelerate(0.3):zoom(3)
if S == 1 then
self:diffuse(color("#77FF77"))
else
self:diffuse(color("#FF9900"))
end
	else
		self:decelerate(0.3):zoom(2):diffuse({1,1,1,1})
	end
	end;
	Con3MessageCommand=function(self) self:stoptweening(); self:decelerate(0.5); self:zoom(0); end;
	Can3MessageCommand=function(self) self:stoptweening(); self:decelerate(0.5); self:zoomx(0); self:diffuse({1,1,1,1}); end;
};
LoadFont( "Common Normal") ..{
	OnCommand=function(self) self:x(SCREEN_CENTER_X*1.5); self:y(SCREEN_CENTER_Y*1.65); self:settext("No"); self:zoom(2); self:zoomx(0); end;
	Con2MessageCommand=function(self)
	self:stoptweening():decelerate(0.5)
	if not RUS then
if S == 1 then
self:diffuse(color("#77FF77"))
else
self:diffuse(color("#FF9900"))
end
self:zoom(3)
	else
	self:diffuse({1,1,1,1}):zoom(2)
	end
	end;
	Re3MessageCommand=function(self)
	self:stoptweening()
	if not RUS then
		self:zoom(3.5):decelerate(0.3):zoom(3)
if S == 1 then
self:diffuse(color("#77FF77"))
else
self:diffuse(color("#FF9900"))
end
	else
		self:decelerate(0.3):zoom(2):diffuse({1,1,1,1})
	end
	end;
	Con3MessageCommand=function(self) self:stoptweening(); self:decelerate(0.5); self:zoom(0); end;
	Can3MessageCommand=function(self) self:stoptweening(); self:decelerate(0.5); self:zoomx(0); end;
};
Def.Quad{
	OnCommand=function(self) self:Center(); self:zoomy(99999); self:zoomx(0); self:diffuse(color("#000000FF")); end;
	Con3MessageCommand=function(self) self:stoptweening(); self:decelerate(0.5); self:zoomx(SCREEN_CENTER_X*2); end;
};
};
LoadActor( THEME:GetPathS("Common","start") )..{OkayMessageCommand=function(self) self:play(); end;};
LoadActor( THEME:GetPathS("Common","value") )..{ArrowMessageCommand=function(self) self:play(); end;};
LoadActor( THEME:GetPathS("Common","cancel") )..{NopeMessageCommand=function(self) self:play(); end;};
};
return t;