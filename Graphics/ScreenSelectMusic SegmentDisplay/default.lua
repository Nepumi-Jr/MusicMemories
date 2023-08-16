-- segment display: tells the player about various gimmicks used in the song timing.
local iconPath = "_timingicons"
local leftColX = -144
local rightColX = -leftColX

local showCmd = function(self) self:finishtweening(); self:accelerate(0.1); self:diffusealpha(1); end
local hideCmd = function(self) self:finishtweening(); self:accelerate(0.1); self:diffusealpha(0); end

local SegmentTypes = {
	Attacks	=	{ Frame = 6, xPos = 52, yPos = -36 },
	Delays	=	{ Frame = 1, xPos = 52, yPos = -24 },
	Fakes	=	{ Frame = 5, xPos = 52, yPos = -12 },
	Scrolls	=	{ Frame = 3, xPos = 52, yPos = 0 },
	Speeds	=	{ Frame = 4, xPos = 52, yPos = 12 },
	Stops	=	{ Frame = 0, xPos = 52, yPos = 24 },
	Warps	=	{ Frame = 2, xPos = 52, yPos = 36 },
};

local SegmentTypeString = {
	"Stops",
	"Warps",
	"Delays",
	"Attacks",
	"Scrolls",
	"Speeds",
	"Fakes",
}

local indAnimate = 0
local segments = {}

local t = Def.ActorFrame{
	BeginCommand=function(self) self:playcommand("SetIcons"); self:playcommand("SetAttacksIconMessage"); end;
	--OffCommand=function(self) self:RunCommandsOnChildren(function(self) self:playcommand("Hide"); end); end;

	SetIconsCommand=function(self)
		self:finishtweening()
		local song = GAMESTATE:GetCurrentSong()
		segments = {}
		if song then
			local timing = song:GetTimingData()

			if timing:HasWarps() then segments[#segments + 1] = "Warps" end
			if timing:HasStops() then segments[#segments + 1] = "Stops" end
			if timing:HasDelays() then segments[#segments + 1] = "Delays" end
			if timing:HasScrollChanges() then segments[#segments + 1] = "Scrolls" end
			if timing:HasSpeedChanges() then segments[#segments + 1] = "Speeds" end
			if timing:HasFakes() then segments[#segments + 1] = "Fakes" end

			--for each player
			for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
				--get timing data from player
				local steps = GAMESTATE:GetCurrentSteps(pn)
				if steps and steps:GetTimingData() then
					local timing = steps:GetTimingData()
					if timing:HasWarps() then segments[#segments + 1] = "Warps" end
					if timing:HasStops() then segments[#segments + 1] = "Stops" end
					if timing:HasDelays() then segments[#segments + 1] = "Delays" end
					if steps:HasAttacks() then segments[#segments + 1] = "Attacks" end
					if timing:HasScrollChanges() then segments[#segments + 1] = "Scrolls" end
					if timing:HasSpeedChanges() then segments[#segments + 1] = "Speeds" end
					if timing:HasFakes() then segments[#segments + 1] = "Fakes" end
				end
			end

			if #segments > 0 then
				--sort and remove duplicates
				table.sort(segments)
				for i=#segments,2,-1 do
					if segments[i] == segments[i-1] then
						table.remove(segments,i)
					end
				end
			end
		end
		indAnimate = 0
		if #segments > 1 then
			self:playcommand("doAnimate")
		elseif #segments == 1 then
			for i=1,#SegmentTypeString do
				self:GetChild(SegmentTypeString[i].."Icon"):playcommand("Hide")
			end
			self:GetChild(segments[1].."Icon"):playcommand("Show")
		else
			self:playcommand("Hide")
		end
	end;
	doAnimateCommand=function(self)
		indAnimate = indAnimate + 1
		if indAnimate > #segments then indAnimate = 1 end
		local segment = segments[indAnimate]
		--hide all icons from SegmentTypeString
		for i=1,#SegmentTypeString do
			self:GetChild(SegmentTypeString[i].."Icon"):playcommand("Hide")
		end
		self:GetChild(segment.."Icon"):playcommand("Show")
		self:sleep(1.5)
		self:queuecommand("doAnimate")
	end;
	CurrentSongChangedMessageCommand=function(self) self:playcommand("SetIcons"); end;
	CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("SetIcons") end;
	CurrentStepsP2ChangedMessageCommand=function(self) self:playcommand("SetIcons") end;
};

for i=1,#SegmentTypeString do
	t[#t+1] = LoadActor("Segments/"..SegmentTypeString[i])..{
		Name=SegmentTypeString[i].."Icon";
		ShowCommand=showCmd;
		HideCommand=hideCmd;
	};

	t[#t+1] = LoadActor(iconPath)..{
		InitCommand=function(self) self:animate(false); self:x(SegmentTypes[SegmentTypeString[i]].xPos); self:y(SegmentTypes[SegmentTypeString[i]].yPos); self:setstate(SegmentTypes[SegmentTypeString[i]].Frame); self:zoom(3/4); end;
		SetIconsCommand = function(self) 
			local thisSegment = SegmentTypeString[i];
			if FindInTable(SegmentTypeString[i],segments) ~= nil then
				self:diffusealpha(1)
			else
				self:diffusealpha(0.1)
			end
		end;
	};
end

return t;