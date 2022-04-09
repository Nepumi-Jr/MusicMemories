
local function CreditsText( pn )
	local text = Def.ActorFrame{
		InitCommand=function(self)
			self:name("Credits" .. PlayerNumberToString(pn))
		end;
		UpdateVisibleCommand=function(self)
				local screen = SCREENMAN:GetTopScreen();
				local bShow = true;
				if screen then
					local sClass = screen:GetName();
					bShow = THEME:GetMetric( sClass, "ShowCreditDisplay" );
				end

				self:visible( bShow );
			end;
		UpdateTextCommand=function(self)
			local str = ScreenSystemLayerHelpers.GetCreditsMessage(pn);
		end;
		LoadActor("Test_Isla.png")..{
			InitCommand=function(self)
				self:name("Credits_Icon" .. PlayerNumberToString(pn))
				self:maxwidth(50);
				if pn == PLAYER_1 then
					self:horizalign(left):vertalign(bottom)
					self:x(SCREEN_LEFT):y(SCREEN_BOTTOM);
				else
					self:horizalign(right):vertalign(bottom)
					self:x(SCREEN_RIGHT):y(SCREEN_BOTTOM);
				end
			end;
			UpdateTextCommand=function(self)
				local str = ScreenSystemLayerHelpers.GetCreditsMessage(pn);
				self:visible(str ~= "PRESS START" and str ~= "NOT PRESENT" and str ~= "INSERT CARD" and str ~= "")
			end;
		}
		LoadFont(Var "LoadingScreen","credits") .. {
			InitCommand=function(self)
				self:name("Credits_Text" .. PlayerNumberToString(pn))
			end;
			UpdateTextCommand=function(self)
				local str = ScreenSystemLayerHelpers.GetCreditsMessage(pn);
				self:settext(str);
				if str ~= "PRESS START" and str ~= "NOT PRESENT" and str ~= "INSERT CARD" and str ~= "" then
					if pn == PLAYER_1 then
						self:x(SCREEN_LEFT+55):y(SCREEN_BOTTOM-16);
					else
						self:x(SCREEN_RIGHT-55):y(SCREEN_BOTTOM-16);
					end
				else
					if pn == PLAYER_1 then
						self:x(SCREEN_LEFT+15):y(SCREEN_BOTTOM-16);
					else
						self:x(SCREEN_RIGHT-15):y(SCREEN_BOTTOM-16);
					end
				end
			end;
		};
	};
	
	return text;
end;

--[[ local function PlayerPane( PlayerNumber ) 
	local t = Def.ActorFrame {
		InitCommand=function(self)
			self:name("PlayerPane" .. PlayerNumberToString(PlayerNumber));
	-- 		ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen");
		end
	};
	t[#t+1] = Def.ActorFrame {
		Name = "Background";
		Def.Quad {
			InitCommand=function(self) self:zoomto(160,28); self:queuecommand("On"); end;
			OnCommand=function(self) self:diffuse(PlayerColor(PlayerNumber)); self:fadebottom(1); end;
		};
	};
	t[#t+1] = Def.BitmapText{
		Font="Common Normal";
		Name = "PlayerText";
		InitCommand=function(self) self:x(-60); self:maxwidth(80/0.5); self:zoom(0.5); self:queuecommand("On"); end;
		OnCommand=function(self) self:playcommand("Set"); end;
		SetCommand=function(self)
			local profile = PROFILEMAN:GetProfile( PlayerNumber) or PROFILEMAN:GetMachineProfile()
			if profile then
				self:settext( profile:GetDisplayName() );
			else
				self:settext( "NoProf" );
			end
		end;
	};
	return t
end --]]
--
local t = Def.ActorFrame {}
	-- Aux
t[#t+1] = LoadActor(THEME:GetPathB("ScreenSystemLayer","aux"));
	-- Credits
t[#t+1] = Def.ActorFrame {
--[[  	PlayerPane( PLAYER_1 ) .. {
		InitCommand=function(self) self:x(scale(0.125,0,1,SCREEN_LEFT,SCREEN_WIDTH)); self:y(SCREEN_BOTTOM-16); end
	}; --]]
 	CreditsText( PLAYER_1 );
	CreditsText( PLAYER_2 ); 
};
	-- Text
t[#t+1] = Def.ActorFrame {
	OnCommand=function(self) self:finishtweening(); self:addx(10); self:decelerate(0.2); self:addx(-10); end;
	OffCommand=function(self) self:sleep(3); self:linear(0.5); self:addx(-10); self:sleep(0.01); self:addx(10); end;
	Def.Quad {
		InitCommand=function(self) self:zoomtowidth(SCREEN_WIDTH); self:zoomtoheight(30); self:horizalign(left); self:vertalign(top); self:y(SCREEN_TOP); self:diffuse(color("0,0,0,0")); end;
		OnCommand=function(self) self:finishtweening(); self:decelerate(0.2); self:diffusealpha(0.85); end;
		OffCommand=function(self) self:sleep(3); self:linear(0.5); self:diffusealpha(0); end;
	};
	Def.BitmapText{
		Font="Common Normal";
		Name="Text";
		InitCommand=function(self) self:maxwidth(750); self:horizalign(left); self:vertalign(top); self:y(SCREEN_TOP+10); self:x(SCREEN_LEFT+10); self:shadowlength(1); self:diffusealpha(0); end;
		OnCommand=function(self) self:finishtweening(); self:decelerate(0.2); self:diffusealpha(1); self:zoom(0.5); end;
		OffCommand=function(self) self:sleep(3); self:linear(0.5); self:diffusealpha(0); end;
	};
	SystemMessageMessageCommand = function(self, params)
		self:GetChild("Text"):settext( params.Message );
		self:playcommand( "On" );
		if params.NoAnimate then
			self:finishtweening();
		end
		self:playcommand( "Off" );
	end;
	HideSystemMessageMessageCommand = function(self) self:finishtweening(); end;
};

return t;
