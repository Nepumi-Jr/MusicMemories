local scoreP1 = 6;
local scoreP2 = 9;

return Def.ActorFrame{
  Def.ActorFrame{
      InitCommand = function(self) self:y(5) end;
      Def.Quad{
          OnCommand = function(self) self:zoomx(10):zoomy(3):y(-3):diffuse(ModeIconColors.Rave) end
      };
      LoadFont("Combo Number")..{
          Text = scoreP1;
          OnCommand = function(self)
              self:zoom(0.3):horizalign(left):x(-70):diffuse(PlayerColor(PLAYER_1))
              if scoreP1 >= scoreP2 then
                  self:bounce():effectmagnitude(3,0,0):effecttiming(0.2,0.6,0.2,0):effectclock("beat")
              end
          end;
      };
      LoadFont("Combo Number")..{
          Text = scoreP2;
          OnCommand = function(self)
              self:zoom(0.3):horizalign(right):x(70):diffuse(PlayerColor(PLAYER_2))
              if scoreP1 <= scoreP2 then
                  self:bounce():effectmagnitude(-3,0,0):effecttiming(0.2,0.6,0.2,0):effectclock("beat")
              end
          end;
      };
  };
};