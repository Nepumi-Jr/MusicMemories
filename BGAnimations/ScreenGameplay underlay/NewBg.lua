local Vdo1 = TP[ToEnumShortString(PLAYER_1)].ActiveModifiers.CusBG or "Default"
local Vdo2 = TP[ToEnumShortString(PLAYER_2)].ActiveModifiers.CusBG or "Default"

local BG1 = TP[ToEnumShortString(PLAYER_1)].ActiveModifiers.HideBG or "Nope"
local BG2 = TP[ToEnumShortString(PLAYER_2)].ActiveModifiers.HideBG or "Nope"

local Dim1 = 0;
local Dim2 = 0;

if BG1 == "Nope" then Dim1 = 0; elseif BG1 == "Hide" then Dim1 = 1; else Dim1 = BG1:gsub("%%","")/100; end
if BG2 == "Nope" then Dim2 = 0; elseif BG2 == "Hide" then Dim2 = 1; else Dim2 = BG2:gsub("%%","")/100; end

local t = Def.ActorFrame{};
if string.match(Vdo1,".mp4") or string.match(Vdo1,".mpg") or string.match(Vdo1,".mpeg") or string.match(Vdo1,".avi") then
	t[#t+1] = LoadActor("../../Resource/BGAV/"..Vdo1)..{
	InitCommand=function(self) self:FullScreen(); self:fadeleft(0); end;
	OnCommand=function(self)
		if GAMESTATE:IsPlayerEnabled(PLAYER_2) and Vdo1 ~= Vdo2 then
			self:faderight(1)
		end
	end;
	};
	t[#t+1] = Def.Quad{
		InitCommand=function(self) self:FullScreen(); self:fadeleft(0); self:diffuse({0,0,0,Dim1}); end;
		OnCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) and Dim1 ~= Dim2 then
				self:faderight(1)
			end
		end;
	};
elseif Vdo1 ~= "Default" then
	t[#t+1] = LoadActor("../../Resource/BGAV/"..Vdo1)..{
	InitCommand=function(self) self:fadeleft(0); end;
	OnCommand=function(self)
		if GAMESTATE:IsPlayerEnabled(PLAYER_2) and Vdo1 ~= Vdo2 then
			self:faderight(1)
		end
	end;
	};
	t[#t+1] = Def.Quad{
		InitCommand=function(self) self:FullScreen(); self:fadeleft(0); self:diffuse({0,0,0,Dim1}); end;
		OnCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) and Dim1 ~= Dim2 then
				self:faderight(1)
			end
		end;
	};
end

if string.match(Vdo2,".mp4") or string.match(Vdo2,".mpg") or string.match(Vdo2,".mpeg") or string.match(Vdo2,".avi") then
	t[#t+1] = LoadActor("../../Resource/BGAV/"..Vdo2)..{
	InitCommand=function(self) self:FullScreen(); self:fadeleft(0); end;
	OnCommand=function(self)
		if GAMESTATE:IsPlayerEnabled(PLAYER_1) and Vdo1 ~= Vdo2 then
			self:faderight(1)
		end
	end;
	};
	t[#t+1] = Def.Quad{
		InitCommand=function(self) self:FullScreen(); self:fadeleft(0); self:diffuse({0,0,0,Dim2}); end;
		OnCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) and Dim1 ~= Dim2 then
				self:faderight(1)
			end
		end;
	};
elseif Vdo2 ~= "Default" then
	t[#t+1] = LoadActor("../../Resource/BGAV/"..Vdo2)..{
	InitCommand=function(self) self:fadeleft(0); end;
	OnCommand=function(self)
		if GAMESTATE:IsPlayerEnabled(PLAYER_1) and Vdo1 ~= Vdo2 then
			self:fadeleft(1)
		end
	end;
	};
	t[#t+1] = Def.Quad{
		InitCommand=function(self) self:FullScreen(); self:fadeleft(0); self:diffuse({0,0,0,Dim2}); end;
		OnCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) and Dim1 ~= Dim2 then
				self:fadeleft(1)
			end
		end;
	};
end
--330965 before
--88050096
--331996
return t;