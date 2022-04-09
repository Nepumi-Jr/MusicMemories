--[[
==============IQ LIST==============
	**"Math"
	I :	5Type:	1(a+b=?)
				2(?+b=c)
				3(a+b=c)??
	N : LEVEL

	**"Missing"
	I : nil
	N : 5Type:	1(Number)
				2(Arrow)
				3(Animal)
				4(Emoji)
		6SPEED
]]

local GT = GAMESTATE:GetCurrentGame():GetName();
local InB = {"Left","Down","Up","Right"}
if GT == 'dance' then
	InB = {"Left","Down","Up","Right"}
elseif GT == 'pump' then
	InB = {"DownLeft","UpLeft","Center","UpRight","DownRight"}
else
	return Def.ActorFrame{};
end


local PICLIST = {9,5,30};
local path;
local PlayerCan;
if GAMESTATE:IsCourseMode() then
	if GAMESTATE:GetCurrentCourse():IsEndless() then
		return Def.ActorFrame{};
	end
path=GAMESTATE:GetCurrentCourse():GetCourseEntry(0):GetSong():GetSongDir();
else
path=GAMESTATE:GetCurrentSong():GetSongDir();
end
if path == nil then return Def.ActorFrame{}; end
	if FILEMAN:DoesFileExist(path.."BrainIQ.lua") then
		LoadActor(path.."BrainIQ.lua");
		PlayerCan = IQ_Condition();
		if PlayerCan[1] == false and PlayerCan[2] == false then return Def.ActorFrame{}; end
	else
		return Def.ActorFrame{};
	end
if not IQBrain then return Def.ActorFrame{}; end

local t = Def.ActorFrame{};

local wai = 115;
local coll = #InB;
local Nown = 1;
local Nowi = "IDK";
local Nowt = 0;
local OPEN = false;


local PROBLEM = 0;


local DI = "IDK";
local DT = 0;
for DN = 1,#IQBrain do
	if IQBrain[DN][3] == "I" then DI = IQBrain[DN][4]; DT = IQBrain[DN][5];
	else
		if DI == "Math" then
			table.insert(IQBrain[DN],{0,0,0,"+",{},0})
			PROBLEM = PROBLEM + 1;
			local a,b,c;--LEVEL
				if IQBrain[DN][5] < 4 then a = math.random(1,9); b = math.random(1,9);
				elseif IQBrain[DN][5] == 4 then a = math.random(10,20); b = math.random(10,20);
				else a = math.random(20,50); b = math.random(20,50); end

					if IQBrain[DN][5] == 1 then
						c = a + b;
					elseif IQBrain[DN][5] == 2 then
						local OP = math.random(1,2);
						if OP == 1 then c = a+b;
						else c = a-b; IQBrain[DN][6][4] = "-" end
					else
						local OP = math.random(1,4);
						if OP == 1 then c = a+b;
						elseif OP == 2 then c = a-b; IQBrain[DN][6][4] = "-"
						elseif OP == 3 then c = a*b; IQBrain[DN][6][4] = "x"
						else
						local TOD=1;
						c = a; a = a*b; IQBrain[DN][6][4] = "/"

						end
					end
					
					IQBrain[DN][6][1] = a;
					IQBrain[DN][6][2] = b;
					IQBrain[DN][6][3] = c;




					if DT <= 2 then

						local qa,qb,qc;
						if DT == 1 then
							qa = a;qb = b;qc = c;
						elseif DT == 2 then
							qa = a;qb = c;qc = b;
						else
							qa = c;qb = b;qc = a;
						end

						for CC = 1,coll do
							local PPP = false;
							for MD = 1,#IQBrain[DN][4] do
								if coll == IQBrain[DN][4][MD][1] and CC == IQBrain[DN][4][MD][2] then
									IQBrain[DN][6][5][CC] = qc
									IQBrain[DN][6][6] = CC
									PPP = true
								end
							end
							local OMW = {math.random(1,2),math.random(1,2)}
							if not PPP then
								if OMW[1] == 1 then
									if OMW[2] == 1 then
										IQBrain[DN][6][5][CC] = qc + math.random(1,math.max(qa,2));
									else
										IQBrain[DN][6][5][CC] = qc + math.random(1,math.max(qb,2));
									end
								else
									if OMW[2] == 1 then
										IQBrain[DN][6][5][CC] = qc - math.random(1,math.max(qa,2));
									else
										IQBrain[DN][6][5][CC] = qc - math.random(1,math.max(qb,2));
									end
								end
							end
						end
					else
						local WTF = math.random(1,2)
						local choi = {};
							for ci = 1,coll do
								choi[ci] = ci;
								IQBrain[DN][6][5][ci] = 37;
							end

							for MD = 1,#IQBrain[DN][4] do
								if coll == IQBrain[DN][4][MD][1] then
									if WTF == 1 then
										IQBrain[DN][6][5][IQBrain[DN][4][MD][2]] = true
									else
										IQBrain[DN][6][5][IQBrain[DN][4][MD][2]] = false
									end
									IQBrain[DN][6][6] = IQBrain[DN][4][MD][2]
									table.remove(choi,IQBrain[DN][4][MD][2])
									for RM = 1,#IQBrain[DN][4][MD][3] do
										table.remove(choi,IQBrain[DN][4][MD][3][RM]);
									end
								end

							end


							if #choi > 0 then
								if WTF == 1 then
									IQBrain[DN][6][5][choi[math.random(1,#choi)]] = false
								else
									IQBrain[DN][6][5][choi[math.random(1,#choi)]] = true
									local bra = math.random(1,2)
										if bra == 1 then IQBrain[DN][6][3] = IQBrain[DN][6][3] + math.random(1,5)
										else IQBrain[DN][6][3] = IQBrain[DN][6][3] - math.random(1,5)  end
								end
							end
					end
		elseif 	DI == "Missing" then
			table.insert(IQBrain[DN],{0,{},{}})
			PROBLEM = PROBLEM + 1;
			--Correct {Choice} {QUEATION}
			local Cee = {Color.Red,Color.Orange,Color.Yellow,Color.Green,Color.SkyBlue,Color.Magenta,Color.Pink}
			local Nu = {};
			local Ro = {};
			for ini = 1,PICLIST[IQBrain[DN][5]] do Nu[ini] = ini;end
			for ini = 1,8 do Ro[ini] = ini; end

			for fc = 1,#IQBrain[DN][4] do
				if coll == IQBrain[DN][4][fc][1] then
					IQBrain[DN][7][1] = IQBrain[DN][4][fc][2];
				end
			end

			for pc = 1 ,coll do
				local Kormoon = {0,{1,1,1,1},0}--Pic Color Rotation
				local Rc = math.random(1,#Cee);
				local Rp = math.random(1,#Nu);
				local Rr = 0;
				if IQBrain[DN][5] == 2 then Rr = math.random(1,#Ro); Kormoon[3] = Ro[Rr] table.remove(Ro,Rr) end
				Kormoon[1] = Nu[Rp]
				if IQBrain[DN][5] ~= 3 then Kormoon[2] = Cee[Rc] table.remove(Cee,Rc) end
				table.remove(Nu,Rp)

				if pc ~= IQBrain[DN][7][1] then table.insert(IQBrain[DN][7][3],Kormoon) end
				table.insert(IQBrain[DN][7][2],Kormoon)
			end
		end
	end


--{0,0,0,"+",{},0}

end

local PnI ={};
for ppp = 1,2 do
	if GAMESTATE:IsPlayerEnabled(_G["PLAYER_"..ppp]) and PlayerCan[ppp] then
	local narin = {0,1,{0,0,0,0,0,0},0,""}--pn nown Correct Wrong Title
		narin[1] = ppp
		table.insert(PnI,narin)
		SM("THERE ARE "..PROBLEM.." kamtam?");
	end
end



local function Getpoom(event)
	if not event then return end
	if event.type == "InputEventType_FirstPress" then
		for evi = 1,2 do
			if event.PlayerNumber == _G["PLAYER_"..evi] then
				--SM(string.format("\n\n NOW MAXSC is %d\n CURRENT SCORE is %d",STATSMAN:GetCurStageStats():GetPlayerStageStats(evi-1):GetPossibleDancePoints(),STATSMAN:GetCurStageStats():GetPlayerStageStats(evi-1):GetActualDancePoints()))
				local NO1S = GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(GAMESTATE:GetSongBeat())
				local NO1D = 0;
				local NO1T = 7;
				local SCP = 0;
				local TNNS = "";
				local REPN1 = 7; for crepn = 1,#PnI do if PnI[crepn][1] == evi then REPN1 = crepn end end

				if PnI[1][2] < #IQBrain+1 then
					if IQBrain[PnI[REPN1][2]][3] == "N" or IQBrain[PnI[REPN1][2]][3] == "S" then

						if IQBrain[PnI[REPN1][2]][3] == "N" then NO1D = GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(IQBrain[PnI[REPN1][2]][2])
						elseif IQBrain[PnI[REPN1][2]][3] == "S" then NO1D = GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(IQBrain[PnI[REPN1][2]][1])
						end

						if math.abs(NO1S-NO1D) <= PREFSMAN:GetPreference("TimingWindowSecondsW1") then
							NO1T = 1; TNNS = "TapNoteScore_W1";SCP = 20;
						elseif math.abs(NO1S-NO1D) <= PREFSMAN:GetPreference("TimingWindowSecondsW2") then
							NO1T = 2; TNNS = "TapNoteScore_W2";SCP = 16;
						elseif math.abs(NO1S-NO1D) <= PREFSMAN:GetPreference("TimingWindowSecondsW3") then
							NO1T = 3; TNNS = "TapNoteScore_W3";SCP = 14;
						elseif math.abs(NO1S-NO1D) <= PREFSMAN:GetPreference("TimingWindowSecondsW4") then
							NO1T = 4; TNNS = "TapNoteScore_W4";SCP = 12;
						elseif math.abs(NO1S-NO1D) <= PREFSMAN:GetPreference("TimingWindowSecondsW5") then
							NO1T = 5; TNNS = "TapNoteScore_W5";SCP = 10;
						elseif math.abs(NO1S-NO1D) <= 0.1 then
							NO1T = 6; TNNS = "TapNoteScore_Miss";
						elseif PnI[REPN1][2] < Nown then
							NO1T = 6; TNNS = "TapNoteScore_Miss";
						end
						if NO1T ~= 7 then
							for ck = 1,coll do
								if event.button == InB[ck] then
									if (PnI[REPN1][5] == "Math" and IQBrain[PnI[REPN1][2]][6][6] == ck) or
										(PnI[REPN1][5] == "Missing" and IQBrain[PnI[REPN1][2]][7][1] == ck) then--
										PnI[REPN1][3][NO1T] = PnI[REPN1][3][NO1T] + 1
										MESSAGEMAN:Broadcast("IQAns", {Cor = true, Notto= PnI[REPN1][2], PPN= PnI[REPN1][1], COLN= ck,JUD = NO1T})
										MESSAGEMAN:Broadcast("Judgment", {Cor = true, TapNoteScore = TNNS, Player= "PlayerNumber_P"..PnI[REPN1][1],TapNoteOffset = NO1S-NO1D,Early = NO1S-NO1D < 0 and true or false})
																			STATSMAN:GetCurStageStats():GetPlayerStageStats(evi-1):SetDancePointLimits(
										STATSMAN:GetCurStageStats():GetPlayerStageStats(evi-1):GetActualDancePoints()
										+SCP
										,
										STATSMAN:GetCurStageStats():GetPlayerStageStats(evi-1):GetPossibleDancePoints()
										)
									else
										PnI[REPN1][4] = PnI[REPN1][4] + 1
										MESSAGEMAN:Broadcast("IQAns", {Cor = false, Notto= PnI[REPN1][2], PPN= PnI[REPN1][1], COLN= ck,JUD = NO1T})
										MESSAGEMAN:Broadcast("Judgment", {Cor = false, TapNoteScore = "TapNoteScore_Miss", Player= "PlayerNumber_P"..PnI[REPN1][1],TapNoteOffset = NO1S-NO1D,Early = NO1S-NO1D < 0 and true or false})
																			STATSMAN:GetCurStageStats():GetPlayerStageStats(evi-1):SetDancePointLimits(
										STATSMAN:GetCurStageStats():GetPlayerStageStats(evi-1):GetActualDancePoints()
										-10
										,
										STATSMAN:GetCurStageStats():GetPlayerStageStats(evi-1):GetPossibleDancePoints()
										)
									end
									--NPK
								end
							end
							PnI[REPN1][2] = PnI[REPN1][2]+1;
						end
					end
				end
				--SCREENMAN:SystemMessage(string.format("P1:%d {%d,%d,%d,%d,%d,%d} %d\nDelta %.2f",PnI[1][2],PnI[1][3][1],PnI[1][3][2],PnI[1][3][3],PnI[1][3][4],PnI[1][3][5],PnI[1][3][6],PnI[1][4],(NO1S-NO1D)));
			end
		end
	end
end

t[#t+1] = Def.Quad{--Control Panal
	OnCommand=function(self)
		for DI = 1,#PnI do
			GAMESTATE:GetPlayerState(_G["PLAYER_"..PnI[DI][1]]):GetPlayerOptions('ModsLevel_Song'):XMod(IQSPEED,999)
			GAMESTATE:GetPlayerState(_G["PLAYER_"..PnI[DI][1]]):GetPlayerOptions('ModsLevel_Song'):Cover(0,999)
					STATSMAN:GetCurStageStats():GetPlayerStageStats(PnI[DI][1]-1):SetDancePointLimits(
										STATSMAN:GetCurStageStats():GetPlayerStageStats(PnI[DI][1]-1):GetActualDancePoints()
										,
										STATSMAN:GetCurStageStats():GetPlayerStageStats(PnI[DI][1]-1):GetPossibleDancePoints()
										+PROBLEM*20
										)
		end
		SCREENMAN:GetTopScreen():AddInputCallback(Getpoom)
		self:visible(false)
	end;
};

local IntN = 1;


t[#t+1] = Def.Quad{--InitNote
	OnCommand=function(self)
		self:playcommand("Nepu"):visible(false)
	end;
	NepuCommand=function(self)
		if (GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(GAMESTATE:GetSongBeat()))
			>= (GAMESTATE:GetCurrentSong():GetTimingData():GetElapsedTimeFromBeat(IQBrain[IntN][2])
			-((SCREEN_BOTTOM+32+32)/(GAMESTATE:GetCurrentSong():GetTimingData():GetBPMAtBeat(IQBrain[IntN][2])*IQSPEED))
			+((wai+32)/(GAMESTATE:GetCurrentSong():GetTimingData():GetBPMAtBeat(IQBrain[IntN][2])*IQSPEED)))
		then
			--SCREENMAN:SystemMessage('YES '..IntN);
			if IQBrain[IntN][3] == "N" then

				MESSAGEMAN:Broadcast("PREC",{NOOTO = IntN})
			end
			IntN = IntN + 1;
		end
		if IntN <= #IQBrain then
			self:sleep(0.02):queuecommand("Nepu")
		end
	end;
};

--[[for m= 1,#PnI do
	t[#t+1] =Def.ActorFrame{
		OnCommand=function(self) self:x(SCREEN_CENTER_X); self:y(0); end;

	 Def.Quad{
		OnCommand=function(self) self:x(64*(-1.5)); self:y(wai); self:zoom(60); self:diffuse(color("#FF8495")); end;
	};
	 Def.Quad{
		OnCommand=function(self) self:x(64*(-.5)); self:y(wai); self:zoom(60); self:diffuse(color("#FFFF88")); end;
	};
	 Def.Quad{
		OnCommand=function(self) self:x(64*(.5)); self:y(wai); self:zoom(60); self:diffuse(color("#8799FF")); end;
	};
	 Def.Quad{
		OnCommand=function(self) self:x(64*(1.5)); self:y(wai); self:zoom(60); self:diffuse(color("#72FF89")); end;
	};
};
end]]


--QUEATION STUFF


local GET = "IDK";
local BGET = "IDK";
local GETT = 0;
local STT = "";
for i = 1,#IQBrain do
	for np = 1,#PnI do
		for nc = 1,coll do
			if IQBrain[i][3] == "N" then
				for ch =1,#IQBrain[i][4] do if IQBrain[i][4][ch][1] == coll then
					if #IQBrain[i][4][ch][3] ~= 0 then for hid =1,#IQBrain[i][4][ch][3] do if nc == IQBrain[i][4][ch][3][hid] then GET = "HAIPAI"; end end end end end

				if GET == "Math" then
					if (GETT > 2 and IQBrain[i][6][5][nc] ~= 37) or GETT <= 2 then

					t[#t+1] = Def.ActorFrame{
						InitCommand=function(self) self:y(SCREEN_BOTTOM+32); end;--IQBrain[i][2]
						OnCommand=function(self) self:x((SCREENMAN:GetTopScreen():GetChild('PlayerP'..PnI[np][1]):GetX())+(256/coll)*(nc-((coll+1)/2))); end;
						PRECMessageCommand=function(self,param)
							if param.NOOTO == i then
							--[[self:sleep()]]
							self:linear((SCREEN_BOTTOM+32+32)/(GAMESTATE:GetCurrentSong():GetTimingData():GetBPMAtBeat(IQBrain[i][2])*IQSPEED)):y(-32);
							end
						end;
						IQAnsMessageCommand=function(self,param)
						--Cor Notto PPN COLN JUD
							if param.PPN == PnI[np][1] and param.Notto == i and param.COLN == nc then
								if param.JUD <= 3 then
									self:finishtweening():y(wai):diffusealpha(1.0):zoom(1.0):linear(0.15):diffusealpha(0.9):zoom(1.15):linear(0.15):diffusealpha(0.0):zoom(1.3)
								else
									self:diffusealpha(0)
								end
							end
						end;

						LoadActor("CHOICE")..{
							OnCommand=function(self) self:zoom(((256/coll)-4)/60); self:diffuse(color("#3355FF")); end;
						};
						LoadFont("_double pixel-7 28px")..{
							OnCommand=function(self)
							if type(IQBrain[i][6][5][nc]) == "boolean" then
							if IQBrain[i][6][5][nc] then self:settext("O"):zoom(1.5):diffuse(Color.Green) else self:settext("X"):zoom(1.5):diffuse(Color.Red) end
							else self:settext(IQBrain[i][6][5][nc]):diffuse(color("#994477")) if math.abs(IQBrain[i][6][5][nc]) <= 99 then self:zoom(1.8) elseif math.abs(IQBrain[i][6][5][nc]) <= 999 then self:zoom(1.5) else self:zoom(1) end if IQBrain[i][6][5][nc] < 0 then self:zoom(self:GetZoom()*0.8) end end
							self:addx(2):addy(2):addy(-5)
							end;
						};
						LoadFont("_double pixel-7 28px")..{
							OnCommand=function(self)
							if type(IQBrain[i][6][5][nc]) == "boolean" then
							if IQBrain[i][6][5][nc] then self:settext("O"):zoom(1.5):diffuse(Color.Green) else self:settext("X"):zoom(1.5):diffuse(Color.Red) end
							else self:settext(IQBrain[i][6][5][nc]):diffuse(color("#FF77AA")) if math.abs(IQBrain[i][6][5][nc]) <= 99 then self:zoom(1.8) elseif math.abs(IQBrain[i][6][5][nc]) <= 999 then self:zoom(1.5) else self:zoom(1) end if IQBrain[i][6][5][nc] < 0 then self:zoom(self:GetZoom()*0.8) end end
							self:addy(-5)
							end;
						};
					};
					end
				--else
				elseif GET == "Missing" then
					t[#t+1] = Def.ActorFrame{
						InitCommand=function(self) self:y(SCREEN_BOTTOM+32); self:zoom(((256/coll)-4)/60); end;--IQBrain[i][2]
						OnCommand=function(self) self:x((SCREENMAN:GetTopScreen():GetChild('PlayerP'..PnI[np][1]):GetX())+(256/coll)*(nc-((coll+1)/2))); end;
						PRECMessageCommand=function(self,param)
							if param.NOOTO == i then
							self:linear((SCREEN_BOTTOM+32+32)/(GAMESTATE:GetCurrentSong():GetTimingData():GetBPMAtBeat(IQBrain[i][2])*IQSPEED)):y(-32);
							end
						end;
						IQAnsMessageCommand=function(self,param)
							if param.PPN == PnI[np][1] and param.Notto == i and param.COLN == nc then
								if param.JUD <= 3 then
									self:finishtweening():y(wai):diffusealpha(1.0):zoom(1.0):linear(0.15):diffusealpha(0.9):zoom(1.15):linear(0.15):diffusealpha(0.0):zoom(1.3)
								else
									self:diffusealpha(0)
								end
							end
						end;

						LoadActor("CHOICE")..{
							OnCommand=function(self) self:zoom(1); self:diffuse(color("#2255FF")); end;
						};
						LoadFont("_double pixel-7 28px")..{
							Condition=(IQBrain[i][5]==1);
							OnCommand=function(self)
							self:settext(IQBrain[i][7][2][nc][1])
							self:diffuse(IQBrain[i][7][2][nc][2])
							self:rotationz(IQBrain[i][7][2][nc][3]*45)
							self:addx(2):addy(2):addy(-5):zoom(1.5)
							end;
						};
						Def.Sprite{
							Condition=(IQBrain[i][5]~=1);
							OnCommand=function(self)
							self:Load("/Themes/"..ThemeNamae().."/BGAnimations/ScreenGameplay overlay/IQ/IconStuff/Type"..tostring(IQBrain[i][5]).."/"..tostring(IQBrain[i][7][2][nc][1])..".png")
							self:diffuse(IQBrain[i][7][2][nc][2])
							self:rotationz(IQBrain[i][7][2][nc][3]*45)
							if IQBrain[i][5]==3 then self:zoom(60/256/2) else self:zoom(.8) end
							end;
						};
						Def.Sprite{
							Condition=(IQBrain[i][5]~=1 and FILEMAN:DoesFileExist("/Themes/"..ThemeNamae().."/BGAnimations/ScreenGameplay overlay/IQ/IconStuff/Type"..tostring(IQBrain[i][5]).."/"..tostring(IQBrain[i][7][2][nc][1]).."-O.png"));
							OnCommand=function(self)
							self:Load("/Themes/"..ThemeNamae().."/BGAnimations/ScreenGameplay overlay/IQ/IconStuff/Type"..tostring(IQBrain[i][5]).."/"..tostring(IQBrain[i][7][2][nc][1]).."-O.png")
							self:rotationz(IQBrain[i][7][2][nc][3]*45)
							if IQBrain[i][5]==3 then self:zoom(60/256/2) else self:zoom(.8) end
							end;
						};
					};
				--OTHER GAME
				elseif GET == "HAIPAI" then
					GET = BGET
				end
			else
			BGET = IQBrain[i][4];
			GET = IQBrain[i][4];
			GETT = IQBrain[i][5];
			end
		end
	end
end
--SCREENMAN:SystemMessage(type(true))

--PN STUFF
for np = 1,#PnI do
	for nc = 1,coll do
		t[#t+1] = LoadActor("_flash")..{
			OnCommand=function(self) self:x((SCREENMAN:GetTopScreen():GetChild('PlayerP'..PnI[np][1]):GetX())+(256/coll)*(nc-((coll+1)/2))); self:y(wai); self:blend("BlendMode_Add"); self:diffusealpha(0); end;
			IQAnsMessageCommand=function(self,param)
				if param.PPN == PnI[np][1] and param.COLN == nc and param.JUD <= 2 then
					self:finishtweening():diffusealpha(1):zoom(1):linear(0.2):diffusealpha(0):zoom(1.2)
				end
			end;
		};
	end
end

	t[#t+1] =Def.ActorFrame{--REAL Control Panal
		InitCommand=function(self) self:Center(); self:playcommand("JOD"); end;
		JODCommand=function(self)
			local camsang = self:GetChildren();

			if GAMESTATE:GetSongBeat() > IQBrain[Nown][1] and IQBrain[Nown][3] == "I" then
				if GAMESTATE:GetSongBeat() < IQBrain[Nown][2] and not OPEN then
					camsang.FRAME:decelerate(0.5):zoomy(SCREEN_CENTER_Y*0.9)
					Nowi = IQBrain[Nown][4]
					Nowt = IQBrain[Nown][5]
					if IQBrain[Nown][4] == "Math" then
						if IQBrain[Nown][5] == 1 then
							camsang.Say:settext("Solve all Equation(s)\nCorrectly.")
						elseif IQBrain[Nown][5] == 2 then
							camsang.Say:settext("Find all \"?\" in\neach Equation(s) Correctly.")
						elseif IQBrain[Nown][5] == 3 then
							camsang.Say:settext("Look these Equation(s)\nIf Correct Ans \"O\"\nIf it not Ans \"X\"")
						end
					elseif IQBrain[Nown][4] == "Missing" then
						camsang.Say:settext("Look all of THESE Symbol\nRemember and Step\nthe symbol that not APPEAR!")
					end
					camsang.Say:sleep(0.5):linear(0.5):cropright(0)
						for DI = 1,#PnI do
							GAMESTATE:GetPlayerState(_G["PLAYER_"..PnI[DI][1]]):GetPlayerOptions('ModsLevel_Song'):Cover(0.8,1)
						end
					OPEN = true;
				elseif GAMESTATE:GetSongBeat() > IQBrain[Nown][2] and OPEN then
					camsang.FRAME:decelerate(0.5):zoomy(0)
					camsang.Say:linear(0.5):cropright(1)
					OPEN = false;

					for Pnn = 1,#PnI do  PnI[Pnn][2] = PnI[Pnn][2] + 1; PnI[Pnn][5] = IQBrain[Nown][4]; end
						for DI = 1,#PnI do
							GAMESTATE:GetPlayerState(_G["PLAYER_"..PnI[DI][1]]):GetPlayerOptions('ModsLevel_Song'):Cover(0,1)
						end
					Nown = Nown + 1
				end
			elseif GAMESTATE:GetSongBeat() > IQBrain[Nown][1] and IQBrain[Nown][3] == "N" then
				if GAMESTATE:GetSongBeat() < IQBrain[Nown][2] and not OPEN then
					if Nowi == "Math" then
						camsang.FRAMELek:decelerate(0.5):zoomx(SCREEN_RIGHT*0.8)

						if Nowt == 1 then
							camsang.SayNoi:settextf("%d %s %d = ?",IQBrain[Nown][6][1],IQBrain[Nown][6][4],IQBrain[Nown][6][2])
						elseif Nowt == 2 then
							local fff = math.random(1,3);
							if (IQBrain[Nown][6][4] ~= "-" and IQBrain[Nown][6][4] ~= "/") and fff < 3 then
								camsang.SayNoi:settextf("? %s %d = %d",IQBrain[Nown][6][4],IQBrain[Nown][6][1],IQBrain[Nown][6][3])
							else
								camsang.SayNoi:settextf("%d %s ? = %d",IQBrain[Nown][6][1],IQBrain[Nown][6][4],IQBrain[Nown][6][3])
							end
						elseif Nowt == 3 then
							camsang.SayNoi:settextf("%d %s %d = %d",IQBrain[Nown][6][1],IQBrain[Nown][6][4],IQBrain[Nown][6][2],IQBrain[Nown][6][3])
						end
						camsang.SayNoi:cropright(0)
					elseif Nowi == "Missing" then
						camsang.RailWay:decelerate(0.5):zoomx(70)
						MESSAGEMAN:Broadcast("IQQue", {nnn = Nown})
					end
						for DI = 1,#PnI do
							GAMESTATE:GetPlayerState(_G["PLAYER_"..PnI[DI][1]]):GetPlayerOptions('ModsLevel_Song'):Cover(0.95,1)
						end
					OPEN = true;
				elseif GAMESTATE:GetSongBeat() > IQBrain[Nown][2] and OPEN then
					--SCREENMAN:SystemMessage("Pass IQBrain")
					local RESET = false
					if Nown == #IQBrain then --nothing
						RESET = true
						Nown = Nown + 1; OPEN = false
						for DI = 1,#PnI do
							GAMESTATE:GetPlayerState(_G["PLAYER_"..PnI[DI][1]]):GetPlayerOptions('ModsLevel_Song'):Cover(0,1)
						end
					elseif IQBrain[Nown+1][3] == "I" then
						Nown = Nown + 1; OPEN = false
						RESET = true
						for DI = 1,#PnI do
							GAMESTATE:GetPlayerState(_G["PLAYER_"..PnI[DI][1]]):GetPlayerOptions('ModsLevel_Song'):Cover(0,1)
						end
					elseif IQBrain[Nown+1][1] - IQBrain[Nown][2] <= 4 then
						camsang.SayNoi:sleep(0.5):cropright(1)
						Nown = Nown + 1; OPEN = false
					else
						RESET = true
						Nown = Nown + 1; OPEN = false
						for DI = 1,#PnI do
							GAMESTATE:GetPlayerState(_G["PLAYER_"..PnI[DI][1]]):GetPlayerOptions('ModsLevel_Song'):Cover(0,1)
						end
					end

					if RESET then
						camsang.SayNoi:linear(0.25):cropright(1)
						camsang.FRAMELek:decelerate(0.5):zoomx(0)
						camsang.RailWay:decelerate(0.5):zoomx(0)
					end
				end
			end
			if Nown ~= #IQBrain+1 then
				self:sleep(0.02):queuecommand("JOD")
			end
		end;
		Def.Quad{
			Name = "FRAME";
			InitCommand=function(self) self:diffuse(color("#6699FFAA")); self:diffusebottomedge(color("#6699FF55")); self:zoomx(SCREEN_RIGHT*0.9); self:zoomy(0); end;

		};
		LoadFont("_double pixel-7 28px")..{
			Name = "Say";
			InitCommand=function(self) self:zoom(2); self:cropright(1); end;
		};


		Def.Quad{
			Name = "FRAMELek";
			InitCommand=function(self) self:diffuse(color("#66FF99AA")); self:diffusebottomedge(color("#6699FF55")); self:zoomx(0); self:zoomy(SCREEN_CENTER_Y*0.5); end;
		};
		Def.Quad{
			Name = "RailWay";
			InitCommand=function(self) self:diffuse(color("#66FF99AA")); self:diffusebottomedge(color("#6699FF55")); self:zoomx(0); self:zoomy(SCREEN_CENTER_Y*2); end;
		};
		LoadFont("_double pixel-7 28px")..{
			Name = "SayNoi";
			InitCommand=function(self) self:zoom(2); self:settext("HELOOOOOOO"); self:cropright(1); end;
		};

	};

	local QI = "";
	local QT = 0;
for i = 1,#IQBrain do
	for nc = 1,(coll-1) do
	if IQBrain[i][3] == "I" then QI = IQBrain[i][4]; QT = IQBrain[i][5] or 0;
	else
		if QI == "Missing" then
		t[#t+1] = Def.ActorFrame{
			OnCommand=function(self)
				self:CenterX():y(-40):zoom(((256/coll)-4)/60)
			end;
			IQQueMessageCommand=function(self,param)
				if param.nnn == i then
					self:sleep(0.35*nc-0.05*IQBrain[i][6]):linear(3.5-0.5*IQBrain[i][6]):y(SCREEN_BOTTOM+40)
				end
			end;
						LoadActor("CHOICE")..{
							OnCommand=function(self) self:zoom(((256/coll)-4)/60); self:diffuse(color("#2255FF")); end;
						};
						LoadFont("_double pixel-7 28px")..{
							Condition=(IQBrain[i][5]==1);
							OnCommand=function(self)
							self:settext(IQBrain[i][7][3][nc][1])
							self:diffuse(IQBrain[i][7][3][nc][2])
							self:rotationz(IQBrain[i][7][3][nc][3]*45)
							self:addy(-5):zoom(1.5)
							end;
						};
						Def.Sprite{
							Condition=(IQBrain[i][5]~=1);
							OnCommand=function(self)
							self:Load("/Themes/"..ThemeNamae().."/BGAnimations/ScreenGameplay overlay/IQ/IconStuff/Type"..tostring(IQBrain[i][5]).."/"..tostring(IQBrain[i][7][3][nc][1])..".png")
							self:diffuse(IQBrain[i][7][3][nc][2])
							self:rotationz(IQBrain[i][7][3][nc][3]*45)
							if IQBrain[i][5]==3 then self:zoom(60/256/2) else self:zoom(.8) end
							end;
						};
						Def.Sprite{
							Condition=(IQBrain[i][5]~=1 and FILEMAN:DoesFileExist("/Themes/"..ThemeNamae().."/BGAnimations/ScreenGameplay overlay/IQ/IconStuff/Type"..tostring(IQBrain[i][5]).."/"..tostring(IQBrain[i][7][3][nc][1]).."-O.png"));
							OnCommand=function(self)
							self:Load("/Themes/"..ThemeNamae().."/BGAnimations/ScreenGameplay overlay/IQ/IconStuff/Type"..tostring(IQBrain[i][5]).."/"..tostring(IQBrain[i][7][3][nc][1]).."-O.png")
							self:rotationz(IQBrain[i][7][3][nc][3]*45)
							if IQBrain[i][5]==3 then self:zoom(60/256/2) else self:zoom(.8) end
							end;
						};
		};
		end
		end
	end
end


--DE BUG

--[[t[#t+1] = LoadFont("Common Normal")..{
	OnCommand=function(self) self:CenterX(); self:y(SCREEN_BOTTOM*.95); self:settext("Nep"); self:playcommand("May"); end;
	MayCommand=function(self)

		self:settextf("BEAT : %.2f\nNown : %d",GAMESTATE:GetSongBeat(),Nown)

		self:sleep(0.02):queuecommand("May")
	end;
}]]

return t;
