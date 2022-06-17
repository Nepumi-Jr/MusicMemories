
local Timu = 0
local Dayy = 0
local thisPath = getThemeDir().."/Graphics/Global Background/"

local function DayNight(self)
	local this = self:GetChildren()
	
	Dayy = 1 - LoadModule("ColorTone.Nighty.lua")()

	this.DayBG:diffusealpha(Dayy)
	this.Stars:diffusealpha(scale(Dayy,0,1,1,0.25))
	this.Cloud:diffuse(ScaleColor(Dayy,0,1,{0.2,0.2,0.2,1},{1,1,1,1}))

end

local t = Def.ActorFrame{
	InitCommand=function(self) self:SetUpdateFunction(DayNight) end;



	Def.Quad{
		Name ="VeryBG";
		OnCommand=function(self) self:FullScreen(); self:diffuse(color("#000000FF")); end;
	};

	LoadActor("Night.png")..{
		Name ="NightBG";
		InitCommand=function(self) self:FullScreen(); self:diffuse({1,1,1,0.7}); end;
	};
	LoadActor("Day.png")..{
		Name ="DayBG";
		InitCommand=function(self) self:FullScreen(); self:diffuse({1,1,1,1}); end;
	};

	LoadActor("cloud.png")..{
		Name ="Cloud";
		InitCommand=function(self) self:Center(); self:zoom(1); self:diffuse({1,1,1,1}); self:texcoordvelocity(0.0003,0); end;
	};

};

local function loadVectorStar(bigPath)
    return LoadActor("StarVector.lua",bigPath);
end

local function PicDlcRand()

	local path = thisPath.."DLC/"
	local files = FILEMAN:GetDirListing(path)

	local LL = {}

	for k,filename in ipairs(files) do
		LL[#LL+1] = filename;
	end


	return "DLC/"..LL[math.random(1,#LL)]
end


local Stars = Def.ActorFrame{
	Name = "Stars";
};


for i = 1,30 do

	if math.random(1,10) == 1 then
		Stars[#Stars+1] = Def.ActorFrame{
            InitCommand=function(self) self:zoom(math.random(1,10)/10*0.5); self:x(math.random(0,SCREEN_RIGHT)); self:y(math.random(0,SCREEN_BOTTOM)); self:diffusealpha(math.random(0,30)/30); self:rotationz(math.random(-60,60)); end;
			OnCommand=function(self) self:effectclock("beat"); self:diffuseshift(); self:effectcolor1({1,1,1,1}); self:effectcolor2({1,1,1,0.2}); self:effectperiod(16); self:effectoffset(math.random(1,8)); end;
            loadVectorStar(PicDlcRand());
        };
	else
		Stars[#Stars+1] = LoadActor("LittleCircle.png")..{
			InitCommand=function(self) self:zoom(math.random(30,70)/50/8); self:x(math.random(0,SCREEN_RIGHT)); self:y(math.random(0,SCREEN_BOTTOM)); self:diffusealpha(math.random(0,30)/30); end;
			OnCommand=function(self) self:effectclock("beat"); self:diffuseshift(); self:effectcolor1({1,1,1,1}); self:effectcolor2({1,1,1,0.2}); self:effectperiod(16); self:effectoffset(math.random(1,8)); end;
		};
	end
end


t[#t+1] = Stars;

local function GameTypePic()
	local path = thisPath.."GameMode/"

	if FILEMAN:DoesFileExist(path..GAMESTATE:GetCurrentGame():GetName()..".lua") then
		return "GameMode/"..GAMESTATE:GetCurrentGame():GetName()..".lua"
	else
		return "GameMode/OutFox.lua"
	end


end


--GAMESTATE:GetCurrentSong()

t[#t+1]=Def.ActorFrame{
    InitCommand=function(self) self:x(math.random(100,200)); self:y(math.random(250,300)); self:zoom(0.75); self:diffusealpha(0.75); self:rotationz(math.random(0,35)); end;
	OnCommand=function(self) self:wag(); self:effectmagnitude(0,0,5); self:effectclock("beat"); self:effectperiod(32); end;
    loadVectorStar(GameTypePic());
};


return t;
