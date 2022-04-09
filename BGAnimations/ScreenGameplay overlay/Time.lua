local plused = false;
local dat = 1;
local Change = math.random(10,25)

local sc = {0,0};

local hang = 12;
local NumF = "_thin pixel-7 24px"--NumF;

local function NameString(str)
	return THEME:GetString('ScreenGameplay',str)
end

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


local t = Def.ActorFrame{OnCommand=function(self) self:CenterX(); self:y(20); end;};
	t[#t+1] = Def.ActorFrame{
		OnCommand=function(self)
			self:sleep(math.random(7*8,15*8)/8):decelerate(.5):rotationx(180)
			self:sleep(math.random(7*8,15*8)/8):decelerate(.5):rotationx(360)
			self:sleep(0.02):rotationx(0):queuecommand("On")
		end;
		Def.ActorFrame{
			InitCommand=function(self) self:diffuse(Color.SkyBlue); self:zoom(1.7); self:rotationx(180); end; 
			LoadFont("Combo Number") .. {
                OnCommand=function(self) self:zoom(0.2); self:y(3); self:cullmode('back'); self:playcommand("Row"); end;
                RowCommand=function(self)
                    REM = math.max(GAMESTATE:GetCurrentSong():GetLastSecond() - GAMESTATE:GetCurMusicSeconds(),0)
                    if REM > 60*60 then
                        self:settext(SecondsToHHMMSS(REM))
                    else
                        self:settext(SecondsToMMSSMsMs(REM))
                    end
				    self:sleep(0.02):queuecommand("Row") 
				end; 
            };
		};
		Def.ActorFrame{
			InitCommand=function(self) end; 
			LoadFont("Common Normal") .. {
				Condition = not (TP.Battle.IsBattle);
				InitCommand=function(self) self:y(3); self:cullmode('back'); end;
				OnCommand=function(self)
					local NS = GAMESTATE:GetCurrentStageIndex()+1;
					if IsNetConnected() then
						self:settext("Online Mode"):diffuse(Color.Green)
					elseif TP.Battle.IsBattle then
						self:settextf("%s Round",NumtoST(NS)):diffuse(ModeIconColors["Rave"])
					elseif GAMESTATE:IsCourseMode() then
						if GAMESTATE:GetCurrentCourse():IsNonstop()  then
							self:settext("NonStop!!"):diffuse(ModeIconColors["Nonstop"])
						elseif GAMESTATE:GetCurrentCourse():IsOni()  then
							self:settext("Survive!"):diffuse(ModeIconColors["Oni"])
						elseif GAMESTATE:GetCurrentCourse():IsEndless() then
							self:settext("Endless"):diffuse(ModeIconColors["Endless"])
						end
					elseif ToEnumShortString(GAMESTATE:GetCurrentStage()) == "Event" then
						self:settextf(NameString("SMemories"),NumtoST(NS)):diffuse(NumStageColor(NS))
					else
						local playMode = GAMESTATE:GetPlayMode()
						local sStage = ""
						sStage = GAMESTATE:GetCurrentStage()
						if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
						  sStage = playMode;
						end
						self:settext(ToEnumShortString(sStage).." Stage"):diffuse(NumStageColor(NS))
					end
				
				end; 
			};
			LoadFont("Common Normal") .. {
				Condition = TP.Battle.IsBattle;
				InitCommand=function(self) self:y(3); self:cullmode('back'); end;
				OnCommand=function(self)
					--SM("\n\n\n\nISLALA:"..math.random( 10, 99 ));
					sc = {0,0};
					self:settextf("Vs",NumtoST(NS)):diffuse({1,1,1,1})		
					for i = 1,#TP.Battle.Info do
					if TP.Battle.Info[i][4] == 1 then
					sc[1] = sc[1] +1
					elseif TP.Battle.Info[i][4] == 2 then
					sc[2] = sc[2] +1
					end
					end
				end; 
			};
			LoadFont("Common Normal") .. {
				Condition = TP.Battle.IsBattle;
				InitCommand=function(self) self:x(-50); self:y(3); self:cullmode('back'); end;
				OnCommand=function(self)
					self:settext(sc[1]);
					self:diffuse(PlayerColor(PLAYER_1));
				end; 
			};
			LoadFont("Common Normal") .. {
				Condition = TP.Battle.IsBattle;
				InitCommand=function(self) self:x(50); self:y(3); self:cullmode('back'); end;
				OnCommand=function(self)
					self:settext(sc[2]);
					self:diffuse(PlayerColor(PLAYER_2));
				end; 
			};
		};
	};
return t;