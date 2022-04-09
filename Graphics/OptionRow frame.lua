local item_width = THEME:GetMetric("OptionRow","ItemsStartX") + scale( SCREEN_WIDTH, 960, 1280, SCREEN_RIGHT-300 + 30, SCREEN_RIGHT-20 + 30)
return Def.ActorFrame{
    Def.Quad{
        OnCommand=function(self) self:x(223); self:zoomto(item_width,35); self:diffuse({0,0,0,0.6}); self:fadeleft(0.2); self:faderight(0.2); end;
    };
    Def.Sprite{
        OnCommand=function(self)
            (function(self) self:x(223); self:diffuse({1,1,1,0}); self:fadeleft(0.1); self:faderight(0.1); end)(self)
            local isFocus = self:GetParent():GetParent():GetParent():HasFocus( GAMESTATE:GetMasterPlayerNumber() )
            if isFocus then
                self:playcommand("GainFocus")
            end
        end;
        --function(self) self:x(223); self:y(-34.5/2); self:zoomto(0, 0); self:diffuse({1,1,1,1}); self:fadeleft(0.1); self:faderight(0.1); end;
        GainFocusCommand=function(self)
            self:Load(THEME:GetPathG("OptionRow","FG"))
            

            if self:GetParent():GetParent():GetParent():HasFocus( PLAYER_1 ) then
                self:diffuseleftedge(PlayerColor(PLAYER_1))
            else
                self:diffuseleftedge({1,1,1,0})
            end
            
            if self:GetParent():GetParent():GetParent():HasFocus( PLAYER_2 ) then
                self:diffuserightedge(PlayerColor(PLAYER_2))
            else
                self:diffuserightedge({1,1,1,0})
            end
            self:stoptweening():decelerate(0.2):diffusealpha(0.7)
        end;
        LoseFocusCommand=function(self) self:stoptweening(); self:decelerate(0.2); self:diffusealpha(0); end;
    };
    Def.Quad{
        OnCommand=function(self)
            (function(self) self:x(223); self:y(-34.5/2); self:zoomto(0, 0); self:diffuse({1,1,1,1}); self:fadeleft(0.1); self:faderight(0.1); end)(self)
            local isFocus = self:GetParent():GetParent():GetParent():HasFocus( GAMESTATE:GetMasterPlayerNumber() )
            if isFocus then
                self:playcommand("GainFocus")
            end
        end;
        --function(self) self:x(223); self:y(-34.5/2); self:zoomto(0, 0); self:diffuse({1,1,1,1}); self:fadeleft(0.1); self:faderight(0.1); end;
        GainFocusCommand=function(self) self:stoptweening(); self:decelerate(0.2); self:zoomto(item_width, 2); end;
        LoseFocusCommand=function(self) self:stoptweening(); self:decelerate(0.2); self:zoomto(0 ,0); end;
    };
    Def.Quad{
        OnCommand=function(self)
            (function(self) self:x(223); self:y(34.5/2); self:zoomto(0, 0); self:diffuse({1,1,1,1}); self:fadeleft(0.1); self:faderight(0.1); end)(self)
            local isFocus = self:GetParent():GetParent():GetParent():HasFocus( GAMESTATE:GetMasterPlayerNumber() )
            if isFocus then
                self:playcommand("GainFocus")
            end
        end;
        GainFocusCommand=function(self) self:stoptweening(); self:decelerate(0.2); self:zoomto(item_width, 2); end;
        LoseFocusCommand=function(self) self:stoptweening(); self:decelerate(0.2); self:zoomto(0, 0); end;
    };
};