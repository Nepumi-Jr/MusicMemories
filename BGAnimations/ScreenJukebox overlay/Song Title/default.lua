local Bpms = {};
function Bpm2Cl(Bpm)
local R,G,B;
local Disgo = false;
		if Bpm <= 100 then
		R = 0;
		G = 0;
		B = Bpm/100;
		elseif Bpm > 100 and Bpm <= 150 then
		R = 0;
		G = (Bpm-100)*2/100;
		B = 1;
		elseif Bpm > 150 and Bpm <= 200 then
		R = 0;
		G = 1;
		B = 1-((Bpm-150)*2/100);
		elseif Bpm > 200 and Bpm <= 300 then
		R = (Bpm-200)/100;
		G = 1-((Bpm-200)/100);
		B = 0;
		elseif Bpm > 300 and Bpm <= 400 then
		R = 1;
		G = 0;
		B = 0;
		elseif Bpm > 400 and Bpm <= 450 then
		R = 1-((Bpm-400)/100);
		G = 0;
		B = 0;
		elseif Bpm > 450 and Bpm < 600 then
		R = 0.5;
		B = 0;
		G = 0;
		else
		if math.mod(GAMESTATE:GetSongBeat(),1)< 0.5 and not Disgo then
		Disgo = true;
		R = math.random(1,10)/10;
		G = math.random(1,10)/10;
		B = math.random(1,10)/10;
		else
		Disgo = false;
		end
		end
		return color(R..","..G..","..B..",1")
end;
function Xbarrr(S)
local Re=0;
for i = 1,#S do
	Re = Re+S[i]
end
	return Re/#S
end;
local t = Def.ActorFrame{
LoadFont("_rockwell 20px")..{
				InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-30;zoom,0.3*(72/20));
		OnCommand=function(self)
			self:queuecommand("NepuSong");
		end;
		CurrentSongChangedMessageCommand=cmd(queuecommand,"NepuSong");
				
				NepuSongCommand=function(self)
				self:settext(GAMESTATE:GetCurrentSong():GetDisplayMainTitle())
				end;
};
LoadFont("_rockwell 20px")..{
				InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-15;zoom,0.15*(72/20));
		OnCommand=function(self)
if GAMESTATE:IsCourseMode() then
			self:queuecommand("NepuC");
end
		end;
				CurrentSongChangedMessageCommand=function(self)
if GAMESTATE:IsCourseMode() then
			self:queuecommand("NepuC");
end
		end;
				NepuCCommand=function(self)
				self:settext(GAMESTATE:GetCurrentCourse():GetDisplayFullTitle())
				self:diffuse({1,1,1,1})
				end;
};
};
return t;