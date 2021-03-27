local function strpl(I,a)
	return I..","..a
end;
local PN = PLAYER_1;
local Bpms = {};
local t = Def.ActorFrame{};
local w = {};

local function Sp2Cl(Sp)
if Sp < 300 then
return color("0.2,1,0.2,1")
elseif Sp >= 300 and Sp < 600 then
return color(0.2+(((Sp-300)/300)*0.8)..",1,0.2,1")
elseif Sp >= 600 and Sp < 900 then
return color("1,"..(1-(((Sp-600)/300)*0.8))..",0.2,1")
elseif Sp >= 900 then
return color("1,0.2,0.2,1")
end
end;

local function N2P(n)
if n == 1 then
return ""
else
return string.format("%d",math.floor(n*100)).."% "
end
end;


function Xbarrr(S)
local Re=0;
for i = 1,#S do
	Re = Re+S[i]
end
	return Re/#S
end;
local modslevel = topscreen  == "ScreenEditOptions" and "ModsLevel_Stage" or "ModsLevel_Preferred"
local Op1 = GAMESTATE:GetPlayerState(PN):GetCurrentPlayerOptions(modslevel);

local n1 = 1;

local sec1 = {};
sec1[#sec1+1] = 1

local i1 = 1;

local STR = {};
local STRC = {};

t[#t+1] =Def.ActorFrame{
	OnCommand=function(self)

		local Isla = "";

	end;
};



t[#t+1] = Def.Quad{
	InitCommand=cmd(visible,false);
	OnCommand=function(self)
			local Isla = "";
			if Op1:CMod() then
				Isla = "C"..string.format("%d",Op1:CMod())
			elseif Op1:MMod() then
				Isla = "m"..string.format("%d",Op1:MMod())
			elseif Op1:XMod() then
				Isla = string.format("%.2f",Op1:XMod()).."x"
			end

				Isla = strpl(Isla,Op1:NoteSkin());
				Isla = strpl(Isla,TP[ToEnumShortString(PN)].ActiveModifiers.JudgmentGraphic or "tor12315za");
				if Op1:Cover()*100 ~= 0 then
				Isla = strpl(Isla,N2P(Op1:Cover()).."Hide Background");
				end

				if Op1:Overhead() then
				Isla = strpl(Isla,"OverHead");
				elseif Op1:Hallway() then
				Isla = strpl(Isla,N2P(Op1:Hallway()).."Hallway");
				elseif Op1:Distant() then
				Isla = strpl(Isla,N2P(Op1:Distant()).."Distant");
				elseif Op1:Incoming() then
				Isla = strpl(Isla,N2P(Op1:Incoming()).."Incoming");
				elseif Op1:Space() then
				Isla = strpl(Isla,N2P(Op1:Space()).."Space");
				end

				if 	Op1:Alternate() ~= 0 or
				Op1:Beat() ~= 0 or
				Op1:Big() or
				Op1:Blink() ~= 0 or
				Op1:Blind() ~= 0 or
				Op1:Boomerang() ~= 0 or
				Op1:Boost() ~= 0 or
				Op1:Brake() ~= 0 or
				Op1:Bumpy() ~= 0 or
				Op1:Centered() ~= 0 or
				Op1:Confusion() ~= 0 or
				Op1:Cross() ~= 0 or
				Op1:Dark() ~= 0 or
				Op1:Dizzy() ~= 0 or
				Op1:Drunk() ~= 0 or
				Op1:Echo() or
				Op1:Expand() ~= 0 or
				Op1:Flip() ~= 0 or
				Op1:Hidden() ~= 0 or
				Op1:HiddenOffset() ~= 0 or
				Op1:Invert() ~= 0 or
				Op1:Left() or
				Op1:Little() or
				Op1:Mini() ~= 0 or
				Op1:Mirror() or
				not Op1:NoAttack() or
				Op1:NoFakes() or
				Op1:NoHolds() or
				Op1:NoJumps() or
				Op1:NoHands() or
				Op1:NoLifts() or
				Op1:NoQuads() or
				Op1:NoStretch() or
				Op1:NoMines() or
				Op1:NoRolls() or
				Op1:Reverse() ~= 0 or
				Op1:RandomVanish() ~= 0 or
				Op1:Right() or
				Op1:Roll() ~= 0 or
				Op1:Shuffle() or
				Op1:Skippy() or
				Op1:SoftShuffle() or
				Op1:Split() ~= 0 or
				Op1:Stealth() ~= 0 or
				Op1:Stomp() or
				Op1:Sudden() ~= 0 or
				Op1:SuddenOffset() ~= 0 or
				Op1:SuperShuffle() or
				Op1:Tiny() ~= 0 or
				Op1:Tipsy() ~= 0 or
				Op1:Tornado() ~= 0 or
				Op1:Twirl() ~= 0 or
				Op1:Twister() or
				Op1:Quick() or
				Op1:BMRize() or
				Op1:Wave() ~= 0 or
				Op1:Xmode() ~= 0
			then
				Isla = strpl(Isla,"And more...");
			end
			STR[#STR+1] = Isla;
			STRC[#STRC+1] = PlayerColor(PN);

			--222222222222

			Isla = "";
			local fc = true;

			if Op1:Alternate() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Alternate()).."Alternate" else 
			Isla = strpl(Isla,N2P(Op1:Alternate()).."Alternate") end end

			if Op1:Cross() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Cross()).."Cross" else 
			Isla = strpl(Isla,N2P(Op1:Cross()).."Cross") end end

			if Op1:Split() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Split()).."Split" else 
			Isla = strpl(Isla,N2P(Op1:Split()).."Split") end end

			if Op1:Reverse() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Reverse()).."Reverse" else 
			Isla = strpl(Isla,N2P(Op1:Reverse()).."Reverse") end end

			if Op1:Centered() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Centered()).."Centered" else 
			Isla = strpl(Isla,N2P(Op1:Centered()).."Centered") end end


			if Op1:Mirror() then if fc then fc = false;
			Isla = "Mirror" else 
			Isla = strpl(Isla,"Mirror") end end

			if Op1:Left() then if fc then fc = false;
			Isla = "Step Left" else 
			Isla = strpl(Isla,"Step Left") end end

			if Op1:Right() then if fc then fc = false;
			Isla = "Step Right" else 
			Isla = strpl(Isla,"Step Right") end end

			if Op1:Shuffle() then if fc then fc = false;
			Isla = "Shuffle" else 
			Isla = strpl(Isla,"Shuffle") end end

			if Isla ~= "" then 
				STR[#STR+1] = Isla; 
				STRC[#STRC+1] = Color.Green or {0,1,0,1};
			end
			
			--33333333

			Isla = "";
			fc = true;


			if Op1:Boost() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Boost()).."Boost" else 
			Isla = strpl(Isla,N2P(Op1:Boost()).."Boost") end end

			if Op1:Brake() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Brake()).."Brake" else 
			Isla = strpl(Isla,N2P(Op1:Brake()).."Brake") end end

			if Op1:Expand() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Expand()).."Expand" else 
			Isla = strpl(Isla,N2P(Op1:Expand()).."Expand") end end

			if Op1:Boomerang() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Boomerang()).."Boomerang" else 
			Isla = strpl(Isla,N2P(Op1:Boomerang()).."Boomerang") end end

			if Op1:Wave() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Wave()).."Wave" else 
			Isla = strpl(Isla,N2P(Op1:Wave()).."Wave") end end

			if Isla ~= "" then 
				STR[#STR+1] = Isla; 
				STRC[#STRC+1] = Color.Orange or {1,0.5,0,1};
			end
			
			--4444444

			Isla = "";
			fc = true;

			if Op1:Drunk() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Drunk()).."Drunk" else 
			Isla = strpl(Isla,N2P(Op1:Drunk()).."Drunk") end end

			if Op1:Dizzy() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Dizzy()).."Dizzy" else 
			Isla = strpl(Isla,N2P(Op1:Dizzy()).."Dizzy") end end

			if Op1:Confusion() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Confusion()).."Confusion" else 
			Isla = strpl(Isla,N2P(Op1:Confusion()).."Confusion") end end

			if Op1:Mini() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Mini()).."Mini" else 
			Isla = strpl(Isla,N2P(Op1:Mini()).."Mini") end end

			if Op1:Flip() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Flip()).."Flip" else 
			Isla = strpl(Isla,N2P(Op1:Flip()).."Flip") end end

			if Op1:Invert() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Invert()).."Invert" else 
			Isla = strpl(Isla,N2P(Op1:Invert()).."Invert") end end

			if Op1:Tornado() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Tornado()).."Tornado" else 
			Isla = strpl(Isla,N2P(Op1:Tornado()).."Tornado") end end

			if Op1:Tipsy() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Tipsy()).."Tipsy" else 
			Isla = strpl(Isla,N2P(Op1:Tipsy()).."Tipsy") end end

			if Op1:Bumpy() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Bumpy()).."Bumpy" else 
			Isla = strpl(Isla,N2P(Op1:Bumpy()).."Bumpy") end end

			if Op1:Beat() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Beat()).."Beat" else 
			Isla = strpl(Isla,N2P(Op1:Beat()).."Beat") end end

			if Op1:AttackMines() then if fc then fc = false;
			Isla = "AttackMines" else 
			Isla = strpl(Isla,"AttackMines") end end

			if Isla ~= "" then 
				STR[#STR+1] = Isla; 
				STRC[#STRC+1] = Color.Purple or {1,0,1,1};
			end

			--55555555

			Isla = "";
			fc = true;

			if Op1:Hidden() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Hidden()).."Hidden" else 
			Isla = strpl(Isla,N2P(Op1:Hidden()).."Hidden") end end

			if Op1:Sudden() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Sudden()).."Sudden" else 
			Isla = strpl(Isla,N2P(Op1:Sudden()).."Sudden") end end

			if Op1:Blink() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Blink()).."Blink" else 
			Isla = strpl(Isla,N2P(Op1:Blink()).."Blink") end end

			if Op1:RandomVanish() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:RandomVanish()).."R.Vanish" else 
			Isla = strpl(Isla,N2P(Op1:RandomVanish()).."R.Vanish") end end

			if Op1:Blind() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Blind()).."Blind" else 
			Isla = strpl(Isla,N2P(Op1:Blind()).."Blind") end end

			if Op1:Dark() ~= 0 then if fc then fc = false;
			Isla = N2P(Op1:Dark()).."Dark" else 
			Isla = strpl(Isla,N2P(Op1:Dark()).."Dark") end end

			if Isla ~= "" then 
				STR[#STR+1] = Isla; 
				STRC[#STRC+1] = Color.Blue or {0,0,1,1};
			end

			--666666666

			Isla = "";
			fc = true;

			if Op1:Wide() then if fc then fc = false;
			Isla = "Wide" else 
			Isla = strpl(Isla,"Wide") end end

			if Op1:Big() then if fc then fc = false;
			Isla = "Big" else 
			Isla = strpl(Isla,"Big") end end

			if Op1:Quick() then if fc then fc = false;
			Isla = "Quick" else 
			Isla = strpl(Isla,"Quick") end end

			if Op1:BMRize() then if fc then fc = false;
			Isla = "BMRize" else 
			Isla = strpl(Isla,"BMRize") end end

			if Op1:Skippy() then if fc then fc = false;
			Isla = "Skippy" else 
			Isla = strpl(Isla,"Skippy") end end

			if Op1:Echo() then if fc then fc = false;
			Isla = "Echo" else 
			Isla = strpl(Isla,"Echo") end end

			if Op1:Stomp() then if fc then fc = false;
			Isla = "Stomp" else 
			Isla = strpl(Isla,"Stomp") end end

			if Isla ~= "" then 
				STR[#STR+1] = Isla; 
				STRC[#STRC+1] = Color.Red or {1,0,0,1};
			end

			--7777777

			Isla = "";
			fc = true;

			if Op1:NoFakes() then if fc then fc = false;
			Isla = "No Fakes" else 
			Isla = strpl(Isla,"No Fakes") end end

			if Op1:NoHands() then if fc then fc = false;
			Isla = "No Hands" else 
			Isla = strpl(Isla,"No Hands") end end

			if Op1:NoHolds() then if fc then fc = false;
			Isla = "No Holds" else 
			Isla = strpl(Isla,"No Holds") end end

			if Op1:NoJumps() then if fc then fc = false;
			Isla = "No Jumps" else 
			Isla = strpl(Isla,"No Jumps") end end

			if Op1:NoLifts() then if fc then fc = false;
			Isla = "No Lifts" else 
			Isla = strpl(Isla,"No Lifts") end end

			if Op1:NoQuads() then if fc then fc = false;
			Isla = "No Quads" else 
			Isla = strpl(Isla,"No Quads") end end

			if Op1:NoRolls() then if fc then fc = false;
			Isla = "No Rolls" else 
			Isla = strpl(Isla,"No Rolls") end end

			if Op1:NoStretch() then if fc then fc = false;
			Isla = "No Stretch" else 
			Isla = strpl(Isla,"No Stretch") end end

			if Op1:NoMines() then if fc then fc = false;
			Isla = "No Mines" else 
			Isla = strpl(Isla,"No Mines") end end

			if Isla ~= "" then 
				STR[#STR+1] = Isla; 
				STRC[#STRC+1] = Color.Green or {0,1,0,1};
			end

		end;
};

local LoopI = 1;

t[#t+1] = LoadFont("Common Normal")..{
	InitCommand=cmd(x,10;y,7;zoom,0.8*0.6;horizalign,left);
	OnCommand=function(self)

		self:settext(STR[1]):diffuse(STRC[1])

		if #STR > 1 then
			self:sleep(math.random(1,15)/10+7);
			self:accelerate(0.5)
			self:rotationx(90);
			LoopI = math.mod(LoopI + 1 - 1,#STR)+1;
			self:queuecommand("Loopu");
		end
	end;
	LoopuCommand=function(self)
		--SM("\n\n\n\n LOOPUUU"..LoopI)
		self:decelerate(0.5)
		self:settext(STR[LoopI]):diffuse(STRC[LoopI])
		self:rotationx(0);

		self:sleep(math.random(1,15)/10+5);
		self:accelerate(0.5)
		self:rotationx(90);
		LoopI = math.mod(LoopI + 1 - 1,#STR)+1;
		self:queuecommand("Loopu");
	end;
}
return t;
