return function(Timu)

    if ThemePrefs.Get("BackgroundTheme") < 2 then
        return ThemePrefs.Get("BackgroundTheme")
    end

	Timu = Timu or (Hour()*60+Minute()+Second()/60)
	Timu = math.mod(Timu,60*24)

	if Timu <= 5*60 then
		--Night
		return 1
	elseif Timu <= 6*60 then
		--Night -> Day
		return scale(Timu,5*60,6*60,1,0)
	elseif Timu <= 19*60 then
		--Day
		return 0
	elseif Timu <= 20*60 then
		--Day -> Night
		return scale(Timu,19*60,20*60,0,1)
	else
		--Night
		return 1
	end

end