local verts = LoadActor("Dance_Java.lua");

local t = Def.ActorFrame{
    Def.ActorMultiVertex{
        InitCommand=function(self)
            self:SetDrawState{Mode="DrawMode_Lines"}:SetVertices(verts)
        end;
    };

};

for i = 1,#verts do
t[#t+1] = LoadActor("LittleCircle.png")..{
    InitCommand=function(self) self:xy(verts[i][1][1],verts[i][1][2]); self:zoom(0.25); end;
}
end

return t;