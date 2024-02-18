					--[[WTF=GAMESTATE:GetCurrentSong():GetLastSecond()-GAMESTATE:GetCurMusicSeconds()
					Hi=SecondsToMSSMsMs(GAMESTATE:GetCurrentSong():GetLastSecond()-GAMESTATE:GetCurMusicSeconds())
					kuy=SecondsToMSSMsMs(GAMESTATE:GetCurrentSong():GetLastSecond())
					Clockmin = math.floor((GAMESTATE:GetCurrentSong():GetLastSecond()-GAMESTATE:GetCurMusicSeconds())/60)
					Clocksec = math.floor((GAMESTATE:GetCurrentSong():GetLastSecond()-GAMESTATE:GetCurMusicSeconds())-Clockmin*60)
					ClockWTF = (string.format('%.2f',((GAMESTATE:GetCurrentSong():GetLastSecond()-GAMESTATE:GetCurMusicSeconds())-Clockmin*60) - Clocksec))*100
					COLON = ""
					if MonthOfYear() == 4-1 and DayOfMonth() == 1 then
						COLON = ":"
						if ClockWTF < 10 then
							RClockWTF = '0'..ClockWTF
						else
							RClockWTF = ClockWTF
						end
						if ClockWTF >= 50 then
						clocknow = " :  :  "
						else
						if Clocksec < 10 then
						clocknow = Clockmin..COLON.."0"..Clocksec..COLON..RClockWTF
						else
						clocknow = Clockmin..COLON..Clocksec..COLON..RClockWTF
						end
						end
					else
						if ClockWTF >= 50 then
						COLON = ":"
						else
						COLON = " "
						end
						if ClockWTF < 10 then
						RClockWTF = '0'..ClockWTF
						else
							RClockWTF = ClockWTF
						end
						if Clocksec < 10 then
						clocknow = Clockmin..COLON.."0"..Clocksec..COLON..RClockWTF
						else
						clocknow = Clockmin..COLON..Clocksec..COLON..RClockWTF
						end
					end
								
		
		if WTF <= 0 then
		self:settext("0"..COLON.."00"..COLON.."00")
		elseif P >= 50 and P <= 55 then
		self:diffusealpha(0)
		elseif P >= 55 and P <= 100 then
		self:diffusealpha(1)
		self:settext(clocknow)
		elseif P >= 100 then
		self:settext("0"..COLON.."00"..COLON.."00")
		else
		self:settext(clocknow)
		end]]
local plused = false;
local dat = 0;
local Change = math.random(10,25)
local hang = 12;
local NumF = "_determination mono 24px"
LoadActor("../../_save/SampleText.lua")
local Os = 0;
if DayOfMonth() ~= day or MonthOfYear()-1 ~= mon or Year() ~= year then
Os = 0
Od = DayOfMonth()
Om = MonthOfYear()-1
Oy = Year()
else
Os = sec
Od = day
Om = mon
Oy = year
end
local t = Def.ActorFrame{};
	t[#t+1] = Def.ActorFrame{
		Def.ActorFrame{
			OnCommand=function(self) self:y(60); self:x(SCREEN_CENTER_X-hang*3.5); self:zoom(0.8); end;
			DMessageCommand=function(self) self:sleep(0.1*0); self:decelerate(0.5); self:rotationx(180); end;
			TMessageCommand=function(self) self:sleep(0.1*0); self:decelerate(0.5); self:rotationx(360); self:sleep(0.00001); self:rotationx(0); end;
		LoadFont(NumF) .. {
		InitCommand=function(self) self:diffuse(color("#0011FF")); self:cullmode('back'); end;
		OnCommand=function(self)
		STD = self
		end;
		};
		LoadFont(NumF) .. {
		InitCommand=function(self) self:diffuse(color("#0011FF")); self:cullmode('back'); self:rotationx(180); end;
		OnCommand=function(self)
		STT = self
		end;
		};
		};
		Def.ActorFrame{
			OnCommand=function(self) self:y(60); self:x(SCREEN_CENTER_X-hang*2.5); self:zoom(0.8); end;
			DMessageCommand=function(self) self:sleep(0.1*1); self:decelerate(0.5); self:rotationx(180); end;
			TMessageCommand=function(self) self:sleep(0.1*1); self:decelerate(0.5); self:rotationx(360); self:sleep(0.00001); self:rotationx(0); end;
		LoadFont(NumF) .. {
		InitCommand=function(self) self:diffuse(color("#0011FF")); self:cullmode('back'); end;
		OnCommand=function(self)
		NDD = self
		end;
		};
		LoadFont(NumF) .. {
		InitCommand=function(self) self:diffuse(color("#0011FF")); self:cullmode('back'); self:rotationx(180); end;
		OnCommand=function(self)
		NDT = self
		end;
		};
		};
		Def.ActorFrame{
			OnCommand=function(self) self:y(60); self:x(SCREEN_CENTER_X-hang*1.5); self:zoom(0.8); end;
			DMessageCommand=function(self) self:sleep(0.1*2); self:decelerate(0.5); self:rotationx(180); end;
			TMessageCommand=function(self) self:sleep(0.1*2); self:decelerate(0.5); self:rotationx(360); self:sleep(0.00001); self:rotationx(0); end;
		LoadFont(NumF) .. {
		InitCommand=function(self) self:diffuse(color("#0011FF")); self:cullmode('back'); end;
		OnCommand=function(self)
		RDD = self
		end;
		};
		LoadFont(NumF) .. {
		InitCommand=function(self) self:diffuse(color("#0011FF")); self:cullmode('back'); self:rotationx(180); end;
		OnCommand=function(self)
		RDT = self
		end;
		};
		};
		Def.ActorFrame{
			OnCommand=function(self) self:y(60); self:x(SCREEN_CENTER_X-hang*0.5); self:zoom(0.8); end;
			DMessageCommand=function(self) self:sleep(0.1*3); self:decelerate(0.5); self:rotationx(180); end;
			TMessageCommand=function(self) self:sleep(0.1*3); self:decelerate(0.5); self:rotationx(360); self:sleep(0.00001); self:rotationx(0); end;
		LoadFont(NumF) .. {
		InitCommand=function(self) self:diffuse(color("#0011FF")); self:cullmode('back'); end;
		OnCommand=function(self)
		THD = self
		end;
		};
		LoadFont(NumF) .. {
		InitCommand=function(self) self:diffuse(color("#0011FF")); self:cullmode('back'); self:rotationx(180); end;
		OnCommand=function(self)
		THT = self
		end;
		};
		};
		Def.ActorFrame{
			OnCommand=function(self) self:y(60); self:x(SCREEN_CENTER_X+hang*0.5); self:zoom(0.8); end;
			DMessageCommand=function(self) self:sleep(0.1*4); self:decelerate(0.5); self:rotationx(180); end;
			TMessageCommand=function(self) self:sleep(0.1*4); self:decelerate(0.5); self:rotationx(360); self:sleep(0.00001); self:rotationx(0); end;
		LoadFont(NumF) .. {
		InitCommand=function(self) self:diffuse(color("#0011FF")); self:cullmode('back'); end;
		OnCommand=function(self)
		FID = self
		end;
		};
		LoadFont(NumF) .. {
		InitCommand=function(self) self:diffuse(color("#0011FF")); self:cullmode('back'); self:rotationx(180); end;
		OnCommand=function(self)
		FIT = self
		end;
		};
		};
		Def.ActorFrame{
			OnCommand=function(self) self:y(60); self:x(SCREEN_CENTER_X+hang*1.5); self:zoom(0.8); end;
			DMessageCommand=function(self) self:sleep(0.1*5); self:decelerate(0.5); self:rotationx(180); end;
			TMessageCommand=function(self) self:sleep(0.1*5); self:decelerate(0.5); self:rotationx(360); self:sleep(0.00001); self:rotationx(0); end;
		LoadFont(NumF) .. {
		InitCommand=function(self) self:diffuse(color("#0011FF")); self:cullmode('back'); end;
		OnCommand=function(self)
		SID = self
		end;
		};
		LoadFont(NumF) .. {
		InitCommand=function(self) self:diffuse(color("#0011FF")); self:cullmode('back'); self:rotationx(180); end;
		OnCommand=function(self)
		SIT = self
		end;
		};
		};
		Def.ActorFrame{
			OnCommand=function(self) self:y(60); self:x(SCREEN_CENTER_X+hang*2.5); self:zoom(0.8); end;
			DMessageCommand=function(self) self:sleep(0.1*6); self:decelerate(0.5); self:rotationx(180); end;
			TMessageCommand=function(self) self:sleep(0.1*6); self:decelerate(0.5); self:rotationx(360); self:sleep(0.00001); self:rotationx(0); end;
		LoadFont(NumF) .. {
		InitCommand=function(self) self:diffuse(color("#0011FF")); self:cullmode('back'); end;
		OnCommand=function(self)
		SED = self
		end;
		};
		LoadFont(NumF) .. {
		InitCommand=function(self) self:diffuse(color("#0011FF")); self:cullmode('back'); self:rotationx(180); end;
		OnCommand=function(self)
		SET = self
		end;
		};
		};
		Def.ActorFrame{
			OnCommand=function(self) self:y(60); self:x(SCREEN_CENTER_X+hang*3.5); self:zoom(0.8); end;
			DMessageCommand=function(self) self:sleep(0.1*7); self:decelerate(0.5); self:rotationx(180); end;
			TMessageCommand=function(self) self:sleep(0.1*7); self:decelerate(0.5); self:rotationx(360); self:sleep(0.00001); self:rotationx(0); end;
		LoadFont(NumF) .. {
		InitCommand=function(self) self:diffuse(color("#0011FF")); self:cullmode('back'); end;
		OnCommand=function(self)
		EAD = self
		end;
		};
		LoadFont(NumF) .. {
		InitCommand=function(self) self:diffuse(color("#0011FF")); self:cullmode('back'); self:rotationx(180); end;
		OnCommand=function(self)
		EAT = self
		end;
		};
		};
	};
	t[#t+1] = LoadFont(NumF) .. {
		InitCommand=function(self) self:Center(); end;
		OnCommand=function(self) self:playcommand("Neptune"); end;
		NeptuneCommand=function(self)
		Remind = math.max(GAMESTATE:GetCurrentSong():GetLastSecond() - GAMESTATE:GetCurMusicSeconds(),0)
		Clockmin = math.floor((Remind)/60)
		Clocksec = math.floor((Remind)-Clockmin*60)
		ClockWTF = (string.format('%.2f',((Remind)-Clockmin*60) - Clocksec))*100
		if ClockWTF >= 50 then
			COLON = ":"
		else
			COLON = ""
		end
		if ClockWTF == 100 then
			OutCW = 99
		elseif ClockWTF < 100 then
			OutCW = ClockWTF
		end
		STD:settext(math.floor(Clockmin/10))
		NDD:settext(Clockmin-(math.floor(Clockmin/10))*10)
		RDD:settext(COLON)
		THD:settext(math.floor(Clocksec/10))
		FID:settext(Clocksec-(math.floor(Clocksec/10))*10)
		SID:settext(COLON)
		SED:settext(math.floor(OutCW/10))
		EAD:settext(OutCW-(math.floor(OutCW/10))*10)
		if GAMESTATE:GetCurMusicSeconds() >= GAMESTATE:GetCurrentSong():GetLastSecond() and not plused then
			plused = true
			Os = Os + GAMESTATE:GetCurrentSong():GetLastSecond()
	local file = RageFileUtil.CreateRageFile()
	file:Open("/Themes/News/BGAnimations/_save/SampleText.lua", 2 ) --2 = write
	file:PutLine("--Time all SET")
	file:PutLine("sec = "..Os)
	file:PutLine("day = "..Od)
	file:PutLine("mon = "..Om)
	file:PutLine("year = "..Oy)
	file:PutLine("--End of SampleText")
	file:Close();
		elseif GAMESTATE:GetCurMusicSeconds() < GAMESTATE:GetCurrentSong():GetLastSecond() and plused then
			plused = false
		end
		outsec = Os + math.min(math.max(GAMESTATE:GetCurMusicSeconds(),0),GAMESTATE:GetCurrentSong():GetLastSecond()) - TFO( GAMESTATE:GetCurMusicSeconds() > GAMESTATE:GetCurrentSong():GetLastSecond(), GAMESTATE:GetCurrentSong():GetLastSecond(),0)
		outsech = math.floor(outsec/3600)
		outsecm = (math.floor(outsec/60))-outsech*60
		outsecs = math.floor(outsec)-(outsech*60*60+outsecm*60)
		outsecw = (outsec - math.floor(outsec))*100
		if outsecw == 100 then
			RW = 99
		elseif outsecw < 100 then
			RW = outsecw
		end
		if outsecw > 50 then
			RC = ""
		else
			RC = ":"
		end
		STT:settext(math.floor(outsech/10))
		NDT:settext(outsech-(math.floor(outsech/10))*10)
		RDT:settext(RC)
		THT:settext(math.floor(outsecm/10))
		FIT:settext(outsecm-(math.floor(outsecm/10))*10)
		SIT:settext(RC)
		SET:settext(math.floor(outsecs/10))
		EAT:settext(outsecs-(math.floor(outsecs/10))*10)
		if GAMESTATE:GetCurMusicSeconds() >= Change then
			Change = Change + math.random(8,20)
			if dat == 0 then
				MESSAGEMAN:Broadcast("D")
				dat = 1
			elseif dat == 1 then
				MESSAGEMAN:Broadcast("T")
				dat = 0
			end
		elseif GAMESTATE:GetCurMusicSeconds() < 10 and Change > 25 then
			Change = 0
		end
		--self:settext(outsec)
		self:sleep(0.02)
		self:queuecommand("Neptune")
		end;
	};
return t;