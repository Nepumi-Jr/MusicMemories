local t = Def.ActorFrame{ OnCommand=function(self) self:y(5); end; };

local widthText = 0;

local iconLoad = TP.Battle.Mode.."_Icon";
local textDisp = "";

if TP.Battle.Mode == "Ac" then
    textDisp = "Accuracy Battle";
else
    textDisp = "Survival Battle";
end

t[#t+1] = LoadFont("Common", "Normal")..{
    Text = textDisp;
    OnCommand = function(self)
        self:diffuse(ModeIconColors.Rave):zoom(0.7):maxwidth(140)
        widthText = self:GetWidth() * 0.7;
    end;
};

t[#t+1] = LoadActor(iconLoad)..{
    OnCommand = function(self) self:horizalign(right):x(-widthText/2 - 3):zoom(0.5):y(-3); end;
};
t[#t+1] = LoadActor(iconLoad)..{
    OnCommand = function(self) self:horizalign(left):x(widthText/2 + 3):zoom(0.5):y(-3); end;
};




return Def.ActorFrame{
    t;
};