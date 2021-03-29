local t = Def.ActorFrame {};



local RanCl = {"Red","Blue","Green","Yellow","Orange","Purple","Greener","Magenta","Pink"};
local HEAD = Screen.String("HeaderText");

t[#t+1] = Def.ActorFrame {

	LoadFont("Common Large")..{
		OnCommand=function(self)
			self:settext(HEAD)
			self:zoom(0.4)
			self:y(15)

			for i = 0,string.len(HEAD) - 1 do
				local yeetCl = Color[RanCl[math.random(1,#RanCl)]]
				self:AddAttribute(i,
			{ Length = 1; Diffuses = {
				Color.White,Color.White,yeetCl,yeetCl
			}; })
			end
			self:skewx(-0.1)

			if Var "LoadingScreen" == "ScreenSelectMusic" then
				self:zoom(0.25)
				self:y(7)
			end
			

		end;
	}
	
};



return t
