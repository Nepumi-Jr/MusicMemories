return function()
    local TimingName = ""
    
    TimingName = LoadModule("Options.ReturnCurrentTiming.lua")().Name
    
    local paths = {THEMEDIR().."/Graphics/_Judgement Font","/Appearance/Judgments"}
    local JG = {}
    local JudgmentGraphics = {}

    for _,v in pairs(paths) do

        local files = FILEMAN:GetDirListing(v.."/",false,true)
    
        for k,filename in ipairs(files) do
            if string.match(filename, " %dx%d") and string.match(filename, ".png") then
                if LoadModule("Options.JudgmentsFileShortName.lua")(filename) == "MemoryP2" then
                    table.insert(JG, 1, filename)
                else
                    JG[#JG+1] = filename
                end
            end
        end

    end

    if #JG == 0 then--no judgments
        lua.ReportScriptError( "judgments is missing!" )
        return {"!!missing!!"}
    end
    
    for i,fileName in ipairs(JG) do
        local typemode = string.match(fileName,"%[%a*]")
        if typemode then
            if string.find( TimingName, typemode:sub(2,-2) ) then
                table.insert( JudgmentGraphics, fileName )
            end
        end
    end



    if #JudgmentGraphics == 0 then
        
        for i,fileName in ipairs(JG) do
            local typemode = string.match(fileName,"%[%a*]")
            if not typemode or typemode == "[double]" then
                table.insert( JudgmentGraphics, fileName )
            end
        end
    end
    return JudgmentGraphics
end