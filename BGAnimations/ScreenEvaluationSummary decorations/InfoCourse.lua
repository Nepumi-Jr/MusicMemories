local w = 0
local function TWA(s,GS,lim)
	local zom = GS:GetZoom() or 1;
	GS:settext(s)
	
	if GS:GetWidth()*zom > lim then

		local noi=0
		local mak=string.len( s )-1;
		local ANS=-1;
		while noi<=mak do
			local mid = math.floor((noi+mak)/2);
			GS:settext(string.sub( s, 1, mid+1 ).."...");

			if GS:GetWidth()*zom <= lim then
				ANS = mid;
				noi=mid+1;
			else
				mak = mid-1;
			end

		end
		--SM("\n\n\n\nYEY ISLA"..string.format("<%d>",ANS));
		if ANS == -1 then
			GS:settext(s)
		else
			GS:settext(string.sub( s, 1, ANS+1 ).."...");
		end
	else
		GS:settext(s)
	end
end

local function TW(T,n)
lim = n or 15
if string.len(T) > lim then
return string.sub(T,1,lim - 2).."..."
else
return T
end
end

local Sp = math.random(50,100)/50;

local SL = {};

local mee = GAMESTATE:GetCurrentCourse():GetEstimatedNumStages();

for i,v in pairs(GAMESTATE:GetCurrentCourse():GetCourseEntries()) do
	if math.mod(i,3) == 1 then
	SL[math.ceil(i/3)]={};
	end
	SL[math.ceil(i/3)][math.mod((i-1),3)+1] = v;
end


local Sc = 10;
local t = Def.ActorFrame{};

t[#t+1]=Def.ActorFrame{
--Control Panel
OnCommand=cmd(playcommand,"nep");
nepCommand=function(self)
--Control here

--Time wait here
self:sleep(math.random(50,70)/10)
--plus Sc here
if Sc == math.ceil(mee/3)*10 then
Sc = 10
wa = 1;
else
Sc = Sc + 10
end
if mee > 3 then self:queuecommand("Send") end

end;
SendCommand=function(self)
MESSAGEMAN:Broadcast("Nepu");
self:queuecommand("nep")
end;
};
local wa = 1;
local ami = {1,1,1};
if GAMESTATE:GetCurrentCourse():GetDescription() ~= "" then
ami = {2,3,4};
else
ami = {2,2,3};
end



--[[t[#t+1]=Def.ActorFrame{
LoadFont("Common Normal")..{
		InitCommand=cmd(x,550;y,75;horizalign,left;zoom,1.1);
		OnCommand=function(self)
		self:settext("Total")
		end;
};
LoadFont("Common Normal")..{
		InitCommand=cmd(x,550;y,100;horizalign,left;zoom,1);
		OnCommand=function(self)
		if mee == 1 then 
		self:settext(TW("1 song..."))
		else
		self:settext(TW(GAMESTATE:GetCurrentCourse():GetEstimatedNumStages()).." song(s)")
		end
		end;
};

LoadFont("Common Normal")..{
		InitCommand=cmd(x,550;y,130;horizalign,left;zoom,1.1);
		OnCommand=function(self)
		self:settext("Time")
		end;
};
LoadFont("Common Normal")..{
		InitCommand=cmd(x,550;y,155;horizalign,left);
		OnCommand=function(self)
			local dislen = "";
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
				if (GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentSteps(PLAYER_1):GetStepsType()) + GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentSteps(PLAYER_2):GetStepsType()))/2 > 60*30 then
					dislen = SecondsToHHMMSS(GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentSteps(PLAYER_1):GetStepsType()))..","..SecondsToHHMMSS(GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentSteps(PLAYER_2):GetStepsType()));
				else
					dislen = SecondsToMMSSMsMs(GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentSteps(PLAYER_1):GetStepsType()))..","..SecondsToMMSSMsMs(GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentSteps(PLAYER_2):GetStepsType()));
				end
			elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
				if GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentSteps(PLAYER_1):GetStepsType()) > 60*30 then
					dislen = SecondsToHHMMSS(GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentSteps(PLAYER_1):GetStepsType()));
				else
					dislen = SecondsToMMSSMsMs(GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentSteps(PLAYER_1):GetStepsType()));
				end
			elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
				if GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentSteps(PLAYER_2):GetStepsType()) > 60*30 then
					dislen = SecondsToHHMMSS(GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentSteps(PLAYER_2):GetStepsType()));
				else
					dislen = SecondsToMMSSMsMs(GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentSteps(PLAYER_2):GetStepsType()));
				end
			end
		self:settext(dislen)
		w = w + 1;
		end;
};



};
]]

t[#t+1] = LoadFont("Common Normal")..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y*0.85-30);
	OnCommand=function(self)
	TWA(GAMESTATE:GetCurrentCourse():GetDisplayFullTitle(),self,240);
	w = w + 1;
	end;
};

if mee == 1 then
t[#t+1] = LoadFont("Common Normal")..{
		InitCommand=cmd(x,SCREEN_CENTER_Y;y,SCREEN_CENTER_Y*0.85-10;zoom,0.75);
		OnCommand=function(self)
		self:settext("Song list (1/1)")
		end;
};
t[#t+1] = LoadFont("Common Normal")..{
		InitCommand=cmd(x,SCREEN_CENTER_Y;y,SCREEN_CENTER_Y*0.85-10+20*1;zoom,0.7);
		OnCommand=function(self)
		self:settext("***Just one song...")
		end;
};
t[#t+1] = LoadFont("Common Normal")..{
		InitCommand=cmd(x,310;y,SCREEN_CENTER_Y*0.85-10+20*2;horizalign,left;zoom,0.7);
		OnCommand=function(self)
		TWA(SL[1][1]:GetSong():GetDisplayMainTitle(),self,200)
		end;
};
t[#t+1] = LoadFont("Common Normal")..{
		InitCommand=cmd(x,545;y,SCREEN_CENTER_Y*0.85-10+20*2;horizalign,right;zoom,0.7);
		OnCommand=function(self)
		self:settext(SecondsToMMSS(SL[1][1]:GetSong():GetLastSecond()))
		end;
};
else
for i,v in pairs(SL) do
t[#t+1] = LoadFont("Common Normal")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y*0.85-10;zoom,0.75;rotationx,(i==1) and 0 or 90);
		OnCommand=function(self)
		self:settext("Song list ("..i.."/"..math.ceil(mee/3)..")")
		end;
		NepuMessageCommand=function(self)
		if Sc == i*10 then
		self:sleep(Sp/2+((Sp/7)*(1-1))):accelerate(Sp/3):rotationx(0)
		else
		self:sleep((Sp/7)*(1-1)):decelerate(Sp/3):rotationx(90)
		end
		end;
};
for a,k in pairs(v) do
t[#t+1] = Def.ActorFrame{
LoadFont("Common Normal")..{
		InitCommand=cmd(x,310;y,SCREEN_CENTER_Y*0.85-10+20*a;horizalign,left;zoom,0.7;rotationx,(i==1) and 0 or 90);
		OnCommand=function(self)
		TWA(k:GetSong():GetDisplayMainTitle(),self,200)
		end;
		NepuMessageCommand=function(self)
		if Sc == i*10 then
		self:sleep(Sp/2+((Sp/7)*(a))):accelerate(Sp/3):rotationx(0)
		else
		self:sleep((Sp/7)*(a)):decelerate(Sp/3):rotationx(90)
		end
		end;
};
LoadFont("Common Normal")..{
		InitCommand=cmd(x,545;y,SCREEN_CENTER_Y*0.85-10+20*a;horizalign,right;zoom,0.7;rotationx,(i==1) and 0 or 90);
		OnCommand=function(self)
		self:settext(SecondsToMMSS(k:GetSong():GetLastSecond()))
		end;
		NepuMessageCommand=function(self)
		if Sc == i*10 then
		self:sleep(Sp/2+((Sp/7)*(a))):accelerate(Sp/3):rotationx(0)
		else
		self:sleep((Sp/7)*(a)):decelerate(Sp/3):rotationx(90)
		end
		end;
};
};
end
end
end

return t;