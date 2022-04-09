local nowh = 0;
local nowm = 0;
local nows = 0;
local nowd = 0;
local nowmon = 0;
local realh = 0;
local realm = 0;
local reals = 0;
local nowWTF = 0;
local nowCOLON = "";
local file = RageFileUtil.CreateRageFile();
local path = "/Themes/News/BGAnimations/_save/";
function SVAEFORDDDDAYYYYYY() --saveforday 
	file:Open(path.."SaveForDay.lua", 2 ) --2 = write
	file:PutLine("local nowh = "..nowh..";")
	file:PutLine("local nowm = "..nowm..";")
	file:PutLine("local nows = "..nows..";")
	file:PutLine("local nowd = "..nowd..";")
	file:PutLine("local nowmon = "..nowmon..";")
	file:PutLine("local realh = "..realh..";")
	file:PutLine("local realm = "..realm..";")
	file:PutLine("local reals = "..reals..";")
	file:PutLine("local nowWTF = "..nowWTF..";")
	file:PutLine("local nowCOLON = "..nowCOLON..";")
	file:PutLine("local file = RageFileUtil.CreateRageFile();")
	file:PutLine('local path = "/Themes/News/BGAnimations/_save/";')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('	file:Open(path.."SaveForDay.lua", 2 ) --2 = write')
	file:PutLine('	file:PutLine("local nowh = "..nowh..";")')
	file:PutLine('	file:PutLine("local nowm = "..nowm..";")')
	file:PutLine('	file:PutLine("local nows = "..nows..";")')
	file:PutLine('	file:PutLine("local nowmon = "..nowmon..";")')
	file:PutLine('	file:PutLine("local realh = "..realh..";")')
	file:PutLine('	file:PutLine("local realm = "..realm..";")')
	file:PutLine('	file:PutLine("local reals = "..reals..";")')
	file:PutLine('	file:PutLine("local nowWTF = "..nowWTF..";")')
	file:PutLine('	file:PutLine("local nowCOLON = "..nowCOLON..";")')
	file:PutLine('	file:PutLine("local file = RageFileUtil.CreateRageFile();")')
	file:PutLine("	file:PutLine('local path = '/Themes/News/BGAnimations/_save/';')")
	file:PutLine('	file:PutLine("function SVAEFORDDDDAYYYYYY()")')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:PutLine('function SVAEFORDDDDAYYYYYY()')
	file:Close();
end
--ReportAllSpectrumParameters
local savefordaybitch = false
local t = Def.ActorFrame{
	LoadFont("_determination mono 24px") .. {
InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_BOTTOM-20); self:zoom(0.85); self:diffusealpha(1); end;
OnCommand=function(self)
--MonthOfYear() == 12-1 and DayOfMonth() == 31
	if nowd ~= DayOfMonth() and nowmon+1 ~= MonthOfYear() then
			nowh = 0;
			nowm = 0;
			nows = 0;
			nowd = DayOfMonth();
			nowmon = MonthOfYear();
	end
	self:diffuse(color("#FFFFFF"))
	self:playcommand('loop')
end;
		loopCommand=function(self)
		nowWTF = nowWTF + 0.02
		if nowWTF >= 0.5 then nowCOLON = " " else nowCOLON = ":" end
		if nowWTF >= 1 then nowWTF = 0 nows = nows + 1 end
		if nows >= 60 then nows = 0 nowm = nowm + 1 end
		if nowm >= 60 then nowm = 0 nowh = nowh + 1 end
		if nows < 10 then reals = "0"..nows else reals = nows end
		if nowm < 10 then realm = "0"..nowm else realm = nowm end
		if nowh < 10 then realh = "0"..nowh else realh = nowh end
	if GAMESTATE:GetCurMusicSeconds() >= GAMESTATE:GetCurrentSong():GetLastSecond() and not savefordaybitch then SVAEFORDDDDAYYYYYY() savefordaybitch = true end
	self:settext("today playtime:"..realh..nowCOLON..realm..nowCOLON..reals) self:sleep(0.02) self:queuecommand('loop')
		end;
};
};

return t