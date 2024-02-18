local t = LoadActor("ScreenWithMenuElements decorations");

local players = GAMESTATE:GetHumanPlayers();

-- Judgment and combo with offset
for pn in ivalues(players) do
    local perfectCmd;
    t[#t+1] = Def.ActorFrame{
        OnCommand=function(self)
            self:y(SCREEN_CENTER_Y-40)
            self:zoom(0.75)
            if pn == PLAYER_1 then
                self:x(-200):decelerate(0.3):x(100)
            else
                self:x(SCREEN_RIGHT+200):decelerate(0.3):x(SCREEN_RIGHT-100)
            end
            
        end;
        LoadFont("Common Normal")..{
            Text="This is for preview only\nIt may not be accurate\nfor some effect\nE.g. reverse or mod chart.";
            OnCommand=function(self)
                self:zoom(0.7)
                self:y(-100)
                self:x(pn == PLAYER_1 and -120 or 120)
                self:horizalign(pn == PLAYER_1 and left or right)
                self:diffuseshift()
                self:effectcolor1(color("#FFFFFF"))
                self:effectcolor2(Color.Red)
            end;
        };

        Def.ActorFrame{
            OnCommand=function(self)
                self:y(-20)
            end;
            Def.ActorFrame{
                OnCommand=function(self)
                    local offset = LoadModule("PlayerOption.GetOffset.lua")(pn, "Judge")
                    self:x(offset.x)
                    self:y(offset.y)
                    self:zoom(offset.zoom)
                    self:diffusealpha(offset.alpha)
                end;
                offsetJudgeMessageCommand=function(self, params) --? offset goes here
                    if params.Player == pn then
                        if params.alpha then
                            local value = tonumber(string.match(params.alpha, '%d+')) / 100
                            self:diffusealpha(value)
                        end

                        if params.zoom then
                            local value = tonumber(string.match(params.zoom, '%d+')) / 100
                            self:zoom(value)
                        end
                        
                        if params.xyValue then
                            if params.xOry == "x" then
                                self:x(params.xyValue)
                            else
                                self:y(params.xyValue)
                            end
                        end
                    end
                end;
                Def.Sprite{
                    InitCommand=THEME:GetMetric("Judgment","JudgmentOnCommand");
                    OnCommand=function(self)
                        local jName = TP[ToEnumShortString(pn)].ActiveModifiers.JudgmentGraphic or "!!default!!"
                        local jPath = LoadModule("Options.JudgmentGetPath.lua")(jName)
                        self:pause():Load(jPath)
                        perfectCmd = LoadModule("Options.JudgmentAnimation.lua")(jName)["W1LateCommand"]
                        self:queuecommand("cycle");
                    end;
                    cycleCommand=function(self)
                        perfectCmd(self)
                        self:sleep(0.1):queuecommand("cycle");
                    end;
                };
            };
            Def.ActorFrame{
                OnCommand=function(self)
                    local offset = LoadModule("PlayerOption.GetOffset.lua")(pn, "SubJudge")
                    self:x(offset.x)
                    self:y(offset.y)
                    self:zoom(offset.zoom)
                    self:diffusealpha(offset.alpha)
                end;
                offsetSubJudgeMessageCommand=function(self, params) --? offset goes here
                    if params.Player == pn then
                        if params.alpha then
                            local value = tonumber(string.match(params.alpha, '%d+')) / 100
                            self:diffusealpha(value)
                        end

                        if params.zoom then
                            local value = tonumber(string.match(params.zoom, '%d+')) / 100
                            self:zoom(value)
                        end
                        
                        if params.xyValue then
                            if params.xOry == "x" then
                                self:x(params.xyValue)
                            else
                                self:y(params.xyValue)
                            end
                        end
                    end
                end;
                Def.Sprite{                
                    OnCommand=function(self)
                        self:pause();
                        local JudF = TP[ToEnumShortString(pn)].ActiveModifiers.JudgmentGraphic
                        local JudgeFastSlow = LoadModule("Judgement.GetFastSlowPath.lua")(JudF)
                        self:Load(JudgeFastSlow);
                    end;
                    InitCommand=function(self) self:zoom(0.5):xy(40, 40); end;
                };
            };
        };

        Def.ActorFrame{
            OnCommand=function(self)
                self:y(40)
            end;
            Def.ActorFrame{
                OnCommand=function(self)
                    local offset = LoadModule("PlayerOption.GetOffset.lua")(pn, "Combo")
                    self:x(offset.x)
                    self:y(offset.y)
                    self:zoom(offset.zoom)
                    self:diffusealpha(offset.alpha)
                end;
                offsetComboMessageCommand=function(self, params) --? offset goes here
                    if params.Player == pn then
                        if params.alpha then
                            local value = tonumber(string.match(params.alpha, '%d+')) / 100
                            self:diffusealpha(value)
                        end

                        if params.zoom then
                            local value = tonumber(string.match(params.zoom, '%d+')) / 100
                            self:zoom(value)
                        end
                        
                        if params.xyValue then
                            if params.xOry == "x" then
                                self:x(params.xyValue)
                            else
                                self:y(params.xyValue)
                            end
                        end
                    end
                end;
                LoadFont("Combo Number")..{
                    Text = math.random(10, 99);
                    OnCommand=THEME:GetMetric("Combo", "Numbertor12315OnCommand");
                };
                LoadFont("Isla/_chakra petch semibold overlay 72px")..{
                    InitCommand=function(self) self:diffuse(color("#000000")) end;
                    OnCommand=THEME:GetMetric("Combo", "Numbertor12315OnCommand");
                };
                LoadActor(THEME:GetPathG("","Memories_combo"))..{
                    OnCommand = THEME:GetMetric("Combo", "ComboLabelOnCommand");
                };
            };
        };
    };
end

return t;
