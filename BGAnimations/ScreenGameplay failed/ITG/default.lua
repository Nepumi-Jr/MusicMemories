--Even in death, we still scale things. -Kid
local border_height_ratio = SCREEN_HEIGHT/480
local border_width_ratio = SCREEN_WIDTH/640

local failed = "failed (res 468x152).png";
local round = "round (res 470x146).png";

if math.random(1, 4) == 1 then
  failed = "railed (res 498x172).png";
  round = "found (res 500x166).png";
end

return Def.ActorFrame{
  Name= "xtl_actor_smb",
  --Moved some actors into main lua. -Kid
  --Scaled zooms and positions. -Kid
  Def.Quad{
    Name= "xtl_actor_dnb",
    InitCommand=function(self) self:FullScreen(); self:diffuse(color("#00000000")) end,
    OnCommand=function(self) self:linear(1):diffusealpha(1):sleep(1.4):linear(1):diffuse(color("#441122")) end,
  },
  Def.Sprite{
    Name= "xtl_actor_xmb",
    OnCommand= function(self)
      self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):zoom(3.2*border_height_ratio):rotationz(-30)
      :fadeleft(0.3):faderight(0.3):cropleft(1.3):cropright(-0.3):linear(1):cropleft(-0.3)
      :zoom(2.8*border_height_ratio):linear(2):zoom(2.0*border_height_ratio):linear(1)
      :cropright(1.3):zoom(1.6*border_height_ratio) end,
    Texture= "red streak (res 1024x128).png",
  },
  Def.Sprite{
    Name= "xtl_actor_ymb",--Added starting zoom, don't use SCREEN variables for x movement. -Kid
    OnCommand= function(self)
      self:zoom(border_height_ratio):rotationz(-30):x(SCREEN_CENTER_X-42*border_height_ratio)
      :y(SCREEN_CENTER_Y-32*border_height_ratio):addx(640*1.3*border_height_ratio):addy(-SCREEN_HEIGHT)
      :decelerate(0.5):addx(-640*1.3*border_height_ratio):addy(SCREEN_HEIGHT):sleep(2)
      :accelerate(0.5):addx(-640*1.3*border_height_ratio):addy(SCREEN_HEIGHT) end,
    Texture= "life (res 298x146).png",
  },
  Def.Sprite{
    Name= "xtl_actor_zmb",--Added starting zoom. -Kid
    OnCommand= function(self)
      self:zoom(border_height_ratio):rotationz(-30):x(SCREEN_CENTER_X+42*border_height_ratio)
      :y(SCREEN_CENTER_Y+32*border_height_ratio):addx(-640*1.3*border_height_ratio):addy(SCREEN_HEIGHT)
      :decelerate(0.5):addx(640*1.3*border_height_ratio):addy(-SCREEN_HEIGHT)
      :sleep(2):accelerate(0.5):addx(640*1.3*border_height_ratio):addy(-SCREEN_HEIGHT) end,
    Texture= "depleted (res 662x152).png",
  },
  Def.Sprite{
    Name= "xtl_actor_anb",
    OnCommand= function(self)
      self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):zoom(3.6*border_height_ratio):rotationz(-30)
      :fadeleft(0.3):faderight(0.3):cropleft(1.3):cropright(-0.3):sleep(2.5):linear(1)
      :cropleft(-0.3):zoom(3.2*border_height_ratio):linear(3):zoom(2.0*border_height_ratio)
      :linear(1):cropright(1.3):zoom(1.6*border_height_ratio) end,
    Texture= "blue streak (res 1024x128).png",
  },
  Def.Sprite{
    Name= "xtl_actor_bnb",--Added starting zoom. -Kid
    OnCommand= function(self)
      self:zoom(border_height_ratio):rotationz(-30):x(SCREEN_CENTER_X-90*border_height_ratio)
      :y(SCREEN_CENTER_Y):addx(640*1.3*border_height_ratio):addy(-SCREEN_HEIGHT)
      :sleep(2.5):decelerate(0.5):addx(-640*1.3*border_height_ratio):addy(SCREEN_HEIGHT)
      :sleep(3):accelerate(0.5):addx(-640*1.3*border_height_ratio):addy(SCREEN_HEIGHT) end,
    Texture= round,
  },
  Def.Sprite{
    Name= "xtl_actor_cnb",--Added starting zoom. -Kid
    OnCommand= function(self)
      self:zoom(border_height_ratio):rotationz(-30):x(SCREEN_CENTER_X+100*border_height_ratio)
      :y(SCREEN_CENTER_Y):addx(-640*1.3*border_height_ratio):addy(SCREEN_HEIGHT):sleep(2.5)
      :decelerate(0.5):addx(640*1.3*border_height_ratio):addy(-SCREEN_HEIGHT)
      :sleep(3):accelerate(0.5):addx(640*1.3*border_height_ratio):addy(-SCREEN_HEIGHT) end,
    Texture= failed,
  },
  
  LoadActor("ITG.mp3")..{
    Name= "Sound";
    StartTransitioningCommand= function(self) self:play() end,
  },
}
