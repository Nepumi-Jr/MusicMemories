local item_width = THEME:GetMetric("OptionRow","ItemsStartX") + scale( SCREEN_WIDTH, 960, 1280, SCREEN_RIGHT-300 + 30, SCREEN_RIGHT-20 + 30)
return Def.ActorFrame{
    Def.Quad{
        OnCommand=cmd(x,223;zoomto,item_width,35;diffuse,{0,0,0,0.6}; fadeleft,0.2;faderight,0.2;);
    };
    Def.Sprite{
        OnCommand=function(self)
            (cmd(x,223;diffuse,{1,1,1,0}; fadeleft,0.1;faderight,0.1;))(self)
            local isFocus = self:GetParent():GetParent():GetParent():HasFocus( GAMESTATE:GetMasterPlayerNumber() )
            if isFocus then
                self:playcommand("GainFocus")
            end
        end;
        --cmd(x,223;y,-34.5/2;zoomto,0, 0;diffuse,{1,1,1,1}; fadeleft,0.1;faderight,0.1;);
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
        LoseFocusCommand=cmd(stoptweening;decelerate,0.2;diffusealpha,0);
    };
    Def.Quad{
        OnCommand=function(self)
            (cmd(x,223;y,-34.5/2;zoomto,0, 0;diffuse,{1,1,1,1}; fadeleft,0.1;faderight,0.1;))(self)
            local isFocus = self:GetParent():GetParent():GetParent():HasFocus( GAMESTATE:GetMasterPlayerNumber() )
            if isFocus then
                self:playcommand("GainFocus")
            end
        end;
        --cmd(x,223;y,-34.5/2;zoomto,0, 0;diffuse,{1,1,1,1}; fadeleft,0.1;faderight,0.1;);
        GainFocusCommand=cmd(stoptweening;decelerate,0.2;zoomto,item_width, 2);
        LoseFocusCommand=cmd(stoptweening;decelerate,0.2;zoomto,0 ,0);
    };
    Def.Quad{
        OnCommand=function(self)
            (cmd(x,223;y,34.5/2;zoomto,0, 0;diffuse,{1,1,1,1}; fadeleft,0.1;faderight,0.1;))(self)
            local isFocus = self:GetParent():GetParent():GetParent():HasFocus( GAMESTATE:GetMasterPlayerNumber() )
            if isFocus then
                self:playcommand("GainFocus")
            end
        end;
        GainFocusCommand=cmd(stoptweening;decelerate,0.2;zoomto,item_width, 2);
        LoseFocusCommand=cmd(stoptweening;decelerate,0.2;zoomto,0, 0);
    };
};