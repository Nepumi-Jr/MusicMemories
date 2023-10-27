function Actor:LyricCommand(side)
	self:draworder(DrawOrder.Screen+1);
	self:settext(Var "LyricText")

	self:finishtweening()
	self:shadowlengthx(0)
	self:shadowlengthy(0)
	self:zoomx(clamp(SCREEN_WIDTH/(self:GetZoomedWidth()+1), 0, 1))

	local Color = Var "LyricColor"
	local Factor = 1
	local timeLen =  Var "LyricDuration" 


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
		local timeLenClamp = clamp(timeLen, 0.5, 10)
		self:cropright(1):y(0):rotationz(0)

		self:strokecolor(ColorTone(Color)):textglowmode("TextGlowMode_Stroke");

		self:sleep( timeLen * 0.1):linear( timeLen * 0.75)
		self:cropright(0)

		self:accelerate( timeLen * 0.14 )
		self:diffusealpha(0):y(scale(timeLenClamp, 0.5, 10, 5, 12)):rotationz(scale(timeLenClamp, 0.5, 10, 0, 5))
	elseif side == "Back" then
		self:diffusealpha(0):y(-5)
		if ColorCmp(ColorTone(Color),{1,1,1,0}) then
			self:strokecolor({0.8,0.8,0.8,1});
		else
			self:strokecolor({0.2,0.2,0.2,1});
		end
        self:textglowmode("TextGlowMode_Stroke");

		self:decelerate( timeLen * 0.15)
		self:diffusealpha(1):y(0)

		self:sleep( timeLen * 0.70)
		self:diffusealpha(0)
	end
	
	
	
	
end

