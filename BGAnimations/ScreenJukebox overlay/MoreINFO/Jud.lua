local H = 25;

local PN = (GAMESTATE:GetHumanPlayers())[1];

local N = Def.ActorFrame{
	
	Def.Quad{
		OnCommand=cmd(zoomy,H*8+20;zoomx,140;diffuse,{0.3,0.3,0.3,0.5});
		
	};
	
	
	LoadFont("Common Normal")..{
		Text = "Pure";
		OnCommand=cmd(x,-58;y,-3.5*H;horizalign,left;diffuse,
		GameColor.Judgment["JudgmentLine_W1"];
		textglowmode,"TextGlowMode_Stroke";
		strokecolor,{1,1,1,1};
		);
	};
	LoadFont("Common Normal")..{
		Text = "Per";
		OnCommand=cmd(x,-58;y,-2.5*H;horizalign,left;diffuse,
		GameColor.Judgment["JudgmentLine_W2"];
		textglowmode,"TextGlowMode_Stroke";
		strokecolor,{1,1,1,1};
		);
	};
	LoadFont("Common Normal")..{
		Text = "Gre";
		OnCommand=cmd(x,-58;y,-1.5*H;horizalign,left;diffuse,
		GameColor.Judgment["JudgmentLine_W3"];
		textglowmode,"TextGlowMode_Stroke";
		strokecolor,{1,1,1,1};
		);
	};
	LoadFont("Common Normal")..{
		Text = "Goo";
		OnCommand=cmd(x,-58;y,-0.5*H;horizalign,left;diffuse,
		GameColor.Judgment["JudgmentLine_W4"];
		textglowmode,"TextGlowMode_Stroke";
		strokecolor,{0,0,0,1};
		);
	};
	LoadFont("Common Normal")..{
		Text = "Bad";
		OnCommand=cmd(x,-58;y,0.5*H;horizalign,left;diffuse,
		GameColor.Judgment["JudgmentLine_W5"];
		textglowmode,"TextGlowMode_Stroke";
		strokecolor,{0,0,0,1};
		);
	};
	LoadFont("Common Normal")..{
		Text = "Mis";
		OnCommand=cmd(x,-58;y,1.5*H;horizalign,left;diffuse,
		GameColor.Judgment["JudgmentLine_Miss"];
		textglowmode,"TextGlowMode_Stroke";
		strokecolor,{0,0,0,1};
		);
	};
	LoadFont("Common Normal")..{
		Text = "OK";
		OnCommand=cmd(x,-58;y,2.5*H;horizalign,left;diffuse,
		{1,1,1,1};
		textglowmode,"TextGlowMode_Stroke";
		strokecolor,GameColor.Judgment["JudgmentLine_Held"];
		);
	};
	LoadFont("Common Normal")..{
		Text = "NG";
		OnCommand=cmd(x,-58;y,3.5*H;horizalign,left;diffuse,
		{0,0,0,1};
		textglowmode,"TextGlowMode_Stroke";
		strokecolor,GameColor.Judgment["JudgmentLine_W5"];
		);
	};
	
	
	LoadFont("Common Normal")..{
		Text = "0";
		OnCommand=cmd(x,58;y,-3.5*H;horizalign,right;diffuse,
		GameColor.Judgment["JudgmentLine_W1"];
		);
		JudgmentMessageCommand=function(self)
			self:settextf("%d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PN):
			GetTapNoteScores("TapNoteScore_W1"))
		end;
	};
	LoadFont("Common Normal")..{
		Text = "0";
		OnCommand=cmd(x,58;y,-2.5*H;horizalign,right;diffuse,
		GameColor.Judgment["JudgmentLine_W2"];
		);
		JudgmentMessageCommand=function(self)
			self:settextf("%d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PN):
			GetTapNoteScores("TapNoteScore_W2"))
		end;
	};
	LoadFont("Common Normal")..{
		Text = "0";
		OnCommand=cmd(x,58;y,-1.5*H;horizalign,right;diffuse,
		GameColor.Judgment["JudgmentLine_W3"];
		);
		JudgmentMessageCommand=function(self)
			self:settextf("%d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PN):
			GetTapNoteScores("TapNoteScore_W3"))
		end;
	};
	LoadFont("Common Normal")..{
		Text = "0";
		OnCommand=cmd(x,58;y,-0.5*H;horizalign,right;diffuse,
		GameColor.Judgment["JudgmentLine_W4"];
		);
		JudgmentMessageCommand=function(self)
			self:settextf("%d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PN):
			GetTapNoteScores("TapNoteScore_W4"))
		end;
	};
	
	LoadFont("Common Normal")..{
		Text = "0";
		OnCommand=cmd(x,58;y,0.5*H;horizalign,right;diffuse,
		GameColor.Judgment["JudgmentLine_W5"];
		);
		JudgmentMessageCommand=function(self)
			self:settextf("%d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PN):
			GetTapNoteScores("TapNoteScore_W5"))
		end;
	};
	
	LoadFont("Common Normal")..{
		Text = "0";
		OnCommand=cmd(x,58;y,1.5*H;horizalign,right;diffuse,
		GameColor.Judgment["JudgmentLine_Miss"];
		);
		JudgmentMessageCommand=function(self)
			self:settextf("%d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PN):
			GetTapNoteScores("TapNoteScore_Miss"))
		end;
	};
	
	LoadFont("Common Normal")..{
		Text = "0";
		OnCommand=cmd(x,58;y,2.5*H;horizalign,right;diffuse,
		GameColor.Judgment["JudgmentLine_Held"];
		);
		JudgmentMessageCommand=function(self)
			self:settextf("%d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PN):
			GetHoldNoteScores("HoldNoteScore_Held"))
		end;
	};
	
	LoadFont("Common Normal")..{
		Text = "0";
		OnCommand=cmd(x,58;y,3.5*H;horizalign,right;diffuse,
		GameColor.Judgment["JudgmentLine_W5"];
		);
		JudgmentMessageCommand=function(self)
			self:settextf("%d",STATSMAN:GetCurStageStats():GetPlayerStageStats(PN):
			GetHoldNoteScores("HoldNoteScore_LetGo"))
		end;
	};
	
	
	
};


return N;

