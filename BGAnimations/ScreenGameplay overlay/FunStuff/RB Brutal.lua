local jx,jy,cx,cy;
local BRU = {};
local initY = {};

local t = Def.ActorFrame{};

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = Def.ActorFrame{
		OnCommand=function(self)
			local childPlayer = pn == PLAYER_1 and SCREENMAN:GetTopScreen():GetChild('PlayerP1') or SCREENMAN:GetTopScreen():GetChild('PlayerP2');
			BRU[pn] = -0.5;
			GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Song'):Hidden(1,3);
			GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Song'):HiddenOffset(BRU[pn],20);
			initY[pn] = childPlayer:GetY();
			self:xy(childPlayer:GetX(),initY[pn] + scale(BRU[pn],-0.5,1.3,-100,200));
		end;
			
		JudgmentMessageCommand=function(self,Isla)
			
			if Isla.TapNoteScore == "TapNoteScore_HitMine" then
				BRU[pn] = -0.5
			elseif Isla.TapNoteScore == "TapNoteScore_Miss" then
				BRU[pn] = math.max(BRU[pn] - 0.15,-0.5);
			elseif Isla.TapNoteScore == "TapNoteScore_W5" then
				BRU[pn] = math.max(BRU[pn] - 0.1,-0.5);
			elseif Isla.TapNoteScore == "TapNoteScore_W4" then
				BRU[pn] = math.max(BRU[pn] - 0.08,-0.5);
			elseif Isla.TapNoteScore == "TapNoteScore_W3" then
				BRU[pn] = math.min(BRU[pn] + 0.01,1.3);
			elseif Isla.TapNoteScore == "TapNoteScore_W2" then
				BRU[pn] = math.min(BRU[pn] + 0.02,1.3);
			elseif Isla.TapNoteScore == "TapNoteScore_W1" then
				BRU[pn] = math.min(BRU[pn] + 0.03,1.3);
			elseif Isla.TapNoteScore == "TapNoteScore_CheckpointHit" then
				BRU[pn] = math.min(BRU[pn] + 0.001,1.3);
			elseif Isla.TapNoteScore == "TapNoteScore_CheckpointMiss" then
				BRU[pn] = math.max(BRU[pn] - 0.15,-0.5);
			end
			GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Song'):HiddenOffset(BRU[pn],20);
			self:stoptweening():decelerate(0.3):y(initY[pn] + scale(BRU[pn],-0.5,1.3,-100,200));
		end;
		Def.Quad{
			OnCommand=function(self)
				self:zoomx(GAMESTATE:GetCurrentStyle():ColumnsPerPlayer() * 64);
				self:zoomy(3);
				self:bounce():effectmagnitude(0,-1.5,0):effecttiming(0.2,0.6,0.2,0):effectclock("beat");
				self:diffuse(Color.SkyBlue);
			end;
		};
		Def.Quad{
			OnCommand=function(self)
				self:zoomx(GAMESTATE:GetCurrentStyle():ColumnsPerPlayer() * 64);
				self:zoomy(3);
				self:bounce():effectmagnitude(0,1.5,0):effecttiming(0.2,0.6,0.2,0):effectclock("beat");
				self:diffuse(Color.SkyBlue);
			end;
		};
		LoadFont("Common Normal")..{
			Text = "Hidden\nLine";
			InitCommand=function(self)
				self:x(-GAMESTATE:GetCurrentStyle():ColumnsPerPlayer() * 64 / 2 - 20)
				self:zoom(0.5);
				self:diffuse(Color.SkyBlue);
				self:strokecolor(Color.Black);
				self:shadowlength(1);
				self:diffusealpha(0.5);
			end;
		};
	};
end


return t;
