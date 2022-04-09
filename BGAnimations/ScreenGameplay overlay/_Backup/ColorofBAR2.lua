local zoooomy = 10;
local wai = 0;
local maxnum = 100;
local P1H = 0;
local P2H = 0;
local mixH = 0;
local t = Def.ActorFrame{};
for i=1,maxnum do
t[#t+1] = Def.Quad{
InitCommand=function(self)
self:diffuse(color("#5577FF00"))
self:horizalign(left)
self:zoomx(SCREEN_RIGHT/maxnum);
self:zoomy(zoooomy)
self:x((i-1)*(SCREEN_RIGHT/maxnum));
self:y(wai)
self:fadetop(0.5);
end;
OnCommand=function(self) self:playcommand('Super'); end;
		SuperCommand=function(self)
		if GAMESTATE:GetCurMusicSeconds() < (GAMESTATE:GetCurrentSong():MusicLengthSeconds()/maxnum)*(i-1) then
		self:diffusealpha(0)
		elseif GAMESTATE:GetCurMusicSeconds() >= (GAMESTATE:GetCurrentSong():MusicLengthSeconds()/maxnum)*(i-1) and GAMESTATE:GetCurMusicSeconds() < (GAMESTATE:GetCurrentSong():MusicLengthSeconds()/maxnum)*(i) then
			
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
			mixH = (P1H + P2H) / 2
			if mixH > 50 then
			self:diffuse(1-((mixH-50)*0.02),1,0,0)
			elseif mixH <= 50 then
			self:diffuse(1,(mixH)*0.02,0,0)
			end
			elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
			if P1H > 50 then
			self:diffuse(1-((P1H-50)*0.02),1,0,0)
			elseif P1H <= 50 then
			self:diffuse(1,(P1H)*0.02,0,0)
			end
			elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
			if P2H > 50 then
			self:diffuse(1-((P2H-50)*0.02),1,0,0)
			elseif P2H <= 50 then
			self:diffuse(1,(P2H)*0.02,0,0)
			end
			end
		elseif GAMESTATE:GetCurMusicSeconds() >= (GAMESTATE:GetCurrentSong():MusicLengthSeconds()/maxnum)*(i) then
		self:diffusealpha(1)
		end
		if GAMESTATE:GetCurMusicSeconds()-1 >= (GAMESTATE:GetCurrentSong():MusicLengthSeconds()/maxnum)*(i) then
		else
		self:sleep(0.05)
		self:queuecommand('Super')
		end
		end;
};
end
t[#t+1] = Def.ActorFrame{
Def.Quad {
OnCommand=function(self) self:zoom(0); end;
		LifeChangedMessageCommand=function(self,params)
			if(params.Player == PLAYER_2) then
				P2H = params.LifeMeter:GetLife()*100
			end;
		end;
};
Def.Quad {
OnCommand=function(self) self:zoom(0); end;
		LifeChangedMessageCommand=function(self,params)
			if(params.Player == PLAYER_1) then
				P1H = params.LifeMeter:GetLife()*100
			end;
		end;
};
};
return t;
--[[
if sc_right == 300
if music = 60
if tap = 6
<------------------------------------- 300 pix ------------------------------->
-------------
x =300/tap
             -------------
			              -------------
						               -------------
									                -------------
													             -------------
																              


0-----------------------------------------------------------------------------60



]]