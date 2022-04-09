local t = LoadFallbackB();

local StepsType = ToEnumShortString( GAMEMAN:GetFirstStepsTypeForGame(GAMESTATE:GetCurrentGame()) );
local stString = THEME:GetString("StepsType",StepsType);

local NumColumns = THEME:GetMetric(Var "LoadingScreen", "NumColumns");

t[#t+1] = Def.ActorFrame {
	InitCommand=function(self) self:x(SCREEN_CENTER_X); self:y(SCREEN_CENTER_Y-160); end;
	Def.Quad {
		InitCommand=function(self) self:zoomto(SCREEN_WIDTH, 32); end;
		OnCommand=function(self) self:y(-16); self:diffuse(Color.Black); self:fadebottom(0.8); end;
	};
	Def.Quad {
		InitCommand=function(self) self:zoomto(SCREEN_WIDTH, 56); end;
		OnCommand=function(self) self:diffuse(color("#333333")); self:diffusealpha(0.75); self:fadebottom(0.35); end;
	};
};

for i=1,NumColumns do
	local st = THEME:GetMetric(Var "LoadingScreen","ColumnStepsType" .. i);	
	local dc = THEME:GetMetric(Var "LoadingScreen","ColumnDifficulty" .. i);
	local s = GetCustomDifficulty( st, dc );
	
	t[#t+1] = Def.ActorFrame {
		InitCommand=function(self) self:x(SCREEN_CENTER_X-60 + 80 * (i-1)); self:y(SCREEN_CENTER_Y-168); end;
		LoadActor(THEME:GetPathB("_frame","3x1"),"rounded fill", 18) .. {
			OnCommand=function(self) self:diffuse(CustomDifficultyToDarkColor(s)); self:diffusealpha(0.5); end;
		};
		LoadActor(THEME:GetPathB("_frame","3x1"),"rounded gloss", 18) .. {
			OnCommand=function(self) self:diffuse(CustomDifficultyToColor(s)); self:diffusealpha(0.125); end;
		};
		LoadFont("Common Normal") .. {
			InitCommand=function(self) self:uppercase(true); self:settext(CustomDifficultyToLocalizedString(s)); end;
			OnCommand=function(self) self:zoom(0.675); self:maxwidth(80/0.675); self:diffuse(CustomDifficultyToColor(s)); self:shadowlength(1); end;
		};
	};
end

t[#t+1] = LoadFont("Common Bold") .. {
	InitCommand=function(self) self:settext(stString); self:x(SCREEN_CENTER_X-220); self:y(SCREEN_CENTER_Y-168); end;
	OnCommand=function(self) self:skewx(-0.125); self:diffusebottomedge(color("0.75,0.75,0.75")); self:shadowlength(2); end;
};

t.OnCommand=function(self) self:draworder(105); end;

return t;
