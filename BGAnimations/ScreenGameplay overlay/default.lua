




local OldVer = false;

local TexttoDeBUG = "";


local Funny=true;





local t = Def.ActorFrame{};

-- t[#t+1] = Def.Quad{
-- 	OnCommand=function(self)
-- 		self:visible(false);
-- 		for k, v in pairs( SCREENMAN:GetTopScreen():GetChild('PlayerP1'):GetChild('NoteField'):GetChild('Board'):GetChildren() ) do
-- 			--TexttoDeBUG = TexttoDeBUG..tostring(k).."\n";

-- 		end
-- 		local screen = SCREENMAN:GetTopScreen() -- grabs the current screen, which is probably ScreenGameplay
--         local field = screen:GetChild('PlayerP1'):GetChild('NoteField') -- grabs player 1's notefield, allowing you to (ab)use it
--        -- local column = field:get_columns() -- returns the columns in a table. column[1] would grab the left arrow, column[2] the right, etc etc

--         -- put your super amazing functions here
-- 	end;

-- };

if not OldVer then
if TexttoDeBUG ~= "" then
t[#t+1] = LoadActor("BeatMann");
end


t[#t+1] = LoadActor("SoundReady");
t[#t+1] = LoadActor("Time.lua")..{
	GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,-100;);
};
t[#t+1] = LoadActor("BPM")..{
	GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,-50;);
};
if ((GAMESTATE:GetPlayerState(PLAYER_1):GetCurrentPlayerOptions():DrainSetting() == "DrainType_SuddenDeath" and GAMESTATE:IsPlayerEnabled(PLAYER_1)) or 
(GAMESTATE:GetPlayerState(PLAYER_2):GetCurrentPlayerOptions():DrainSetting() == "DrainType_SuddenDeath" and GAMESTATE:IsPlayerEnabled(PLAYER_2))) and not ((GAMESTATE:IsCourseMode()) and not GAMESTATE:GetCurrentCourse():IsNonstop()) then
t[#t+1] = LoadActor("Wario's Time")..{
	OnCommand=cmd(y,-10);
	GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;zoom,0;);
};
end

t[#t+1] = LoadActor("MulPStuff");



if GAMESTATE:IsCourseMode() then
	t[#t+1]=LoadActor("TitleCRS");
end


if ThemePrefs.Get("More1PInfo") and #(GAMESTATE:GetHumanPlayers())==1 then
	t[#t+1]=LoadActor("MoreINFO");
end

t[#t+1]=LoadActor("TitleAll");

--if tostring(SCREENMAN:GetTopScreen():GetScreenType()) ~== "ScreenType_SystemMenu" then
--end
t[#t+1] = LoadActor("IQ");

t[#t+1] = LoadActor("BetterG");

t[#t+1] = LoadActor("Boom");

t[#t+1] = LoadActor("FunStuff");

if OP() or true then
t[#t+1] = LoadActor("Niko");
end

t[#t+1] = LoadActor("Border");
if TP.Battle.IsBattle  then
t[#t+1] = LoadActor("Battle");
end


if (not TP.Battle.IsBattle) and not (GAMESTATE:GetPlayMode() == 'PlayMode_Rave' or GAMESTATE:GetPlayMode() == 'PlayMode_Battle') then
	t[#t+1] = LoadActor("ButtomLifeLine/NewDefault.lua")..{
		GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,10;);
	};
	else
	t[#t+1] = LoadActor("DancingLine")..{
		GETOUTOFGAMESMMessageCommand=cmd(sleep,.75;accelerate,0.5;y,10;);
	};
	
	end


t[#t+1] = Def.Quad{
	OnCommand=cmd(playcommand,"Narin");
	NarinCommand=function(self)

		if SCREENMAN:GetTopScreen():GetChild("ActiveAttackListP1") then SCREENMAN:GetTopScreen():GetChild("ActiveAttackListP1"):visible(SCREENMAN:GetTopScreen():GetChild("Overlay"):GetVisible()) end
		if SCREENMAN:GetTopScreen():GetChild("ActiveAttackListP2") then SCREENMAN:GetTopScreen():GetChild("ActiveAttackListP2"):visible(SCREENMAN:GetTopScreen():GetChild("Overlay"):GetVisible()) end

		self:sleep(1/60):queuecommand("Narin")
	end;
};

t[#t+1] = Def.Quad{
	InitCommand=cmd(visible,false);
	OnCommand=cmd(sleep,math.max(0.001,GAMESTATE:GetCurrentSong():GetFirstSecond()-1);queuecommand,"Bruh");
	BruhCommand=function()
		MESSAGEMAN:Broadcast("SystemRePoss",{state = "GamePlay"})
	end;
};




t[#t+1] = LoadFont( "Common Large") .. {
InitCommand=cmd(CenterX;y,300;zoom,0.2);
BEATMessageCommand=function(self,params)
if TexttoDeBUG ~= "" then -- U can Make it 'False' if u Dont wan Them
self:settext("DeBug\n"..TexttoDeBUG.."\n")
self:decelerate(params.len*0.75):diffuse(color((math.random(1,10)/10)..","..(math.random(1,10)/10)..","..(math.random(1,10)/10)..","..1))
end
end;
};

local I = 1;

--[[t[#t+1] = Def.Quad{
	StepP1MessageCommand=function(self,Isla)
	--TableToStringAdv(
	SM("\n\n\n\n\n\nIsla\n"..TableToStringAdv(Isla)
	
	--..string.format("\n There are %d NOTEs\n",#Isla.Notes or -1)
	);
	end;
};]]

else
t[#t+1] = LoadActor("_Backup");
end;
return t;