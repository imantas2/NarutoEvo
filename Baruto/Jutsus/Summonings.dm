mob
	summonings
		SnakeSummoning
			icon='Pein Summoning.dmi'
			icon_state="2"
			density=1
			var/mob/lowner
			New()
				spawn(1)
					src.SnakeCombat()
				..()
			proc
				SnakeCombat()
					while(src)
						var/mob/c_target=lowner.Target_Get(TARGET_MOB)
						if(c_target&&c_target==src) return
						sleep(1)
						if(c_target)
							if(src.health<=0)
								del(src)
							src.Move()
							step_towards(src,c_target)
							if(get_dist(src,c_target)<=1)
								if(c_target.dead==1) return
								src.Strike(c_target)
							sleep(4)
						sleep(1)
				Strike(mob/A)
					var/dmg=lowner.strength+lowner.ninjutsu+lowner.genjutsu
					A.health-=dmg
					var/colour = colour2html("red")
					F_damage(A,dmg,colour)
					A.Death(lowner)
					if(A) A.UpdateHMB()
		DogSummoning
			icon='Pein Summoning.dmi'
			icon_state="1"
			density=1
obj
	AkatsukiArms1
		//icon='AkatsukiHands.dmi'
		icon_state="Hand1"
		density=1
	AkatsukiArms2
		//icon='AkatsukiHands.dmi'
		icon_state="Hand2"
		density=1



mob
	jutsus
		var/mob/OWNER
		KazekagePuppet
			icon='Kazekage Puppet.dmi'
			Name="Kazekage Puppet"
			health=2800
			maxhealth=2800
			var/hited=0
			move=0
			Bump(mob/M)
				if(src.hited==1) return
				if(istype(M,/mob/White_Zettsu/))
					M.health-=OWNER.strength+OWNER.ninjutsu*1.6
					var/colour = colour2html("red")
					F_damage(M,OWNER.strength+OWNER.ninjutsu*1.6,colour)
					M.UpdateHMB()
					M.Death(OWNER)
				if(istype(M,/mob/player/))
					flick("punch",src)
					M.health-=OWNER.strength+OWNER.ninjutsu*0.8
					var/colour = colour2html("red")
					F_damage(M,OWNER.strength+OWNER.ninjutsu*0.8,colour)
					M.UpdateHMB()
					M.Death(OWNER)
					src.hited=1
					sleep(10)
					src.hited=0
				else
					return
			Move()
				sleep(3)
				if(src.move==1)
					return
				..()
			New()
				spawn(5)

					src.CombatAI()
				..()
		Summon_Spider
			icon='SpiderS.dmi'
			Name="Huge Spider"
			health=1200
			maxhealth=1200
			var/hited=0
			pixel_y=-40
			pixel_x=-40
			move=0
			Bump(mob/M)
				if(src.hited==1) return
				if(istype(M,/mob/White_Zettsu/))
					M.health-=OWNER.strength*1.2
					var/colour = colour2html("red")
					F_damage(M,OWNER.strength*1.2,colour)
					M.UpdateHMB()
					M.Death(OWNER)
				if(istype(M,/mob/player/))
					//flick("punch",src)
					M.health-=OWNER.strength+OWNER.ninjutsu*0.6
					var/colour = colour2html("red")
					F_damage(M,OWNER.strength+OWNER.ninjutsu*0.6,colour)
					M.UpdateHMB()
					M.Death(OWNER)
					src.hited=1
					sleep(10)
					src.hited=0
				else
					return
			Move()
				if(src.move==1)
					return
				..()
			New()
				spawn(5)//leave 5 here so that it doesnt throw out an run time error caused by target_get proc which is instantly called when summoned and it appears that in jutsu itself owner is defined a split second later lol so theres null.target_get lmao! XD
					src.CombatAI()
				..()


mob/jutsus/proc/CombatAI()
	while(src)
		var/mob/c_target=OWNER.Target_Get(TARGET_MOB)
		if(c_target&&c_target==src) return
		sleep(1)
		if(c_target)
			if(src.health<=0)
				del(src)
			src.Move()
			step_towards(src,c_target)
			if(get_dist(src,c_target)<=1)
				if(c_target.dead==1) return
				Bump(c_target)
			sleep(4)
		sleep(1)