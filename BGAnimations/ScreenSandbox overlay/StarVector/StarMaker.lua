
local inputHandle = function( event )
	if not event then return end
    --printf("Watsup %s",event.DeviceInput.button)

    if event.DeviceInput.button == "DeviceButton_left (01)" then
        printf("Watsup %f",event.DeviceInput.level)
    end

	
end;



local t = Def.ActorFrame{
    OnCommand=function(self)
        printf("Watsup aa")
		SCREENMAN:GetTopScreen():AddInputCallback(inputHandle)
	end;
};




return t;


