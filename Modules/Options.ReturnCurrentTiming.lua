--Modified a little bit from fallback
return function()

    --adding for reloading a custom judge animation and timing stuff.
    for i,CurPrefTiming in pairs({GAMESTATE:Env()["SmartTimings"], LoadModule("Options.OverwriteTiming.lua")()}) do
        if CurPrefTiming then
            -- First, check the timings from our current timing window.
            --? From fallback
            for _,v in ipairs(TimingWindow) do
                local data = v()
                if data.Name == CurPrefTiming then
                    data.Timings = LoadModule("Gameplay.UseTimingTable.lua")(data)
                    return data
                end
            end
        end
    end

    -- We did not find anything. This might be cause as another theme used a custom timing process
    -- that is not present on the base configuration's Timing.lua file.
    if n == nil then
        local fallbacktime = TimingWindow[1]()
        Warn( ("[Options.ReturnCurrentTiming] Current Timing '%s' is not present on TimingWindows, using '%s' instead."):format( CurPrefTiming, fallbacktime.Name ) )
        return fallbacktime
    end

    return n
end