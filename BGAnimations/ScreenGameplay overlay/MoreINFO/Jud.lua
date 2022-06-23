local H = 25;

local PN = (GAMESTATE:GetHumanPlayers())[1];

local N = Def.ActorFrame{
	
	Def.Quad{
		OnCommand=function(self) self:zoomy(H*8+20); self:zoomx(140); self:diffuse({0.3,0.3,0.3,0.5}); end;
		
	};
	
	
	LoadFont("Common Normal")..{
		Text = "Pure";
		OnCommand=function(self) self:x(-58); self:y(-3.5*H); self:horizalign(left); self:diffuse(JudgmentLineToColor("W1")); self:textglowmode("TextGlowMode_Stroke"); self:strokecolor({1,1,1,1}); end;
	};
	LoadFont("Common Normal")..{
		Text = "Per";
		OnCommand=function(self) self:x(-58); self:y(-2.5*H); self:horizalign(left); self:diffuse(JudgmentLineToColor("W2")); self:textglowmode("TextGlowMode_Stroke"); self:strokecolor({1,1,1,1}); end;
	};
	LoadFont("Common Normal")..{
		Text = "Gre";
		OnCommand=function(self) self:x(-58); self:y(-1.5*H); self:horizalign(left); self:diffuse(JudgmentLineToColor("W3")); self:textglowmode("TextGlowMode_Stroke"); self:strokecolor({1,1,1,1}); end;
	};
	LoadFont("Common Normal")..{
		Text = "Goo";
		OnCommand=function(self) self:x(-58); self:y(-0.5*H); self:horizalign(left); self:diffuse(JudgmentLineToColor("W4")); self:textglowmode("TextGlowMode_Stroke"); self:strokecolor({0,0,0,1}); end;
	};
	LoadFont("Common Normal")..{
		Text = "Bad";
		OnCommand=function(self) self:x(-58); self:y(0.5*H); self:horizalign(left); self:diffuse(JudgmentLineToColor("W5")); self:textglowmode("TextGlowMode_Stroke"); self:strokecolor({0,0,0,1}); end;
	};
	LoadFont("Common Normal")..{
		Text = "Mis";
		OnCommand=function(self) self:x(-58); self:y(1.5*H); self:horizalign(left); self:diffuse(JudgmentLineToColor("Miss")); self:textglowmode("TextGlowMode_Stroke"); self:strokecolor({0,0,0,1}); end;
	};
	LoadFont("Common Normal")..{
		Text = "OK";
		OnCommand=function(self) self:x(-58); self:y(2.5*H); self:horizalign(left); self:diffuse({1,1,1,1}); self:textglowmode("TextGlowMode_Stroke"); self:strokecolor(JudgmentLineToColor("Held")); end;
	};
	LoadFont("Common Normal")..{
		Text = "NG";
		OnCommand=function(self) self:x(-58); self:y(3.5*H); self:horizalign(left); self:diffuse({0,0,0,1}); self:textglowmode("TextGlowMode_Stroke"); self:strokecolor(JudgmentLineToColor("W5")); end;
	};
	
	
	LoadFont("Common Normal")..{
		Text = "0";
		OnCommand=function(self) self:x(58); self:y(-3.5*H); self:horizalign(right); self:diffuse(JudgmentLineToColor("W1")); end;
		JudgmentMessageCommand=function(self)
			self:settextf("%d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PN):
			GetTapNoteScores("TapNoteScore_W1"))
		end;
	};
	LoadFont("Common Normal")..{
		Text = "0";
		OnCommand=function(self) self:x(58); self:y(-2.5*H); self:horizalign(right); self:diffuse(JudgmentLineToColor("W2")); end;
		JudgmentMessageCommand=function(self)
			self:settextf("%d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PN):
			GetTapNoteScores("TapNoteScore_W2"))
		end;
	};
	LoadFont("Common Normal")..{
		Text = "0";
		OnCommand=function(self) self:x(58); self:y(-1.5*H); self:horizalign(right); self:diffuse(JudgmentLineToColor("W3")); end;
		JudgmentMessageCommand=function(self)
			self:settextf("%d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PN):
			GetTapNoteScores("TapNoteScore_W3"))
		end;
	};
	LoadFont("Common Normal")..{
		Text = "0";
		OnCommand=function(self) self:x(58); self:y(-0.5*H); self:horizalign(right); self:diffuse(JudgmentLineToColor("W4")); end;
		JudgmentMessageCommand=function(self)
			self:settextf("%d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PN):
			GetTapNoteScores("TapNoteScore_W4"))
		end;
	};
	
	LoadFont("Common Normal")..{
		Text = "0";
		OnCommand=function(self) self:x(58); self:y(0.5*H); self:horizalign(right); self:diffuse(JudgmentLineToColor("W5")); end;
		JudgmentMessageCommand=function(self)
			self:settextf("%d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PN):
			GetTapNoteScores("TapNoteScore_W5"))
		end;
	};
	
	LoadFont("Common Normal")..{
		Text = "0";
		OnCommand=function(self) self:x(58); self:y(1.5*H); self:horizalign(right); self:diffuse(JudgmentLineToColor("Miss")); end;
		JudgmentMessageCommand=function(self)
			self:settextf("%d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PN):
			GetTapNoteScores("TapNoteScore_Miss"))
		end;
	};
	
	LoadFont("Common Normal")..{
		Text = "0";
		OnCommand=function(self) self:x(58); self:y(2.5*H); self:horizalign(right); self:diffuse(JudgmentLineToColor("Held")); end;
		JudgmentMessageCommand=function(self)
			self:settextf("%d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PN):
			GetHoldNoteScores("HoldNoteScore_Held"))
		end;
	};
	
	LoadFont("Common Normal")..{
		Text = "0";
		OnCommand=function(self) self:x(58); self:y(3.5*H); self:horizalign(right); self:diffuse(JudgmentLineToColor("W5")); end;
		JudgmentMessageCommand=function(self)
			self:settextf("%d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PN):
			GetHoldNoteScores("HoldNoteScore_LetGo"))
		end;
	};
	
	
	
};


return N;

