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


local function NumtoST(n)
if math.mod(n,100) <= 10 then
	if math.mod(n,10) == 1 then
		return n..StrUti("st")
	elseif math.mod(n,10) == 2 then
		return n..StrUti("nd")
	elseif math.mod(n,10) == 3 then
		return n..StrUti("rd")
	else
		return n..StrUti("th")
	end
elseif math.mod(n,100) <= 20 then
	return n..StrUti("th")
else
	if math.mod(n,10) == 1 then
		return n..StrUti("st")
	elseif math.mod(n,10) == 2 then
		return n..StrUti("nd")
	elseif math.mod(n,10) == 3 then
		return n..StrUti("rd")
	else
		return n..StrUti("th")
	end
end
end;

NS = GAMESTATE:GetCurrentStageIndex()+1;

local Picdir = THEME:GetPathG("","_blank");

if IsNetConnected() then
	Picdir = THEME:GetPathG("ScreenStageInformation stage","online")
	Text1 = THEME:GetString("sStageInfo","Online")
	See1 = GameColor.Stage["Stage_Event"]
	See2 = NumStageColor(NS)
	Text2 = string.format(THEME:GetString("sStageInfo","ssStage"),NumtoST(NS));
	Fasst = 0.5;
elseif TP.Battle.IsBattle then--BattleTor
	Picdir = THEME:GetPathG("ScreenStageInformation stage","battle")
	Text1 = THEME:GetString("PlayMode","Battle");
	See1 = ModeIconColors["Rave"]
	See2 = NumStageColor(NS)
	Text2 = string.format(THEME:GetString("sStageInfo","ssRound"),NumtoST(NS));
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
			Text2 = string.format(THEME:GetString("sStageInfo","ssStage"),NumtoST(NS));
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
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y*1.65;settext,SE[i];zoom,1;);
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
	InitCommand=cmd(diffusealpha,0);
	OnCommand=cmd(sleep,1.773;decelerate,2;diffusealpha,1;sleep,1.259;linear,0.5;diffusealpha,0);
	Def.Quad{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y*1.5;zoomx,SCREEN_RIGHT;zoomy,SCREEN_CENTER_Y,0.7;diffuse,{0,0,0,0};fadetop,0.2);
		OnCommand=cmd(diffusealpha,0.7);
	};
	LoadActor(Picdir)..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y*1.15-50;diffusealpha,0;zoom,0.5);
		OnCommand=cmd(decelerate,5;y,SCREEN_CENTER_Y*1.15;diffusealpha,1);
	};
	LoadFont("Common Normal")..{
		Text = "-"..Text1.."-";
		InitCommand=cmd(x,SCREEN_CENTER_X-50;y,SCREEN_CENTER_Y*1.3;diffuse,See1;zoom,0.6);
		OnCommand=cmd(decelerate,5;x,SCREEN_CENTER_X;);
	};
	LoadFont("Common Normal")..{
		Text = Text2;
		InitCommand=cmd(x,SCREEN_CENTER_X+50;y,SCREEN_CENTER_Y*1.45;diffuse,See2;zoom,1.2);
		OnCommand=cmd(decelerate,5;x,SCREEN_CENTER_X;);
	};

	at;
	
	LoadFont("Common Normal")..{
		Condition = GAMESTATE:IsHumanPlayer(PLAYER_1) and (not GAMESTATE:IsCourseMode()) ;
		Text = "";
		InitCommand=cmd(horizalign,left;x,0;y,SCREEN_CENTER_Y*1.7;diffuse,Color.Orange);
		OnCommand=cmd(settext,"Step by\n"..GAMESTATE:GetCurrentSteps(PLAYER_1):GetAuthorCredit() or "???";decelerate,5;x,30);
	};
	LoadFont("Common Normal")..{
		Condition = GAMESTATE:IsHumanPlayer(PLAYER_2) and (not GAMESTATE:IsCourseMode()) ;
		Text = "";
		InitCommand=cmd(horizalign,right;x,SCREEN_RIGHT;y,SCREEN_CENTER_Y*1.7;diffuse,Color.Orange);
		OnCommand=cmd(settext,"Step by\n"..GAMESTATE:GetCurrentSteps(PLAYER_2):GetAuthorCredit() or "???";decelerate,5;x,SCREEN_RIGHT-30);
	};
};


return t;