local jx,jy,cx,cy;
return Def.ActorFrame{

	Def.Quad{
		OnCommand=function(self)
			self:visible(false)
			jx = 0
			jy = -30
			cx = 0;
			cy = 30;
		end;
		
		JudgmentMessageCommand=function(self,Isla)
			if Isla.TapNoteScore == "TapNoteScore_HitMine" then
				local player = Isla.Player and 'PlayerP1' or 'PlayerP2';
				local F = 12;
				local ROTA = math.random(0,F-1)*(360/F);
			
				SCREENMAN:GetTopScreen():GetChild(player):rotationz(ROTA)
				SCREENMAN:GetTopScreen():GetChild(player):GetChild('Judgment'):stoptweening()
				:x(jx*math.cos((ROTA)*math.pi/180) + jy*math.sin((ROTA)*math.pi/180))
				:y(jx*math.sin((ROTA)*math.pi/180) + jy*math.cos((ROTA)*math.pi/180))
				:rotationz(-ROTA):sleep(500);
				SCREENMAN:GetTopScreen():GetChild(player):GetChild('Combo'):stoptweening()
				:x(cx*math.cos((ROTA)*math.pi/180) + cy*math.sin((ROTA)*math.pi/180))
				:y(cx*math.sin((ROTA)*math.pi/180) + cy*math.cos((ROTA)*math.pi/180))
				:rotationz(-ROTA):sleep(500);

			end
		end;
	};

};