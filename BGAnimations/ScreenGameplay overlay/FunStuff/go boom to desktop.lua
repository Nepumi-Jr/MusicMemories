local jx,jy,cx,cy;

local t = Def.ActorFrame{};

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = LoadFont("Common Normal")..{
		Text = "GOT BOOMED!!";
		OnCommand = function(self)
			local field = SCREENMAN:GetTopScreen():GetChild(pn == PLAYER_1 and 'PlayerP1' or 'PlayerP2');
			self:xy(field:GetX(),field:GetY()):zoom(1.5):rotationz(-20):diffuse(color("#FF2222")):strokecolor(color("#000000"))
			self:bob():effectmagnitude(0,20,3):effectperiod(2):effectclock("beat"):visible(false)
		end;
		JudgmentMessageCommand=function(self,Isla)
			if Isla.TapNoteScore == "TapNoteScore_HitMine" and Isla.Player == pn then
				self:visible(true)
			end
		end;
	};
end

t[#t+1] = Def.Quad{
	OnCommand=function(self)
		self:FullScreen():diffusealpha(0)
	end;
	JudgmentMessageCommand=function(self,Isla)
		if Isla.TapNoteScore == "TapNoteScore_HitMine" then
			self:stoptweening():diffusealpha(1):decelerate(0.2):diffuse({1,0,0,0})
			SCREENMAN:GetTopScreen():SetNextScreenName("ScreenExit"):StartTransitioningScreen("SM_GoToNextScreen")
		end
	end;
};

return t;