

local Color_SA = {}
local TitleText = {}
local SubText = {}
local function Parti(am)
    local P = Def.ActorFrame{}

    for i = 1,math.random(am,am*1.3) do

        local ang = math.random(0,360)/180*math.pi
        local sp = math.random(60,120)
        SM("\n\n\n\n\n"..ang)
        P[#P+1] = LoadActor("Aura.png")..{
            InitCommand=function(self) self:x(64*2.1*(math.random(0,1)==1 and -1 or 1)); self:y(math.random(0,SCREEN_BOTTOM)-SCREEN_CENTER_Y); self:zoom(0.03); self:diffusealpha(0); end;
            FcStageMessageCommand=function(self) self:sleep(0.5); self:diffuse(Color_SA[PLAYER_1]); self:decelerate(1.5); self:addx(math.cos(ang)*sp); self:addy(math.sin(ang)*sp); self:diffusealpha(0); end;
        }
    end

    return P;


end






local t = Def.ActorFrame{
    InitCommand=function(self) self:Center(); end;
    OnCommand=function(self) self:sleep(2); self:queuecommand("FcStage"); end;
    FcStageMessageCommand=function(self)
        if true then--Stage
            
            Color_SA[PLAYER_1] = JudgmentLineToColor("W1")
            TitleText[PLAYER_1] = "FC"
            SubText[PLAYER_1] = "Almost all perfect but 1 great..."


        else
            self:visible(false)
        end
    end;

    Def.Quad{
        InitCommand=function(self) self:zoomx(64*5); self:zoomy(SCREEN_BOTTOM*1.2); self:fadeleft(0.1); self:faderight(0.1); self:croptop(1); self:diffuse({1,1,1,0.4}); end;
        FcStageMessageCommand=function(self) self:decelerate(0.4); self:croptop(0); self:sleep(0.1); self:decelerate(0.4); self:cropbottom(1); end;
    };
    Def.Quad{
        InitCommand=function(self) self:zoomx(64*5); self:zoomy(SCREEN_BOTTOM*1.2); self:fadeleft(0.1); self:faderight(0.1); self:croptop(1); self:diffusealpha(0.7); end;
        FcStageMessageCommand=function(self) self:diffuse(Color_SA[PLAYER_1]); self:sleep(0.5); self:decelerate(0.1); self:croptop(0); self:decelerate(0.4); self:zoomx(64*5.5); self:diffusealpha(0.4); self:fadeleft(0.12); self:faderight(0.12); self:sleep(0+2); self:decelerate(0.3); self:cropbottom(1); end;
    };
    LoadFont("Common Large")..{
        InitCommand=function(self) self:y(-150); self:diffusealpha(0); self:shadowlength(2); self:skewx(-0.2); end;
        FcStageMessageCommand=function(self) self:settext(TitleText[PLAYER_1]); self:diffuse(Color_SA[PLAYER_1]); self:diffusealpha(0); self:sleep(0.5); self:decelerate(0.2); self:y(-60); self:diffusealpha(1); self:sleep(0.3+2); self:decelerate(0.3); self:diffusealpha(0); end;
    };
    LoadFont("Common Normal")..{
        InitCommand=function(self) self:y(70); self:diffusealpha(0); self:shadowlength(1); end;
        FcStageMessageCommand=function(self) self:settext(SubText[PLAYER_1]); self:diffuse(Color_SA[PLAYER_1]); self:diffusealpha(0); self:sleep(0.5); self:decelerate(0.25); self:y(30); self:diffusealpha(1); self:sleep(0.25+2); self:decelerate(0.3); self:diffusealpha(0); end;
    };

    Parti(30);

};

return t;