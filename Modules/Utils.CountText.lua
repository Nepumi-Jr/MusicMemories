return function(text, pattern)
    local result = LoadModule("Utils.TextMatching.lua")(text, pattern)

    return #result

end