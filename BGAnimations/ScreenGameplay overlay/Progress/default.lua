local ENDED = false;

local updateCmd = function(self)
	if not ENDED then
		local SONGg = GAMESTATE:GetCurrentSong();
		local per =GAMESTATE:GetCurMusicSeconds()/SONGg:GetLastSecond();
		self:x(per*SCREEN_RIGHT);
	end
end;

local customizePath = "Gameplay Time Progress";
local progressActors = LoadModule("Utils.GetCustomizeFilesList.lua")( customizePath, {"lua"} );
local curProgressActor = "defaultArrow.lua"
if ThemePrefs.Get("GameplayProgress") == "Random" and #progressActors > 0 then
	curProgressActor = "/"..progressActors[math.random(1,#progressActors)];
elseif ThemePrefs.Get("GameplayProgress") ~= "Default" then
	curProgressActor = "/"..ThemePrefs.Get("GameplayProgress")

	-- Check if the file exists
	if not FILEMAN:DoesFileExist(curProgressActor) then
		-- If it doesn't exist, use the default
		curProgressActor = "defaultArrow.lua"
		lua.ReportScriptError("Gameplay Progress: File "..curProgressActor.." does not exist.\nplease select a new one on Theme's gameplay setting...\nUsing default for now.");
	end

end

local t=Def.ActorFrame{

	Def.ActorFrame{
		InitCommand=function(self) 
			self:y(SCREEN_BOTTOM-32);
			self:SetUpdateFunction(
			updateCmd
			);
		end;
		OffCommand=function(self)
			ENDED = true;
		end;
		LoadActor(curProgressActor);
	};

};

return t;
