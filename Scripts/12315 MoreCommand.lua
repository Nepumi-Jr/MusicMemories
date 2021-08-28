
function THEMEDIR()
	return THEME:GetCurrentThemeDirectory()
end

function PN_Name(pn)
	if PROFILEMAN:GetProfile(pn):GetDisplayName() then
		return PROFILEMAN:GetProfile(pn):GetDisplayName();
	elseif GAMESTATE:IsHumanPlayer(pn) then
		return "Player"..(pn+1).."...";
	else
		return "Someone...";
	end

end

function OP()
	local ENTITY = {PLAYER_1,PLAYER_2};

	for i = 1,#ENTITY do
		if GAMESTATE:IsPlayerEnabled(ENTITY[i]) then
			if string.match( PN_Name(ENTITY[i]), "Isla") then
				return true;
			end
		end
	end
	return false;

end


function SMPairs(t)
	local temp = ""
	for k,v in pairs(t) do
		temp = temp .. "key: " .. tostring(k) .. ", val: " .. tostring(v) .."\n"
	end
	SCREENMAN:SystemMessage(temp)
end


function SM(str)
	SCREENMAN:SystemMessage(tostring(str))
end

function FindInTable(needle, haystack)
	for i = 1, #haystack do
		if needle == haystack[i] then
			return i
		end
	end
	return nil
end


function TFO(s,t,f)
    if s then
        return t
    else
        return f
    end
end

function SM( arg )

	-- if a table has been passed in
	if type( arg ) == "table" then

		-- recurively print its contents to a string
		local msg = TableToString_Recursive(arg)
		-- and SystemMessage() that string
		SCREENMAN:SystemMessage( msg )

		-- tables as strings spill off SM's screen height quickly,
		-- so we might as well also do a proper Trace() to ./Logs/log.txt
		Trace( msg )
	else
		SCREENMAN:SystemMessage( tostring(arg) )
	end
end



function TableToString(S)
	local Talk = "";
	if type(S) ~= "table" then
		return tostring(S);
	else
		local crt = 1;
		Talk = "#"..tostring(#S)..":{";
		for Con in ivalues(S) do
			Talk = Talk..TableToString(Con)..",";
			crt = crt + 1;
			if crt == 10 then crt = 1; Talk = Talk.."\n"; end
		end
		Talk = Talk.."}";
		return Talk;
	end
end


function TableToStringAdv(S)
	local Talk = "";
	if type(S) ~= "table" then
		return tostring(S);
	else
		local crt = 1;
		Talk = "#"..tostring(#S)..":{";
		for k, v in pairs(S) do
			Talk = Talk..k..":"..TableToString(v)..", ";
			crt = crt + 1;
			if crt == 10 then crt = 1; Talk = Talk.."\n"; end
		end
		Talk = Talk.."}";
		return Talk;
	end
end


function printf(SF,...)
	lua.ReportScriptError(string.format(tostring(SF),...))
end
