local function GetList()
	local l = {};
	for i=1,7 do
		local stats;
		stats = STATSMAN:GetPlayedStageStats(i);
		
		if not stats then
			break
		end
		
		l[#l+1] = stats;
	end
	return l
end

local statList = GetList();

local as = Def.ActorScroller {
	SecondsPerItem = 1;
	NumItemsToDraw = 10;
	TransformFunction = function( self, offset, itemIndex, numItems)
		self:diffusealpha(1-offset);
	end;
	OnCommand=function(self)
		self:SetLoop(true);
		self:SetSecondsPauseBetweenItems(2);
		self:ScrollThroughAllItems();
	end;
}

for i=1,#statList do
	local j = #statList - (i-1);
	as[#as+1] = Def.ActorFrame {
		Def.Sprite {
			InitCommand=function(self) self:scaletoclipped(256,80); end;
			BeginCommand=function(self)
				local path = statList[j]:GetPlayedSongs()[1]:GetBannerPath() or THEME:GetPathG("Common","fallback banner");
				self:LoadBanner(path);
			end;
		};
		Def.Quad {
			InitCommand=function(self) self:x(128); self:y(40); self:horizalign(right); self:vertalign(bottom); end;
			OnCommand=function(self) self:zoomto(80,18); self:diffuse(Color.Black); self:diffusealpha(0.5); self:fadeleft(0.5); end;
		};
		LoadFont("Common Normal") .. {
			Text=StageToLocalizedString( statList[j]:GetStage() );
			InitCommand=function(self) self:x(128-4); self:y(40-4); self:horizalign(right); self:vertalign(bottom); end;
			OnCommand=function(self) self:diffuse(StageToColor(statList[j]:GetStage())); self:zoom(0.675); self:shadowlength(1); end;
		};
	};
end

return Def.ActorFrame {
	as;
	LoadActor(THEME:GetPathG("ScreenSelectMusic","BannerFrame"));
};
