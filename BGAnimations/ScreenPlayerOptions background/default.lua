local num_players = GAMESTATE:GetHumanPlayers();
local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame {
	Def.Sprite {
		Condition=not GAMESTATE:IsCourseMode();
		InitCommand=function(self) self:Center(); end;
		OnCommand=function(self)
			if GAMESTATE:GetCurrentSong() then
				local song = GAMESTATE:GetCurrentSong();
				if song:HasBackground() then
					self:LoadBackground(song:GetBackgroundPath());
				end;
				self:scale_or_crop_background();
				(function(self) self:fadebottom(0.25); self:fadetop(0.25); self:croptop(48/480); self:cropbottom(48/480); end)(self);
			else
				self:visible(false);
			end
		end;
	};
	Def.Quad {
		InitCommand=function(self) self:Center(); self:scaletoclipped(SCREEN_WIDTH+1,SCREEN_HEIGHT); end;
		OnCommand=function(self)
			self:diffuse(Alpha(color("#CCCCCC"),0.45)):diffusealpha(0.45)
			if #num_players==2 then
				self:diffuseleftedge(Alpha(Color[TP[ToEnumShortString(num_players[1])].ActiveModifiers.ComboColorstring or "Red"],0.45))
				self:diffusebottomedge(Alpha(Color[TP[ToEnumShortString(num_players[1])].ActiveModifiers.ComboColorstring or "Red"],0.45))
				self:playcommand("ColorComChanged",{Player=num_players[2],Jud=TP[ToEnumShortString(num_players[2])].ActiveModifiers.ComboColorstring or "Blue"})
			else
				self:playcommand("ColorComChanged",{Player=num_players[1],Jud=TP[ToEnumShortString(num_players[1])].ActiveModifiers.ComboColorstring or "Blue"})
			end
		end;
		ColorComChangedMessageCommand=function(self,param)
				self:stoptweening():decelerate(0.2)
				if #num_players==2 then
					if param.Player == num_players[1] then
					
						self:diffuseleftedge(Alpha(Color[param.Jud],0.45))
						self:diffusebottomedge(Alpha(Color[param.Jud],0.45))
					else
						self:diffuserightedge(Alpha(Color[param.Jud],0.45))
						self:diffusetopedge(Alpha(Color[param.Jud],0.45))
					end
				else
					self:diffuse(Alpha(Color[param.Jud],0.45))
				end
		end;
		
	};
};



return t
