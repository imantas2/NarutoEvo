mob/NPCs/Shinobi
	icon='MaleBase.dmi'
	name="Village Shinobi"
	village="Hidden Leaf"
	var/target
	var/Original
	var/OriginalDir
	var/Aggressive=0
	var/VillageGuard=1
	var/TutorialGuy=0
	var/AttackAll=0
	var/list/OriginalOverlays=list()
	var/GoingtoOriginal=0
	strength=200
	New()
		//if(!TutorialGuy)if(src)del(src)//REMEMBER TO REMOVE THIS LATER AFTER YOU FIX LAG FROM NPCS USING MOVEMENT/JUTSU
		spawn()NewStuff()
		..()
	verb
		ShunshinNPC()
			if(!move||injutsu||firing)return
			var/mob/c_target=src.target
			if(!c_target)return
			firing=1
			//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
			flick("jutsuse",src)
			view(src)<<sound('dash.wav',0,0)
			flick('Shunshin.dmi',src)
			spawn(1)
				src.loc = c_target.loc
				step(src,c_target.dir)
				src.dir = get_dir(src,c_target)
				flick("punchl",src)
				c_target.health-=round(strength/2)
				var/colour = colour2html("white")
				F_damage(c_target,round(strength/2),colour)
				c_target.UpdateHMB()
			spawn(25)if(src)firing=0
		SickleWeaselNPC()
			if(!move||injutsu||firing)return
			var/mob/c_target=src.target
			if(!c_target)return
			firing=1
			//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
			flick("2fist",src)
			view(src)<<sound('wirlwind.wav',0,0)
			var/num=rand(2,4)
			if(c_target)
				while(num)
					sleep(2)
					num--
					src.dir=get_dir(src,c_target)
					var/obj/Projectiles/Weaponry/SickleSlash/A = new/obj/Projectiles/Weaponry/SickleSlash(src.loc)
					A.IsJutsuEffect=src
					if(prob(50))A.pixel_y+=rand(3,5)
					else A.pixel_y-=rand(1,5)
					if(prob(50))A.pixel_x+=rand(3,8)
					else A.pixel_x-=rand(1,8)
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=rand(10,25)+round(src.strength/6)
					if(c_target) walk_towards(A,c_target.loc,0)
					spawn(4)if(A)walk(A,A.dir)
			spawn(25)if(src)firing=0
		MudslideNPC()
			if(!move||injutsu||firing)return
			var/mob/c_target=src.target
			if(!c_target)return
			firing=1
			//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Fire Ball"
			flick("jutsuse",src)
			view(src)<<sound('man_fs_l_mt_wat.ogg',0,0)
			var/TimeAsleep=rand(30,100)
			new/obj/Jutsus/Effects/mudslide(src.loc)
			var/mob/M = c_target
			if(M)
				new/obj/Jutsus/Effects/mudslide(M.loc)
				M.icon_state="dead"
				M.move=0
				M.injutsu=1
				M.canattack=0
				M.Sleeping=1
				spawn(TimeAsleep)
					if(!M||M.dead) return
					M.icon_state=""
					M.move=1
					M.injutsu=0
					M.Sleeping=0
					M.canattack=1
			spawn(25)if(src)firing=0
		Multiple_Fireballs()
			if(!move||injutsu||firing)return
			var/mob/c_target=src.target
			if(!c_target)return
			firing=1
			//view()<<"<font size=1><font face=Times New Roman><b><font color=white>[src] Says:<font color=yellow> Fire Release:Phoenix Immortal Fire Technique"
			flick("jutsuse",src)
			view(src)<<sound('fire.wav',0,0)
			var/I=rand(3,5)
			while(I)
				sleep(2)
				I--
				if(c_target)
					src.dir=get_dir(src,c_target)
					var/obj/Projectiles/FireBall/A = new/obj/Projectiles/FireBall(src.loc)
					A.IsJutsuEffect=src
					if(prob(50)) A.pixel_y+=rand(1,8)
					else A.pixel_y-=rand(1,8)
					if(prob(50)) A.pixel_x+=rand(1,8)
					else A.pixel_x-=rand(1,8)
					A.Owner=src
					A.layer=src.layer
					A.fightlayer=src.fightlayer
					A.damage=round(strength/5)
					walk_towards(A,c_target.loc,0)
					spawn(4)if(A)walk(A,A.dir)
			src.copy=null
			spawn(25)if(src)firing=0
		Fire_BallNPC()
			if(!move||injutsu||firing)return
			var/mob/c_target=src.target
			if(!c_target)return
			src.UpdateHMB()
			firing=1
			flick("jutsuse",src)
			view(src)<<sound('fire.wav',0,0)
			src.dir=get_dir(src,c_target)
			var/obj/Projectiles/FireBall/A = new/obj/Projectiles/FireBall(src.loc)
			A.IsJutsuEffect=src
			A.Owner=src
			A.layer=src.layer
			A.fightlayer=src.fightlayer
			A.damage=rand(20,45)+round(src.strength/3)
			walk_towards(A,c_target.loc,0)
			spawn(4)if(A)walk(A,A.dir)
			spawn(25)if(src)firing=0
		ThrowNPC()
			set hidden=1
			set category=null
			if(!move||injutsu||firing)return
			if(usr.equipped=="Shurikens")
				if(usr.firing==0&&usr.dead==0)
					var/mob/c_target=usr.Target_Get(TARGET_MOB)
					usr.firing=1
					if(prob(50))
						flick("throw",usr)
						view(usr)<<sound('SkillDam_ThrowSuriken2.wav',0,0)
					else
						flick("throw",usr)
						view(usr)<<sound('SkillDam_ThrowSuriken3.wav',0,0)
					if(c_target)
						src.dir=get_dir(usr,c_target)
					//	usr.Target_Atom(c_target)
						src:target = c_target
						src:target_mob = c_target
						var/obj/Projectiles/Weaponry/Shuriken/A = new/obj/Projectiles/Weaponry/Shuriken(usr.loc)
						if(prob(50))A.pixel_y+=rand(5,10)
						else A.pixel_y-=rand(5,10)
						if(prob(50))A.pixel_x+=rand(1,8)
						else A.pixel_x-=rand(1,8)
						A.Owner=usr
						A.layer=usr.layer
						A.fightlayer=usr.fightlayer
						A.damage=round(usr.strength/3)
						walk_towards(A,c_target.loc,0)
						spawn(4)if(A)walk(A,A.dir)
					else
						var/obj/Projectiles/Weaponry/Shuriken/A = new/obj/Projectiles/Weaponry/Shuriken(usr.loc)
						if(prob(50))A.pixel_y+=rand(5,10)
						else A.pixel_y-=rand(5,10)
						if(prob(50))A.pixel_x+=rand(1,8)
						else A.pixel_x-=rand(1,8)
						A.Owner=usr
						A.layer=usr.layer
						A.fightlayer=usr.fightlayer
						A.damage=round(usr.strength/3)
						walk(A,usr.dir)
					spawn(25)if(usr)usr.firing=0
			if(usr.equipped=="ExplodeKunais")
				if(usr.firing==0&&usr.dead==0)
					var/mob/c_target=usr.Target_Get(TARGET_MOB)
					usr.firing=1
					if(prob(50))
						flick("throw",usr)
						view(usr)<<sound('SkillDam_ThrowSuriken2.wav',0,0)
					else
						flick("throw",usr)
						view(usr)<<sound('SkillDam_ThrowSuriken3.wav',0,0)
					if(c_target)
						src.dir=get_dir(usr,c_target)
						//usr.Target_Atom(c_target)
						src:target = c_target
						src:target_mob = c_target
						var/obj/Projectiles/Weaponry/Exploding_Kunai/A = new/obj/Projectiles/Weaponry/Exploding_Kunai(usr.loc)
						if(prob(50))A.pixel_y+=rand(5,10)
						else A.pixel_y-=rand(5,10)
						if(prob(50))A.pixel_x+=rand(1,8)
						else A.pixel_x-=rand(1,8)
						A.Owner=usr
						A.layer=usr.layer
						A.fightlayer=usr.fightlayer
						A.damage=round(usr.strength/3)
						walk_towards(A,c_target.loc,0)
						spawn(4)if(A)walk(A,A.dir)
					else
						var/obj/Projectiles/Weaponry/Exploding_Kunai/A = new/obj/Projectiles/Weaponry/Exploding_Kunai(usr.loc)
						if(prob(50))A.pixel_y+=rand(5,10)
						else A.pixel_y-=rand(5,10)
						if(prob(50))A.pixel_x+=rand(1,8)
						else A.pixel_x-=rand(1,8)
						A.Owner=usr
						A.layer=usr.layer
						A.fightlayer=usr.fightlayer
						A.damage=round(usr.strength/3)
						walk(A,usr.dir)
					spawn(25)if(usr)usr.firing=0
			if(usr.equipped=="Kunais")
				if(!usr.firing&&!usr.dead)
					var/mob/c_target=usr.Target_Get(TARGET_MOB)
					usr.firing=1
					if(prob(50))
						flick("throw",usr)
						view(usr)<<sound('SkillDam_ThrowSuriken2.wav',0,0)
					else
						flick("throw",usr)
						view(usr)<<sound('SkillDam_ThrowSuriken3.wav',0,0)
					if(c_target)
						src.dir=get_dir(usr,c_target)
					//	usr.Target_Atom(c_target)
						src:target = c_target
						src:target_mob = c_target
						var/obj/Projectiles/Weaponry/Kunai/A = new/obj/Projectiles/Weaponry/Kunai(usr.loc)
						if(prob(50))A.pixel_y+=rand(5,10)
						else A.pixel_y-=rand(5,10)
						if(prob(50))A.pixel_x+=rand(1,8)
						else A.pixel_x-=rand(1,8)
						A.Owner=usr
						A.layer=usr.layer
						A.fightlayer=usr.fightlayer
						A.damage=round(usr.strength/3)
						walk_towards(A,c_target.loc,0)
						spawn(4)if(A)walk(A,A.dir)
					else
						var/obj/Projectiles/Weaponry/Kunai/A = new/obj/Projectiles/Weaponry/Kunai(usr.loc)
						if(prob(50))A.pixel_y+=rand(5,10)
						else A.pixel_y-=rand(5,10)
						if(prob(50))A.pixel_x+=rand(1,8)
						else A.pixel_x-=rand(1,8)
						A.Owner=usr
						A.layer=usr.layer
						A.fightlayer=usr.fightlayer
						A.damage=round(usr.strength/3)
						walk(A,usr.dir)
					spawn(25)if(usr)usr.firing=0
			if(usr.equipped=="Needles")
				if(usr.firing==0&&usr.dead==0)
					var/mob/c_target=usr.Target_Get(TARGET_MOB)
					usr.firing=1
					if(prob(50))
						flick("throw",usr)
						view(usr)<<sound('SkillDam_ThrowSuriken2.wav',0,0)
					else
						flick("throw",usr)
						view(usr)<<sound('SkillDam_ThrowSuriken3.wav',0,0)
					if(c_target)
						src.dir=get_dir(usr,c_target)
						//usr.Target_Atom(c_target)
						src:target = c_target
						src:target_mob = c_target
						var/obj/Projectiles/Weaponry/Needle/A = new/obj/Projectiles/Weaponry/Needle(usr.loc)
						if(prob(50))A.pixel_y+=rand(5,10)
						else A.pixel_y-=rand(5,10)
						if(prob(50))A.pixel_x+=rand(1,8)
						else A.pixel_x-=rand(1,8)
						A.Owner=usr
						A.layer=usr.layer
						A.fightlayer=usr.fightlayer
						A.damage=round(usr.strength/3)
						walk_towards(A,c_target.loc,0)
						spawn(4)if(A)walk(A,A.dir)
					else
						var/obj/Projectiles/Weaponry/Needle/A = new/obj/Projectiles/Weaponry/Needle(usr.loc)
						if(prob(50))A.pixel_y+=rand(5,10)
						else A.pixel_y-=rand(5,10)
						if(prob(50))A.pixel_x+=rand(1,8)
						else A.pixel_x-=rand(1,8)
						A.Owner=usr
						A.layer=usr.layer
						A.fightlayer=usr.fightlayer
						A.damage=round(usr.strength/3)
						walk(A,usr.dir)
					spawn(25)if(usr)usr.firing=0
			if(usr.equipped=="ExplosiveTags")
				if(usr.explosivetag<6)
					if(usr.firing==0&&usr.dead==0)
						var/mob/c_target=usr.Target_Get(TARGET_MOB)
						usr.firing=1
						usr.explosivetag++
						if(prob(50))
							flick("throw",usr)
							view(usr)<<sound('SkillDam_ThrowSuriken2.wav',0,0)
						else
							flick("throw",usr)
							view(usr)<<sound('SkillDam_ThrowSuriken3.wav',0,0)
						if(c_target)
							src.dir=get_dir(usr,c_target)
						//	usr.Target_Atom(c_target)
							var/obj/Projectiles/Weaponry/ExplosiveTag/A = new/obj/Projectiles/Weaponry/ExplosiveTag(usr.loc)
							if(prob(50))A.pixel_y+=rand(5,10)
							else A.pixel_y-=rand(5,10)
							if(prob(50))A.pixel_x+=rand(1,8)
							else A.pixel_x-=rand(1,8)
							A.Owner=usr
							A.layer=usr.layer
							A.fightlayer=usr.fightlayer
							A.damage=round(usr.ninjutsu/5)
							if(c_target in get_step(usr,usr.dir))
								A.Linkage=c_target
								A.pixel_y+=rand(8,10)
								A.layer=MOB_LAYER+1
							step(A,usr.dir)
						else
							var/obj/Projectiles/Weaponry/ExplosiveTag/A = new/obj/Projectiles/Weaponry/ExplosiveTag(usr.loc)
							if(prob(50))A.pixel_y+=rand(1,8)
							else A.pixel_y-=rand(1,8)
							if(prob(50))A.pixel_x+=rand(1,8)
							else A.pixel_x-=rand(1,8)
							A.Owner=usr
							A.layer=usr.layer
							A.fightlayer=usr.fightlayer
							A.damage=round(usr.ninjutsu/5)
							for(var/mob/M in get_step(usr,usr.dir))
								A.Linkage=M
								A.pixel_y+=rand(8,10)
								A.layer=MOB_LAYER+1
							step(A,usr.dir)
						spawn(25)if(usr)usr.firing=0
	NewStuff()
		/*spawn(rand(10,50))
			for(var/i,i<600,i++)
				var/obj/Inventory/Weaponry/Shuriken/S=new()
				itemAdd(S)
			for(var/i,i<600,i++)
				var/obj/Inventory/Weaponry/Exploding_Kunai/D=new()
				itemAdd(D)
			for(var/i,i<600,i++)
				var/obj/Inventory/Weaponry/Kunai/F=new()
				itemAdd(F)
			for(var/i,i<600,i++)
				var/obj/Inventory/Weaponry/Needle/G=new()
				itemAdd(G)*/
		Element=pick("Fire","Earth","Wind")
		src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
		src.overlays += 'Shade.dmi'
		src.overlays+='Shirt.dmi'
		if(src.village=="Hidden Leaf")src.overlays+='Chunin Vest.dmi'
		if(src.village=="Hidden Sand")src.overlays+='SandChuninVest.dmi'
		src.overlays+='Sandals.dmi'
		src.overlays+='Headband.dmi'
		src.Original=loc
		OriginalDir=dir
		src.name="[village] Shinobi"
		if(!VillageGuard)
			src.Aggressive=pick(0,1)
			src.name="Rogue Shinobi"
			src.village=null
		src.Ryo=rand(10,50)
		if(!TutorialGuy)src.maxhealth=rand(1000,2500)
		else
			src.Ryo=0
			src.name="Rogue Shinobi"
			src.strength=7
			src.maxhealth=rand(10,40)
			VillageGuard=0
			src.village=null
		health=maxhealth
		src.Name(name)
		OriginalOverlays=overlays.Copy()
		wander()
		..()
	Move()
		if(dead)return
		..()
	Death(mob/killer)
		if(dead)return
		if(src && killer && ismob(killer) && !istype(killer,/mob/NPCs/Shinobi/))
			if(!target||!target_mob)
				src:target_mob = killer
				src:target = killer
			killer.Attacked=src
			spawn(200) if(killer) killer.Attacked=null
		if(src.health<=0&&!dead&&ismob(killer))
			if(TutorialGuy&&killer.Tutorial==4)
				killer.Tutorial=5
				killer<<"Great job! You've taken down a rogue shinobi. Proceed through now, or continue training."
			target=null
			Target_Remove()
			src.dead=1
			src.density=0
			src.icon_state="dead"
		//	if(killer&&ismob(killer))
		//		killer<<"You killed the [src]."
		//		killer<<"You gained [src.Ryo] Ryo."
		//		killer.Ryo+=src.Ryo
			spawn(600*2)
				src.health=maxhealth
				src.dead=0
				density=1
				src.loc=Original
				src.icon_state=""
				src.overlays=null
				src.overlays += pick('Short.dmi','Short2.dmi','Short3.dmi')
				src.overlays += 'Shade.dmi'
				src.overlays+='Shirt.dmi'
				if(src.village=="Hidden Leaf")
					src.overlays+='Chunin Vest.dmi'
					src.overlays+='HeadbandLeaf.dmi'
				if(src.village=="Hidden Sand")
					src.overlays+='SandChuninVest.dmi'
					src.overlays+='HeadBandSand.dmi'
				if(src.village=="Hidden Sound")
					src.overlays+='SoundVest.dmi'
					src.overlays+='HeadBandSound.dmi'
				if(src.village=="Hidden Mist")
					src.overlays+='MistChuunin.dmi'
					src.overlays+='HeadBand.dmi'
				if(src.village=="Hidden Rock")
					src.overlays+='RockChuunin.dmi'
					src.overlays+='HeadBandSand.dmi'
				src.overlays+='Sandals.dmi'
				src.Name(name)
			if(village==killer.village)
				killer.exp-=(killer.exp/10)
				if(killer.exp<=0) killer.exp=0
				killer<<output("You have lost 10% of your EXP for killing a fellow villager.","actionoutput")
				killer.KillCombo=0
	proc/GotoOriginal()
		if(GoingtoOriginal||target||target_mob)return
		while(get_dist(src,Original)>1&&!target)
			GoingtoOriginal=1
			sleep(5)
			step_to(src,Original,0)
		GoingtoOriginal=0
		if(OriginalDir) dir=OriginalDir
	proc/wander()
		set background=1
		spawn(5)
			while(src)
				sleep(2)
				if(dead) continue
			//	while(stepcount < 5)
				var/mob/XX = target
				if(TutorialGuy&&XX) if(XX.dead||XX.invisibility||get_dist(src,XX)>4)
					Target_Remove()
					target=null
				if(XX) if(XX.dead||XX.invisibility||get_dist(src,XX)>7)
					Target_Remove()
					target=null
			//	Target_Remove()
			//	target=null
				var/dostuff=0
				if(AttackAll&&!target)
					for(var/mob/M in orange(src))
						if(M.name=="EYE") dostuff=1
						if(!M.dead&&M.village!=src.village&&M.name!="EYE")
							src:target_mob = M
							target=M
				if(Aggressive&&!target&&!AttackAll)
					for(var/mob/player/M in oview(src))
						if(!M.dead)
							src:target_mob = M
							target=M
					dostuff=1
				if(VillageGuard&&!target&&!AttackAll)
					for(var/mob/player/M in oview(src))
						var/mob/X=M.Attacked
						if(X&&ismob(X)) if(!M.dead&&X.village==src.village)
							src:target_mob = M
							target=M
					for(var/mob/player/M in oview(src))
						if(!M.dead&&M.village!=village)
							if(VillageAttackers.Find(M.village)&&VillageDefenders.Find(village))
								src:target_mob = M
								target=M
							if(VillageAttackers.Find(village)&&VillageDefenders.Find(M.village))
								src:target_mob = M
								target=M
							if(M.village=="Akatsuki")
								src:target_mob = M
								target=M
					dostuff=1
				if(target&&dostuff)attack()
				//step(src,src.dir)
				/*if(OriginalOverlays.len) overlays=OriginalOverlays.Copy()
				sleep(7)
		//	src.dir = turn(src.dir, pick(90,180,270,0))
				if(loc!=Original&&!target&&!target_mob&&!GoingtoOriginal)spawn(10)GotoOriginal()
				if(loc==Original&&!target&&!target_mob) dir=OriginalDir
				if(get_dist(Original,src)>20&&!GoingtoOriginal)
					target=null
					Target_Remove()
					GotoOriginal()*/
			..()
//if(/mob/Spells/verb/Parseltongue in M.verbs
	proc/GetProjectile()
		var/returning
		var/list/Options=list()
		Options+="Kunai"
		Options+="Senbon"
		Options+="Shuriken"
		if(Element=="Fire") Options+="Fireball"
		if(Element=="Fire") Options+="Multiple Fireballs"
		if(Element=="Earth") Options+="Mud Slide"
		if(Element=="Wind") Options+="Sickle Weasel"
		if(target&&get_dist(src,target)>4) Options+="ExplodeKunai"
		if(target&&get_dist(src,target)>3) Options+="Shunshin"
		returning=pick(Options)
		return returning
	proc/StepAwayFrom(var/obj/S)
		var/turning = pick(90,-90)
		var/atom/l = get_step(src,turn(S.dir, turning))
		if(l.density)turning -= 180
		src.dir = turn(S.dir, turning)
		step(src,src.dir)
		sleep(2)
	proc/attack()
		set background = 1
		while(target)
			sleep(10)
			if(dead) continue
			if(!move) continue
			var/mob/M = target
			if(!target&&!target_mob) continue
			if(M.dead||M.invisibility||get_dist(src,M)>20)
				if(istype(M,/mob/NPCs/Shinobi)&&!AttackAll)
					Target_Remove()
					target=null
				Target_Remove()
				target=null
			for(var/obj/Projectiles/S in view(4)) if(S.density) //dodging
				if(S.owner)
					if(S.dir == EAST || WEST)
						if(S.x == src.x)
							StepAwayFrom(S)
							continue
					if(S.dir == SOUTH || NORTH)
						if(S.y == src.y)
							StepAwayFrom(S)
							continue
					if(S.dir == SOUTHWEST || NORTHWEST || SOUTHEAST || NORTHEAST)
						StepAwayFrom(S)
						continue
			if(get_dist(M, src) < 2)  // This Down vvv Projectile Alignment
				step_away(src,M)
				sleep(2)
			else
				if(src.y != M.y)
					if(src.y-M.y < 0)
						if(get_dist(M, locate(x,y-1,z)) > 3)
							step(src,NORTH)
							sleep(2)
					if(src.y-M.y > 0)
						if(get_dist(M, locate(x,y+1,z)) > 3)
							step(src,SOUTH)
							sleep(2)
				if(src.x != M.x)
					if(src.x-M.x < 0)
						if(get_dist(M, locate(x+1,y,z)) > 3)
							step(src,EAST)
							sleep(2)
					if(src.x-M.x > 0)
						if(get_dist(M, locate(x-1,y,z)) > 3)
							step(src,WEST)
							sleep(2)
			if(get_dist(src, M) <= 8)
				var/Projectile = GetProjectile()
				switch(Projectile)
					if("Senbon")
						src.TurnTowards(M)
						sleep(2)
						src.equipped="Needles"
						src.ThrowNPC()
					if("Shuriken")
						src.TurnTowards(M)
						sleep(2)
						src.equipped="Shurikens"
						src.ThrowNPC()
					if("Kunai")
						src.TurnTowards(M)
						sleep(2)
						src.equipped="Kunais"
						src.ThrowNPC()
					if("ExplodeKunai")
						src.TurnTowards(M)
						sleep(2)
						src.equipped="ExplodeKunais"
						src.ThrowNPC()
					if("Fireball")
						src.TurnTowards(M)
						sleep(2)
						src.Fire_BallNPC()
					if("Multiple Fireballs")
						src.TurnTowards(M)
						sleep(2)
						src.Multiple_Fireballs()
					if("Mud Slide")
						src.TurnTowards(M)
						sleep(2)
						src.MudslideNPC()
					if("Sickle Weasel")
						src.TurnTowards(M)
						sleep(2)
						src.SickleWeaselNPC()
					if("Shunshin")
						src.TurnTowards(M)
						sleep(2)
						src.ShunshinNPC()
mob/proc/TurnTowards(atom/a)
	var/location = src.loc
	step_towards(src,a)
	src.loc = location