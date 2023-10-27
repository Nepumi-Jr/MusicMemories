local t = Def.ActorFrame{
    Def.Quad{
        InitCommand=function(self)
            self:FullScreen()
        if STATSMAN:GetCurStageStats():AllFailed() then
            self:diffuse(color("#441122"));
            if LoadModule("Easter.today.lua")() == "HALLOWEEN" then
                self:diffuse(color("#000000"));
            end
        else
    
            local SA = false;
            for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
                if LoadModule("Eva.CustomStageAward.lua")(pn) ~= "Nope" then
                    SA = true;
                    break
                end
            end
            if SA then
                self:diffuse({0.7,0.7,0.7,1});
            else
                self:diffuse({0,0,0,1});
            end
    
        end
        
        end;
        OnCommand=function(self)
        self:linear(0.5);
        if STATSMAN:GetCurStageStats():AllFailed() then
            self:diffuse({0,0,0,1});
        else
            self:diffuse({1,1,1,1});
        end
        self:linear(3):diffuse({1,1,1,0})
        end;
    };
};
return t;