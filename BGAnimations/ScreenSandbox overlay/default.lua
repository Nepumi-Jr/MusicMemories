local t = Def.ActorFrame{};
local InputOfArrow = function( event )
	if not event then return end

	if event.type == "InputEventType_Repeat" then
		if event.button == "Start" or event.button == "Center" or event.button == "Back" then
			MESSAGEMAN:Broadcast('Confirm')
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
		end
	end
end;

t[#t+1] = Def.ActorFrame{
	name = "YEY";
	InitCommand=function(self) end;
	OnCommand=function(self)
		SCREENMAN:GetTopScreen():AddInputCallback(InputOfArrow)
		self:sleep(1):queuecommand("ISLA")
	end;
	
		LoadActor( THEME:GetPathS("Common","start") )..{
			ConfirmMessageCommand=function(self) self:play(); end;
		};
		LoadActor( THEME:GetPathS("Common","cancel") )..{
			NopeMessageCommand=function(self) self:play(); end;
		};
		LoadActor( THEME:GetPathS("Common","value") )..{
			ChanMessageCommand=function(self) self:play(); end;
		};
};
t[#t+1]=Def.Quad{
	OnCommand=function(self) self:visible(false); self:sleep(9999999); end;
};

--t[#t+1] = LoadActor("SH");

t[#t+1] = Def.Quad{
    OnCommand=function(self)
        

        local RowOptions = {}
        local files = FILEMAN:GetDirListing(getThemeDir().."/Modules/",false,false)
        for _,file in pairs(files) do
            local pl,pr = string.find( file, "RowOption." )
            local sl,sr = string.find( file, ".lua" )
            if pl ~= nil and pl == 1 and pr + 1 <= sl - 1 then
                RowOptions[#RowOptions+1] = string.sub( file, pr + 1, sl - 1 )
            end
        end
        
    end;
};



return t;