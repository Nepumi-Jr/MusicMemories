local t = Def.ActorFrame {};

local HEAD = Screen.String("HeaderText");
local wid;

t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(y,5);

    LoadFont("Common Large")..{
		InitCommand=function(self)
            (cmd(settext,HEAD;horizalign,left;zoom,0.4;y,15;x,30-SCREEN_CENTER_X;skewx,-0.2;))(self)
            wid = self:GetWidth()
            self:visible(false);
        end;
        
	};

    Def.Quad{
        InitCommand=cmd(visible,wid ~= 0;diffuse,GameColor.PlayerColors.PLAYER_2 or {0,0,1,1};horizalign,left;vertalign,top;x,-SCREEN_CENTER_X;y,-2;zoomy,2;zoomx,wid*0.4 + 150;faderight,0.3);
    };
    Def.Quad{
        InitCommand=cmd(visible,wid ~= 0;diffuse,color("#333333");horizalign,left;vertalign,top;x,-SCREEN_CENTER_X;zoomy,50;zoomx,wid*0.4 + 150;faderight,0.3);
    };
    Def.Quad{
        InitCommand=cmd(visible,wid ~= 0;diffuse,GameColor.PlayerColors.PLAYER_2 or {0,0,1,1};horizalign,left;vertalign,top;x,-SCREEN_CENTER_X;y,50;zoomy,2;zoomx,wid*0.4 + 150;faderight,0.3);
    };
    

	LoadFont("Common Large")..{
		InitCommand=cmd(settext,HEAD;diffusebottomedge,color("#999999");horizalign,left;zoom,0.4;y,15;x,30-SCREEN_CENTER_X;skewx,-0.2);
	};

	
};



return t
