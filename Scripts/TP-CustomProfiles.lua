local path =  "Memories/"..GAMESTATE:GetCurrentGame():GetName().."/"

-- Hook called during profile load
function LoadProfileCustom(profile, dir)

	local PrefPath =  dir .. path
	local pn,ppn;
		
	-- we've been passed a profile object as the variable "profile"
	-- see if it matches against anything returned by PROFILEMAN:GetProfile(pn)
	local Players = GAMESTATE:GetHumanPlayers()
	
	if Players then
		for player in ivalues(Players) do
			if profile == PROFILEMAN:GetProfile(player) then
				pn = ToEnumShortString(player)
				ppn = player
			end
		end
	end
	
	
	-- ...and then, if a player profile exists, read .cfg files from it
	if pn then
				
		local f = RageFileUtil.CreateRageFile()
		local setting
		local Optioning

		for k,v in pairs( TP[pn].ActiveModifiers ) do
			
			local fullFilename = PrefPath.."/Mod/"..k..".cfg"
			


			

			if f:Open(fullFilename,1) then
				
				setting = tostring( f:Read() )
				TP[pn].ActiveModifiers[k] = setting 

				if k == "HideBG" then
					if setting  ~= "Nope" and setting  ~= "Hide" then

						local Dim = setting:gsub("%%","")/100

						local topscreen = SCREENMAN:GetTopScreen():GetName()
						local modslevel = topscreen  == "ScreenEditOptions" and "ModsLevel_Stage" or "ModsLevel_Preferred"
						--SM("\n\n\nDoing "..string.format( "%s : %s(%.2f) man...",profile:GetDisplayName(),setting ,Dim));
						GAMESTATE:GetPlayerState(pn):GetPlayerOptions(modslevel):Cover(Dim)
					elseif setting  == "Hide" then
						local topscreen = SCREENMAN:GetTopScreen():GetName()
						local modslevel = topscreen  == "ScreenEditOptions" and "ModsLevel_Stage" or "ModsLevel_Preferred"
						--SM("\n\n\nDoing "..string.format( "%s : %s(%.2f) man...",profile:GetDisplayName(),setting ,Dim));
						GAMESTATE:GetPlayerState(pn):GetPlayerOptions(modslevel):Cover(1)
					else
						local topscreen = SCREENMAN:GetTopScreen():GetName()
						local modslevel = topscreen  == "ScreenEditOptions" and "ModsLevel_Stage" or "ModsLevel_Preferred"
						--SM("\n\n\nDoing "..string.format( "%s : %s(%.2f) man...",profile:GetDisplayName(),setting ,Dim));
						GAMESTATE:GetPlayerState(pn):GetPlayerOptions(modslevel):Cover(0)
					end
				elseif k == "CustomMini" then
					if setting  ~= "Nope" and setting  ~= "Normal" then

						local Dim = setting:gsub("%%","")/100

						local topscreen = SCREENMAN:GetTopScreen():GetName()
						local modslevel = topscreen  == "ScreenEditOptions" and "ModsLevel_Stage" or "ModsLevel_Preferred"
						--SM("\n\n\nDoing "..string.format( "%s : %s(%.2f) man...",profile:GetDisplayName(),setting ,Dim));
						GAMESTATE:GetPlayerState(pn):GetPlayerOptions(modslevel):Mini(Dim)
					else
						local topscreen = SCREENMAN:GetTopScreen():GetName()
						local modslevel = topscreen  == "ScreenEditOptions" and "ModsLevel_Stage" or "ModsLevel_Preferred"
						--SM("\n\n\nDoing "..string.format( "%s : %s(%.2f) man...",profile:GetDisplayName(),setting ,Dim));
						GAMESTATE:GetPlayerState(pn):GetPlayerOptions(modslevel):Mini(0)
					end
				elseif k == "HelpNote" then
					local topscreen = SCREENMAN:GetTopScreen():GetName()
					local modslevel = topscreen  == "ScreenEditOptions" and "ModsLevel_Stage" or "ModsLevel_Preferred"
					
					local a,b = GAMESTATE:GetPlayerState(pn):GetPlayerOptions(modslevel):NoteSkin(setting)
					--SM("\n\n\nDoing "..string.format( "%s : %s <%s>man...",profile:GetDisplayName(),setting,b and "Complete" or "Nooooo"));
				end

			else
				local fError = f:GetError()
				Trace( "[FileUtils] Error reading ".. fullFilename ..": ".. fError )
				f:ClearError()
			end
		end
		
		
		-- don't destroy the RageFile until we've tried to load all custom options
		-- and set them to the env table to make them accessible from anywhere in SM
		f:destroy()
		TP[pn].ActiveModifiers["IconDir"] = dir.."Memories/Icon.png";
	end
	
	return true
end

-- Hook called during profile save
function SaveProfileCustom(profile, dir)

	local PrefPath =  dir .. path


	local pn
	
	local Players = GAMESTATE:GetHumanPlayers()
	
	for player in ivalues(Players) do
		if profile == PROFILEMAN:GetProfile(player) then
			pn = ToEnumShortString(player)
		end
	end
	
	if pn then
		-- a generic ragefile (?)
		local f = RageFileUtil.CreateRageFile()

		
		-- then loop through the prefs, saving one .cfg file per available setting
		-- if a particular value is nil, nothing gets written
		for k,v in pairs( TP[pn].ActiveModifiers ) do
		
			local fullFilename = PrefPath.."/Mod/"..k..".cfg"

			if f:Open(fullFilename, 2) then
				
				-- if a setting exists (it should) write that to the .cfg file
				if v then
					f:Write( tostring( v ) )
				end
			else
				local fError = f:GetError()
				Trace( "[FileUtils] Error writing to ".. fullFilename ..": ".. fError )
				f:ClearError()
			end
		end
		
		
		-- again, don't destroy the file until after we're done looping
		-- through all possible custom options
		f:destroy()
	end
	
	return true	
end