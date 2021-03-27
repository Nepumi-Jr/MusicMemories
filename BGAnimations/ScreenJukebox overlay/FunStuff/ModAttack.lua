
-- const + a * {level}
local Mod_List = {
	{
		Display = "%d beat",
		Mod = "*5 %d beat",
		Const = 100,a = 200
	},
	{
		Display = "%d tornado",
		Mod = "*5 %d tornado",
		Const = 5,a = 10
	},
	{
		Display = "%d dizzy",
		Mod = "*5 %d dizzy",
		Const = 30,a = 30
	}
}



local t = def.ActorFrame{
};

return t;