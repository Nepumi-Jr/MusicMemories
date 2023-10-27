
local nBar = math.ceil(SCREEN_WIDTH/32);
local t = Def.ActorFrame{
    LoadActor("failed.ogg")..{
        StartTransitioningCommand=function(self) self:play(); end;
    };
};
for i=1,nBar do
    t[#t+1] = Def.ActorFrame{
        Def.Quad{
            OnCommand=function(self)
                self:vertalign(bottom):y(32 * i):zoomy(32):diffuse(color("#000000"));
                self:sleep(0.07*(i - 1))
                if math.mod(i,2) == 1 then
                    self:horizalign(left):x(0)
                    self:zoomx(-128):linear(1.2):zoomx(SCREEN_WIDTH+128);
                else
                    self:horizalign(right):x(SCREEN_WIDTH)
                    self:zoomx(-128):linear(1.2):zoomx(SCREEN_WIDTH+128);
                end;
            end;
        };
        Def.Quad{
            OnCommand=function(self)
                self:vertalign(bottom):y(32 * i):zoomy(32):diffuse(color("#441122"));
                self:sleep(0.07*(i))
                if math.mod(i,2) == 1 then
                    self:horizalign(left):x(0):faderight(1)
                    self:zoomx(-128):linear(1.2):zoomx(SCREEN_WIDTH+128):faderight(0);
                else
                    self:horizalign(right):x(SCREEN_WIDTH):fadeleft(1)
                    self:zoomx(-128):linear(1.2):zoomx(SCREEN_WIDTH+128):fadeleft(0);
                end;
            end;
        };
        LoadActor(math.mod(i,2) == 1 and "LeftToRight.png" or "RightToLeft.png")..{
            OnCommand=function(self)
                self:vertalign(bottom):y(32 * i);
                if math.mod(i,2) == 1 then
                    self:x(-128)
                    self:sleep(0.07*(i - 1)):linear(1.2):x(SCREEN_WIDTH+128);
                else
                    self:x(SCREEN_WIDTH+128)
                    self:sleep(0.07*(i - 1)):linear(1.2):x(-128);
                end;
            end;
        };
    };
end;

for i=1,4 do
    t[#t+1] = LoadActor("failed.png")..{
        OnCommand=function(self)
            self:Center():diffusealpha(0):zoom(4):sleep(0.4)
            self:sleep(0.1 * i):decelerate(0.6):diffusealpha(0.4):zoom(0.6):accelerate(0.4):zoom(1):decelerate(0.2):zoom(1.1):linear(0.1):zoom(1.0):sleep(2):linear(0.5):diffusealpha(0)
        end;
    };
end;

return t;