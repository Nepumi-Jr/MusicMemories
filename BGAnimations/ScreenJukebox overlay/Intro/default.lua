local RDText = "1st STAGE";
local RDtime;

local function BtS(x){
	return GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(x) or 0;
}


local t=Def.ActorFrame{
	LoadFont("Common Large")..{
		OnCommand=cmd(Center;y,50;rainbow;settext,"TEST";zoom,0.4);
	};
	Def.Quad{
		OnCommand=function(self)
			--CMD
			RDtime = round(round(GAMESTATE:GetCurrentSong():GetFirstBeat())/4)*4;
		end;
	};
};




for i = 1,string.len( RDText ) do
	t[#t+1]=Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X+(i-((string.len( RDText )+1)/2))*40;CenterY;zoom,0.85);
		OnCommand=cmd(sleep,5;ease,1.2+0.3,80;x,SCREEN_CENTER_X+(i-((string.len( RDText )+1)/2))*60;zoom,0.65);
		LoadFont("Common Large")..{
			InitCommand=cmd(rainbow;settext,string.sub( RDText, i, i ));
			OnCommand=cmd(diffusealpha,0;sleep,5;linear,0.7;diffusealpha,1;sleep,1.2-0.7;linear,0.3;zoomx,0);
		};
	};
end


return t;