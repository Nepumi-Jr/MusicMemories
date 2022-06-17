local t = Def.ActorFrame{
    LoadActor("MEMEDirected (loop)")..{
        StartTransitioningCommand=function(self) self:play(); end;
    };
    Def.Quad{
        OnCommand=function(self) self:zoom(99999); self:diffuse(color("#000000FF")); end;
    };
    LoadFont("Common Normal")..{
        InitCommand=function(self) self:diffusealpha(0); self:Center(); self:zoom(1.2); end;
        OnCommand=function(self)
            
    
            self:sleep(1.234)
            self:diffusealpha(1)
            self:settext("Directed by\nROBERT B.WEIDE")
            self:sleep(4.526-1.234)
            self:queuecommand("Ex")
        end;
        ExCommand=function(self) self:settext("Executive Producer\nLARRY DAVID"); self:sleep(7.794-4.526); self:queuecommand("me"); end;
        meCommand=function(self)
            local lt = "Failed Player\n";
            for player in ivalues(GAMESTATE:GetHumanPlayers()) do
                lt=lt..string.upper( getPlayerName(player) ).." ";
            end
            self:settext(lt)
        end
    };
    
};



return t;