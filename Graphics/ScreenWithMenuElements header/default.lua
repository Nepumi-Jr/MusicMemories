local t = Def.ActorFrame {};

local HEAD = Screen.String("HeaderText");
local wid;

t[#t+1] = Def.ActorFrame {
    InitCommand=function(self) self:y(5); end;

    LoadFont("Common Large")..{
		InitCommand=function(self)
            (function(self) self:settext(HEAD); self:horizalign(left); self:zoom(0.4); self:y(15); self:x(30-SCREEN_CENTER_X); self:skewx(-0.2); end)(self)
            wid = self:GetWidth()
            self:visible(false);
        end;
        
	};

    Def.Quad{
        InitCommand=function(self) self:visible(wid ~= 0); self:diffuse(GameColor.PlayerColors.PLAYER_2 or {0,0,1,1}); self:horizalign(left); self:vertalign(top); self:x(-SCREEN_CENTER_X); self:y(-2); self:zoomy(2); self:zoomx(wid*0.4 + 150); self:faderight(0.3); end;
    };
    Def.Quad{
        InitCommand=function(self) self:visible(wid ~= 0); self:diffuse(color("#333333")); self:horizalign(left); self:vertalign(top); self:x(-SCREEN_CENTER_X); self:zoomy(50); self:zoomx(wid*0.4 + 150); self:faderight(0.3); end;
    };
    Def.Quad{
        InitCommand=function(self) self:visible(wid ~= 0); self:diffuse(GameColor.PlayerColors.PLAYER_2 or {0,0,1,1}); self:horizalign(left); self:vertalign(top); self:x(-SCREEN_CENTER_X); self:y(50); self:zoomy(2); self:zoomx(wid*0.4 + 150); self:faderight(0.3); end;
    };
    

	LoadFont("Common Large")..{
		InitCommand=function(self) self:settext(HEAD); self:diffusebottomedge(color("#999999")); self:horizalign(left); self:zoom(0.4); self:y(15); self:x(30-SCREEN_CENTER_X); self:skewx(-0.2); end;
	};

	
};



return t
