local t = Def.ActorFrame {};
			t[#t+1] = Def.Sprite{
				Texture="_arrow/Red 4x4.png";
				Frame0000=8;
				Delay0000=1/16;
				Frame0001=9;
				Delay0001=1/16;
				Frame0002=10;
				Delay0002=1/16;
				Frame0003=11;
				Delay0003=1/16;
				Frame0004=12;
				Delay0004=1/16;
				Frame0005=13;
				Delay0005=1/16;
				Frame0006=14;
				Delay0006=1/16;
				Frame0007=15;
				Delay0007=1/16;
				Frame0008=0;
				Delay0008=1/16;
				Frame0009=1;
				Delay0009=1/16;
				Frame0010=2;
				Delay0010=1/16;
				Frame0011=3;
				Delay0011=1/16;
				Frame0012=4;
				Delay0012=1/16;
				Frame0013=5;
				Delay0013=1/16;
				Frame0014=6;
				Delay0014=1/16;
				Frame0015=7;
				Delay0015=1/16;
				InitCommand=function(self) self:effectclock('beat'); self:wag(); self:zoom(0.75); end;
				OnCommand=function(self)
				if GAMESTATE:GetCurrentGame():GetName() == 'dance' then
					self:visible(true);
					else
					self:visible(false);
				end
				end;
			};
	--Text=GAMESTATE:GetCurrentGame():GetName();

return t