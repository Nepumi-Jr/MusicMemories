

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
            InitCommand=cmd(x,64*2.1*(math.random(0,1)==1 and -1 or 1);y,math.random(0,SCREEN_BOTTOM)-SCREEN_CENTER_Y;zoom,0.03;diffusealpha,0);
            FcStageMessageCommand=cmd(sleep,0.5;diffuse,Color.White;decelerate,1.5;addx,math.cos(ang)*sp;addy,math.sin(ang)*sp;diffusealpha,0);
        }
    end

    return P;


end






local t = Def.ActorFrame{};

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
    t[#t+1] = Def.ActorFrame{
        InitCommand=cmd(Center);
        FcStageMessageCommand=function(self)
            if LoadModule("Eva.CustomStageAward.lua")(pn) ~= "Nope" then--Stage

                local SA = LoadModule("Eva.CustomStageAward.lua")(pn);

                self:x(SCREENMAN:GetTopScreen():GetChild(pn == PLAYER_1 and 'PlayerP1' or 'PlayerP2'):GetX())
                self:y(SCREENMAN:GetTopScreen():GetChild(pn == PLAYER_1 and 'PlayerP1' or 'PlayerP2'):GetY())
                
                if string.find( SA,"W1") then
                    Color_SA[pn] = GameColor.Judgment.JudgmentLine_W1
                    TitleText[pn] = "W1"
                elseif string.find( SA,"W2") then
                    Color_SA[pn] = GameColor.Judgment.JudgmentLine_W2
                    TitleText[pn] = "W2"
                elseif string.find( SA,"W3") then
                    Color_SA[pn] = GameColor.Judgment.JudgmentLine_W3
                    TitleText[pn] = "W3"
                elseif string.find( SA,"Choke") then
                    Color_SA[pn] = GameColor.Judgment.JudgmentLine_W4
                    TitleText[pn] = "W4"
                elseif string.find( SA,"NoMiss") then
                    Color_SA[pn] = GameColor.Judgment.JudgmentLine_W5
                    TitleText[pn] = "W5"
                end

                SubText[pn] = THEME:GetString("StageAward",ToEnumShortString(SA))
                YEP[pn] = true;         
                

                self:queuecommand("EXE");
                
            else
                self:visible(false)
            end
        end;
        EXECommand=cmd();
        Def.Quad{
            InitCommand=cmd(visible,false);
            EXECommand=cmd(playcommand,"MOD");
            MODCommand=function(self)
                if YEP[pn] then
                    GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Song'):Stealth(1,1,true):Dark(1,1,true):Blind(1,1,true)
                    self:sleep(0.1):queuecommand("MOD");
                end
            end;
        };
        Def.Quad{
            InitCommand=cmd(zoomx,cols*50+20;zoomy,SCREEN_BOTTOM*1.2;fadeleft,0.1;faderight,0.1;croptop,1;diffuse,{1,1,1,0.4};);
            EXECommand=cmd(decelerate,0.4;croptop,0;sleep,0.1;decelerate,0.4;cropbottom,1);
        };
        Def.Quad{
            InitCommand=cmd(zoomx,cols*50+20;zoomy,SCREEN_BOTTOM*1.2;fadeleft,0.1;faderight,0.1;croptop,1;diffusealpha,0.7);
            EXECommand=cmd(diffuse,Color_SA[pn];sleep,0.5;decelerate,0.1;croptop,0;decelerate,0.4;zoomx,64*5.5;diffusealpha,0.4;fadeleft,0.12;faderight,0.12;);
        };
        Def.Sprite{
            InitCommand=cmd(y,-150;diffusealpha,0;zoom,0.25);
            EXECommand=cmd(Load,path.."FC"..TitleText[pn]..".png";diffusealpha,0;sleep,0.5;decelerate,0.2;y,-60;diffusealpha,1);
        };
        LoadFont("Common Normal")..{
            InitCommand=cmd(y,70;diffusealpha,0;shadowlength,1;);
            EXECommand=cmd(settext,SubText[pn];diffuse,Color_SA[pn];diffusealpha,0;sleep,0.5;decelerate,0.25;y,30;diffusealpha,1);
        };
    
        Def.ActorFrame{
            EXECommand=cmd(diffuse,Color_SA[pn]);
            Parti(30);
        };
        
    
    };
end

return t;