local verts
local t = Def.ActorFrame{
    Def.ActorMultiVertex{
        InitCommand=function(self)
            self:SetDrawState{Mode="DrawMode_Strip"}:SetVertices(verts)
        end;
        OnCommand=function(self)
            verts = {}
            
            local CX = SCREEN_CENTER_X;
            local CY = SCREEN_CENTER_Y;
            
            table.insert( verts,{{0, CY-50, 0}, Color.Green })
            for i = 1,5 do
                table.insert( verts,{{i*100, CY-50-math.random(0,50), 0}, Color.Red})
            end
            table.insert( verts,{{6*100, CY-50, 0}, Color.Green })

            self:SetNumVertices(#verts):SetVertices( verts )
        end;
    };

};

return t;