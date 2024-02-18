local jx,jy,cx,cy;
local BOOM = {};
local initY = {};
local mxUpper = {};
local song;

local t = Def.ActorFrame{};

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = Def.ActorFrame{
		OnCommand=function(self)
            song = GAMESTATE:GetCurrentSong();
			local childPlayer = pn == PLAYER_1 and SCREENMAN:GetTopScreen():GetChild('PlayerP1') or SCREENMAN:GetTopScreen():GetChild('PlayerP2');
			BOOM[pn] = 0;
			GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Song'):Hidden(1,3);
			GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Song'):HiddenOffset(-0.5,20);
			initY[pn] = childPlayer:GetY();
            mxUpper[pn] = 40 + math.random(-10, 10) + math.min(song:GetLastSecond(), 300) / 300 * 30;
            printf("songs : %s...", tostring(song));
			self:xy(childPlayer:GetX(),initY[pn] - 100);
		end;
			
		JudgmentMessageCommand=function(self,Isla)
            --check with player with pn
            if Isla.Player ~= pn then
                return;
            end
            if Isla.TapNoteScore == "TapNoteScore_HitMine" then
                BOOM[pn] = BOOM[pn] + 1
            end
            local stat = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
            local acc = math.min(stat:GetActualDancePoints()/stat:GetCurrentPossibleDancePoints(),1)
            local upperBound = math.min(scale(GAMESTATE:GetCurMusicSeconds(), 0, song:GetLastSecond(), 0, mxUpper[pn]) + BOOM[pn] * 3, 100);
            local lowerBound = math.min(upperBound + 40, 100);
            local thisPercent = scale(acc, 0, 1, lowerBound, upperBound);

			GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Song'):HiddenOffset(scale(thisPercent, 0, 100, -0.5, 1.3),20);
			self:stoptweening():decelerate(0.3):y(initY[pn] + scale(thisPercent, 0, 100,-100,200));
		end;
		Def.Quad{
			OnCommand=function(self)
				self:zoomx(GAMESTATE:GetCurrentStyle():ColumnsPerPlayer() * 64);
				self:zoomy(3);
				self:bounce():effectmagnitude(0,-1.5,0):effecttiming(0.2,0.6,0.2,0):effectclock("beat");
				self:diffuse(Color.Green);
			end;
		};
		Def.Quad{
			OnCommand=function(self)
				self:zoomx(GAMESTATE:GetCurrentStyle():ColumnsPerPlayer() * 64);
				self:zoomy(3);
				self:bounce():effectmagnitude(0,1.5,0):effecttiming(0.2,0.6,0.2,0):effectclock("beat");
				self:diffuse(Color.Green);
			end;
		};
		LoadFont("Common Normal")..{
			Text = "Hidden\nLine";
			InitCommand=function(self)
				self:x(-GAMESTATE:GetCurrentStyle():ColumnsPerPlayer() * 64 / 2 - 20)
				self:zoom(0.5);
				self:diffuse(Color.Green);
				self:strokecolor(Color.Black);
				self:shadowlength(1);
				self:diffusealpha(0.5);
			end;
		};
	};
end


return t;
