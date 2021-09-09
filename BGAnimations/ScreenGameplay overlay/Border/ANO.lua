--SM("\n\n\n\n\n"..TP.GamePlay.Mode)
local ISLA = Def.ActorFrame{
		--|line man..(P1)
	LoadActor("Under lay2")..{
		InitCommand=cmd(FullScreen;y,SCREEN_CENTER_Y+10;SetTextureFiltering,false;);
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Nep");
		NepCommand=function(self)
			if TP.GamePlay.Mode == "Battle" then
				self:diffuse(Color.Blue or color("#5555FF"))
			elseif TP.GamePlay.Mode == "Mission" and false then
				self:diffuse(color("#777777"))
			elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
				self:diffuse({1,1,1,1})
				self:diffuseupperright(Diff2Cl(GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty(),1))
				self:diffuseupperleft(Diff2Cl(GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty(),1))
			elseif GAMESTATE:IsPlayerEnabled(PLAYER_1) then
				self:diffuse(Diff2Cl(GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty(),1))
			elseif GAMESTATE:IsPlayerEnabled(PLAYER_2) then
				self:diffuse(Diff2Cl(GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty(),1))
			end
		end;
	};
    LoadActor("TimeBar.png")..{
		InitCommand=cmd(FullScreen;y,SCREEN_CENTER_Y+10;SetTextureFiltering,false;diffuse,{0,0,0,1});
	};


};


local x=Def.ActorFrame{


Def.ActorFrame{
OnCommand=cmd(queuecommand,"Nep");
	ISLA;
	Def.Quad{
		OnCommand=cmd(diffuse,Color.White;x,SCREEN_CENTER_X-SCREEN_CENTER_X*1.935/2;horizalign,left;y,14.7+57;zoomx,SCREEN_CENTER_X*1.935;zoomy,5.9;queuecommand,"Nep");
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Nep");
		NepCommand=function(self)
		self:diffuse(Color.White)
		self:diffusealpha(0.45)
		self:playcommand("PRO")
		end;
		PROCommand=function(self)
			if GAMESTATE:GetSongBeat()<GAMESTATE:GetCurrentSong():GetLastBeat() then
				self:zoomx(math.max(math.min(GAMESTATE:GetSongBeat()/GAMESTATE:GetCurrentSong():GetLastBeat(),1)*SCREEN_CENTER_X*1.935,0))
				self:sleep(1/30):queuecommand("PRO")
			end
		end;
		GETOUTOFGAMESMMessageCommand=cmd(finishtweening;accelerate,1;diffusealpha,0);
	};

	};
	Def.ActorFrame{
		OnCommand=cmd(diffuseshift;effectcolor1,{1,1,1,0.5};effectcolor2,{1,1,1,0};effectclock,"beat";effectperiod,4);
		ISLA;
	};
};
return x;