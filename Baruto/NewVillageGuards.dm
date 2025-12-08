//ALHPA PHASE OF NEW VILLAGE SHINOBI   --->>>YEEEEE
//I'LL CONTINUE TO WORK ON THEM IN ORDER TO MAKE THEM TOTALLY LAGLESS AND WITH NICE AMOUNT OF JUTSUS
//... viktorian
mob
	Village_Guard
		icon='MaleBase.dmi'
		Name="Village Guard"
		village="Hidden Leaf"
		health=3000
		maxhealth=3000
		chakra=1500
		maxchakra=1500
		strength=80
		ninjutsu=80
		genjutsu=80
		dead=0
		var/hited=0
		move=0
		proc
			Attack(mob/M)
				var/ppunch="left"
				if(src.hited==1) return
				if(istype(M,/mob/White_Zettsu/))
					return
				if(istype(M,/mob/player/))
					if(ppunch=="left")
						ppunch="right"
						flick("punchl",src)
					if(ppunch=="right")
						ppunch="left"
						flick("punchr",src)
					M.health-=src.strength*rand(1,3)
					M.UpdateHMB()
					M.Death(src)
					src.hited=1
					sleep(10)
					src.hited=0
				else
					return
		Move()
			if(src.move==1||src.dead==1)
				return
			else
				..()
		Death()
			if(src.health<=0)
				src.dead=1
				src.icon_state="dead"
				src.Isdead()
		verb
			FireProjectile(mob/M)
				var/obj/Projectiles/Effects/Maniper/A = new/obj/Projectiles/Effects/Maniper(src.loc)
				A.Owner=src
				A.layer=src.layer
				A.fightlayer=src.fightlayer
				A.damage=src.ninjutsu*5
				var/obj/Projectiles/Weaponry/Exploding_Kunai/S=new/obj/Projectiles/Weaponry/Exploding_Kunai(src.loc)
				S.Owner=src
				S.layer=src.layer
				S.fightlayer=src.fightlayer
				walk_to(A,M.loc)
				spawn(1)
					walk_to(S,M.loc)
					src.dir=A.dir
			Flicker(mob/M)
				sleep(1)
				src.dir=get_dir(src,M)
				flick(src,"dash")
				step(src,src.dir)
				step(src,src.dir)
				step(src,src.dir)

mob/Village_Guard/New()
	src.health=src.maxhealth
	src.chakra=src.maxchakra
	src.icon_state=""
	if(src.village=="Hidden Sand")
		src.verbs+=typesof(/mob/Village_Guard/Sand/verb)
		var/s=rand(1,3)
		if(s==1)
			src.overlays+='Deidara.dmi'
		if(s==2)
			src.overlays+='Long.dmi'
		if(s==3)
			src.overlays+='Short.dmi'
		src.overlays+='SandChuninVest.dmi'
	if(src.village=="Hidden Leaf")
		src.verbs+=typesof(/mob/Village_Guard/Sand/verb)
		var/s=rand(1,3)
		if(s==1)
			src.overlays+='Deidara.dmi'
		if(s==2)
			src.overlays+='Long.dmi'
		if(s==3)
			src.overlays+='Short.dmi'
		src.overlays+='Clothing/Chunin Vest.dmi'
	if(src.village=="Hidden Sound")
		src.verbs+=typesof(/mob/Village_Guard/Sand/verb)
		var/s=rand(1,3)
		if(s==1)
			src.overlays+='Deidara.dmi'
		if(s==2)
			src.overlays+='Long.dmi'
		if(s==3)
			src.overlays+='Short.dmi'
		src.overlays+='SoundVest.dmi'
	if(src.village=="Hidden Mist")
		src.verbs+=typesof(/mob/Village_Guard/Sand/verb)
		var/s=rand(1,3)
		if(s==1)
			src.overlays+='Deidara.dmi'
		if(s==2)
			src.overlays+='Long.dmi'
		if(s==3)
			src.overlays+='Short.dmi'
		src.overlays+='MistChuunin.dmi'
		src.overlays+='Sandals.dmi'
	if(src.village=="Hidden Rock")
		src.verbs+=typesof(/mob/Village_Guard/Sand/verb)
		var/s=rand(1,3)
		if(s==1)
			src.overlays+='Deidara.dmi'
		if(s==2)
			src.overlays+='Long.dmi'
		if(s==3)
			src.overlays+='Short.dmi'
		src.overlays+='RockChuunin.dmi'
		src.overlays+='Sandals.dmi'
	if(src.village=="Hidden Leaf")
		src.overlays+='HeadbandLeaf.dmi'
	if(src.village=="Hidden Sand")
		src.overlays+='HeadBandSand.dmi'
	if(src.village=="Hidden Rock")
		src.overlays+='HeadBandSand.dmi'
	if(src.village=="Hidden Sound")
		src.overlays+='HeadBandSound.dmi'
	if(src.village=="Hidden Mist")
		src.overlays+='HeadBand.dmi'
	spawn(10)
		src.CombatAI()
		..()
mob/Village_Guard/proc/CombatAI()
	while(src)
		if(src.dead==1) break
		for(var/mob/M in oview())
			if(!M.key) continue
			if(istype(M,/mob/Village_Guard/))
				continue
			if(M.village==src.village)
				return
			if(M.dead==1)
				continue
			if(get_dist(src,M)>=6)
				src.FireProjectile(M)
				sleep(5)
			spawn(2)
				step(src,M)
			if(get_dist(src,M)>=2&&get_dist(src,M)<6)
				src.Flicker(M)
			sleep(5)
			if(get_dist(src,M)<=1)
				src.dir=get_dir(src,M)
				src.Attack(M)
			sleep(rand(1,2))
		sleep(rand(6,9))

mob
	Village_Guard
		proc
			Isdead()
				sleep(600*3)
				src.icon_state=""
				src.dead=0
				src.health=src.maxhealth
				src.chakra=src.maxchakra
				src.CombatAI()
mob
	Village_Guard
		Sand
			var/lol=0
			verb
				MudJutsu(mob/M)
					if(lol==1) return
					flick(src,"jutsuse")
					var/obj/loll=new/obj/Jutsus/Effects/mudslide(M.loc)
					spawn(3)
					if(M.loc==loll.loc)
						M.icon_state="dead"
						M.move=0
						M.injutsu=1
						M.canattack=0
						M.Sleeping=1
						spawn(30)
							if(M)
								M.icon_state=""
								M.move=1
								M.injutsu=0
								M.canattack=1
								M.Sleeping=0

					else
						del(loll)
					spawn(50)
						lol=0
		Leaf
		Sound
		Mist

mob/proc/NewStuff()//dont remove this its needed, its from old Village Guards.dmi file...
	..()

