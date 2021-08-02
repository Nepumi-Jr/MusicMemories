function Actor:LyricCommand(side)
	self:draworder(DrawOrder.Screen+1);
	self:settext(Var "LyricText")

	self:finishtweening()
	self:shadowlengthx(0)
	self:shadowlengthy(0)
	self:strokecolor(Color("Outline"))
	self:zoomx(clamp(SCREEN_WIDTH/(self:GetZoomedWidth()+1), 0, 1))

	local Color = Var "LyricColor"
	local Factor = 1
	if side == "Back" then
		Factor = 0.5
	elseif side == "Front" then
		Factor = 0.9
	end
	self:diffuse({
		Color[1] * Factor,
		Color[2] * Factor,
		Color[3] * Factor,
		Color[4] * Factor
	})

	if side == "Front" then
		self:cropright(1)
		self:strokecolor(ColorTone(Color));
        self:textglowmode("TextGlowMode_Stroke");
	elseif side == "Back" then
		self:diffusealpha(0)
		if ColorCmp(ColorTone(Color),{1,1,1,0}) then
			self:strokecolor({0.8,0.8,0.8,1});
		else
			self:strokecolor({0.2,0.2,0.2,1});
		end
		
        self:textglowmode("TextGlowMode_Stroke");
	else
		self:strokecolor(ColorTone(Color));
		self:cropleft(0)
	end
	
	self:zoomy(1)
	
	if side == "Back" then
		self:decelerate( Var "LyricDuration" * 0.15)
		self:diffusealpha(1)
	else
	self:linear( Var "LyricDuration" * 0.1)
	end
	if side == "Back" then
	self:sleep( Var "LyricDuration" * 0.70)
	else
	self:linear( Var "LyricDuration" * 0.75)
	end
	if side == "Front" then
		self:cropright(0)
	end
	self:sleep(0.001)
	if side == "Back" then
	else
	self:accelerate( Var "LyricDuration" * 0.15 )
	end
	self:diffusealpha(0)
end

