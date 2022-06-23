

local path = THEME:GetCurrentThemeDirectory().."BGAnimations/ScreenGameplay decorations/Stageaward/";

local Color_SA = {}
local TitleText = {}
local SubText = {}
local YEP = {}

local style = GAMESTATE:GetCurrentStyle()
local cols = style:ColumnsPerPlayer()

local function Parti(am)
    local P = Def.ActorFrame{}

    for i = 1,math.random(am,am*1.3) do

        local ang = math.random(0,360)/180*math.pi
        local sp = math.random(60,120)
        P[#P+1] = LoadActor("Aura.png")..{
            InitCommand=function(self) self:x(64*2.1*(math.random(0,1)==1 and -1 or 1)); self:y(math.random(0,SCREEN_BOTTOM)-SCREEN_CENTER_Y); self:zoom(0.03); self:diffusealpha(0); end;
            FcStageMessageCommand=function(self) self:sleep(0.5); self:diffuse(Color.White); self:decelerate(1.5); self:addx(math.cos(ang)*sp); self:addy(math.sin(ang)*sp); self:diffusealpha(0); end;
        }
    end

    return P;


end






local t = Def.ActorFrame{};

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
    t[#t+1] = Def.ActorFrame{
        InitCommand=function(self) self:Center(); end;
        FcStageMessageCommand=function(self)
            if LoadModule("Eva.CustomStageAward.lua")(pn) ~= "Nope" then--Stage

                local SA = LoadModule("Eva.CustomStageAward.lua")(pn);

                self:x(SCREENMAN:GetTopScreen():GetChild(pn == PLAYER_1 and 'PlayerP1' or 'PlayerP2'):GetX())
                self:y(SCREENMAN:GetTopScreen():GetChild(pn == PLAYER_1 and 'PlayerP1' or 'PlayerP2'):GetY())
                
                if string.find( SA,"W1") then
                    Color_SA[pn] = JudgmentLineToColor("W1")
                    TitleText[pn] = "W1"
                elseif string.find( SA,"W2") then
                    Color_SA[pn] = JudgmentLineToColor("W2")
                    TitleText[pn] = "W2"
                elseif string.find( SA,"W3") then
                    Color_SA[pn] = JudgmentLineToColor("W3")
                    TitleText[pn] = "W3"
                elseif string.find( SA,"Choke") then
                    Color_SA[pn] = JudgmentLineToColor("W4")
                    TitleText[pn] = "W4"
                elseif string.find( SA,"NoMiss") then
                    Color_SA[pn] = JudgmentLineToColor("W5")
                    TitleText[pn] = "W5"
                end

                SubText[pn] = THEME:GetString("StageAward",ToEnumShortString(SA))
                YEP[pn] = true;         
                

                self:queuecommand("EXE");
                
            else
                self:visible(false)
            end
        end;
        EXECommand=function(self) end;
        Def.Quad{
            InitCommand=function(self) self:visible(false); end;
            EXECommand=function(self) self:playcommand("MOD"); end;
            MODCommand=function(self)
                if YEP[pn] then
                    GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Song'):Blind(1,1,true)
                    self:sleep(0.1):queuecommand("MOD");
                end
            end;
        };
        Def.Quad{
            InitCommand=function(self) self:zoomx(cols*50+20); self:zoomy(SCREEN_BOTTOM*2.5); self:fadeleft(0.1); self:faderight(0.1); self:croptop(1); self:diffuse({1,1,1,0.4}); end;
            EXECommand=function(self) self:decelerate(0.4); self:croptop(0); self:sleep(0.1); self:decelerate(0.4); self:cropbottom(1); end;
        };
        Def.Quad{
            InitCommand=function(self) self:zoomx(cols*50+20); self:zoomy(SCREEN_BOTTOM*2.5); self:fadeleft(0.1); self:faderight(0.1); self:croptop(1); self:diffusealpha(0.7); end;
            EXECommand=function(self) self:diffuse(Color_SA[pn]); self:sleep(0.5); self:decelerate(0.1); self:croptop(0); self:decelerate(0.4); self:zoomx(64*5.5); self:diffusealpha(0.4); self:fadeleft(0.12); self:faderight(0.12); end;
        };
        Def.Sprite{
            InitCommand=function(self) self:y(-150); self:diffusealpha(0); self:zoom(0.25); end;
            EXECommand=function(self) self:Load(path.."FC"..TitleText[pn]..".png"); self:diffusealpha(0); self:sleep(0.5); self:decelerate(0.2); self:y(-60); self:diffusealpha(1); end;
        };
        LoadFont("Common Normal")..{
            InitCommand=function(self) self:y(70); self:diffusealpha(0); self:shadowlength(1); end;
            EXECommand=function(self) self:settext(SubText[pn]); self:diffuse(Color_SA[pn]); self:diffusealpha(0); self:sleep(0.5); self:decelerate(0.25); self:y(30); self:diffusealpha(1); end;
        };
    
        Def.ActorFrame{
            EXECommand=function(self) self:diffuse(Color_SA[pn]); end;
            Parti(30);
        };
        
    
    };
end

return t;