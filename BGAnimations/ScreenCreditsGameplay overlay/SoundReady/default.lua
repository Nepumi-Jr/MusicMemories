
local PPeng;
if GAMESTATE:IsCourseMode() then
PPeng = GAMESTATE:GetCurrentCourse():GetCourseEntry(0):GetSong();
else
PPeng = GAMESTATE:GetCurrentSong();
end

if PPeng == nil then return Def.ActorFrame{}; end

local function NEP(x)
	return PPeng:GetTimingData():GetElapsedTimeFromBeat(x);
end

local FB = round(round(PPeng:GetFirstBeat())/4)*4
local cha = PREFSMAN:GetPreference('GlobalOffsetSeconds')*2;

local Stat = 0;
local Pat = THEMEDIR().."/BGAnimations/ScreenGameplay overlay/SoundReady/";
function LentSeng(num)
		if num == 4 then
			SOUND:PlayOnce(Pat.."readyOr.mp3");
		elseif num == 3 then
			SOUND:PlayOnce(Pat.."Tick.wav");
		elseif num == 2 then
			SOUND:PlayOnce(Pat.."Tick.wav");
		elseif num == 1 then
			SOUND:PlayOnce(Pat.."Tick.wav");
		elseif num == 0 then
			SOUND:PlayOnce(Pat.."Tick.wav");
		end
end


local function MS(self)
	local this = self:GetChildren()
if GAMESTATE:GetCurMusicSeconds() >= NEP(FB-1)+cha  and Stat == 4 then
Stat = Stat + 1;
this.Ma:settext("IKU")
LentSeng(0)
--Go
elseif GAMESTATE:GetCurMusicSeconds() >= NEP(FB-2)+cha and Stat == 3 then
Stat = Stat + 1;
this.Ma:settext("1")
LentSeng(1)
--1
elseif GAMESTATE:GetCurMusicSeconds() >= NEP(FB-3)+cha and Stat == 2 then
Stat = Stat + 1;
this.Ma:settext("2")
LentSeng(2)
--2
elseif GAMESTATE:GetCurMusicSeconds() >= NEP(FB-4)+cha and Stat == 1 then
Stat = Stat + 1;
this.Ma:settext("3")
LentSeng(3)
--3
elseif GAMESTATE:GetCurMusicSeconds() >= NEP(FB-8)+cha and Stat == 0 then
Stat = Stat + 1;
this.Ma:settext("READY")
LentSeng(4)
--R U Ready
end


end


local Tune = Def.ActorFrame{
InitCommand=function(self) self:SetUpdateFunction(MS); end;

LoadFont("Common Normal")..{
Name = "Ma";
InitCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y*0.65); self:zoom(0); self:rainbow(); self:settext("Nope"); end;
};





};
return Tune;