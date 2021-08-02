
local Timu = 0
local Dayy = 0
local thisPath = THEMEDIR().."/Graphics/Global Background/"

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
		OnCommand=cmd(FullScreen;diffuse,color("#000000FF"));
	};

	LoadActor("Night.png")..{
		Name ="NightBG";
		InitCommand=cmd(FullScreen;diffuse,{1,1,1,0.7});
	};
	LoadActor("Day.png")..{
		Name ="DayBG";
		InitCommand=cmd(FullScreen;diffuse,{1,1,1,1});
	};

	LoadActor("cloud.png")..{
		Name ="Cloud";
		InitCommand=cmd(Center;zoom,1;diffuse,{1,1,1,1};texcoordvelocity,0.0003,0;);
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
            InitCommand=cmd(zoom,math.random(1,10)/10*0.5;x,math.random(0,SCREEN_RIGHT);y,math.random(0,SCREEN_BOTTOM);diffusealpha,math.random(0,30)/30;rotationz,math.random(-60,60));
			OnCommand=cmd(effectclock,"beat";diffuseshift;effectcolor1,{1,1,1,1};effectcolor2,{1,1,1,0.2};effectperiod,16;effectoffset,math.random(1,8));
            loadVectorStar(PicDlcRand());
        };
	else
		Stars[#Stars+1] = LoadActor("LittleCircle.png")..{
			InitCommand=cmd(zoom,math.random(30,70)/50/8;x,math.random(0,SCREEN_RIGHT);y,math.random(0,SCREEN_BOTTOM);diffusealpha,math.random(0,30)/30);
			OnCommand=cmd(effectclock,"beat";diffuseshift;effectcolor1,{1,1,1,1};effectcolor2,{1,1,1,0.2};effectperiod,16;effectoffset,math.random(1,8));
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
    InitCommand=cmd(x,math.random(100,200);y,math.random(250,300);zoom,0.75;diffusealpha,0.75;rotationz,math.random(0,35));
	OnCommand=cmd(wag;effectmagnitude,0,0,5;effectclock,"beat";effectperiod,32);
    loadVectorStar(GameTypePic());
};


return t;
