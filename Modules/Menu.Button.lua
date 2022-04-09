return function(XX,YY,BGColor,FGColor,pawColor,textColor,subTextColor,text,subText)
	local L = Def.ActorFrame{};
	local tableText = LoadModule("Utils.TextToTable.lua")(text);
	L[#L+1] = Def.ActorFrame{
		OnCommand=function(self) self:x(0); self:y(0); end;
		LoadActor(THEME:GetPathG("MC","BG"))..{
			OnCommand=function(self) self:diffuse(BGColor); end;
		};
		LoadActor(THEME:GetPathG("MC","CT"))..{
			OnCommand=function(self) self:diffuse(pawColor); end;
		};
		LoadActor(THEME:GetPathG("MC","FG"))..{
			OnCommand=function(self) self:diffuse(FGColor); end;
		};
	};
	local NormalText = "";
	for i = 1 , math.min(#tableText,5) do
		if #tableText > 5 then
			NormalText = NormalText..tableText[((#tableText-5)+i)]
		else
			NormalText = NormalText..tableText[i]
		end
	end
	L[#L+1] = LoadFont("Common Large")..{
		Text = NormalText;
		InitCommand=function(self) self:x(0+125); self:y(0-75); self:horizalign(right); self:zoom(0.7); end;
		OnCommand=function(self) self:diffuse(textColor); end;
	};
	if #tableText > 5 then
		for i = 1,#tableText - 5 do
			L[#L+1] = Def.ActorFrame{
				InitCommand=function(self) self:x(0+100-150); self:y(0-75+125); self:rotationz(-32.8*i); end;
				LoadFont("Common Large")..{
					Text=tableText[(#tableText - 5) - i +1];
					InitCommand=function(self) self:y(-125); self:zoom(0.7); end;
					OnCommand=function(self) self:diffuse(textColor); end;
				};
			};
		end
	end
	L[#L+1] = LoadFont("Common Large")..{
		Text = subText;
		InitCommand=function(self) self:x(0-75); self:y(0+25); self:horizalign(left); self:zoom(0.45); end;
		OnCommand=function(self) self:diffuse(subTextColor); end;
	};
	return L
end;