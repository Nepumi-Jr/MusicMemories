local t = Def.ActorFrame{};
local Title;
local Sub;
local Time;
local playMode = GAMESTATE:GetPlayMode()
if GAMESTATE:IsCourseMode() then
Title = GAMESTATE:GetCurrentCourse():GetDisplayFullTitle();
else
Title = GAMESTATE:GetCurrentSong():GetDisplayMainTitle();
end

Sub = GAMESTATE:IsCourseMode() and ToEnumShortString( GAMESTATE:GetCurrentCourse():GetCourseType() ) or GAMESTATE:GetCurrentSong():GetDisplaySubTitle();

if GAMESTATE:IsCourseMode() then
if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	
	if GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentTrail(PLAYER_1):GetStepsType()) == nil then
		Time = nil
	else	
		Time = ((GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentTrail(PLAYER_1):GetStepsType()) or 99999)
		+(GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentTrail(PLAYER_2):GetStepsType()) or 99999)
		)/2;
	end
	elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	Time = GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentTrail(PLAYER_1):GetStepsType())
	elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	Time = GAMESTATE:GetCurrentCourse():GetTotalSeconds(GAMESTATE:GetCurrentTrail(PLAYER_2):GetStepsType())
	end
else
	Time = GAMESTATE:GetCurrentSong():MusicLengthSeconds();
end

See = color("#FF8800")
local SE = {};
if Title == "" then
	SE[#SE+1] = "No Title"
else
	SE[#SE+1] = Title..""
end

if Sub ~= "" then
	SE[#SE+1] = Sub..""
end

if Time then
	SE[#SE+1] = SecondsToMSSMsMs(Time)
else
	SE[#SE+1] = "??:??.??"
end



local Text1 = "Sample";
local Text2 = "";
local Sped = 65;
local See1;
See1 = color("#FF8800")
local See2;
See2 = color("#22FFAA")


local function StrUti(str)
	return THEME:GetString('RageUtil',"Num"..string.upper( string.sub(str,1,1) )..string.lower( string.sub(str,2,2) )) or str
end;



NS = GAMESTATE:GetCurrentStageIndex()+1;

local Picdir = THEME:GetPathG("","_blank");

if IsNetConnected() then
	Picdir = THEME:GetPathG("ScreenStageInformation stage","online")
	Text1 = THEME:GetString("sStageInfo","Online")
	See1 = GameColor.Stage["Stage_Event"]
	See2 = NumStageColor(NS)
	Text2 = string.format(THEME:GetString("sStageInfo","ssStage"),FormatNumberAndSuffix(NS));
	Fasst = 0.5;
elseif TP.Battle.IsBattle then--BattleTor
	Picdir = THEME:GetPathG("ScreenStageInformation stage","battle")
	Text1 = THEME:GetString("PlayMode","Battle");
	See1 = ModeIconColors["Rave"]
	See2 = NumStageColor(NS)
	Text2 = string.format(THEME:GetString("sStageInfo","ssRound"),FormatNumberAndSuffix(NS));
	Fasst = 0.5;
elseif ToEnumShortString(GAMESTATE:GetCurrentStage()) == "Event" then--if EventMode
	Picdir = THEME:GetPathG("ScreenStageInformation stage","event")
	Text1 = THEME:GetString("Stage","Event");
	See1 = GameColor.Stage["Stage_Event"]
		if GAMESTATE:IsCourseMode() then -- Course
			if GAMESTATE:GetCurrentCourse():IsNonstop()  then
				See2 = ModeIconColors["Nonstop"]
				Text2 = THEME:GetString("Stage","Nonstop");
			elseif GAMESTATE:GetCurrentCourse():IsOni()  then
				See2 = ModeIconColors["Oni"]
				Text2 = THEME:GetString("Stage","Oni");
			elseif GAMESTATE:GetCurrentCourse():IsEndless() then
				See2 = ModeIconColors["Endless"]
				Text2 = THEME:GetString("Stage","Endless");
			end
		elseif playMode == 'PlayMode_Rave' or playMode == 'PlayMode_Battle' then--Rave
			See2 = ModeIconColors["Rave"]
			Text2 = THEME:GetString("PlayMode","Rave");
		else
			See2 = NumStageColor(NS)
			Text2 = string.format(THEME:GetString("sStageInfo","ssStage"),FormatNumberAndSuffix(NS));
		end
	Fasst = 0.5;
else
	if GAMESTATE:IsCourseMode() then -- Course
		if GAMESTATE:GetCurrentCourse():IsNonstop() then
			See1 = ModeIconColors["Nonstop"]
			Text1 = THEME:GetString("Stage","Nonstop");
            Picdir = THEME:GetPathG("ScreenStageInformation stage","nonstop")
		elseif GAMESTATE:GetCurrentCourse():IsOni() then
			See1 = ModeIconColors["Oni"]
			Text1 = THEME:GetString("Stage","Oni");
            Picdir = THEME:GetPathG("ScreenStageInformation stage","oni")
		elseif GAMESTATE:GetCurrentCourse():IsEndless() then
			See1 = ModeIconColors["Endless"]
			Text1 = THEME:GetString("Stage","Endless");
            Picdir = THEME:GetPathG("ScreenStageInformation stage","endless")
		end
	elseif playMode == 'PlayMode_Rave' or playMode == 'PlayMode_Battle' then--Rave
		See1 = ModeIconColors["Rave"]
		Text1 = THEME:GetString("PlayMode","Rave");
        Picdir = THEME:GetPathG("ScreenStageInformation stage","magic")
	else

        local sStage = ""
        sStage = GAMESTATE:GetCurrentStage()

		if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
		  sStage = playMode;
		end
		See1 = NumStageColor(NS)
		Text1 = THEME:GetString("Stage",ToEnumShortString(sStage))
        Picdir = THEME:GetPathG("ScreenStageInformation stage",ToEnumShortString(sStage))
    end
end



local at = Def.ActorFrame{

};

for i = 1,#SE do
	at[#at+1] = LoadFont("Common Normal") .. {
		InitCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y*1.65); self:settext(SE[i]); self:zoom(1); end;
		OnCommand=function(self)
            local thisSong = GAMESTATE:GetCurrentSong();
		if Time then
            if thisSong == nil then
                if GAMESTATE:IsCourseMode() then
                    self:diffuse({1,1,1,1}):diffusebottomedge(Color("Magenta"))
                else
                    self:diffuse({1,1,1,1})
                end
            else
                if thisSong:IsMarathon() then
                    self:diffuse({1,1,1,1}):diffusebottomedge(Color("Magenta"))
                elseif thisSong:IsLong() then
                    self:diffuse({1,1,1,1}):diffusebottomedge(Color("Red"))
                else
                    self:diffuse({1,1,1,1})
                end
            end
		else 
			self:diffuse({1,1,1,1}):diffusebottomedge(Color("Magenta"))
		end
		self:y(SCREEN_CENTER_Y*1.65+30+25*(i-1)):sleep(2.1+0.3*(i-1)):decelerate(1):y(SCREEN_CENTER_Y*1.6+25*(i-1))
		end;
	};
end

t[#t+1] =Def.ActorFrame{
	InitCommand=function(self) self:diffusealpha(0); end;
	OnCommand=function(self) self:sleep(1.773); self:decelerate(2); self:diffusealpha(1); self:sleep(1.259 + 2); self:linear(0.5); self:diffusealpha(0); end;
	Def.Quad{
		InitCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y*1.5); self:zoomx(SCREEN_RIGHT); self:zoomy(SCREEN_CENTER_Y,0.7); self:diffuse({0,0,0,0}); self:fadetop(0.2); end;
		OnCommand=function(self) self:diffusealpha(0.7); end;
	};
	LoadActor(Picdir)..{
		InitCommand=function(self) self:CenterX(); self:y(SCREEN_CENTER_Y*1.15-50); self:diffusealpha(0); self:zoom(0.5); end;
		OnCommand=function(self) self:decelerate(6); self:y(SCREEN_CENTER_Y*1.15); self:diffusealpha(1); end;
	};
	LoadFont("Common Normal")..{
		Text = "-"..Text1.."-";
		InitCommand=function(self) self:x(SCREEN_CENTER_X-50); self:y(SCREEN_CENTER_Y*1.3); self:diffuse(See1); self:zoom(0.6); end;
		OnCommand=function(self) self:decelerate(6); self:x(SCREEN_CENTER_X); end;
	};
	LoadFont("Common Normal")..{
		Text = Text2;
		InitCommand=function(self) self:x(SCREEN_CENTER_X+50); self:y(SCREEN_CENTER_Y*1.45); self:diffuse(See2); self:zoom(1.2); end;
		OnCommand=function(self) self:decelerate(6); self:x(SCREEN_CENTER_X); end;
	};

	at;
	
	LoadFont("Common Normal")..{
		Condition = GAMESTATE:IsHumanPlayer(PLAYER_1) and (not GAMESTATE:IsCourseMode()) ;
		Text = "";
		InitCommand=function(self) self:horizalign(left); self:x(0); self:y(SCREEN_CENTER_Y*1.7); self:diffuse(Color.Orange); end;
		OnCommand=function(self) self:settext("Step by\n"..GAMESTATE:GetCurrentSteps(PLAYER_1):GetAuthorCredit() or "???"); self:decelerate(6); self:x(30); end;
	};
	LoadFont("Common Normal")..{
		Condition = GAMESTATE:IsHumanPlayer(PLAYER_2) and (not GAMESTATE:IsCourseMode()) ;
		Text = "";
		InitCommand=function(self) self:horizalign(right); self:x(SCREEN_RIGHT); self:y(SCREEN_CENTER_Y*1.7); self:diffuse(Color.Orange); end;
		OnCommand=function(self) self:settext("Step by\n"..GAMESTATE:GetCurrentSteps(PLAYER_2):GetAuthorCredit() or "???"); self:decelerate(6); self:x(SCREEN_RIGHT-30); end;
	};
};


return t;