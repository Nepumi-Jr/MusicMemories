return function(XX,YY,BGColor,FGColor,pawColor,textColor,subTextColor,text,subText)
	local L = Def.ActorFrame{};
	local tableText = LoadModule("Utils.TextToTable.lua")(text);
	L[#L+1] = Def.ActorFrame{
		OnCommand=cmd(x,0;y,0);
		LoadActor(THEME:GetPathG("MC","BG"))..{
			OnCommand=cmd(diffuse,BGColor);
		};
		LoadActor(THEME:GetPathG("MC","CT"))..{
			OnCommand=cmd(diffuse,pawColor);
		};
		LoadActor(THEME:GetPathG("MC","FG"))..{
			OnCommand=cmd(diffuse,FGColor);
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
		InitCommand=cmd(x,0+125;y,0-75;horizalign,right;zoom,0.7);
		OnCommand=cmd(diffuse,textColor);
	};
	if #tableText > 5 then
		for i = 1,#tableText - 5 do
			L[#L+1] = Def.ActorFrame{
				InitCommand=cmd(x,0+100-150;y,0-75+125;rotationz,-32.8*i);
				LoadFont("Common Large")..{
					Text=tableText[(#tableText - 5) - i +1];
					InitCommand=cmd(y,-125;zoom,0.7);
					OnCommand=cmd(diffuse,textColor);
				};
			};
		end
	end
	L[#L+1] = LoadFont("Common Large")..{
		Text = subText;
		InitCommand=cmd(x,0-75;y,0+25;horizalign,left;zoom,0.45);
		OnCommand=cmd(diffuse,subTextColor);
	};
	return L
end;