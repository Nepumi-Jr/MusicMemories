local function RandCl()
    return {math.random(0,20)/20,math.random(0,20)/20,math.random(0,20)/20,1}
end

local CyclePat = {
    {RandCl(),RandCl(),RandCl(),RandCl(),RandCl(),RandCl(),RandCl(),RandCl()},--Frame1
    {RandCl(),RandCl(),RandCl(),RandCl(),RandCl(),RandCl(),RandCl(),RandCl()},--Frame2
    {RandCl(),RandCl(),RandCl(),RandCl(),RandCl(),RandCl(),RandCl(),RandCl()},--Frame3
    {RandCl(),RandCl(),RandCl(),RandCl(),RandCl(),RandCl(),RandCl(),RandCl()},--Frame4
}

local TexData = {

}


local Scaling = 2;
local width = 100;
local height = 100;




local t = Def.ActorFrame{
    OnCommand=function(self)

        for i = 1,height do
            local nowt = {}
            for j = 1,width do
                nowt[j] = math.random(1,8)
            end
            TexData[i] = nowt
        end

        self:playcommand("Loop")
    end;
    LoopCommand=function(self)
        local Canva = self:GetChildren()["Canvas"]
        verts = {}
        
        local Frame = 1
        
        for i = 1,height do
            for j = 1,width do
                table.insert( verts,{{(j-1)*Scaling  -  (width/2)*Scaling, (i-1)*Scaling -  (height/2)*Scaling, 0}, CyclePat[Frame][TexData[i][j]]})
                table.insert( verts,{{(j)*Scaling -  (width/2)*Scaling, (i-1)*Scaling -  (height/2)*Scaling, 0}, CyclePat[Frame][TexData[i][j]]})
                table.insert( verts,{{(j)*Scaling -  (width/2)*Scaling, (i)*Scaling -  (height/2)*Scaling, 0}, CyclePat[Frame][TexData[i][j]]})
                table.insert( verts,{{(j-1)*Scaling -  (width/2)*Scaling, (i)*Scaling -  (height/2)*Scaling, 0}, CyclePat[Frame][TexData[i][j]]})
            end
        end
        

        Canva:SetNumVertices(#verts):SetVertices( verts )

        self:sleep(1/30):queuecommand("Loop")
    end;

    Def.ActorMultiVertex{
        Name = "Canvas";
        InitCommand=function(self)
            self:SetDrawState{Mode="DrawMode_Quads"}
        end;
        OnCommand=function(self)
            self:Center()
            
            
        end;
    };

};

return t;