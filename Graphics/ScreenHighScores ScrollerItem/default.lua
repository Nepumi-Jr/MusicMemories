local t = Def.ActorFrame {
	FOV=90;
	InitCommand=function(self) self:runcommandsonleaves(function(self) self:ztest(true); end); end;
};

t[#t+1] = LoadActor("frame") .. {
	InitCommand=function(self) self:diffusealpha(0.25); end;
};


t[#t+1] = Def.TextBanner {
	InitCommand=function(self) self:x(-292); self:Load("TextBannerHighScores"); end;
	SetCommand=function(self, params)
		if params.Song then
			self:SetFromSong( params.Song );
			self:diffuse( SONGMAN:GetSongColor(params.Song) );
		else
			self:SetFromString( params.Course:GetTitle() );
			self:diffuse( SONGMAN:GetCourseColor(params.Course) );
		end
	end;
};

local NumColumns = THEME:GetMetric(Var "LoadingScreen", "NumColumns");

local c;
local Scores = Def.ActorFrame {
	InitCommand = function(self)
		c = self:GetChildren();
	end;
};
t[#t+1] = Scores;

for idx=1,NumColumns do
	local x_pos = -60 + 80 * (idx-1);
	Scores[#Scores+1] = LoadFont(Var "LoadingScreen","Name") .. {
		Name = idx .. "Name";
		InitCommand=function(self) self:x(x_pos); self:y(8); self:shadowlength(1); self:maxwidth(68); end;
		OnCommand=function(self) self:zoom(0.75); end;
	};
	Scores[#Scores+1] = LoadFont(Var "LoadingScreen","Score") .. {
		Name = idx .. "Score";
		InitCommand=function(self) self:x(x_pos); self:y(-9); self:shadowlength(1); self:maxwidth(68); end;
		OnCommand=function(self) self:zoom(0.75); end;
	};
	Scores[#Scores+1] = LoadActor("filled") .. {
		Name = idx .. "Filled";
		InitCommand=function(self) self:x(x_pos); end;
	};
	Scores[#Scores+1] = LoadActor("empty") .. {
		Name = idx .. "Empty";
		InitCommand=function(self) self:x(x_pos); end;
		OnCommand=function(self) self:zoom(0.75); end;
	};
	
end

local sNoScoreName = THEME:GetMetric("Common", "NoScoreName");

Scores.SetCommand=function(self, params)
	local pProfile = PROFILEMAN:GetMachineProfile();

	for name, child in pairs(c) do
		child:visible(false);
	end
	for idx=1,NumColumns do
		c[idx .. "Empty"]:visible(true);
	end

	local Current = params.Song or params.Course;
	if Current then
		for idx, CurrentItem in pairs(params.Entries) do
			if CurrentItem then
				local hsl = pProfile:GetHighScoreList(Current, CurrentItem);
				local hs = hsl and hsl:GetHighScores();

				local name = c[idx .. "Name"];
				local score = c[idx .. "Score"];
				local filled = c[idx .. "Filled"];
				local empty = c[idx .. "Empty"];
				
				name:visible( true );
				score:visible( true );
				filled:visible( true );
				empty:visible( false );
				
				if hs and #hs > 0 then
					name:settext( hs[1]:GetName() );
					score:settext( FormatPercentScore( hs[1]:GetPercentDP() ) );
				else
					name:settext( sNoScoreName );
					score:settext( FormatPercentScore( 0 ) );
				end
			end
		end;
	end
end;

return t;
