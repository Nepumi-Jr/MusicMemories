local w = -1
local function TW(T,n)
lim = n or 15
if string.len(T) > lim then
return string.sub(T,1,lim - 2).."..."
else
return T
end
end

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

local t = Def.ActorFrame{
LoadFont("Common Normal")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y*0.85-30); end;
		OnCommand=function(self)
		TWA(GAMESTATE:GetCurrentSong():GetDisplayFullTitle(),self,240);
		w = w + 1;
		end;
};

Def.ActorFrame{
Condition = GAMESTATE:GetCurrentSong():GetDisplayMainTitle() ~= "" and GAMESTATE:GetCurrentSong():GetDisplayMainTitle() ~= GAMESTATE:GetCurrentSong():GetDisplayFullTitle();
LoadFont("Common Normal")..{
		InitCommand=function(self) self:x(310); self:y(SCREEN_CENTER_Y*0.85); self:horizalign(left); self:zoom(0.75); end;
		OnCommand=function(self)
		self:settext("Title:"):y(SCREEN_CENTER_Y*0.85-10+20*w)
		
		end;
};

LoadFont("Common Normal")..{
		InitCommand=function(self) self:x(545); self:y(SCREEN_CENTER_Y*0.85+100*w); self:horizalign(right); self:zoom(0.75); end;
		OnCommand=function(self)
		TWA(GAMESTATE:GetCurrentSong():GetDisplayMainTitle(),self,200);
		self:y(SCREEN_CENTER_Y*0.85-10+20*w)
		--SM("\n\n\n\n\nISLA : "..self:GetWidth())
		--self:settext(TW(GAMESTATE:GetCurrentSong():GetDisplayMainTitle())):
		w = w + 1;
		end;
};
};

Def.ActorFrame{
Condition = GAMESTATE:GetCurrentSong():GetDisplaySubTitle() ~= "";
LoadFont("Common Normal")..{
		InitCommand=function(self) self:x(310); self:y(SCREEN_CENTER_Y*0.85); self:horizalign(left); self:zoom(0.75); end;
		OnCommand=function(self)
		self:settext("Sub:"):y(SCREEN_CENTER_Y*0.85-10+20*w)
		end;
};
LoadFont("Common Normal")..{
		InitCommand=function(self) self:x(545); self:y(SCREEN_CENTER_Y*0.85+100*w); self:horizalign(right); self:zoom(0.75); end;
		OnCommand=function(self)
		TWA(GAMESTATE:GetCurrentSong():GetDisplaySubTitle(),self,200);
		self:y(SCREEN_CENTER_Y*0.85-10+20*w)
		w = w + 1;
		end;
};
};

Def.ActorFrame{
Condition = GAMESTATE:GetCurrentSong():GetDisplayArtist() ~= "" and GAMESTATE:GetCurrentSong():GetDisplayArtist() ~= "Unknown artist";
LoadFont("Common Normal")..{
		InitCommand=function(self) self:x(310); self:y(SCREEN_CENTER_Y*0.85); self:horizalign(left); self:zoom(0.75); end;
		OnCommand=function(self)
		self:settext("Artist:"):y(SCREEN_CENTER_Y*0.85-10+20*w)
		end;
};
LoadFont("Common Normal")..{
		InitCommand=function(self) self:x(545); self:y(SCREEN_CENTER_Y*0.85+100*w); self:horizalign(right); self:zoom(0.75); end;
		OnCommand=function(self)
		TWA(GAMESTATE:GetCurrentSong():GetDisplayArtist(),self,180);
		self:y(SCREEN_CENTER_Y*0.85-10+20*w)
		w = w + 1;
		end;
};
};


Def.ActorFrame{
LoadFont("Common Normal")..{
		InitCommand=function(self) self:x(310); self:y(SCREEN_CENTER_Y*0.85); self:horizalign(left); self:zoom(0.75); end;
		OnCommand=function(self)
		self:settext("Group:"):y(SCREEN_CENTER_Y*0.85-10+20*w)
		end;
};
LoadFont("Common Normal")..{
		InitCommand=function(self) self:x(545); self:y(SCREEN_CENTER_Y*0.85+100*w); self:horizalign(right); self:zoom(0.75); end;
		OnCommand=function(self)
		TWA(GAMESTATE:GetCurrentSong():GetGroupName(),self,180)
		self:y(SCREEN_CENTER_Y*0.85-10+20*w)
		w = w + 1;
		end;
};
};

--[[Def.ActorFrame{
LoadFont("Common Normal")..{
		InitCommand=function(self) self:x(550); self:y(75); self:horizalign(left); self:zoom(1.1); end;
		OnCommand=function(self)
		self:settext("Time")
		end;
};
LoadFont("Common Normal")..{
		InitCommand=function(self) self:x(550); self:y(100); self:horizalign(left); self:zoom(1); end;
		OnCommand=function(self)
		if GAMESTATE:GetCurrentSong():MusicLengthSeconds() > 60*30 then
		self:settext(SecondsToHHMMSS(GAMESTATE:GetCurrentSong():MusicLengthSeconds()))
		else
		self:settext(SecondsToMMSSMsMs(GAMESTATE:GetCurrentSong():MusicLengthSeconds()))
		end
		w = w + 1;
		end;
};
};

Def.ActorFrame{
LoadFont("Common Normal")..{
		InitCommand=function(self) self:x(550); self:y(130); self:horizalign(left); self:zoom(1.1); end;
		OnCommand=function(self)
		self:settext("Bpm")
		end;
};
LoadFont("Common Normal")..{
		InitCommand=function(self) self:x(550); self:y(155); self:horizalign(left); end;
		OnCommand=function(self)
		if GAMESTATE:GetCurrentSong():GetDisplayBpms()[1] == GAMESTATE:GetCurrentSong():GetDisplayBpms()[2] then
		self:settextf("%d",GAMESTATE:GetCurrentSong():GetDisplayBpms()[1])
		else
		self:settextf("%d - %d",GAMESTATE:GetCurrentSong():GetDisplayBpms()[1],GAMESTATE:GetCurrentSong():GetDisplayBpms()[2])
		end
		w = w + 1;
		end;
};
};]]



};
return t;